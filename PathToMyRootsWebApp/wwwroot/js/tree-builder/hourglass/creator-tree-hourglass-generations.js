const hourglassTreeCreator = {

    async createHourglassBiologicalTreeGenerations(treeContext) {
        return await this.createBiologicalTreeGenerationsExtendedMarriages(treeContext);
    },

    async createHourglassExtendedTreeGenerations(treeContext) {
        return await this.createExtendedTreeGenerationsExtendedMarriages(treeContext);
    },

    async createBiologicalTreeGenerationsExtendedMarriages(treeContext) {
        const person = await getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.diagramFrame);

        await hourglassBiological.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);
        await hourglassBiological.addUnknownAncestorsOf(ancestorsGenerations, person);

        const personsExtendedMarriages = await hourglassBiological.createExtendedMarriagesWithSpousesWithCommonChildrenOfPerson(context, context.person, 0);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };

        const siblings = await hourglassBiological.createSiblingsOf(context, person);
        personsGeneration.extendedMarriages.push(...siblings);

        await hourglassBiological.createDescendantsOf(context, person);
        const descendantsGenerations = sortByLevelAndConvertToArray(context.descendantsGenerationsMap);

        this.removeDuplicatedExtendedMarriages([personsGeneration]);
        sortExtendedMarriagesByBirthDate([personsGeneration]);
        sortExtendedMarriagesBySpouses([personsGeneration]);

        this.removeDuplicatedExtendedMarriages(descendantsGenerations);
        sortExtendedMarriagesByBirthDate(descendantsGenerations);
        sortExtendedMarriagesBySpouses(descendantsGenerations);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descendantsGenerations)
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    async createExtendedTreeGenerationsExtendedMarriages(treeContext) {
        const person = await getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.diagramFrame);

        await hourglassExtended.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const personsExtendedMarriages = await hourglassExtended.createExtendedMarriagesWithSpousesOfPerson(context, person, 0);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };

        const siblings = await hourglassExtended.createSiblingsOf(context);
        personsGeneration.extendedMarriages.push(...siblings);

        await hourglassExtended.createDescendantsOf(context);
        const descendantsGenerations = sortByLevelAndConvertToArray(context.descendantsGenerationsMap);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descendantsGenerations);
        this.removeDuplicatedExtendedMarriages(generations);
        sortExtendedMarriagesByBirthDate(generations);
        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);
        sortSiblingsChainsByChildren(generations.slice(0, generations.indexOf(personsGeneration) + 1));

        return generations;
    },

    createIterationContext(person, processedPersonIds, ancestorsGenerationsMap, descendantsGenerationsMap, ancestorsDepth, descendantsDepth, diagramFrame) {
        return {
            person: person,
            processedPersonIds: processedPersonIds,
            ancestorsGenerationsMap: ancestorsGenerationsMap,
            descendantsGenerationsMap: descendantsGenerationsMap,
            ancestorsDepth: ancestorsDepth,
            descendantsDepth: descendantsDepth,
            diagramFrame: diagramFrame
        };
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