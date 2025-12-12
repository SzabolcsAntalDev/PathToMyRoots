// groups the individual siblings by parents
// - this also includes sorting siblings chains by parents
// one siblingChain can be as complex as
// s1: (female - male female - male female - male)
// s2: (female - male female - male female - male)
// s3: (female - male female)
// s4: (female - male female)
// resulting in [[s1, s2], [s3], [s4]]
function createSiblingsChains(generations) {
    generations.forEach((generation, level) => {
        let siblingsChains = [];

        // persons on first level are non siblings
        if (level == 0) {
            generation.siblings.forEach(sibling => {
                siblingsChains.push([sibling]);
            });
        }

        else {
            const consumedSiblings = [];
            // use siblings set in the previous iteration, needed for the order of the children
            const parentsGeneration = generations[level - 1];
            parentsGeneration.siblingsChains.forEach(parentSiblingsChain => {
                parentSiblingsChain.forEach(parentSibling => {
                    parentSibling.forEach(parentExtendedMarriage => {

                        const secondaryMarriageChildrenIds = getSecondaryMarriageChildrenIds(parentExtendedMarriage);
                        const secondaryMarriageSiblingsChain = getSiblingsChainFromChildGeneration(generations[level], secondaryMarriageChildrenIds, consumedSiblings);

                        if (secondaryMarriageSiblingsChain.length > 0) {

                            const mySiblingChain = {
                                array: secondaryMarriageSiblingsChain,
                                parentIds: getParentIdsFromParentGeneration(secondaryMarriageSiblingsChain, parentsGeneration),
                            }

                            siblingsChains.push(mySiblingChain);
                        }

                        const mainMarriageChildrenIds = getMainMarriageChildrenIds(parentExtendedMarriage);
                        const mainMarriageSiblingsChain = getSiblingsChainFromChildGeneration(generations[level], mainMarriageChildrenIds, consumedSiblings);

                        if (mainMarriageSiblingsChain.length > 0) {

                            const mySiblingChain = {
                                array: mainMarriageSiblingsChain,
                                parentIds: getParentIdsFromParentGeneration(mainMarriageSiblingsChain, parentsGeneration),
                            }

                            siblingsChains.push(mySiblingChain);
                        }
                    });
                });
            });

            // here we remove the object and leave the array
            siblingsChains = mergeSiblingsChains(siblingsChains);

            // add orphans
            generation.siblings.forEach(sibling => {
                if (!consumedSiblings.includes(sibling)) {
                    siblingsChains.push([sibling]);
                }
            });
        }

        generation.siblingsChains = siblingsChains;
    });
}

function getParentIdsFromParentGeneration(childSiblingsChain, parentsGeneration) {
    const childrenIds = [];

    childSiblingsChain.forEach(sibling => {
        sibling.forEach(extendedMarriage => {
            childrenIds.push(extendedMarriage.secondaryMarriage?.maleId);
            childrenIds.push(extendedMarriage.secondaryMarriage?.femaleId);
            childrenIds.push(extendedMarriage.mainMarriage?.male?.id);
            childrenIds.push(extendedMarriage.mainMarriage?.female?.id);
        })
    })

    const childrenIdsSet = new Set(childrenIds.filter(id => id != null));
    const parentIds = {
        fatherIds: [],
        motherIds: []
    }

    parentsGeneration.siblingsChains.forEach(siblingsChain => {
        siblingsChain.forEach(siblings => {
            siblings.forEach(extendedMarriage => {
                // Szabi: check what happens for biological tree, cause this is not ok for there, hopefully adoptive are empty here in case of biological
                const secBio = extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [];
                const secAdopt = extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? [];
                const mainBio = extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [];
                const mainAdopt = extendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? [];

                // SECONDARY BIOLOGICAL
                if (anyMatch(secBio, childrenIdsSet)) {
                    parentIds.fatherIds.push(extendedMarriage.secondaryMarriage.maleId);
                    parentIds.motherIds.push(extendedMarriage.secondaryMarriage.femaleId);
                }

                // SECONDARY ADOPTIVE
                if (anyMatch(secAdopt, childrenIdsSet)) {
                    parentIds.fatherIds.push(extendedMarriage.secondaryMarriage.maleId);
                    parentIds.motherIds.push(extendedMarriage.secondaryMarriage.femaleId);
                }

                // MAIN BIOLOGICAL
                if (anyMatch(mainBio, childrenIdsSet)) {
                    parentIds.fatherIds.push(extendedMarriage.mainMarriage.male.id);
                    parentIds.motherIds.push(extendedMarriage.mainMarriage.female.id);
                }

                // MAIN ADOPTIVE
                if (anyMatch(mainAdopt, childrenIdsSet)) {
                    parentIds.fatherIds.push(extendedMarriage.mainMarriage.male.id);
                    parentIds.motherIds.push(extendedMarriage.mainMarriage.female.id);
                }

            })
        });
    });

    return parentIds;

}

function anyMatch(idsArray, childrenIdsSet) {
    return idsArray && idsArray.some(id => childrenIdsSet.has(id));
}

function mergeSiblingsChains(siblingChains) {
    const mergedChains = [];
    const used = new Array(siblingChains.length).fill(false);

    function shareParent(a, b) {
        // Check father overlap
        if (a.parentIds.fatherIds.some(id => b.parentIds.fatherIds.includes(id))) return true;

        // Check mother overlap
        if (a.parentIds.motherIds.some(id => b.parentIds.motherIds.includes(id))) return true;

        return false;
    }

    for (let i = 0; i < siblingChains.length; i++) {
        if (used[i]) continue;

        // Clone base object
        let base = {
            array: [...siblingChains[i].array],
            parentIds: {
                fatherIds: [...siblingChains[i].parentIds.fatherIds],
                motherIds: [...siblingChains[i].parentIds.motherIds],
            }
        };
        used[i] = true;

        let changed = true;
        while (changed) {
            changed = false;

            for (let j = 0; j < siblingChains.length; j++) {
                if (used[j]) continue;

                const sc = siblingChains[j];

                // Merge if they share at least one parent
                if (shareParent(base, sc)) {
                    base.array.push(...sc.array);

                    // Expand parentId sets
                    base.parentIds.fatherIds.push(...sc.parentIds.fatherIds);
                    base.parentIds.motherIds.push(...sc.parentIds.motherIds);

                    used[j] = true;
                    changed = true;
                }
            }

            // Cleanup duplicates in parent lists
            base.parentIds.fatherIds = [...new Set(base.parentIds.fatherIds)];
            base.parentIds.motherIds = [...new Set(base.parentIds.motherIds)];
        }

        // Return only the merged array of siblings
        mergedChains.push(base.array);
    }

    return mergedChains;
}



function getSecondaryMarriageChildrenIds(parentExtendedMarriage) {
    return (parentExtendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(parentExtendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? []);
}

function getMainMarriageChildrenIds(parentExtendedMarriage) {
    return (parentExtendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
        .concat(parentExtendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? []);
}

function getSiblingsChainFromChildGeneration(childGeneration, childrenIds, consumedSiblings) {
    const siblingsChain = [];
    childGeneration.siblings.forEach(sibling => {
        if (consumedSiblings.includes(sibling)) {
            return;
        }

        if (siblingIsChildOf(sibling, childrenIds)) {
            siblingsChain.push(sibling);
            consumedSiblings.push(sibling);
        }
    });

    return siblingsChain;
}

function siblingIsChildOf(sibling, childrenIds) {
    return sibling.some(extendedMarriage => {
        const maleId = extendedMarriage.mainMarriage?.male?.id;
        const femaleId = extendedMarriage.mainMarriage?.female?.id;

        return childrenIds.includes(maleId) || childrenIds.includes(femaleId);
    });
}