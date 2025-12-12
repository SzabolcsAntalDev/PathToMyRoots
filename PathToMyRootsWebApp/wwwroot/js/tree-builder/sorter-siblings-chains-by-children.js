// sorts parents by children upwards starting from the actual person's parents
function sortSiblingsChainsByChildren(generations) {

    generations.reverse();

    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i + 1];
        const childrenGeneration = generations[i];

        const newParentsSiblingsChains = new Set();
        childrenGeneration.siblingsChains.forEach(childSiblingsChain => {
            childSiblingsChain.forEach(childSibling => {
                childSibling.forEach(childExtendedMarriage => {
                    const childMaleId = childExtendedMarriage.mainMarriage?.male?.id;
                    const childFemaleId = childExtendedMarriage.mainMarriage?.female?.id;

                    parentsGeneration.siblingsChains.forEach(parentSiblingsChain => {
                        if (isParentOfChild(parentSiblingsChain, childMaleId)) {
                            newParentsSiblingsChains.add(parentSiblingsChain);
                        }
                    });

                    parentsGeneration.siblingsChains.forEach(parentSiblingsChain => {
                        if (isParentOfChild(parentSiblingsChain, childFemaleId)) {
                            newParentsSiblingsChains.add(parentSiblingsChain);
                        }
                    });
                })
            })
        });

        // add parents that have no children
        parentsGeneration.siblingsChains.forEach(parentSiblingsChain => {
            if (!newParentsSiblingsChains.has(parentSiblingsChain)) {
                newParentsSiblingsChains.add(parentSiblingsChain);
            }
        });

        parentsGeneration.siblingsChains = newParentsSiblingsChains;
    };
}

function isParentOfChild(parentSiblingsChain, personId) {
    const childrenIds = [];

    parentSiblingsChain.forEach(sibling => {
        sibling.forEach(extendedMarriage => {
            childrenIds.push(...getMarriagesChildrenIds(extendedMarriage));
        })
    });

    return childrenIds.includes(personId);
}

function getMarriagesChildrenIds(extendedMarriage) {
    return (extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? []);
}