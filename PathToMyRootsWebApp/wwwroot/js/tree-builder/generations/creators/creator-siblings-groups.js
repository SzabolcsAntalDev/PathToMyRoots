// groups the individual marriage entities groups by parents, so they become siblings

function createSiblingsGroups(generations) {
    generations.forEach((generation, level) => {
        let siblingsGroups = [];

        // marriage entities groups on first level are not siblings
        if (level == 0) {
            generation.marriageEntitiesGroups.forEach(marriageEntitiesGroup => {
                siblingsGroups.push([marriageEntitiesGroup]);
            });
        }

        else {
            const consumedMarriageEntitiesGroups = [];
            const siblingsGroupsAndParentsIds = [];

            // use marriage entities groups set in the previous iteration, needed for the order of the children
            const parentsGeneration = generations[level - 1];

            parentsGeneration.siblingsGroups.forEach(parentSiblingsGroup => {
                parentSiblingsGroup.forEach(marriageEntitiesGroup => {
                    marriageEntitiesGroup.forEach(marriageEntity => {

                        const siblingsGroup = getSiblingsGroupFromChildGeneration(
                            generations[level],
                            marriageEntity.marriage?.inverseParentIds ?? [],
                            consumedMarriageEntitiesGroups);

                        if (siblingsGroup.length > 0) {

                            const siblingsGroupAndParentIds = {
                                siblingsGroup: siblingsGroup,
                                parentsIds: getParentIdsOfSiblingsGroupFromParentGeneration(siblingsGroup, parentsGeneration),
                            }

                            siblingsGroupsAndParentsIds.push(siblingsGroupAndParentIds);
                        }
                    });
                });
            });

            siblingsGroups = mergeSiblingsGroupsAndParentsIds(siblingsGroupsAndParentsIds);

            // add orphans
            generation.marriageEntitiesGroups.forEach(marriageEntitiesGroup => {
                if (!consumedMarriageEntitiesGroups.includes(marriageEntitiesGroup)) {
                    siblingsGroups.push([marriageEntitiesGroup]);
                }
            });
        }

        generation.siblingsGroups = siblingsGroups;
    });
}

function getSiblingsGroupFromChildGeneration(childrenGeneration, childrenIds, consumedMarriageEntitiesGroups) {
    const siblingsGroup = [];
    childrenGeneration.marriageEntitiesGroups.forEach(marriageEntitiesGroup => {
        if (consumedMarriageEntitiesGroups.includes(marriageEntitiesGroup)) {
            return;
        }

        if (siblingIsChildOf(marriageEntitiesGroup, childrenIds)) {
            siblingsGroup.push(marriageEntitiesGroup);
            consumedMarriageEntitiesGroups.push(marriageEntitiesGroup);
        }
    });

    return siblingsGroup;
}

function siblingIsChildOf(sibling, childrenIds) {
    return sibling.some(marriageEntity => {
        const maleId = marriageEntity.male?.id;
        const femaleId = marriageEntity.female?.id;

        return childrenIds.includes(maleId) || childrenIds.includes(femaleId);
    });
}

function getParentIdsOfSiblingsGroupFromParentGeneration(childSiblingsGroup, parentsGeneration) {
    const childrenSpousesIdsSet = new Set();

    childSiblingsGroup.forEach(sibling => {
        sibling.forEach(marriageEntity => {
            childrenSpousesIdsSet.add(marriageEntity.male?.id);
            childrenSpousesIdsSet.add(marriageEntity.female?.id);
        })
    })

    childrenSpousesIdsSet.delete(null);

    const parentsIds = {
        fatherIds: new Set(),
        motherIds: new Set()
    }

    parentsGeneration.siblingsGroups.forEach(siblingsGroup => {
        siblingsGroup.forEach(marriageEntitiesGroup => {
            marriageEntitiesGroup.forEach(marriageEntity => {

                const inverseParentIds = marriageEntity.marriage?.inverseParentIds ?? [];

                if (includesAny(inverseParentIds, childrenSpousesIdsSet)) {
                    parentsIds.fatherIds.add(marriageEntity.male.id);
                    parentsIds.fatherIds.add(marriageEntity.female.id);
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

function mergeSiblingsGroupsAndParentsIds(siblingsGroupsAndParentsIds) {
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