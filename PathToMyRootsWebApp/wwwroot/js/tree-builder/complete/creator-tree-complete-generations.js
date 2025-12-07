const completeTreeCreator = {
    async createCompleteTreeGenerations(treeContext) {
        const generations = await this.createGenerationsWithExtendedMarriages(treeContext);

        sortExtendedMarriagesByBirthDate(generations);
        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    async createGenerationsWithExtendedMarriages(treeContext) {
        const processedPersonIds = createProcessedPersonIds();
        const generationsMap = new Map();

        const context = this.createIterationContext(treeContext.personId, processedPersonIds, generationsMap, treeContext.ancestorsDepth, treeContext.descendantsDepth, treeContext.treeDiagramFrame)

        await this.createGenerationsRecursive(context, treeContext.personId, 0);
        const generations = sortByLevelAndConvertToArray(generationsMap);
        const duplicatedPersonIds = processedPersonIds.getDuplicatedPersonIds();

        return this.removeDuplicatedPersonsFromDifferentLevels(generations, duplicatedPersonIds);
    },

    createIterationContext(sourcePersonId, processedPersonIds, generationsMap, ancestorsDepth, descendantsDepth, treeDiagramFrame) {
        return {
            sourcePersonId: sourcePersonId,
            processedPersonIds: processedPersonIds,
            generationsMap: generationsMap,
            ancestorsDepth: ancestorsDepth,
            descendantsDepth: descendantsDepth,
            treeDiagramFrame: treeDiagramFrame
        };
    },

    async createGenerationsRecursive(context, personId, currentLevel) {
        if (!personId || context.processedPersonIds.containsOnSameLevel(currentLevel, personId)) {
            return;
        }

        if ((context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) || (context.descendantsDepth >= 0) && currentLevel > context.descendantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);
        if (person.id == context.sourcePersonId) {
            person.isHighlighted = true;
        }

        if (context.processedPersonIds.containsOnAnyOtherLevel(personId)) {
            context.processedPersonIds.add(currentLevel, personId);
            const duplicatedPersonsExtendedMarriage = {
                mainMarriage: {
                    male: person?.isMale ? person : null,
                    female: person?.isMale ? null : person
                }
            }

            if (!context.generationsMap.has(currentLevel)) {
                context.generationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.generationsMap.get(currentLevel);
            generation.extendedMarriages.push(duplicatedPersonsExtendedMarriage);

            return;
        }

        const extendedMarriage = {};
        const mainMarriage = {};
        let firstWifesFirstSpouseId;
        let secondWifesFirstSpouseId;

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null && male.secondSpouseId == null) { // MALE
                mainMarriage.male = male;
                context.processedPersonIds.add(currentLevel, male.id);
            }

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // single married male
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId == null) { // MALE female

                    mainMarriage.male = male;
                    mainMarriage.female = firstWife;
                    mainMarriage.marriage = createMarriage(male, firstWife, true, true);

                    context.processedPersonIds.add(currentLevel, male.id);
                    context.processedPersonIds.add(currentLevel, firstWife.id);
                }

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId != null) { // single married male with double married female

                    if (firstWife.firstSpouseId == male.id) { // ? ? - MALE
                        extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false, true);
                        mainMarriage.male = male;

                        context.processedPersonIds.add(currentLevel, male.id);
                        // firstWife should be processed in a later iteration
                    }

                    if (firstWife.secondSpouseId == male.id) { // MALE female - ?
                        mainMarriage.male = male;
                        mainMarriage.female = firstWife;
                        mainMarriage.marriage = createMarriage(male, firstWife, true, true);

                        context.processedPersonIds.add(currentLevel, male.id);
                        context.processedPersonIds.add(currentLevel, firstWife.id);

                        // if MALE female - male then firstWife's firstSpouse should be created inclusively
                        firstWifesFirstSpouseId = firstWife.firstSpouseId;
                    }
                }
            }
            if (male.firstSpouseId != null && male.secondSpouseId != null) { // ? - MALE female
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false, true);

                mainMarriage.male = male;
                mainMarriage.female = secondWife;
                mainMarriage.marriage = createMarriage(male, secondWife, true, true);

                context.processedPersonIds.add(currentLevel, male.id);
                context.processedPersonIds.add(currentLevel, secondWife.id);

                // if - MALE female - male then secondWife's firstSpouse should be created inclusively
                secondWifesFirstSpouseId = secondWife.firstSpouseId;
            }

        }
        else {
            const female = person;

            if (female.firstSpouseId == null && female.secondSpouseId == null) { // FEMALE
                mainMarriage.female = female;
                context.processedPersonIds.add(currentLevel, female.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // single married female
                const husbandId = female.firstSpouseId;
                const husband = await getPersonJson(husbandId);

                if (husband.firstSpouseId != null && husband.secondSpouseId == null) { // male FEMALE
                    mainMarriage.male = husband;
                    mainMarriage.female = female;
                    mainMarriage.marriage = createMarriage(husband, female, true, true);

                    context.processedPersonIds.add(currentLevel, female.id);
                    context.processedPersonIds.add(currentLevel, husband.id);
                }

                if (husband.firstSpouseId == female.id && husband.secondSpouseId != null) { // FEMALE - ? ?
                    mainMarriage.female = female;
                    context.processedPersonIds.add(currentLevel, female.id);
                }

                if (husband.firstSpouseId != null && husband.secondSpouseId == female.id) { // ? - m? FEM?
                    // female will be added in the husbands iteration
                }
            }

            if (female.firstSpouseId != null && female.secondSpouseId != null) { // m? FEM? - ?
                // female will be added in the husbands iteration
            }
        }

        if (extendedMarriage.secondaryMarriage != null || mainMarriage.male != null || mainMarriage.female != null) {
            if (mainMarriage.male != null || mainMarriage.female != null) {
                extendedMarriage.mainMarriage = mainMarriage;
            }

            if (!context.generationsMap.has(currentLevel)) {
                context.generationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.generationsMap.get(currentLevel);
            generation.extendedMarriages.push(extendedMarriage);
        }

        loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        await this.createGenerationsRecursive(context, person.biologicalFatherId, currentLevel - 1);
        await this.createGenerationsRecursive(context, person.adoptiveFatherId, currentLevel - 1);

        if (person.firstSpouse != null) {
            await this.createGenerationsRecursive(context, person.firstSpouse.id, currentLevel);
            await this.createGenerationsRecursive(context, person.firstSpouse.biologicalFatherId, currentLevel - 1);
            await this.createGenerationsRecursive(context, person.firstSpouse.adoptiveFatherId, currentLevel - 1);
        }

        if (person.secondSpouse != null) {
            await this.createGenerationsRecursive(context, person.secondSpouse.id, currentLevel);
            await this.createGenerationsRecursive(context, person.secondSpouse.biologicalFatherId, currentLevel - 1);
            await this.createGenerationsRecursive(context, person.secondSpouse.adoptiveFatherId, currentLevel - 1);
        }

        const children = (person.inverseBiologicalFather ?? [])
            .concat(person.inverseBiologicalMother ?? [])
            .concat(person.inverseAdoptiveFather ?? [])
            .concat(person.inverseAdoptiveMother ?? []);

        for (const child of children) {
            await this.createGenerationsRecursive(context, child.id, currentLevel + 1);
        }

        if (firstWifesFirstSpouseId) {
            await this.createGenerationsRecursive(context, firstWifesFirstSpouseId, currentLevel);
        }

        if (secondWifesFirstSpouseId) {
            await this.createGenerationsRecursive(context, secondWifesFirstSpouseId, currentLevel);
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

                childrenGeneration.extendedMarriages = childrenGeneration.extendedMarriages.filter(extendedMarriage => {
                    // if secondary marriage exists or main marriage has two persons
                    if (extendedMarriage.secondaryMarriage || (extendedMarriage.mainMarriage?.male && extendedMarriage.mainMarriage?.female)) {
                        return true;
                    }

                    const person = extendedMarriage.mainMarriage?.male ?? extendedMarriage.mainMarriage?.female;

                    // if person is not duplicated
                    if (!duplicatedPersonIds.has(person?.id)) {
                        return true;
                    }

                    childIdsInParentsGeneration = childIdsInParentsGeneration ?? this.getChildIdsInParentsGeneration(parentsGeneration);
                    return childIdsInParentsGeneration.has(person.id);
                });
            }
        }

        return generations.filter(generation => generation.extendedMarriages.length > 0);
    },

    getChildIdsInParentsGeneration(parentsGeneration) {
        const childIdsInParentsGeneration = new Set();

        for (const extendedMarriage of parentsGeneration?.extendedMarriages ?? []) {
            const mainMarriage = extendedMarriage.mainMarriage?.marriage;
            const secondaryMarriage = extendedMarriage.secondaryMarriage;

            const childIds = [
                ...(mainMarriage?.inverseBiologicalParentIds ?? []),
                ...(mainMarriage?.inverseAdoptiveParentIds ?? []),
                ...(secondaryMarriage?.inverseBiologicalParentIds ?? []),
                ...(secondaryMarriage?.inverseAdoptiveParentIds ?? [])
            ];

            for (const childId of childIds) {
                childIdsInParentsGeneration.add(childId);
            }
        }

        return childIdsInParentsGeneration;
    },
}