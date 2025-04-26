async function createGenerationsData(personId) {

    const generations = await createGenerationsWithExtendedMarriages(personId);

    sortExtendedMarriagesByBirthDate(generations);
    sortExtendedMarriagesBySecondaryMarriages(generations);
    createExtendedMarriagesChains(generations);
    createSiblingsChains(generations)

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}