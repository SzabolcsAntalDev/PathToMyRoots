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
                        const childrenIds = getChildrenIds(extendedMarriage)
                        const siblings = getChildrenFromGeneration(generations[level], childrenIds, consumedMarriagesChain);
                        if (siblings.length > 0) {
                            siblingsChains.push(siblings);
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

function getChildrenIds(extendedMarriage) {
    return (extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
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

        if (childrenIds.includes(maleId) || childrenIds.includes(femaleId)) {
            extendedMarriage.isMainSibling = true;
            return true;
        }

        return false;
    });
}