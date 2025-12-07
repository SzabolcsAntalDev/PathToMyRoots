const hourglassTreeCreator = {

    async createHourglassBiologicalTreeGenerations(treeContext) {
        const generations = await this.createBiologicalTreeGenerationsExtendedMarriages(treeContext);
        return this.createSiblingsAndSiblingsChains(generations);
    },

    async createHourglassExtendedTreeGenerations(treeContext) {
        const generations = await this.createExtendedTreeGenerationsExtendedMarriages(treeContext);
        return this.createSiblingsAndSiblingsChains(generations);
    },

    async createBiologicalTreeGenerationsExtendedMarriages(treeContext) {
        const person = await getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descedantsDepth, treeContext.treeDiagramFrame);

        await hourglassBiological.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);
        await hourglassBiological.addUnknownAncestorsOf(ancestorsGenerations, person);

        const personsExtendedMarriages = await hourglassBiological.createExtendedMarriagesWithSpousesWithCommonChildrenOfPerson(context, context.person, 0);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };

        const siblings = await hourglassBiological.createSiblingsOf(context, person);
        personsGeneration.extendedMarriages.push(...siblings);

        await hourglassBiological.createDescedantsOf(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);

        this.removeDuplicatedExtendedMarriages([personsGeneration]);
        sortExtendedMarriagesByBirthDate([personsGeneration]);
        sortExtendedMarriagesBySpouses([personsGeneration]);
        createSiblings([personsGeneration]);
        createSiblingsChains([personsGeneration]);

        this.removeDuplicatedExtendedMarriages(descedantsGenerations);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);
        sortExtendedMarriagesBySpouses(descedantsGenerations);
        createSiblings(descedantsGenerations);
        createSiblingsChains(descedantsGenerations);

        return ancestorsGenerations.concat(personsGeneration).concat(descedantsGenerations);
    },

    async createExtendedTreeGenerationsExtendedMarriages(treeContext) {
        const person = await getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descedantsDepth, treeContext.treeDiagramFrame);

        await hourglassExtended.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const personsExtendedMarriages = await hourglassExtended.createExtendedMarriagesWithSpousesOfPerson(context, person, 0);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };

        const siblings = await hourglassExtended.createSiblingsOf(context);
        personsGeneration.extendedMarriages.push(...siblings);

        await hourglassExtended.createDescedantsOf(context);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descedantsGenerations);
        this.removeDuplicatedExtendedMarriages(generations);
        sortExtendedMarriagesByBirthDate(generations);
        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    createIterationContext(person, processedPersonIds, ancestorsGenerationsMap, descedantsGenerationsMap, ancestorsDepth, descedantsDepth, treeDiagramFrame) {
        return {
            person: person,
            processedPersonIds: processedPersonIds,
            ancestorsGenerationsMap: ancestorsGenerationsMap,
            descedantsGenerationsMap: descedantsGenerationsMap,
            ancestorsDepth: ancestorsDepth,
            descedantsDepth: descedantsDepth,
            treeDiagramFrame: treeDiagramFrame
        };
    },

    createSiblingsAndSiblingsChains(generations) {
        createSiblings(generations);
        createSiblingsChains(generations);
        return generations;
    },

    removeDuplicatedExtendedMarriages(generations) {
        generations.forEach(generation => {
            const existingExtendedMarriageJsons = new Set();

            generation.extendedMarriages = generation.extendedMarriages.filter(extendedMarriage => {
                const extendedMarriageJson = JSON.stringify(extendedMarriage);

                if (existingExtendedMarriageJsons.has(extendedMarriageJson)) {
                    return false;
                }

                existingExtendedMarriageJsons.add(extendedMarriageJson);
                return true;
            });
        });
    }
}