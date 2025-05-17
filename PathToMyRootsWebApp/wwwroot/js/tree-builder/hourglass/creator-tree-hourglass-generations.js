let fakeId = -10000;

const hourglassTreeCreator = {

    async createHourglassExtendedTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generations = await this.createExtendedTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
        return this.sortExtendedMarriagesAndCreateSiblingsChains(generations);
    },

    async createHourglassWithAdoptiveTreeGenerations(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const generations = await this.createWithAdoptiveTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent);
        return this.sortExtendedMarriagesAndCreateSiblingsChains(generations);
    },

    sortExtendedMarriagesAndCreateSiblingsChains(generations) {
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

    async createExtendedTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const person = await getPersonJson(personId);
        person.isHighlighted = true;

        const context = this.createIterationContext(false, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await this.createKnownAncestorsRecursive(context, person.id, person.biologicalFatherId, person.adoptiveFatherId, -1);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);
        this.addUnknownAncestors(ancestorsGenerations);

        const generation0 = await this.createGeneration0(context, person);

        await this.createDescedants(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);

        return ancestorsGenerations.concat(generation0).concat(descedantsGenerations);
    },

    async createWithAdoptiveTreeGenerationsExtendedMarriages(personId, ancestorsDepth, descedantsDepth, loadingTextContainerParent) {
        const person = await getPersonJson(personId);
        person.isHighlighted = true;

        const context = this.createIterationContext(true, new Set([personId]), new Map(), new Map(), ancestorsDepth, descedantsDepth, loadingTextContainerParent);

        await this.createKnownAncestorsRecursive(context, person.id, person.biologicalFatherId, person.adoptiveFatherId, -1);
        const ancestorsGenerations = sortByLevelAndConvertToArray(context.ancestorsGenerationsMap);

        const generation0 = await this.createGeneration0(context, person);

        await this.createDescedants(context, person);
        const descedantsGenerations = sortByLevelAndConvertToArray(context.descedantsGenerationsMap);
        sortExtendedMarriagesByBirthDate(descedantsGenerations);

        return ancestorsGenerations.concat(generation0).concat(descedantsGenerations);
    },

    async createKnownAncestorsRecursive(context, childId, biologicalFatherId, adoptiveFatherId, currentLevel) {
        if (!biologicalFatherId && (context.includeAdoptive && !adoptiveFatherId))
            return;

        if (currentLevel < -context.ancestorsDepth) {
            return;
        }

        if (biologicalFatherId) {
            const biologicalFather = await getPersonJson(biologicalFatherId);

            let mainMarriage;
            let biologicalMotherId;
            let biologicalMothersBiologicalFatherId;
            let biologicalMothersAdoptiveFatherId;

            if (biologicalFather.firstSpouseId != null && biologicalFather.secondSpouseId == null) { // single married male
                biologicalMotherId = biologicalFather.firstSpouseId;
                const biologicalMother = await getPersonJson(biologicalMotherId);

                mainMarriage = {
                    male: biologicalFather,
                    female: biologicalMother,
                    marriage: createMarriage(biologicalFather, biologicalMother, true)
                }

                biologicalMotherId = biologicalMother.id;
                biologicalMothersBiologicalFatherId = biologicalMother.biologicalFatherId;
                biologicalMothersAdoptiveFatherId = biologicalMother.adoptiveFatherId;

                context.processedPersonIds.add(biologicalFather.id);
                context.processedPersonIds.add(biologicalMother.id);
            }

            if (biologicalFather.firstSpouseId != null && biologicalFather.secondSpouseId != null) { // double married male
                const firstWife = await getPersonJson(biologicalFather.firstSpouseId);
                let biologicalMother = (firstWife.inverseBiologicalMother.map(e => e.id).includes(childId))
                    ? firstWife
                    : await getPersonJson(biologicalFather.secondSpouseId);

                mainMarriage = {
                    male: biologicalFather,
                    female: biologicalMother,
                    marriage: createMarriage(biologicalFather, biologicalMother, true)
                }

                biologicalMotherId = biologicalMother.id;
                biologicalMothersBiologicalFatherId = biologicalMother.biologicalFatherId;
                biologicalMothersAdoptiveFatherId = biologicalMother.adoptiveFatherId;

                context.processedPersonIds.add(biologicalFather.id);
                context.processedPersonIds.add(biologicalMother.id);
            }

            // Szabi
            // numberOfAvailableParents will be set when adding unknown parents
            const extendedMarriage = {
                mainMarriage: mainMarriage,
                numberOfAvailableParents: 2
            }

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                context.ancestorsGenerationsMap.set(currentLevel, newGeneration);
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(extendedMarriage);

            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            await this.createKnownAncestorsRecursive(context, biologicalFather.id, biologicalFather.biologicalFatherId, biologicalFather.adoptiveFatherId, currentLevel - 1);
            await this.createKnownAncestorsRecursive(context, biologicalMotherId, biologicalMothersBiologicalFatherId, biologicalMothersAdoptiveFatherId, currentLevel - 1);
        }

        if (context.includeAdoptive && adoptiveFatherId) {
            const adoptiveFather = await getPersonJson(adoptiveFatherId);
            const generation0 = await this.createGeneration0(context, adoptiveFather);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                context.ancestorsGenerationsMap.set(currentLevel, newGeneration);
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...generation0.extendedMarriages);
        }
    },

    addUnknownAncestors(generations) {
        if (generations.length < 2) {
            return;
        }

        let childrenLevel = generations.length - 1;

        while (true) {
            const parents = generations[childrenLevel - 1];
            const children = generations[childrenLevel];

            if (!parents || !children) {
                return;
            }

            let coupleIndex = 0;

            children.extendedMarriages.forEach(childExtendedMarriage => {
                const maleId = childExtendedMarriage.mainMarriage.male?.id;
                const femaleId = childExtendedMarriage.mainMarriage.female?.id;

                const malesFatherId = childExtendedMarriage.mainMarriage.male?.biologicalFatherId;
                const femalesFatherId = childExtendedMarriage.mainMarriage.female?.biologicalFatherId;

                const malesParentsExtendedMarriageIndex = coupleIndex * 2;
                const femalesParentsExtendedMarriageIndex = malesParentsExtendedMarriageIndex + 1;

                const fatherIdOnMalesFatherIndex = parents.extendedMarriages[malesParentsExtendedMarriageIndex]?.mainMarriage.male.id;

                // malesFatherId != fatherIdOnMalesFatherIndex will be true if the index of the male's father
                // is occupied by a father that should be more the right - so that one should be shifted
                if (!malesFatherId || malesFatherId != fatherIdOnMalesFatherIndex) {
                    const male = this.createFakeMale(maleId);
                    const female = this.createFakeFemale(maleId);
                    const fakeExtendedMarriage = this.createFakeExtendedMarriage(male, female);
                    parents.extendedMarriages.splice(malesParentsExtendedMarriageIndex, 0, fakeExtendedMarriage);
                }

                const fatherIdOnFemalesFatherIndex = parents.extendedMarriages[femalesParentsExtendedMarriageIndex]?.mainMarriage.male.id;
                if (!femalesFatherId || femalesFatherId != fatherIdOnFemalesFatherIndex) {
                    const male = this.createFakeMale(femaleId);
                    const female = this.createFakeFemale(femaleId);
                    const fakeExtendedMarriage = this.createFakeExtendedMarriage(male, female);
                    parents.extendedMarriages.splice(femalesParentsExtendedMarriageIndex, 0, fakeExtendedMarriage);
                }

                coupleIndex++;
            });
            childrenLevel--;

            if (childrenLevel == 0) {
                generations[0].extendedMarriages.forEach(extendedMarriage => {
                    extendedMarriage.numberOfAvailableParents = 0;
                });

                return;
            }
        }
    },

    // creates the nodes with person and its first and second spouse
    async createGeneration0(context, person) {
        let extendedMarriageLeft;
        let extendedMarriageRight;

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null && male.secondSpouseId == null) { // | MALE | -----
                extendedMarriageLeft = {
                    mainMarriage: {
                        male: male
                    },
                    numberOfAvailableParents: (male.biologicalFatherId || male.biologicalMotherId) ? 1 : 0
                }

                context.processedPersonIds.add(male.id);
            }

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // | MALE | female | ----
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                extendedMarriageLeft = {
                    mainMarriage: {
                        male: male,
                        female: firstWife,
                        marriage: createMarriage(male, firstWife, true)
                    },
                    numberOfAvailableParents: (male.biologicalFatherId || male.biologicalMotherId) ? 1 : 0
                }

                context.processedPersonIds.add(male.id);
                context.processedPersonIds.add(firstWife.id);
            }
            if (male.firstSpouseId != null && male.secondSpouseId != null) { // | ???? | - l l - | MALE | female | -----
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriageLeft = {
                    mainMarriage: {
                        female: firstWife
                    },
                    numberOfAvailableParents: 0
                }

                extendedMarriageRight = {
                    secondaryMarriage: createMarriage(male, firstWife, false),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true)
                    },
                    numberOfAvailableParents: (male.biologicalFatherId || male.biologicalMotherId) ? 1 : 0
                }

                context.processedPersonIds.add(male.id);
                context.processedPersonIds.add(firstWife.id);
                context.processedPersonIds.add(secondWife.id);
            }

        }
        else {
            const female = person;

            if (female.firstSpouseId == null && female.secondSpouseId == null) { // | FEMALE | -----
                extendedMarriageLeft = {
                    mainMarriage: {
                        female: female
                    },
                    numberOfAvailableParents: (female.biologicalFatherId || female.biologicalMotherId) ? 1 : 0
                }

                context.processedPersonIds.add(female.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // | FEMALE | male | ----
                const firstHusbandId = female.firstSpouseId;
                const firstHusband = await getPersonJson(firstHusbandId);

                extendedMarriageLeft = {
                    mainMarriage: {
                        male: firstHusband,
                        female: female,
                        marriage: createMarriage(firstHusband, female, true)
                    },
                    numberOfAvailableParents: (female.biologicalFatherId || female.biologicalMotherId) ? 1 : 0
                }

                context.processedPersonIds.add(female.id);
                context.processedPersonIds.add(firstHusband.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId != null) { // | male | FEMALE | - l l - | male | -----
                const firstHusband = await getPersonJson(female.firstSpouseId);
                const secondHusband = await getPersonJson(female.secondSpouseId);

                extendedMarriageLeft = {
                    mainMarriage: {
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true)
                    },
                    numberOfAvailableParents: (female.biologicalFatherId || female.biologicalMotherId) ? 1 : 0
                }

                extendedMarriageRight = {
                    secondaryMarriage: createMarriage(firstHusband, female, false),
                    mainMarriage: {
                        male: firstHusband,
                    },
                    numberOfAvailableParents: 0
                }

                context.processedPersonIds.add(female.id);
                context.processedPersonIds.add(firstHusband.id);
                context.processedPersonIds.add(secondHusband.id);
            }
        }

        const extendedMarriages = [];
        if (extendedMarriageLeft != null) {
            extendedMarriages.push(extendedMarriageLeft);
        }

        if (extendedMarriageRight != null) {
            extendedMarriages.push(extendedMarriageRight);
        }

        const generation = {
            extendedMarriages: extendedMarriages,
        };

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        return generation;
    },

    async createDescedants(context, person) {
        const currentLevel = 0;

        const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const child of biologicalChildren) {
            await this.createDescedantsRecursive(context, child.id, currentLevel + 1);
        }

        if (currentLevel + 1 > context.descedantsDepth) {
            return;
        }

        if (context.includeAdoptive) {
            const adoptiveChildren = (person.inverseAdoptiveFather ?? []).concat(person.inverseAdoptiveMother ?? []);

            for (const child of adoptiveChildren) {
                const generation0Inner = await this.createGeneration0(context, child);

                if (!context.descedantsGenerationsMap.has(currentLevel + 1)) {
                    const newGeneration = {};
                    newGeneration.extendedMarriages = [];
                    context.descedantsGenerationsMap.set(currentLevel + 1, newGeneration);
                }

                const generation = context.descedantsGenerationsMap.get(currentLevel + 1);
                generation.extendedMarriages.push(...generation0Inner.extendedMarriages);
            }
        }
    },

    async createDescedantsRecursive(context, personId, currentLevel) {
        if (!personId || context.processedPersonIds.has(personId)) {
            return;
        }

        if (currentLevel > context.descedantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);
        const generation0 = await this.createGeneration0(context, person);

        if (!context.descedantsGenerationsMap.has(currentLevel)) {
            const newGeneration = {};
            newGeneration.extendedMarriages = [];
            context.descedantsGenerationsMap.set(currentLevel, newGeneration);
        }

        const generation = context.descedantsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(...generation0.extendedMarriages);

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const child of biologicalChildren) {
            await this.createDescedantsRecursive(context, child.id, currentLevel + 1);
        }

        if (currentLevel + 1 > context.descedantsDepth) {
            return;
        }

        if (context.includeAdoptive) {
            const adoptiveChildren = (person.inverseAdoptiveFather ?? []).concat(person.inverseAdoptiveMother ?? []);

            for (const child of adoptiveChildren) {
                const generation0Inner = await this.createGeneration0(context, child);

                if (!context.descedantsGenerationsMap.has(currentLevel + 1)) {
                    const newGeneration = {};
                    newGeneration.extendedMarriages = [];
                    context.descedantsGenerationsMap.set(currentLevel + 1, newGeneration);
                }

                const generation = context.descedantsGenerationsMap.get(currentLevel + 1);
                generation.extendedMarriages.push(...generation0Inner.extendedMarriages);
            }
        }
    },

    createFakeMale(childId) {
        fakeId++;
        const male = {
            fakeId: fakeId,
            id: fakeId,
            isMale: true,
            inverseBiologicalFather: [{ id: childId }],
            inverseAdoptiveFather: []
        };
        return male;
    },

    createFakeFemale(childId) {
        fakeId++;
        const female = {
            fakeId: fakeId,
            id: fakeId,
            isMale: false,
            inverseBiologicalMother: [{ id: childId }],
            inverseAdoptiveMother: []
        };
        return female;
    },

    createFakeExtendedMarriage(male, female) {
        male.firstSpouseId = female.fakeId;
        female.firstSpouseId = male.fakeId;

        return {
            mainMarriage: {
                male: male,
                female: female,
                marriage: createMarriage(male, female, true, true)
            },
            numberOfAvailableParents: 2
        };
    }
}