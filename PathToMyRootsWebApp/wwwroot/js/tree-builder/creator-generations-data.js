
async function createGenerationsData(personId, treeType, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
    let generations;

    if (treeType == treeTypes.HOURGLASS_BIOLOGICAL) {
        generations = await hourglassTreeCreator.createHourglassBiologicalTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
    }

    if (treeType == treeTypes.HOURGLASS_EXTENDED) {
        generations = await hourglassTreeCreator.createHourglassExtendedTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
    }

    if (treeType == treeTypes.COMPLETE) {
        generations = await completeTreeCreator.createCompleteTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
    }

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}

// gets the largest -persons with available parents number- of all generations
function getLargestGenerationSize(generations) {
    let largestGenerationSize = 0;
    generations.forEach(generation => {
        largestGenerationSize = Math.max(largestGenerationSize, getGenerationSize(generation));
    })

    return largestGenerationSize;
}

// gets the number of lines that should be drawn towards the generation
function getGenerationSize(generation) {
    let size = 0;

    generation.extendedMarriages.forEach(extendedMarriage => {
        size += extendedMarriage.numberOfAvailableParents;
    });

    return size;
}