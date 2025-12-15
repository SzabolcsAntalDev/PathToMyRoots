// sorts parents by children upwards starting from the actual person's parents
function sortParentsSiblingsGroupsByChildren(generations) {

    generations.reverse();

    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i + 1];
        const childrenGeneration = generations[i];

        const newParentsSiblingsGroups = new Set();
        childrenGeneration.siblingsGroups.forEach(childSiblingsGroup => {
            childSiblingsGroup.forEach(childSibling => {
                childSibling.forEach(marriageEntity => {
                    const childMaleId = marriageEntity.male?.id;
                    const childFemaleId = marriageEntity.female?.id;

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
        sibling.forEach(marriageEntity => {
            childrenIds.push(...marriageEntity.marriage?.inverseParentIds ?? []);
        })
    });

    return childrenIds.includes(personId);
}