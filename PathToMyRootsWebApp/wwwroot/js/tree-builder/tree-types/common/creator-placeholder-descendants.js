// adds marriage entities downwards starting from the person's generation

function addPlaceholderDescendants(person, generations, placeholderPersonIdObject, hideDescendants) {
    const personsAndDescendantGenerations = getPersonsAndDescendantGenerations(person, generations);

    for (let i = 0; i < personsAndDescendantGenerations.length - 1; i++) {
        const parentsGeneration = personsAndDescendantGenerations[i];
        const childrenGeneration = personsAndDescendantGenerations[i + 1];

        const averageNumberOfChildren = getAverageNumberOfChildrenThatHaveParentsPerParents(parentsGeneration.marriageEntities, childrenGeneration.marriageEntities);

        for (const parentMarriageEntity of parentsGeneration.marriageEntities) {
            if (parentMarriageEntity.marriage == null || parentMarriageEntity.marriage.inverseParentIds.length == 0) {

                fillMarriageEntityWithPlaceholderSpouseAndMarriage(parentMarriageEntity, placeholderPersonIdObject, hideDescendants, averageNumberOfChildren);

                for (let i = 0; i < averageNumberOfChildren; i++) {
                    childrenGeneration.marriageEntities.push(createHiddenChildMarriageEntity(parentMarriageEntity.marriage.inverseParentIds[i], hideDescendants));
                }
            }
        }
    }
}

function getPersonsAndDescendantGenerations(person, generations) {
    const personsGenerationIndex = generations.findIndex(generation =>
        generation.marriageEntities.some(
            marriage => marriage.male == person || marriage.female == person
        )
    );

    // if person has 5 ancestor and 2 descendant generations
    // then the person's generation index is 5 and generations length is 8
    return generations.slice(personsGenerationIndex, generations.length);
}

function getAverageNumberOfChildrenThatHaveParentsPerParents(parentsMarriageEntities, childrenMarriageEntities) {
    const childIdsThatHaveParents = new Set();

    for (let parentMarriagEntity of parentsMarriageEntities) {
        for (let childId of parentMarriagEntity.marriage?.inverseParentIds ?? []) {
            childIdsThatHaveParents.add(childId);
        }
    }

    const parentsWithChildren = parentsMarriageEntities.filter(marriageEntity => marriageEntity.marriage?.inverseParentIds.length > 0).length;

    return Math.round(childIdsThatHaveParents.size / parentsWithChildren);
}

function fillMarriageEntityWithPlaceholderSpouseAndMarriage(parentMarriageEntity, placeholderPersonIdObject, hideDescendants, averageNumberOfChildren) {
    const childrenIds = [];

    for (let i = 0; i < averageNumberOfChildren; i++) {
        childrenIds.push(placeholderPersonIdObject.value--);
    }

    const father = parentMarriageEntity.male ?? this.createFakeFather(placeholderPersonIdObject.value--);
    const mother = parentMarriageEntity.female ?? this.createFakeMother(placeholderPersonIdObject.value--);

    father.firstSpouseId = mother.id;
    mother.firstSpouseId = father.id;

    father.inverseBiologicalFather = childrenIds.map(id => ({ id: id }));
    mother.inverseBiologicalMother = childrenIds.map(id => ({ id: id }));

    const marriage = createMarriage(father, mother);
    marriage.isFake = father.isFake || mother.isFake;

    parentMarriageEntity.male = father;
    parentMarriageEntity.female = mother;
    parentMarriageEntity.marriage = marriage;

    if (hideDescendants) {
        parentMarriageEntity.male.isHidden = parentMarriageEntity.male.isFake;
        parentMarriageEntity.female.isHidden = parentMarriageEntity.female.isFake;
        parentMarriageEntity.marriage.isHidden = parentMarriageEntity.marriage.isFake;
    }
}

function createFakeFather(fatherId) {
    return {
        id: fatherId,
        isMale: true,
        inverseAdoptiveFather: [],
        isFake: true
    };
}

function createFakeMother(motherId) {
    return {
        id: motherId,
        isMale: false,
        inverseAdoptiveMother: [],
        isFake: true
    };
}

function createHiddenChildMarriageEntity(childId, hideDescendants) {
    return {
        male: {
            id: childId,
            isMale: true,
            inverseBiologicalFather: [],
            inverseAdoptiveFather: [],
            isFake: true,
            isHidden: hideDescendants
        }
    }
}