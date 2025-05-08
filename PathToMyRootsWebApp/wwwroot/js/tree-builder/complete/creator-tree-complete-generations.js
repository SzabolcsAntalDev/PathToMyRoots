

const completeTreeCreator = {
    async createCompleteTreeGenerations(personId) {
        const generations = await this.createGenerationsWithExtendedMarriages(personId);

        sortExtendedMarriagesByBirthDate(generations);
        sortExtendedMarriagesBySpouses(generations);
        createSiblings(generations);
        createSiblingsChains(generations);

        return generations;
    },

    async createGenerationsWithExtendedMarriages(personId) {
        const generationsMap = new Map();
        await this.createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);
        return sortByLevelAndConvertToArray(generationsMap);
    },

    async createGenerationsRecursive(personId, processedPersonIds, generationsMap, currentLevel) {
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

        extendedMarriage.numberOfAvailableParents = getNumberOfAvailableParents(extendedMarriage);

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        await this.createGenerationsRecursive(person.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        await this.createGenerationsRecursive(person.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);

        if (person.firstSpouse != null) {
            await this.createGenerationsRecursive(person.firstSpouse.id, processedPersonIds, generationsMap, currentLevel);
            await this.createGenerationsRecursive(person.firstSpouse.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
            await this.createGenerationsRecursive(person.firstSpouse.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        }

        if (person.secondSpouse != null) {
            await this.createGenerationsRecursive(person.secondSpouse.id, processedPersonIds, generationsMap, currentLevel);
            await this.createGenerationsRecursive(person.secondSpouse.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
            await this.createGenerationsRecursive(person.secondSpouse.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        }

        if (person.inverseBiologicalFather != null)
            for (let child of person.inverseBiologicalFather)
                await this.createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (person.inverseBiologicalMother != null)
            for (let child of person.inverseBiologicalMother)
                await this.createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (person.inverseAdoptiveFather != null)
            for (let child of person.inverseAdoptiveFather)
                await this.createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (person.inverseAdoptiveMother != null)
            for (let child of person.inverseAdoptiveMother)
                await this.createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

        if (firstWifesFirstSpouseId) {
            await this.createGenerationsRecursive(firstWifesFirstSpouseId, processedPersonIds, generationsMap, currentLevel);
        }
    }
}