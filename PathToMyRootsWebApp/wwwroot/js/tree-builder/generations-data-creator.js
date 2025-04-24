async function createGenerationsData(personId) {

    const generations = await createGenerationsWithExtendedMarriages(personId);

    sortGenerationExtendedMarriagesByBirthDate(generations[0]);
    sortExtendedMarriagesBySecondaryMarriages(generations);
    createExtendedMarriagesChains(generations);
    createSiblingsChains(generations)
    sortSiblingsByBirthDate(generations);
    // sortOrphansByBirthDate(generations);

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}