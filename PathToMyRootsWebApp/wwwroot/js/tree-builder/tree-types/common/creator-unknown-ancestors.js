// adds marriage entities upwards starting from the persons grandparents
function addUnknownAncestors(person, generations, hideAncestors, addFromGreatGrandparents) {
    const personsAndAncestorGenerations = getPersonsAndAncestorGenerations(person, generations);

    let unknownPersonIdObject = { value: -1 };

    for (let i = personsAndAncestorGenerations.length - 1; i > 0; i--) {
        let parentsMarriageEntities = personsAndAncestorGenerations[i - 1].marriageEntities;
        let parentsMarriageEntitiesWithChildren = parentsMarriageEntities.filter(marriageEntity => marriageEntity.marriage?.inverseParentIds.length > 0);

        let childrenMarriageEntities = personsAndAncestorGenerations[i].marriageEntities;

        // if it's biological tree and the parents generation is the person's parents one
        // then restrict the parents only to the biological parents
        // in this case the parents of the person from whom he has siblings will still be displayed, but
        // they won't affect the visual balance of the tree cause their parents will not be displayed
        if (addFromGreatGrandparents) {
            if (i == personsAndAncestorGenerations.length - 1) {
                const singlePersonMarriage =
                {
                    male: person.isMale ? person : null,
                    female: !person.isMale ? person : null,
                }
                childrenMarriageEntities = [singlePersonMarriage];
            }

            if (i == personsAndAncestorGenerations.length - 2) {
                childrenMarriageEntities =
                    childrenMarriageEntities
                        .filter(marriageEntity =>
                            marriageEntity.male.id == person.biologicalFatherId &&
                            marriageEntity.female.id == person.biologicalMotherId);
            }
        }

        // add unknown parents to orphan children
        for (const childMarriageEntity of childrenMarriageEntities) {
            const childMaleId = childMarriageEntity.marriage?.maleId;
            const childFemaleId = childMarriageEntity.marriage?.femaleId;

            // child marriage can have only a male or a female
            if (childMaleId) {
                const childMaleHasParent = parentsMarriageEntitiesWithChildren.some(parentMarriageEntity => parentMarriageEntity.marriage.inverseParentIds.includes(childMaleId));
                if (!childMaleHasParent) {
                    const unknownParentsMarriageEntity = createUnknownParentsMarriageEntity(childMaleId, unknownPersonIdObject, hideAncestors);
                    parentsMarriageEntities.push(unknownParentsMarriageEntity);

                    // add to the parents with children as well so
                    // duplicated children won't cause multiple unknown parents to be added
                    parentsMarriageEntitiesWithChildren.push(unknownParentsMarriageEntity);
                }
            }

            if (childFemaleId) {
                const childFemaleHasParent = parentsMarriageEntitiesWithChildren.some(parentMarriageEntity => parentMarriageEntity.marriage.inverseParentIds.includes(childFemaleId));
                if (!childFemaleHasParent) {
                    const unknownParentsMarriageEntity = createUnknownParentsMarriageEntity(childFemaleId, unknownPersonIdObject, hideAncestors);
                    parentsMarriageEntities.push(unknownParentsMarriageEntity);
                    parentsMarriageEntitiesWithChildren.push(unknownParentsMarriageEntity);
                }
            }
        }
    }
}

function getPersonsAndAncestorGenerations(person, generations) {
    const personsGenerationIndex = generations.findIndex(generation =>
        generation.marriageEntities.some(
            marriage => marriage.male === person || marriage.female === person
        )
    );

    // if person has 3 ancestor generations
    // then the person's generation index is 3
    // so take index + 1 to also take the person's generation
    return generations.slice(0, personsGenerationIndex + 1);
}

function createUnknownParentsMarriageEntity(childId, unknownPersonIdObject, hideAncestors) {
    const unknownFather = createUnknownFather(unknownPersonIdObject.value--, childId);
    const unknownMother = createUnknownMother(unknownPersonIdObject.value--, childId);

    unknownFather.firstSpouseId = unknownMother.id;
    unknownMother.firstSpouseId = unknownFather.id;

    unknownFather.isUnknown = true;
    unknownFather.isHidden = hideAncestors;

    unknownMother.isUnknown = true;
    unknownMother.isHidden = hideAncestors;

    const marriage = createMarriage(unknownFather, unknownMother);
    marriage.isUnknown = true;
    marriage.isHidden = hideAncestors;

    return {
        male: unknownFather,
        female: unknownMother,
        marriage
    };
}

function createUnknownFather(fatherId, childId) {
    return {
        id: fatherId,
        isMale: true,
        inverseBiologicalFather: [{ id: childId }],
        inverseAdoptiveFather: []
    };
}

function createUnknownMother(motherId, childId) {
    return {
        id: motherId,
        isMale: false,
        inverseBiologicalMother: [{ id: childId }],
        inverseAdoptiveMother: []
    };
}