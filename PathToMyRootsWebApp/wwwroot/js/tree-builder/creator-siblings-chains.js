// groups the individual siblings by parents
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
            generations[level - 1].siblingsChains.forEach(siblingsChain => {
                siblingsChain.forEach(sibling => {
                    sibling.forEach(extendedMarriage => {
                        const secondMarriageChildrenIds = getSecondaryMarriageChildrenIds(extendedMarriage);
                        const secondaryMarriageSiblings = getSiblingsFromGeneration(generations[level], secondMarriageChildrenIds, consumedSiblings);
                        if (secondaryMarriageSiblings.length > 0) {
                            siblingsChains.push(secondaryMarriageSiblings);
                        }

                        const mainMarriageChildrenIds = getMainMarriageChildrenIds(extendedMarriage);
                        const mainMarriageSiblings = getSiblingsFromGeneration(generations[level], mainMarriageChildrenIds, consumedSiblings);
                        if (mainMarriageSiblings.length > 0) {
                            siblingsChains.push(mainMarriageSiblings);
                        }
                    });
                });
            });

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

function getSecondaryMarriageChildrenIds(extendedMarriage) {
    return (extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? []);
}

function getMainMarriageChildrenIds(extendedMarriage) {
    return (extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? []);
}

function getSiblingsFromGeneration(generation, childrenIds, consumedSiblings) {
    const siblings = [];
    generation.siblings.forEach(sibling => {
        if (consumedSiblings.includes(sibling)) {
            return;
        }

        if (siblingIsChildOf(sibling, childrenIds)) {
            siblings.push(sibling);
            consumedSiblings.push(sibling);
        }
    });

    return siblings;
}

function siblingIsChildOf(sibling, childrenIds) {
    return sibling.some(extendedMarriage => {
        const maleId = extendedMarriage.mainMarriage?.male?.id;
        const femaleId = extendedMarriage.mainMarriage?.female?.id;

        return childrenIds.includes(maleId) || childrenIds.includes(femaleId);
    });
}