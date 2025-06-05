const hourglassTreeCreator = {

    async createHourglassBiologicalTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generations = await this.createBiologicalTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
        return this.createSiblingsAndSiblingsChains(generations);
    },

    async createHourglassExtendedTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generations = await this.createExtendedTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
        return this.createSiblingsAndSiblingsChains(generations);
    },

    async createBiologicalTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const person = await getPersonJson(personId);
        person.isHighlighted = true;

        const context = this.createIterationContext(false, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await hourglassBiological.createKnownAncestors(context, person.id, person.biologicalFatherId, person.biologicalMotherId, -1);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);
        await hourglassBiological.addUnknownAncestors(ancestorsGenerations, person);

        if (ancestorsGenerations.length) {
            for (const extendedMarriage of ancestorsGenerations[0].extendedMarriages) {
                extendedMarriage.numberOfAvailableParents = 0;
            }
        }

        const personsLevelWithSpousesExtendedMarriages = await createPersonWithSpousesExtendedMarriages(context, person);
        const personsLevelGeneration = { extendedMarriages: personsLevelWithSpousesExtendedMarriages };
        const siblings = await hourglassBiological.createSingleSiblings(context, person);
        personsLevelGeneration.extendedMarriages.push(...siblings);
        sortExtendedMarriagesByBirthDate([personsLevelGeneration]);
        sortExtendedMarriagesBySpouses([personsLevelGeneration]);

        await createDescedants(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);
        sortExtendedMarriagesBySpouses(descedantsGenerations);

        return ancestorsGenerations.concat(personsLevelGeneration).concat(descedantsGenerations);
    },

    async createExtendedTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const person = await getPersonJson(personId);
        person.isHighlighted = true;

        const context = this.createIterationContext(true, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await hourglassExtended.createKnownAncestorsRecursive(context, person.biologicalFatherId, person.biologicalMotherId, person.adoptiveFatherId, person.adoptiveMotherId, -1);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        if (ancestorsGenerations.length) {
            for (const extendedMarriage of ancestorsGenerations[0].extendedMarriages) {
                extendedMarriage.numberOfAvailableParents = 0;
            }
        }

        const personsLevelWithSpousesExtendedMarriages = await createPersonWithSpousesExtendedMarriages(context, person);
        const personsLevelGeneration = { extendedMarriages: personsLevelWithSpousesExtendedMarriages };
        const siblings = await hourglassExtended.createSiblings(context, person);
        personsLevelGeneration.extendedMarriages.push(...siblings);
        sortExtendedMarriagesByBirthDate([personsLevelGeneration]);
        sortExtendedMarriagesBySpouses([personsLevelGeneration]);

        await createDescedants(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);
        sortExtendedMarriagesBySpouses(descedantsGenerations);

        return ancestorsGenerations.concat(personsLevelGeneration).concat(descedantsGenerations);
    },

    createSiblingsAndSiblingsChains(generations) {
        createSiblings(generations);
        createSiblingsChains(generations);
        return generations;
    },

    createIterationContext(includeAdoptive, processedPersonIds, ancestorsGenerationsMap, descedantsGenerationsMap, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        return {
            includeAdoptive: includeAdoptive,
            processedPersonIds: processedPersonIds,
            ancestorsGenerationsMap: ancestorsGenerationsMap,
            descedantsGenerationsMap: descedantsGenerationsMap,
            ancestorsDepth: ancestorsDepth,
            descedantsDepth: descedantsDepth,
            loadingTextContainerParent: loadingTextContainerParent
        };
    },
}