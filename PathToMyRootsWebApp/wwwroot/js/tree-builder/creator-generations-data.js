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

    reduceMarriageInverseParentIds(generations);

    setNumberOfAvailableParents(generations);
    setGenerationsSize(generations);
    setDuplicatedGroupsOnSameLevelCount(generations);

    return {
        generations: generations,
        largestGenerationSize: getLargestGenerationSize(generations),
        largestDuplicatedGroupsOnSameLevelCount: getLargestDuplicatedGroupsOnSameLevelCount(generations)
    }
}

// reduces the inverseBiologicalParentIds and inverseAdoptiveParentIds
// to the ids of the available children, so biological and adoptive paths can be displayed correctly horizontally
function reduceMarriageInverseParentIds(generations) {
    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i];
        const childrenGeneration = generations[i + 1];

        const childrenIds = new Set();

        for (const extendedMarriage of childrenGeneration.extendedMarriages) {
            const maleId = extendedMarriage.mainMarriage?.male?.id;
            const femaleId = extendedMarriage.mainMarriage?.female?.id;

            if (maleId) {
                childrenIds.add(maleId);
            }

            if (femaleId) {
                childrenIds.add(femaleId);
            }
        };

        for (const extendedMarriage of parentsGeneration.extendedMarriages) {
            const secondaryMarriage = extendedMarriage.secondaryMarriage;
            const mainMarriage = extendedMarriage.mainMarriage?.marriage;

            if (secondaryMarriage) {
                secondaryMarriage.inverseBiologicalParentIds =
                    secondaryMarriage.inverseBiologicalParentIds.filter(id => childrenIds.has(id));
                secondaryMarriage.inverseAdoptiveParentIds =
                    secondaryMarriage.inverseAdoptiveParentIds.filter(id => childrenIds.has(id));
            }

            if (mainMarriage) {
                mainMarriage.inverseBiologicalParentIds =
                    mainMarriage.inverseBiologicalParentIds.filter(id => childrenIds.has(id));
                mainMarriage.inverseAdoptiveParentIds =
                    mainMarriage.inverseAdoptiveParentIds.filter(id => childrenIds.has(id));
            }
        }
    }
}

// sets the number of paths (numberOfAvailableParents) to each extended marriage that should be drawn towards it
function setNumberOfAvailableParents(generations) {
    for (let i = 0; i < generations.length - 1; i++) {
        const parentsGeneration = generations[i];
        const childrenGeneration = generations[i + 1];

        for (const extendedMarriage of childrenGeneration.extendedMarriages) {
            extendedMarriage.numberOfAvailableParents =
                getNumberOfAvailableParents(
                    extendedMarriage.mainMarriage?.male?.id,
                    extendedMarriage.mainMarriage?.female?.id,
                    parentsGeneration);
        }
    }
}

function getNumberOfAvailableParents(maleId, femaleId, parentsGeneration) {
    let numberOfAvailableParents = 0;
    const personIdsToCheck = [maleId, femaleId];
    const invserseParentIdsPropertyIds = ['inverseBiologicalParentIds', 'inverseAdoptiveParentIds'];

    for (const extendedMarriage of parentsGeneration.extendedMarriages) {
        const marriages = [
            extendedMarriage.secondaryMarriage,
            extendedMarriage.mainMarriage?.marriage
        ].filter(Boolean);

        for (const marriage of marriages) {
            for (const invserseParentIdsPropertyId of invserseParentIdsPropertyIds) {
                const invserseParentIds = marriage[invserseParentIdsPropertyId] ?? [];

                for (const personId of personIdsToCheck) {
                    if (invserseParentIds.includes(personId)) {
                        numberOfAvailableParents++;
                    }
                }
            }
        }
    }

    return numberOfAvailableParents;
}

// sets the number of paths (generationSize) that should be drawn towards the generation
function setGenerationsSize(generations) {
    generations.forEach(generation => {
        generation.generationSize = generation.extendedMarriages
            .reduce((size, extendedMarriage) => size + (extendedMarriage.numberOfAvailableParents ?? 0), 0);
    });
}

function setDuplicatedGroupsOnSameLevelCount(generations) {
    generations.forEach(generation => {
        generation.duplicatedGroupsOnSameLevelCount = getDuplicatedGroupsOnSameLevelCount(generation.extendedMarriages);
    });
}

function getDuplicatedGroupsOnSameLevelCount(extendedMarriages) {
    const personIdsToCount = new Map();

    extendedMarriages.forEach(extendedMarriage => {
        const marriage = extendedMarriage.mainMarriage;
        if (marriage) {
            const maleId = marriage.male?.id;
            const femaleId = marriage.female?.id;

            if (maleId) {
                personIdsToCount.set(maleId, (personIdsToCount.get(maleId) || 0) + 1);
            }

            if (femaleId) {
                personIdsToCount.set(femaleId, (personIdsToCount.get(femaleId) || 0) + 1);
            }
        }
    });

    let duplicatedGroupsOnSameLevelCount = 0;
    for (const count of personIdsToCount.values()) {
        if (count > 1) {
            duplicatedGroupsOnSameLevelCount++
        };
    }

    return duplicatedGroupsOnSameLevelCount;
}

function getLargestGenerationSize(generations) {
    return generations.reduce((maxSize, generation) => Math.max(maxSize, generation.generationSize ?? 0), 0);
}

function getLargestDuplicatedGroupsOnSameLevelCount(generations) {
    return generations.reduce((maxCount, generation) => Math.max(maxCount, generation.duplicatedGroupsOnSameLevelCount ?? 0), 0);
}