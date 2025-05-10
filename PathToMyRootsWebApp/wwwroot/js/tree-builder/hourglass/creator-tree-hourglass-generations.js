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
        const person = await getPersonJson(personId);

        const processedPersonIds = new Set();
        const ancestorsGenerationsMap = new Map();

        await this.createKnownAncestors(person.id, person.biologicalFatherId, processedPersonIds, ancestorsGenerationsMap, -1);
        const ancestorsGeneration = sortByLevelAndConvertToArray(ancestorsGenerationsMap);
        this.addUnknownAncestors(ancestorsGeneration);

        const generation0 = await this.createGeneration0(person, processedPersonIds);

        return ancestorsGeneration.concat(generation0);
    },

    async createKnownAncestors(childId, fatherId, processedPersonIds, generationsMap, currentLevel) {
        if (!fatherId)
            return;

        const father = await getPersonJson(fatherId);
        let mainMarriage;

        let motherId;
        let mothersFatherId;

        if (father.firstSpouseId != null && father.secondSpouseId == null) { // single married male
            motherId = father.firstSpouseId;
            const mother = await getPersonJson(motherId);

            mainMarriage = {
                male: father,
                female: mother,
                marriage: createMarriage(father, mother, true)
            }

            motherId = mother.id;
            mothersFatherId = mother.biologicalFatherId;

            processedPersonIds.add(father.id);
            processedPersonIds.add(mother.id);
        }

        if (father.firstSpouseId != null && father.secondSpouseId != null) { // double married male
            const firstWife = await getPersonJson(father.firstSpouseId);
            let mother = (firstWife.inverseBiologicalMother.map(e => e.id).includes(childId))
                ? firstWife
                : await getPersonJson(male.secondSpouseId);

            mainMarriage = {
                male: father,
                female: mother,
                marriage: createMarriage(father, mother, true)
            }

            motherId = mother.id;
            mothersFatherId = mother.biologicalFatherId;

            processedPersonIds.add(father.id);
            processedPersonIds.add(mother.id);
        }

        // Szabi
        // numberOfAvailableParents will be set when adding unknown parents
        const extendedMarriage = {
            mainMarriage: mainMarriage,
            numberOfAvailableParents: 2
        }

        if (!generationsMap.has(currentLevel)) {
            const newGeneration = {};
            newGeneration.extendedMarriages = [];
            generationsMap.set(currentLevel, newGeneration);
        }

        const generation = generationsMap.get(currentLevel);
        generation.extendedMarriages.push(extendedMarriage);

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        await this.createKnownAncestors(father.id, father.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        await this.createKnownAncestors(motherId, mothersFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    },

    addUnknownAncestors(generations) {
        if (generations.length <= 1) {
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

                    male.firstSpouseId = female.fakeId;
                    female.firstSpouseId = male.fakeId;

                    const fakeExtendedMarriage = {
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true, true)
                        },
                        numberOfAvailableParents: 2
                    };

                    parents.extendedMarriages.splice(malesParentsExtendedMarriageIndex, 0, fakeExtendedMarriage);
                }

                const fatherIdOnFemalesFatherIndex = parents.extendedMarriages[femalesParentsExtendedMarriageIndex]?.mainMarriage.male.id;
                if (!femalesFatherId || femalesFatherId != fatherIdOnFemalesFatherIndex) {
                    const male = this.createFakeMale(femaleId);
                    const female = this.createFakeFemale(femaleId);

                    male.firstSpouseId = female.fakeId;
                    female.firstSpouseId = male.fakeId;

                    const fakeExtendedMarriage = {
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true, true)
                        },
                        numberOfAvailableParents: 2
                    };

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

    async createGeneration0(person, processedPersonIds) {
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

                processedPersonIds.add(male.id);
            }

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // | MALE | female | ----
                const firstWifeId = male.firstSpouseId;
                const firstWife = await getPersonJson(firstWifeId);

                extendedMarriageLeft = {
                    mainMarriageLeft: {
                        male: male,
                        female: firstWife,
                        marriage: createMarriage(male, firstWife, true)
                    },
                    numberOfAvailableParents: (male.biologicalFatherId || male.biologicalMotherId) ? 1 : 0
                }

                processedPersonIds.add(male.id);
                processedPersonIds.add(firstWife.id);
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

                processedPersonIds.add(male.id);
                processedPersonIds.add(firstWife.id);
                processedPersonIds.add(secondWife.id);
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

                processedPersonIds.add(female.id);
            }

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // | FEMALE | male | ----
                const firstHusbandId = male.firstSpouseId;
                const firstHusband = await getPersonJson(firstHusbandId);

                extendedMarriageLeft = {
                    mainMarriageLeft: {
                        male: firstHusband,
                        female: female,
                        marriage: createMarriage(firstHusband, female, true)
                    },
                    numberOfAvailableParents: (female.biologicalFatherId || female.biologicalMotherId) ? 1 : 0
                }

                processedPersonIds.add(female.id);
                processedPersonIds.add(firstHusband.id);
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

                processedPersonIds.add(female.id);
                processedPersonIds.add(firstHusband.id);
                processedPersonIds.add(secondHusband.id);
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

        setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

        return generation;
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
    }
}