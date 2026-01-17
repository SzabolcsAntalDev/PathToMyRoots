const hourglassTreeCreator = {

    async createHourglassBiologicalTreeGenerations(treeContext) {
        return await this.createBiologicalTreeGenerationsWithMarriageEntities(treeContext);
    },

    async createHourglassExtendedTreeGenerations(treeContext) {
        return await this.createExtendedTreeGenerationsWithMarriageEntities(treeContext);
    },

    async createBiologicalTreeGenerationsWithMarriageEntities(treeContext) {
        const person = await personsCache.getPersonJson(treeContext.personId);

        // person not found is placeholder
        person.isHighlighted = !person.isPlaceholder;

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

        this.reduceMarriageEntitiesInverseParentIds(generations);

        if (treeContext.balanceAncestors || treeContext.balanceDescendants) {
            const additionPersonIdObject = { value: -1 };

            if (treeContext.balanceAncestors) {
                addUnknownAncestors(person, generations, additionPersonIdObject, false, true);
            }

            if (treeContext.balanceDescendants) {
                addPlaceholderDescendants(person, generations, additionPersonIdObject, false, true);
            }
        }

        createMarriageEntitiesGroups(generations);
        createSiblingsGroups(generations);

        // sort unknown ancestors
        sortParentsSiblingsGroupsByChildren(ancestorsGenerations);

        return generations;
    },

    async createExtendedTreeGenerationsWithMarriageEntities(treeContext) {
        const person = await personsCache.getPersonJson(treeContext.personId);

        // person not found is placeholder
        person.isHighlighted = !person.isPlaceholder;

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

        this.reduceMarriageEntitiesInverseParentIds(generations);

        if (treeContext.balanceAncestors || treeContext.balanceDescendants) {
            const additionPersonIdObject = { value: -1 };

            if (treeContext.balanceAncestors) {
                addUnknownAncestors(person, generations, additionPersonIdObject, false, true);
            }

            if (treeContext.balanceDescendants) {
                addPlaceholderDescendants(person, generations, additionPersonIdObject, false, true);
            }
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
    },

    // reduces the inverseBiologicalParentIds and inverseAdoptiveParentIds
    // to the ids of the available children, so biological and adoptive paths can be displayed correctly horizontally
    // without calling this method the inverse parent ids of the marriages would contain
    // child ids that are not actually displayed like:
    // - children of siblings of the actual person in hourglass trees
    // - children of parents that are adopted - which in case of extended trees should not be displayed
    reduceMarriageEntitiesInverseParentIds(generations) {
        for (let i = 0; i < generations.length - 1; i++) {
            const parentsGeneration = generations[i];
            const childrenGeneration = generations[i + 1];

            const childrenIds = new Set();

            for (const marriageEntity of childrenGeneration.marriageEntities) {
                const maleId = marriageEntity.male?.id;
                const femaleId = marriageEntity.female?.id;

                if (maleId) {
                    childrenIds.add(maleId);
                }

                if (femaleId) {
                    childrenIds.add(femaleId);
                }
            };

            for (const marriageEntity of parentsGeneration.marriageEntities) {
                if (marriageEntity.marriage) {

                    marriageEntity.marriage.inverseBiologicalParentIds =
                        marriageEntity.marriage.inverseBiologicalParentIds
                            .filter(id => childrenIds.has(id));

                    marriageEntity.marriage.inverseAdoptiveParentIds =
                        marriageEntity.marriage.inverseAdoptiveParentIds
                            .filter(id => childrenIds.has(id));

                    marriageEntity.marriage.inverseParentIds = marriageEntity.marriage.inverseBiologicalParentIds.concat(marriageEntity.marriage.inverseAdoptiveParentIds);
                }
            }
        }
    }
}