// sorts parents by children upwards starting from the actual person's parents
function sortParentsSiblingsGroupsByChildren(generations) {

    generations.reverse();

    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i + 1];
        const childrenGeneration = generations[i];

        const newParentsSiblingsGroups = new Set();
        childrenGeneration.siblingsGroups.forEach(childSiblingsGroup => {
            childSiblingsGroup.forEach(childSibling => {
                childSibling.forEach(childExtendedMarriage => {
                    const childMaleId = childExtendedMarriage.mainMarriage?.male?.id;
                    const childFemaleId = childExtendedMarriage.mainMarriage?.female?.id;

                    parentsGeneration.siblingsGroups.forEach(parentSiblingsGroup => {
                        if (isParentOfChild(parentSiblingsGroup, childMaleId)) {
                            newParentsSiblingsGroups.add(parentSiblingsGroup);
                        }
                    });

                    parentsGeneration.siblingsGroups.forEach(parentSiblingsGroup => {
                        if (isParentOfChild(parentSiblingsGroup, childFemaleId)) {
                            newParentsSiblingsGroups.add(parentSiblingsGroup);
                        }
                    });
                })
            })
        });

        // add parents that have no children
        parentsGeneration.siblingsGroups.forEach(parentSiblingsGroup => {
            if (!newParentsSiblingsGroups.has(parentSiblingsGroup)) {
                newParentsSiblingsGroups.add(parentSiblingsGroup);
            }
        });

        parentsGeneration.siblingsGroups = newParentsSiblingsGroups;
    };
}

function isParentOfChild(parentSiblingsGroup, personId) {
    const childrenIds = [];

    parentSiblingsGroup.forEach(sibling => {
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