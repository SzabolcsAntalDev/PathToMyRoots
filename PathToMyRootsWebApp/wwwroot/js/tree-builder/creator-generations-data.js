async function createGenerationsData(personId, treeType, loadingTextContainerParent) {
    let generations;

    if (treeType == treeTypes.COMPLETE) {
        generations = await completeTreeCreator.createCompleteTreeGenerations(personId, loadingTextContainerParent);
    }

    if (treeType == treeTypes.HOURGLASS_WITH_ADOPTIVE) {
        generations = await hourglassTreeCreator.createHourglassTreeGenerations(personId, loadingTextContainerParent);
    }

    if (treeType == treeTypes.HOURGLASS_EXTENDED) {
        generations = await hourglassTreeCreator.createHourglassTreeGenerations(personId, loadingTextContainerParent);
    }

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}

// gets the largest persons with available parents number of all generations
// numberOfAvailableParents:
// for COMPLETE trees is adoptive + biological parents number
// for HOURGLASS_EXTENDED trees is only biological known and unknown parents number
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