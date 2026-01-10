const hourglassTreeCreator = {

    async createHourglassBiologicalTreeGenerations(treeContext) {
        return await this.createBiologicalTreeGenerationsWithMarriageEntities(treeContext);
    },

    async createHourglassExtendedTreeGenerations(treeContext) {
        return await this.createExtendedTreeGenerationsWithMarriageEntities(treeContext);
    },

    async createBiologicalTreeGenerationsWithMarriageEntities(treeContext) {
        const person = await personsCache.getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.diagramFrame);

        await hourglassBiological.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const personsMarriageEntities = await hourglassBiological.createMarriageEntitiesWithSpousesWithCommonChildrenOfPerson(context, context.person, 0);
        const personsGeneration = { marriageEntities: personsMarriageEntities };

        const siblings = await hourglassBiological.createSiblingsOf(context, person);
        personsGeneration.marriageEntities.push(...siblings);

        await hourglassBiological.createDescendantsOf(context, person);
        const descendantsGenerations = sortByLevelAndConvertToArray(context.descendantsGenerationsMap);

        this.removeDuplicatedMarriageEntities([personsGeneration]);
        sortMarriageEntitiesByBirthDate([personsGeneration]);

        this.removeDuplicatedMarriageEntities(descendantsGenerations);
        sortMarriageEntitiesByBirthDate(descendantsGenerations);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descendantsGenerations);

        if (treeContext.balance) {
            addUnknownAncestors(person, generations, false, true);
            //addPlaceholderDescendants(descendantsGenerations);
        }

        createMarriageEntitiesGroups(generations);
        createSiblingsGroups(generations);

        // sort unknown ancestors
        sortParentsSiblingsGroupsByChildren(ancestorsGenerations);

        return generations;
    },

    async createExtendedTreeGenerationsWithMarriageEntities(treeContext) {
        const person = await personsCache.getPersonJson(treeContext.personId);
        person.isHighlighted = true;

        const processedPersonIds = createProcessedPersonIds();
        const context = this.createIterationContext(person, processedPersonIds, new Map(), new Map(), treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.diagramFrame);

        await hourglassExtended.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const personsMarriageEntities = await hourglassExtended.createMarriageEntitiesWithSpousesOfPerson(context, person, 0);
        const personsGeneration = { marriageEntities: personsMarriageEntities };

        const siblings = await hourglassExtended.createSiblingsOf(context);
        personsGeneration.marriageEntities.push(...siblings);

        await hourglassExtended.createDescendantsOf(context);
        const descendantsGenerations = sortByLevelAndConvertToArray(context.descendantsGenerationsMap);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descendantsGenerations);
        this.removeDuplicatedMarriageEntities(generations);
        sortMarriageEntitiesByBirthDate(generations);

        if (treeContext.balance) {
            addUnknownAncestors(person, generations, false, true);
            //addPlaceholderDescendants(descendantsGenerations);
        }

        createMarriageEntitiesGroups(generations);
        createSiblingsGroups(generations);
        sortParentsSiblingsGroupsByChildren(generations.slice(0, generations.indexOf(personsGeneration) + 1));

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

    removeDuplicatedMarriageEntities(generations) {
        generations.forEach(generation => {
            const existingMarriageEntitiesJsons = new Set();

            generation.marriageEntities = generation.marriageEntities.filter(marriageEntity => {
                const marriageEntityJson = JSON.stringify(marriageEntity);

                if (existingMarriageEntitiesJsons.has(marriageEntityJson)) {
                    return false;
                }

                existingMarriageEntitiesJsons.add(marriageEntityJson);
                return true;
            });
        });
    }
}