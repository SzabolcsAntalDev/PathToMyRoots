const completeTreeCreator = {
    async createCompleteTreeGenerations(treeContext) {
        const generations = await this.createGenerationsWithMarriageEntities(treeContext);
        const personsGeneration = this.getPersonsGeneration(treeContext.personId, generations);

        sortMarriageEntitiesByBirthDate(generations);

        if (treeContext.balanceAncestors || treeContext.balanceDescendants) {
            const person = await personsCache.getPersonJson(treeContext.personId);
            const additionPersonIdObject = { value: -1 };

            if (treeContext.balanceAncestors) {
                addUnknownAncestors(person, generations, additionPersonIdObject, false, false);
            }

            if (treeContext.balanceDescendants) {
                addPlaceholderDescendants(person, generations, additionPersonIdObject, false);
            }
        }

        createMarriageEntitiesGroups(generations);
        createSiblingsGroups(generations);
        sortParentsSiblingsGroupsByChildren(generations.slice(0, generations.indexOf(personsGeneration) + 1));

        return generations;
    },

    async createGenerationsWithMarriageEntities(treeContext) {
        const processedPersonIds = createProcessedPersonIds();
        const generationsMap = new Map();

        const context = this.createIterationContext(treeContext.personId, processedPersonIds, generationsMap, treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.diagramFrame)

        await this.createGenerationsWithMarriageEntitiesRecursive(context, treeContext.personId, 0);
        const generations = sortByLevelAndConvertToArray(generationsMap);
        const duplicatedPersonIds = processedPersonIds.getDuplicatedPersonIds();

        return this.removeDuplicatedPersonsFromDifferentLevels(generations, duplicatedPersonIds)
    },

    createIterationContext(sourcePersonId, processedPersonIds, generationsMap, ancestorsDepth, descendantsDepth, diagramFrame) {
        return {
            sourcePersonId: sourcePersonId,
            processedPersonIds: processedPersonIds,
            generationsMap: generationsMap,
            ancestorsDepth: ancestorsDepth,
            descendantsDepth: descendantsDepth,
            diagramFrame: diagramFrame
        };
    },

    async createGenerationsWithMarriageEntitiesRecursive(context, personId, currentLevel) {
        if (!personId || context.processedPersonIds.containsOnSameLevel(currentLevel, personId)) {
            return;
        }

        if ((context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) || (context.descendantsDepth >= 0) && currentLevel > context.descendantsDepth) {
            return;
        }

        const person = await personsCache.getPersonJson(personId);
        if (person.id == context.sourcePersonId) {
            // person not found is placeholder
            person.isHighlighted = !person.isPlaceholder;
        }

        if (!context.generationsMap.has(currentLevel)) {
            context.generationsMap.set(currentLevel, { marriageEntities: [] });
        }

        const generation = context.generationsMap.get(currentLevel);

        if (context.processedPersonIds.containsOnAnyOtherLevel(personId)) {
            context.processedPersonIds.add(currentLevel, personId);

            const duplicatedMarriageEntity = {
                male: person?.isMale ? person : null,
                female: person?.isMale ? null : person
            }

            generation.marriageEntities.push(duplicatedMarriageEntity);

            return;
        }

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null) { // MALE
                generation.marriageEntities.push({
                    male: male
                });

                context.processedPersonIds.add(currentLevel, male.id);
            }

            if (male.firstSpouseId != null) { // MALE firstWife
                const firstWifeId = male.firstSpouseId;
                const firstWife = await personsCache.getPersonJson(firstWifeId);

                generation.marriageEntities.push({
                    male: male,
                    female: firstWife,
                    marriage: createMarriage(male, firstWife, true)
                });

                context.processedPersonIds.add(currentLevel, male.id);
                context.processedPersonIds.add(currentLevel, firstWife.id);
            }

            if (male.secondSpouseId != null) { // MALE secondWife
                const secondWifeId = male.secondSpouseId;
                const secondWife = await personsCache.getPersonJson(secondWifeId);

                generation.marriageEntities.push({
                    male: male,
                    female: secondWife,
                    marriage: createMarriage(male, secondWife, true)
                });

                context.processedPersonIds.add(currentLevel, male.id);
                context.processedPersonIds.add(currentLevel, secondWife.id);
            }
        }
        else {
            const female = person;

            if (female.firstSpouseId == null) { // FEMALE
                generation.marriageEntities.push({
                    female: female,
                });

                context.processedPersonIds.add(currentLevel, female.id);
            }
        }

        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        await this.createGenerationsWithMarriageEntitiesRecursive(context, person.biologicalFatherId, currentLevel - 1);
        await this.createGenerationsWithMarriageEntitiesRecursive(context, person.adoptiveFatherId, currentLevel - 1);

        if (person.firstSpouse != null) {
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.firstSpouse.id, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.firstSpouse.firstSpouseId, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.firstSpouse.secondSpouseId, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.firstSpouse.biologicalFatherId, currentLevel - 1);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.firstSpouse.adoptiveFatherId, currentLevel - 1);
        }

        if (person.secondSpouse != null) {
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.secondSpouse.id, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.secondSpouse.firstSpouseId, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.secondSpouse.secondSpouseId, currentLevel);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.secondSpouse.biologicalFatherId, currentLevel - 1);
            await this.createGenerationsWithMarriageEntitiesRecursive(context, person.secondSpouse.adoptiveFatherId, currentLevel - 1);
        }

        const children = (person.inverseBiologicalFather ?? [])
            .concat(person.inverseBiologicalMother ?? [])
            .concat(person.inverseAdoptiveFather ?? [])
            .concat(person.inverseAdoptiveMother ?? []);

        for (const child of children) {
            await this.createGenerationsWithMarriageEntitiesRecursive(context, child.id, currentLevel + 1);
        }
    },

    // removes the persons which are single and do not have parents
    // also removes generations which become empty, for instance when a person
    // is duplicated and alone on the very top level
    removeDuplicatedPersonsFromDifferentLevels(generations, duplicatedPersonIds) {
        for (let i = 0; i < generations.length; i++) {
            const parentsGeneration = generations[i - 1];
            const childrenGeneration = generations[i];

            if (childrenGeneration) {
                let childIdsInParentsGeneration = null;

                childrenGeneration.marriageEntities = childrenGeneration.marriageEntities.filter(marriageEntity => {
                    if (marriageEntity.marriage) {
                        return true;
                    }

                    const person = marriageEntity.male ?? marriageEntity.female;

                    // if person is not duplicated
                    if (!duplicatedPersonIds.has(person?.id)) {
                        return true;
                    }

                    childIdsInParentsGeneration = childIdsInParentsGeneration ?? this.getChildIdsInParentsGeneration(parentsGeneration);
                    return childIdsInParentsGeneration.has(person.id);
                });
            }
        }

        return generations.filter(generation => generation.marriageEntities.length > 0);
    },

    getChildIdsInParentsGeneration(parentsGeneration) {
        const childIdsInParentsGeneration = new Set();

        for (const marriageEntity of parentsGeneration?.marriageEntities ?? []) {
            for (const childId of marriageEntity.marriage?.inverseParentIds ?? []) {
                childIdsInParentsGeneration.add(childId);
            }
        }

        return childIdsInParentsGeneration;
    },

    getPersonsGeneration(personId, generations) {
        return generations.find(generation =>
            generation.marriageEntities.some(marriageEntity => {
                const maleId = marriageEntity.male?.id;
                const femaleId = marriageEntity.female?.id;

                return (maleId == personId) || (femaleId == personId);
            })
        );
    }
}