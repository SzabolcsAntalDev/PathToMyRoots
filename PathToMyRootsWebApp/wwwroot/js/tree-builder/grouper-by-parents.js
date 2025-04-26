function createSiblingsChains(generations) {
    generations.forEach((generation, level) => {
        let siblingsChains = [];
        // persons on first level are non siblings
        if (level == 0) {
            generation.extendedMarriagesChains.forEach(extendedMarriages => {
                siblingsChains.push([extendedMarriages]);
            });
        }
        else {
            const consumedMarriagesChain = [];
            // use siblings set in the previous iteration, needed for the order of the children
            generations[level - 1].siblingsChains.forEach(sibling => {
                sibling.forEach(extendedMarriages => {
                    extendedMarriages.forEach(extendedMarriage => {
                        const secondMarriageChildrenIds = getSecondaryMarriageChildrenIds(extendedMarriage);
                        const secondaryMarriageSiblings = getChildrenFromGeneration(generations[level], secondMarriageChildrenIds, consumedMarriagesChain);
                        if (secondaryMarriageSiblings.length > 0) {
                            siblingsChains.push(secondaryMarriageSiblings);
                        }

                        const mainMarriageChildrenIds = getMainMarriageChildrenIds(extendedMarriage);
                        const mainMarriageSiblings = getChildrenFromGeneration(generations[level], mainMarriageChildrenIds, consumedMarriagesChain);
                        if (mainMarriageSiblings.length > 0) {
                            siblingsChains.push(mainMarriageSiblings);
                        }
                    });
                });
            });

            // add orphans
            generation.extendedMarriagesChains.forEach(extendedMarriages => {
                if (!consumedMarriagesChain.includes(extendedMarriages)) {
                    siblingsChains.push([extendedMarriages]);
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

function getChildrenFromGeneration(generation, childrenIds, consumedMarriagesChain) {
    const siblings = [];
    generation.extendedMarriagesChains.forEach(extendedMarriages => {
        if (consumedMarriagesChain.includes(extendedMarriages)) {
            return;
        }

        if (marriagesIsChildOf(extendedMarriages, childrenIds)) {
            siblings.push(extendedMarriages);
            consumedMarriagesChain.push(extendedMarriages);
        }
    });

    return siblings;
}

function marriagesIsChildOf(extendedMarriages, childrenIds) {
    return extendedMarriages.some(extendedMarriage => {
        const maleId = extendedMarriage.mainMarriage?.male?.id;
        const femaleId = extendedMarriage.mainMarriage?.female?.id;

        return childrenIds.includes(maleId) || childrenIds.includes(femaleId);
    });
}