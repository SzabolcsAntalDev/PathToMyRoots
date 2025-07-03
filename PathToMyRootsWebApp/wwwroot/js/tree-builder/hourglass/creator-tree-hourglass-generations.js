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
        loadingTextManager.setLoadingProgressText(loadingTextContainerParent, `Number of persons found:<br>1`);

        person.isHighlighted = true;

        const context = this.createIterationContext(person, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await hourglassBiological.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);
        await hourglassBiological.addUnknownAncestorsOf(ancestorsGenerations, person);

        const personsExtendedMarriages = await hourglassBiological.createExtendedMarriagesOfPerson(context, context.person);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };
        const siblings = await hourglassBiological.createSiblingsOf(context, person);
        personsGeneration.extendedMarriages.push(...siblings);
        sortExtendedMarriagesByBirthDate([personsGeneration]);
        sortExtendedMarriagesBySpouses([personsGeneration]);

        await hourglassBiological.createDescedantsOf(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        this.removeDuplicatedPersons(descedantsGenerations);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);
        sortExtendedMarriagesBySpouses(descedantsGenerations);

        return ancestorsGenerations.concat(personsGeneration).concat(descedantsGenerations);
    },

    async createExtendedTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const person = await getPersonJson(personId);
        loadingTextManager.setLoadingProgressText(loadingTextContainerParent, `Number of persons found:<br>1`);

        person.isHighlighted = true;

        const context = this.createIterationContext(person, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await hourglassExtended.createKnownAncestorsOf(context);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const personsExtendedMarriages = await hourglassExtended.createExtendedMarriagesOfPerson(context, person);
        const personsGeneration = { extendedMarriages: personsExtendedMarriages };
        const siblings = await hourglassExtended.createSiblingsOf(context);
        personsGeneration.extendedMarriages.push(...siblings);
        sortExtendedMarriagesByBirthDate([personsGeneration]);
        sortExtendedMarriagesBySpouses([personsGeneration]);

        await hourglassExtended.createDescedantsOf(context);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);
        sortExtendedMarriagesBySpouses(descedantsGenerations);

        const generations = ancestorsGenerations.concat(personsGeneration).concat(descedantsGenerations);
        this.removeDuplicatedPersons(generations);

        return generations;
    },

    createIterationContext(person, processedPersonIds, ancestorsGenerationsMap, descedantsGenerationsMap, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        return {
            person: person,
            processedPersonIds: processedPersonIds,
            ancestorsGenerationsMap: ancestorsGenerationsMap,
            descedantsGenerationsMap: descedantsGenerationsMap,
            ancestorsDepth: ancestorsDepth,
            descedantsDepth: descedantsDepth,
            loadingTextContainerParent: loadingTextContainerParent
        };
    },

    createSiblingsAndSiblingsChains(generations) {
        createSiblings(generations);
        createSiblingsChains(generations);
        return generations;
    },

    removeDuplicatedPersons(generations) {
        generations.forEach(generation => {

            const withoutDuplicatedPairs = [];
            generation.extendedMarriages.forEach(extendedMarriage => {
                if (!this.pairAlreadyExists(withoutDuplicatedPairs, extendedMarriage)) {
                    withoutDuplicatedPairs.push(extendedMarriage);
                }
            });

            const withoutDuplicatedSingles = [];
            withoutDuplicatedPairs.forEach(extendedMarriage => {
                if (!this.singleAlreadyExists(withoutDuplicatedSingles, extendedMarriage)) {
                    withoutDuplicatedSingles.push(extendedMarriage);
                }
            });

            const withoutSinglesInCouples = [];
            withoutDuplicatedSingles.forEach(extendedMarriage => {
                if (!this.singleAlreadyExistsInCouple(withoutSinglesInCouples, extendedMarriage)) {
                    withoutSinglesInCouples.push(extendedMarriage);
                }
            });

            generation.extendedMarriages = withoutSinglesInCouples;
        });
    },

    pairAlreadyExists(withoutDuplicatedPairs, targetExtendedMarriage) {
        const targetMaleId = targetExtendedMarriage.mainMarriage.male?.id;
        const targetFemaleId = targetExtendedMarriage.mainMarriage.female?.id;

        if (!targetMaleId || !targetFemaleId) {
            return false;
        }

        return withoutDuplicatedPairs.some(extendedMarriage => {
            const maleId = extendedMarriage.mainMarriage.male?.id;
            const femaleId = extendedMarriage.mainMarriage.female?.id;

            if (!maleId || !femaleId) {
                return false;
            }

            return maleId == targetMaleId && femaleId == targetFemaleId;
        });
    },

    singleAlreadyExists(withoutDuplicatedSingles, targetExtendedMarriage) {
        const targetMaleId = targetExtendedMarriage.mainMarriage.male?.id;
        const targetFemaleId = targetExtendedMarriage.mainMarriage.female?.id;

        if (targetMaleId && targetFemaleId) {
            return false;
        }

        return withoutDuplicatedSingles.some(extendedMarriage => {
            const maleId = extendedMarriage.mainMarriage.male?.id;
            const femaleId = extendedMarriage.mainMarriage.female?.id;

            if (maleId && femaleId) {
                return false;
            }

            return maleId == targetMaleId && femaleId == targetFemaleId;
        });
    },

    singleAlreadyExistsInCouple(withoutSinglesInCouples, targetExtendedMarriage) {
        const targetMaleId = targetExtendedMarriage.mainMarriage.male?.id;
        const targetFemaleId = targetExtendedMarriage.mainMarriage.female?.id;

        if (targetMaleId && targetFemaleId) {
            return false;
        }

        return withoutSinglesInCouples.some(extendedMarriage => {
            const maleId = extendedMarriage.mainMarriage.male?.id;
            const femaleId = extendedMarriage.mainMarriage.female?.id;

            if (!maleId || !femaleId) {
                return false;
            }

            return maleId == targetMaleId || femaleId == targetFemaleId;
        });
    }
}