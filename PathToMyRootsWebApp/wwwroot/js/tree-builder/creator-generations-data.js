async function createGenerationsData(personId) {

    const generations = await createGenerationsWithExtendedMarriages(personId);

    sortExtendedMarriagesByBirthDate(generations);
    createExtendedMarriages(generations);
    createSiblings(generations);
    createSiblingsChains(generations)

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}

// gets the largest persons with available parents number of all generations
function getLargestGenerationSize(generations) {
    let largestGenerationSize = 0;

    generations.forEach(generation => {
        largestGenerationSize = Math.max(largestGenerationSize, getGenerationSize(generation));
    })

    return largestGenerationSize;
}

function getGenerationSize(generation) {
    let size = 0;

    generation.extendedMarriages.forEach(extendedMarriage => {
        size += extendedMarriage.numberOfAvailableParents;
    });

    return size;
}