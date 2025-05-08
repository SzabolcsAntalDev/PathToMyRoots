let fakeId = -10000;

const hourglassTreeCreator = {
    async createHourglassTreeGenerations(personId) {
        const generations = await this.createGenerationsWithExtendedMarriages(personId);

        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    async createGenerationsWithExtendedMarriages(personId) {
        const generationsMap = new Map();

        await this.createGenerations2(personId, new Set([null]), generationsMap, 0);
        //await createGenerationsDown(personId, new Set([null]), generationsMap, 0);
        const generations = sortByLevelAndConvertToArray(generationsMap);
        /*return generations;*/
        return this.addUnknownAncestors(generations);
    },

    addUnknownAncestors(generations) {
        let i = generations.length - 2;

        while (true) {
            const children = generations[i];
            const parents = generations[i - 1];

            if (!parents || !children) {
                return generations;
            }

            let coupleIndex = 0;

            children.extendedMarriages.forEach(childExtendedMarriage => {
                const maleId = childExtendedMarriage.mainMarriage.male?.id;
                const femaleId = childExtendedMarriage.mainMarriage.female?.id;

                const malesFatherId = childExtendedMarriage.mainMarriage.male?.biologicalFatherId;
                const femalesFatherId = childExtendedMarriage.mainMarriage.female?.biologicalFatherId;

                const malesParentsExtendedMarriageIndex = coupleIndex * 2;
                const femalesParentsExtendedMarriageIndex = malesParentsExtendedMarriageIndex + 1;

                const maybeMaleFatherId = parents.extendedMarriages[malesParentsExtendedMarriageIndex]?.mainMarriage.male.id;
                if (!malesFatherId || malesFatherId != maybeMaleFatherId) {
                    const male = this.createUnknownMale(maleId);
                    const female = this.createUnknownFemale(maleId);

                    male.firstSpouseId = female.fakeId;
                    female.firstSpouseId = male.fakeId;

                    const newExtendedMarriage = {
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true, true)
                        },
                        numberOfAvailableParents: 2
                    };

                    parents.extendedMarriages.splice(malesParentsExtendedMarriageIndex, 0, newExtendedMarriage);
                }

                const maybeFemaleFatherId = parents.extendedMarriages[femalesParentsExtendedMarriageIndex]?.mainMarriage.male.id;
                if (!femalesFatherId || femalesFatherId != maybeFemaleFatherId) {
                    const male = this.createUnknownMale(femaleId);
                    const female = this.createUnknownFemale(femaleId);

                    male.firstSpouseId = female.fakeId;
                    female.firstSpouseId = male.fakeId;

                    const newExtendedMarriage = {
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true, true)
                        },
                        numberOfAvailableParents: 2
                    };

                    parents.extendedMarriages.splice(femalesParentsExtendedMarriageIndex, 0, newExtendedMarriage);
                }

                coupleIndex++;
            });
            i--;

            if (i == 0) {
                generations[0].extendedMarriages.forEach(extendedMarriage => {
                    extendedMarriage.numberOfAvailableParents = 0;
                });
                return generations;
            }
        }
    },

    sortByLevelAndConvertToArray(generationsMap) {
        return Array.from(generationsMap.entries())
            .sort((a, b) => a[0] - b[0])
            .map(([_, value]) => value);
    },

    async createGenerations2(personId, processedPersonIds, generationsMap, currentLevel) {
        if (personId == null || processedPersonIds.has(personId))
            return;

        const person = await getPersonJson(personId);
        const extendedMarriage = {};
        const mainMarriage = {};
        let firstWifesFirstSpouseId;

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null && male.secondSpouseId == null) { // | male | -----
                mainMarriage.male = male;
                processedPersonIds.add(male.id);
            }

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // single married male
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId == null) { // | MALE | female | -----

                    mainMarriage.male = male;
                    mainMarriage.female = firstWife;
                    mainMarriage.marriage = createMarriage(male, firstWife, true);

                    processedPersonIds.add(male.id);
                    processedPersonIds.add(firstWife.id);
                }

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId != null) { // single married male with double married female

                    if (firstWife.firstSpouseId == male.id) { // | ???? | ???? | -  l l - | MALE | -----
                        extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);
                        mainMarriage.male = male;

                        processedPersonIds.add(male.id);
                        // firstWife should be processed in a later iteration
                    }

                    if (firstWife.secondSpouseId == male.id) { // | MALE | female | - l l - | ???? | -----
                        mainMarriage.male = male;
                        mainMarriage.female = firstWife;
                        mainMarriage.marriage = createMarriage(male, firstWife, true);

                        processedPersonIds.add(male.id);
                        processedPersonIds.add(firstWife.id);

                        // if | MALE | female | - l l - | male | then firstWife's firstSpouse should be created inclusively
                        firstWifesFirstSpouseId = firstWife.firstSpouseId;
                    }
                }
            }
            if (male.firstSpouseId != null && male.secondSpouseId != null) { // | ???? | - l l - | MALE | female | -----
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);

                mainMarriage.male = male;
                mainMarriage.female = secondWife;
                mainMarriage.marriage = createMarriage(male, secondWife, true);

                processedPersonIds.add(male.id);
                processedPersonIds.add(secondWife.id);
            }

        }
        else {
            const female = person;

            if (female.firstSpouseId == null && female.secondSpouseId == null) { // | FEMALE | -----
                mainMarriage.female = female;
                processedPersonIds.add(female.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // single married female
                const husbandId = female.firstSpouseId;
                const husband = await getPersonJson(husbandId);

                if (husband.firstSpouseId != null && husband.secondSpouseId == null) { // | male | FEMALE | -----
                    mainMarriage.male = husband;
                    mainMarriage.female = female;
                    mainMarriage.marriage = createMarriage(husband, female, true);

                    processedPersonIds.add(female.id);
                    processedPersonIds.add(husband.id);
                }

                if (husband.firstSpouseId == female.id && husband.secondSpouseId != null) { // | FEMALE | - l l - | ???? | ???? | -----
                    mainMarriage.female = female;
                    processedPersonIds.add(female.id);
                }

                if (husband.firstSpouseId != null && husband.secondSpouseId == female.id) { // | ???? | - l l - | m??? | FEM??? | -----
                    // female will be added in the husbands iteration
                }
            }

            if (female.firstSpouseId != null && female.secondSpouseId != null) { // | m??? | FEM??? | - l l - | ???? | -----
                // female will be added in the husbands iteration
            }
        }

        if (extendedMarriage.secondaryMarriage != null || mainMarriage.male != null || mainMarriage.female != null) {
            if (mainMarriage.male != null || mainMarriage.female != null) {
                extendedMarriage.mainMarriage = mainMarriage;
            }

            if (!generationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                generationsMap.set(currentLevel, newGeneration);
            }

            const generation = generationsMap.get(currentLevel);
            generation.extendedMarriages.push(extendedMarriage);
        }

        extendedMarriage.numberOfAvailableParents = 2;

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        await this.createGenerationsRecursive2(personId, person.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    },

    async createGenerationsRecursive2(mainPersonId, personId, processedPersonIds, generationsMap, currentLevel) {
        if (personId == null || processedPersonIds.has(personId))
            return;

        const person = await getPersonJson(personId);
        const extendedMarriage = {};
        const mainMarriage = {};

        let spouseId;
        let spouseFatherId;

        // person is always male
        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // single married male
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                mainMarriage.male = male;
                mainMarriage.female = firstWife;
                mainMarriage.marriage = createMarriage(male, firstWife, true);

                spouseId = firstWife.id;
                spouseFatherId = firstWife.biologicalFatherId;

                processedPersonIds.add(male.id);
                processedPersonIds.add(firstWife.id);
            }
            if (male.firstSpouseId != null && male.secondSpouseId != null) { // double married male
                const firstWife = await getPersonJson(male.firstSpouseId);
                let mainWife = (firstWife.inverseBiologicalMother.map(e => e.id).includes(mainPersonId))
                    ? firstWife
                    : await getPersonJson(male.secondSpouseId);

                mainMarriage.male = male;
                mainMarriage.female = mainWife;
                mainMarriage.marriage = createMarriage(male, mainWife, true);

                spouseId = mainWife.id;
                spouseFatherId = mainWife.biologicalFatherId;

                processedPersonIds.add(male.id);
                processedPersonIds.add(mainWife.id);
            }

            if (mainMarriage.male != null || mainMarriage.female != null) {
                extendedMarriage.mainMarriage = mainMarriage;

                if (!generationsMap.has(currentLevel)) {
                    const newGeneration = {};
                    newGeneration.extendedMarriages = [];
                    generationsMap.set(currentLevel, newGeneration);
                }

                const generation = generationsMap.get(currentLevel);
                generation.extendedMarriages.push(extendedMarriage);
            }
        }

        extendedMarriage.numberOfAvailableParents = 2;

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        await this.createGenerationsRecursive2(person.id, person.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        await this.createGenerationsRecursive2(spouseId, spouseFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    },

    async createGenerationsDown(personId, processedPersonIds, generationsMap, currentLevel) {
        if (personId == null || processedPersonIds.has(personId))
            return;

        const person = await getPersonJson(personId);

        if (person.inverseBiologicalFather != null)
            for (let child of person.inverseBiologicalFather)
                await createGenerationsDownRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (person.inverseBiologicalMother != null)
            for (let child of person.inverseBiologicalMother)
                await createGenerationsDownRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);
    },

    async createGenerationsDownRecursive(personId, processedPersonIds, generationsMap, currentLevel) {
        const person = await getPersonJson(personId);
        const extendedMarriage = {};
        const mainMarriage = {};

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null && male.secondSpouseId == null) { // | male | -----
                mainMarriage.male = male;
                processedPersonIds.add(male.id);
            }

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // single married male
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId == null) { // | MALE | female | -----

                    mainMarriage.male = male;
                    mainMarriage.female = firstWife;
                    mainMarriage.marriage = createMarriage(male, firstWife, true);

                    processedPersonIds.add(male.id);
                    processedPersonIds.add(firstWife.id);
                }

                if (firstWife.firstSpouseId != null && firstWife.secondSpouseId != null) { // single married male with double married female

                    if (firstWife.firstSpouseId == male.id) { // | ???? | ???? | -  l l - | MALE | -----
                        extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);
                        mainMarriage.male = male;

                        processedPersonIds.add(male.id);
                        // firstWife should be processed in a later iteration
                    }

                    if (firstWife.secondSpouseId == male.id) { // | MALE | female | - l l - | ???? | -----
                        mainMarriage.male = male;
                        mainMarriage.female = firstWife;
                        mainMarriage.marriage = createMarriage(male, firstWife, true);

                        processedPersonIds.add(male.id);
                        processedPersonIds.add(firstWife.id);
                    }
                }
            }
            if (male.firstSpouseId != null && male.secondSpouseId != null) { // | ???? | - l l - | MALE | female | -----
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);

                mainMarriage.male = male;
                mainMarriage.female = secondWife;
                mainMarriage.marriage = createMarriage(male, secondWife, true);

                processedPersonIds.add(male.id);
                processedPersonIds.add(secondWife.id);
            }

        }
        else {
            const female = person;

            if (female.firstSpouseId == null && female.secondSpouseId == null) { // | FEMALE | -----
                mainMarriage.female = female;
                processedPersonIds.add(female.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // single married female
                const husbandId = female.firstSpouseId;
                const husband = await getPersonJson(husbandId);

                if (husband.firstSpouseId != null && husband.secondSpouseId == null) { // | male | FEMALE | -----
                    mainMarriage.male = husband;
                    mainMarriage.female = female;
                    mainMarriage.marriage = createMarriage(husband, female, true);

                    processedPersonIds.add(female.id);
                    processedPersonIds.add(husband.id);
                }

                if (husband.firstSpouseId == female.id && husband.secondSpouseId != null) { // | FEMALE | - l l - | ???? | ???? | -----
                    mainMarriage.female = female;
                    processedPersonIds.add(female.id);
                }

                if (husband.firstSpouseId != null && husband.secondSpouseId == female.id) { // | ???? | - l l - | m??? | FEM??? | -----
                    // female will be added in the husbands iteration
                }
            }

            if (female.firstSpouseId != null && female.secondSpouseId != null) { // | m??? | FEM??? | - l l - | ???? | -----
                // female will be added in the husbands iteration
            }
        }

        if (extendedMarriage.secondaryMarriage != null || mainMarriage.male != null || mainMarriage.female != null) {
            if (mainMarriage.male != null || mainMarriage.female != null) {
                extendedMarriage.mainMarriage = mainMarriage;
            }

            if (!generationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                generationsMap.set(currentLevel, newGeneration);
            }

            const generation = generationsMap.get(currentLevel);
            generation.extendedMarriages.push(extendedMarriage);
        }

        extendedMarriage.numberOfAvailableParents = getNumberOfAvailableParents(extendedMarriage);

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        if (person.inverseBiologicalFather != null)
            for (let child of person.inverseBiologicalFather)
                await createGenerationsDownRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (person.inverseBiologicalMother != null)
            for (let child of person.inverseBiologicalMother)
                await createGenerationsDownRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);
    },

    createUnknownMale(childId) {
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

    createUnknownFemale(childId) {
        fakeId++;
        const male = {
            fakeId: fakeId,
            id: fakeId,
            isMale: false,
            inverseBiologicalMother: [{ id: childId }],
            inverseAdoptiveMother: [] // Szabi: make these nullable
        };
        return male;
    }
}