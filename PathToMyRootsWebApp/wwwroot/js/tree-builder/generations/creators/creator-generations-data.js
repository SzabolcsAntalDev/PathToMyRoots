async function createGenerationsData(treeContext) {

    personsCache.removePersonsWithClientSideData();

    // object used later for downloaded image name
    const person = await personsCache.getPersonJson(treeContext.personId);
    treeContext.person = person;

    let generations;

    if (treeContext.treeType == treeTypes.HOURGLASS_BIOLOGICAL) {
        generations = await hourglassTreeCreator.createHourglassBiologicalTreeGenerations(treeContext);
    }

    if (treeContext.treeType == treeTypes.HOURGLASS_EXTENDED) {
        generations = await hourglassTreeCreator.createHourglassExtendedTreeGenerations(treeContext);
    }

    if (treeContext.treeType == treeTypes.COMPLETE) {
        generations = await completeTreeCreator.createCompleteTreeGenerations(treeContext);
    }

    setNumberOfAvailableParentsOfMarriageEntites(generations);
    setNumberOfAvailableParentsOfGenerations(generations);
    setNumberOfDuplicatedPersonsOfGenerations(generations);

    return {
        generations: generations,
        numberOfDuplicatedPersonsOnFirstLevel: getNumberOfDuplicatedPersonsOnFirstLevel(generations),
        largestGenerationSize: getLargestGenerationSize(generations),
    }
}

function setNumberOfAvailableParentsOfMarriageEntites(generations) {
    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i];
        const childrenGeneration = generations[i + 1];

        // keep track of consumed children to skip the duplicated ones
        // so parent child lines will be drawn only towards the first child of the duplicates
        const consumedBiologicalChildrenIds = new Set();
        const consumedAdoptiveChildrenIds = new Set();

        for (const marriageEntity of childrenGeneration.marriageEntities) {
            marriageEntity.numberOfAvailableParents =
                getNumberOfAvailableParents(
                    parentsGeneration,
                    marriageEntity.male,
                    marriageEntity.female,
                    consumedBiologicalChildrenIds,
                    consumedAdoptiveChildrenIds);
        }
    }
}

function getNumberOfAvailableParents(parentsGeneration, male, female, consumedBiologicalChildrenIds, consumedAdoptiveChildrenIds) {
    let numberOfAvailableParents = 0;

    const personIdsToCheck =
        [male, female]
            .filter(person => person && !person.isHidden)
            .map(person => person.id);

    for (const marriageEntity of parentsGeneration.marriageEntities) {
        if (marriageEntity.marriage && !marriageEntity.marriage.isHidden) {
            for (const personId of personIdsToCheck) {
                if (!consumedBiologicalChildrenIds.has(personId)) {
                    if (marriageEntity.marriage.inverseBiologicalParentIds.includes(personId)) {
                        consumedBiologicalChildrenIds.add(personId);
                        numberOfAvailableParents++;
                    }
                }
                if (!consumedAdoptiveChildrenIds.has(personId)) {
                    if (marriageEntity.marriage.inverseAdoptiveParentIds.includes(personId)) {
                        consumedAdoptiveChildrenIds.add(personId);
                        numberOfAvailableParents++;
                    }
                }
            }
        }
    }

    return numberOfAvailableParents;
}

function setNumberOfAvailableParentsOfGenerations(generations) {
    generations.forEach(generation => {
        generation.numberOfAvailableParents = generation.marriageEntities
            .reduce((size, marriageEntity) => size + (marriageEntity.numberOfAvailableParents ?? 0), 0);
    });
}

function setNumberOfDuplicatedPersonsOfGenerations(generations) {
    generations.forEach(generation => {
        generation.numberOfDuplicatedPersons = getNumberOfDuplicatedPersons(generation.marriageEntities);
    });
}

function getNumberOfDuplicatedPersons(marriageEntities) {
    const personIdsToCount = new Map();

    marriageEntities.forEach(marriageEntity => {
        if (marriageEntity) {

            const maleId = marriageEntity.male?.id;
            const femaleId = marriageEntity.female?.id;

            // hidden and placeholder persons will never have duplicated ids
            // add nulls now but filter them later in the for loop
            personIdsToCount.set(maleId, (personIdsToCount.get(maleId) || 0) + 1);
            personIdsToCount.set(femaleId, (personIdsToCount.get(femaleId) || 0) + 1);
        }
    });

    personIdsToCount.delete(null);
    personIdsToCount.delete(undefined);

    let numberOfDuplicatedPersons = 0;
    for (const count of personIdsToCount.values()) {
        if (count > 1) {
            numberOfDuplicatedPersons++
        };
    }

    return numberOfDuplicatedPersons;
}

function getNumberOfDuplicatedPersonsOnFirstLevel(generations) {
    return generations[0].numberOfDuplicatedPersons;
}

function getLargestGenerationSize(generations) {
    return generations.reduce((maxSize, generation) => Math.max(maxSize, generation.numberOfAvailableParents + generation.numberOfDuplicatedPersons), 0);
}