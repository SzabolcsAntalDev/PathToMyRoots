async function createGenerationsData(treeContext) {

    let generations;

    // object used later for downloaded image name
    const person = await getPersonJson(treeContext.personId);
    treeContext.person = person;

    if (treeContext.treeType == treeTypes.HOURGLASS_BIOLOGICAL) {
        generations = await hourglassTreeCreator.createHourglassBiologicalTreeGenerations(treeContext);
    }

    if (treeContext.treeType == treeTypes.HOURGLASS_EXTENDED) {
        generations = await hourglassTreeCreator.createHourglassExtendedTreeGenerations(treeContext);
    }

    if (treeContext.treeType == treeTypes.COMPLETE) {
        generations = await completeTreeCreator.createCompleteTreeGenerations(treeContext);
    }

    reduceMarriageEntitiesInverseParentIds(generations);

    setNumberOfAvailableParents(generations);
    setGenerationsSize(generations);
    setDuplicatedPersonsOnSameLevelCount(generations);

    return {
        generations: generations,
        duplicatedPersonsOnFirstLevelCount: getDuplicatedPersonsOnFirstLevelCount(generations),
        largestGenerationSize: getLargestGenerationSize(generations),
        largestDuplicatedPersonsOnSameLevelCount: getLargestDuplicatedPersonsOnSameLevelCount(generations)
    }
}

// reduces the inverseBiologicalParentIds and inverseAdoptiveParentIds
// to the ids of the available children, so biological and adoptive paths can be displayed correctly horizontally
function reduceMarriageEntitiesInverseParentIds(generations) {
    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i];
        const childrenGeneration = generations[i + 1];

        const childrenIds = new Set();

        for (const marriageEntity of childrenGeneration.marriageEntities) {
            const maleId = marriageEntity.male?.id;
            const femaleId = marriageEntity.female?.id;

            if (maleId) {
                childrenIds.add(maleId);
            }

            if (femaleId) {
                childrenIds.add(femaleId);
            }
        };

        for (const marriageEntity of parentsGeneration.marriageEntities) {
            if (marriageEntity.marriage) {

                marriageEntity.marriage.inverseBiologicalParentIds =
                    marriageEntity.marriage.inverseBiologicalParentIds
                        .filter(id => childrenIds.has(id));

                marriageEntity.marriage.inverseAdoptiveParentIds =
                    marriageEntity.marriage.inverseAdoptiveParentIds
                        .filter(id => childrenIds.has(id));

                marriageEntity.marriage.inverseParentIds = marriageEntity.marriage.inverseBiologicalParentIds.concat(marriageEntity.marriage.inverseAdoptiveParentIds);
            }
        }
    }
}

// sets the number of paths (numberOfAvailableParents) to each extended marriage that should be drawn towards it
function setNumberOfAvailableParents(generations) {
    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i];
        const childrenGeneration = generations[i + 1];

        for (const marriageEntity of childrenGeneration.marriageEntities) {
            marriageEntity.numberOfAvailableParents =
                getNumberOfAvailableParents(
                    marriageEntity.male?.id,
                    marriageEntity.female?.id,
                    parentsGeneration);
        }
    }
}

function getNumberOfAvailableParents(maleId, femaleId, parentsGeneration) {
    let numberOfAvailableParents = 0;
    const personIdsToCheck = [maleId, femaleId];

    for (const marriageEntity of parentsGeneration.marriageEntities) {
        if (marriageEntity.marriage) {
            for (const personId of personIdsToCheck) {
                if (marriageEntity.marriage.inverseParentIds.includes(personId)) {
                    numberOfAvailableParents++;
                }
            }
        }
    }

    return numberOfAvailableParents;
}

// sets the number of paths (generationSize) that should be drawn towards the generation
function setGenerationsSize(generations) {
    generations.forEach(generation => {
        generation.generationSize = generation.marriageEntities
            .reduce((size, marriageEntity) => size + (marriageEntity.numberOfAvailableParents ?? 0), 0);
    });
}

function setDuplicatedPersonsOnSameLevelCount(generations) {
    generations.forEach(generation => {
        generation.duplicatedPersonsOnSameLevelCount = getDuplicatedPersonsOnSameLevelCount(generation.marriageEntities);
    });
}

function getDuplicatedPersonsOnSameLevelCount(marriageEntities) {
    const personIdsToCount = new Map();

    marriageEntities.forEach(marriageEntity => {
        if (marriageEntity) {
            const maleId = marriageEntity.male?.id;
            const femaleId = marriageEntity.female?.id;

            if (maleId) {
                personIdsToCount.set(maleId, (personIdsToCount.get(maleId) || 0) + 1);
            }

            if (femaleId) {
                personIdsToCount.set(femaleId, (personIdsToCount.get(femaleId) || 0) + 1);
            }
        }
    });

    let duplicatedPersonsOnSameLevelCount = 0;
    for (const count of personIdsToCount.values()) {
        if (count > 1) {
            duplicatedPersonsOnSameLevelCount++
        };
    }

    return duplicatedPersonsOnSameLevelCount;
}

function getDuplicatedPersonsOnFirstLevelCount(generations) {
    return generations[0].duplicatedPersonsOnSameLevelCount;
}

function getLargestGenerationSize(generations) {
    return generations.reduce((maxSize, generation) => Math.max(maxSize, generation.generationSize ?? 0), 0);
}

function getLargestDuplicatedPersonsOnSameLevelCount(generations) {
    return generations.reduce((maxCount, generation) => Math.max(maxCount, generation.duplicatedPersonsOnSameLevelCount ?? 0), 0);
}