// groups the individual spouseGroups by parents
// - this also includes sorting siblings groups by parents
// one siblingGroup can be as complex as
// g1: (female - male female - male female - male)
// g2: (female - male female - male female - male)
// g3: (female - male female)
// g4: (female - male female)
// resulting in [[g1, g2], [g3], [g4]]
function createSiblingsGroups(generations) {
    generations.forEach((generation, level) => {
        let siblingsGroups = [];

        // spouse groups on first level are non siblings
        if (level == 0) {
            generation.spousesGroups.forEach(spousesGroup => {
                siblingsGroups.push([spousesGroup]);
            });
        }

        else {
            const consumedSpousesGroups = [];
            const siblingsGroupsAndParentsIds = [];

            // use spouse groups set in the previous iteration, needed for the order of the children
            const parentsGeneration = generations[level - 1];

            parentsGeneration.siblingsGroups.forEach(parentSiblingsGroup => {
                parentSiblingsGroup.forEach(spousesGroup => {
                    spousesGroup.forEach(parentExtendedMarriage => {

                        const secondaryMarriageChildrenIds = getSecondaryMarriageChildrenIds(parentExtendedMarriage);
                        const secondaryMarriageSiblingsGroup = getSiblingsGroupFromChildGeneration(generations[level], secondaryMarriageChildrenIds, consumedSpousesGroups);

                        if (secondaryMarriageSiblingsGroup.length > 0) {

                            const siblingsGroupAndParentIds = {
                                siblingsGroup: secondaryMarriageSiblingsGroup,
                                parentsIds: getParentIdsOfSiblingsGroupFromParentGeneration(secondaryMarriageSiblingsGroup, parentsGeneration),
                            }

                            siblingsGroupsAndParentsIds.push(siblingsGroupAndParentIds);
                        }

                        const mainMarriageChildrenIds = getMainMarriageChildrenIds(parentExtendedMarriage);
                        const mainMarriageSiblingsGroup = getSiblingsGroupFromChildGeneration(generations[level], mainMarriageChildrenIds, consumedSpousesGroups);

                        if (mainMarriageSiblingsGroup.length > 0) {

                            const siblingsGroupAndParentIds = {
                                siblingsGroup: mainMarriageSiblingsGroup,
                                parentsIds: getParentIdsOfSiblingsGroupFromParentGeneration(mainMarriageSiblingsGroup, parentsGeneration),
                            }

                            siblingsGroupsAndParentsIds.push(siblingsGroupAndParentIds);
                        }
                    });
                });
            });

            siblingsGroups = mergesiblingsGroupsAndParentsIds(siblingsGroupsAndParentsIds);

            // add orphans
            generation.spousesGroups.forEach(spousesGroup => {
                if (!consumedSpousesGroups.includes(spousesGroup)) {
                    siblingsGroups.push([spousesGroup]);
                }
            });
        }

        generation.siblingsGroups = siblingsGroups;
    });
}

function getSecondaryMarriageChildrenIds(parentExtendedMarriage) {
    return (parentExtendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(parentExtendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? []);
}

function getMainMarriageChildrenIds(parentExtendedMarriage) {
    return (parentExtendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
        .concat(parentExtendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? []);
}

function getSiblingsGroupFromChildGeneration(childrenGeneration, childrenIds, consumedSpousesGroups) {
    const siblingsGroup = [];
    childrenGeneration.spousesGroups.forEach(spousesGroup => {
        if (consumedSpousesGroups.includes(spousesGroup)) {
            return;
        }

        if (siblingIsChildOf(spousesGroup, childrenIds)) {
            siblingsGroup.push(spousesGroup);
            consumedSpousesGroups.push(spousesGroup);
        }
    });

    return siblingsGroup;
}

function siblingIsChildOf(sibling, childrenIds) {
    return sibling.some(extendedMarriage => {
        const maleId = extendedMarriage.mainMarriage?.male?.id;
        const femaleId = extendedMarriage.mainMarriage?.female?.id;

        return childrenIds.includes(maleId) || childrenIds.includes(femaleId);
    });
}

function getParentIdsOfSiblingsGroupFromParentGeneration(childSiblingsGroup, parentsGeneration) {
    const childrenSpousesIdsSet = new Set();

    childSiblingsGroup.forEach(sibling => {
        sibling.forEach(extendedMarriage => {
            childrenSpousesIdsSet.add(extendedMarriage.secondaryMarriage?.maleId);
            childrenSpousesIdsSet.add(extendedMarriage.secondaryMarriage?.femaleId);
            childrenSpousesIdsSet.add(extendedMarriage.mainMarriage?.male?.id);
            childrenSpousesIdsSet.add(extendedMarriage.mainMarriage?.female?.id);
        })
    })

    childrenSpousesIdsSet.delete(null);

    const parentsIds = {
        fatherIds: new Set(),
        motherIds: new Set()
    }

    parentsGeneration.siblingsGroups.forEach(siblingsGroup => {
        siblingsGroup.forEach(spousesGroup => {
            spousesGroup.forEach(extendedMarriage => {

                // in case of hourglass biological tree, the inverseAdoptiveParentIds are not set
                const secondaryMarriageInverseBiologicalParentIds = extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [];
                const secondaryMarriageInverseAdoptiveParentIds = extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? [];
                const mainMarriageInverseBiologicalParentIds = extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [];
                const mainMarriageInverseAdoptiveParentIds = extendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? [];

                if (includesAny(secondaryMarriageInverseBiologicalParentIds, childrenSpousesIdsSet)) {
                    parentsIds.fatherIds.add(extendedMarriage.secondaryMarriage.maleId);
                    parentsIds.motherIds.add(extendedMarriage.secondaryMarriage.femaleId);
                }

                if (includesAny(secondaryMarriageInverseAdoptiveParentIds, childrenSpousesIdsSet)) {
                    parentsIds.fatherIds.add(extendedMarriage.secondaryMarriage.maleId);
                    parentsIds.motherIds.add(extendedMarriage.secondaryMarriage.femaleId);
                }

                if (includesAny(mainMarriageInverseBiologicalParentIds, childrenSpousesIdsSet)) {
                    parentsIds.fatherIds.add(extendedMarriage.mainMarriage.male.id);
                    parentsIds.motherIds.add(extendedMarriage.mainMarriage.female.id);
                }

                if (includesAny(mainMarriageInverseAdoptiveParentIds, childrenSpousesIdsSet)) {
                    parentsIds.fatherIds.add(extendedMarriage.mainMarriage.male.id);
                    parentsIds.motherIds.add(extendedMarriage.mainMarriage.female.id);
                }

            })
        });
    });

    return parentsIds;
}

function includesAny(childrenIdsSetOfParents, childrenSpousesIdsSet) {
    for (const childIdOfParents of childrenIdsSetOfParents) {
        if (childrenSpousesIdsSet.has(childIdOfParents)) {
            return true;
        }
    }
    return false;
}

function mergesiblingsGroupsAndParentsIds(siblingsGroupsAndParentsIds) {
    const siblingsGroups = [];
    const usedSiblingsGroupsAndParentsIds = new Array(siblingsGroupsAndParentsIds.length).fill(false);

    for (let i = 0; i < siblingsGroupsAndParentsIds.length; i++) {

        if (usedSiblingsGroupsAndParentsIds[i]) {
            continue;
        }

        let baseSiblingsGroupAndParentIds = {
            siblingsGroup: [...siblingsGroupsAndParentsIds[i].siblingsGroup],
            parentsIds: {
                fatherIds: new Set(siblingsGroupsAndParentsIds[i].parentsIds.fatherIds),
                motherIds: new Set(siblingsGroupsAndParentsIds[i].parentsIds.motherIds),
            }
        };

        usedSiblingsGroupsAndParentsIds[i] = true;

        let siblingsGroupsWereMerged = true;
        while (siblingsGroupsWereMerged) {
            siblingsGroupsWereMerged = false;

            for (let j = 0; j < siblingsGroupsAndParentsIds.length; j++) {
                if (usedSiblingsGroupsAndParentsIds[j]) {
                    continue;
                }

                const currentSiblingGroupsAndParentIds = siblingsGroupsAndParentsIds[j];

                // Merge if they share at least one parent
                if (shareAnyParent(baseSiblingsGroupAndParentIds, currentSiblingGroupsAndParentIds)) {
                    baseSiblingsGroupAndParentIds.siblingsGroup.push(...currentSiblingGroupsAndParentIds.siblingsGroup);

                    for (const fatherId of currentSiblingGroupsAndParentIds.parentsIds.fatherIds) {
                        baseSiblingsGroupAndParentIds.parentsIds.fatherIds.add(fatherId);
                    }

                    for (const motherId of currentSiblingGroupsAndParentIds.parentsIds.motherIds) {
                        baseSiblingsGroupAndParentIds.parentsIds.motherIds.add(motherId);
                    }

                    usedSiblingsGroupsAndParentsIds[j] = true;
                    siblingsGroupsWereMerged = true;
                }
            }
        }

        siblingsGroups.push(baseSiblingsGroupAndParentIds.siblingsGroup);
    }

    return siblingsGroups;
}

function shareAnyParent(siblingsGroupAndParentIds1, siblingsGroupAndParentIds2) {
    for (const fatherId of siblingsGroupAndParentIds1.parentsIds.fatherIds) {
        if (siblingsGroupAndParentIds2.parentsIds.fatherIds.has(fatherId)) {
            return true;
        }
    }

    for (const motherId of siblingsGroupAndParentIds1.parentsIds.motherIds) {
        if (siblingsGroupAndParentIds2.parentsIds.motherIds.has(motherId)) {
            return true;
        }
    }

    return false;
}