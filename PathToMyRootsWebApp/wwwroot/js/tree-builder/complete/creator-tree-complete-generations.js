const completeTreeCreator = {
    async createCompleteTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generations = await this.createGenerationsWithExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        sortExtendedMarriagesByBirthDate(generations);
        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    async createGenerationsWithExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generationsMap = new Map();
        const context = this.createIterationContext(personId, createProcessedPersonIds(), generationsMap, ancestorsDepth, descedantsDepth, loadingTextContainerParent)

        await this.createGenerationsRecursive(context, personId, 0);
        return sortByLevelAndConvertToArray(generationsMap);
    },

    createIterationContext(sourcePersonId, processedPersonIds, generationsMap, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        return {
            sourcePersonId: sourcePersonId,
            processedPersonIds: processedPersonIds,
            generationsMap: generationsMap,
            ancestorsDepth: ancestorsDepth,
            descedantsDepth: descedantsDepth,
            loadingTextContainerParent: loadingTextContainerParent
        };
    },

    async createGenerationsRecursive(context, personId, currentLevel) {
        if (!personId || context.processedPersonIds.containsOnSameLevel(currentLevel, personId)) {
            return;
        }

        if ((context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) || (context.descedantsDepth >= 0) && currentLevel > context.descedantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);
        if (person.id == context.sourcePersonId) {
            person.isHighlighted = true;
        }

        if (context.processedPersonIds.containsOnAnyOtherLevel(personId)) {
            person.isDuplicated = true;
            const personClone = structuredClone(person);
            personClone.isDuplicated = true;
            const duplicatedPersonsExtendedMarriage = {
                mainMarriage: {
                    male: personClone?.isMale ? personClone : null,
                    female: personClone?.isMale ? null : personClone
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
                context.generationsMap.set(currentLevel, { extendedMarriages : [] });
            }

            const generation = context.generationsMap.get(currentLevel);
            generation.extendedMarriages.push(extendedMarriage);
        }

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getSize()}`);

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
    }
}