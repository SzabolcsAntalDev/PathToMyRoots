let fakeId = -10000;

const hourglassBiological = {
    async createKnownAncestors(context, childId, biologicalFatherId, biologicalMotherId, currentLevel) {
        if (!biologicalFatherId)
            return;

        if (context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) {
            return;
        }

        const biologicalFather = await getPersonJson(biologicalFatherId);
        const biologicalMother = await getPersonJson(biologicalMotherId);
        const extendedMarriagesOfBiologicalParents = await this.getExtendedMarriagesOf(context, childId, biologicalFather, biologicalMother);

        if (!context.ancestorsGenerationsMap.has(currentLevel)) {
            const newGeneration = {};
            newGeneration.extendedMarriages = [];
            context.ancestorsGenerationsMap.set(currentLevel, newGeneration);
        }

        const generation = context.ancestorsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(...extendedMarriagesOfBiologicalParents);

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        await this.createKnownAncestorsRecursive(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, currentLevel - 1);
        await this.createKnownAncestorsRecursive(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, currentLevel - 1);
    },

    // gets only the biological father and mother, skips their spouses
    async createKnownAncestorsRecursive(context, biologicalFatherId, biologicalMotherId, currentLevel) {
        if (!biologicalFatherId)
            return;

        if (context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) {
            return;
        }

        const biologicalFather = await getPersonJson(biologicalFatherId);
        const biologicalMother = await getPersonJson(biologicalMotherId);

        const mainMarriage = {
            male: biologicalFather,
            female: biologicalMother,
            marriage: createMarriage(biologicalFather, biologicalMother, true)
        }

        context.processedPersonIds.add(biologicalFather.id);
        context.processedPersonIds.add(biologicalMother.id);

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

        await this.createKnownAncestorsRecursive(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, currentLevel - 1);
        await this.createKnownAncestorsRecursive(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, currentLevel - 1);
    },

    // Szabi: childId is never used
    // compare this with method with same name from extended and rename them, also check createPersonWithSpousesExtendedMarriages from common
    async getExtendedMarriagesOf(context, childId, male, female) {
        const extendedMarriages = [];
        const malesFirstSpouse = await getPersonJson(male.firstSpouseId);
        const malesSecondSpouse = await getPersonJson(male.secondSpouseId);
        const femalesFirstSpouse = await getPersonJson(female.firstSpouseId);
        const femalesSecondSpouse = await getPersonJson(female.secondSpouseId);

        context.processedPersonIds.add(male.id);
        context.processedPersonIds.add(female.id);
        context.processedPersonIds.add(malesFirstSpouse?.id);
        context.processedPersonIds.add(malesSecondSpouse?.id);
        context.processedPersonIds.add(femalesFirstSpouse?.id);
        context.processedPersonIds.add(femalesSecondSpouse?.id);

        if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // MALE FEMALE

            extendedMarriages.push({
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: 2
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // MALE FEMALE - male

            const haveCommonChildrenFemale = this.haveCommonChildren(femalesFirstSpouse, female);

            extendedMarriages.push({ // MALE FEMALE
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: 2
            });

            if (haveCommonChildrenFemale) { // - male
                extendedMarriages.push({
                    secondaryMarriage: createMarriage(femalesFirstSpouse, female, false),
                    mainMarriage: {
                        male: femalesFirstSpouse
                    },
                    numberOfAvailableParents: 0
                });
            }
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // female - MALE FEMALE

            const haveCommonChildrenMale = this.haveCommonChildren(male, malesFirstSpouse);

            if (haveCommonChildrenMale) { // female
                extendedMarriages.push({
                    mainMarriage: {
                        female: malesFirstSpouse
                    },
                    numberOfAvailableParents: 0
                });
            }

            extendedMarriages.push({ // - MALE FEMALE
                secondaryMarriage: haveCommonChildrenMale ? createMarriage(male, malesFirstSpouse, false) : null,
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: 2
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // female - MALE FEMALE - male

            const haveCommonChildrenMale = this.haveCommonChildren(male, malesFirstSpouse);
            const haveCommonChildrenFemale = this.haveCommonChildren(femalesFirstSpouse, female);

            if (haveCommonChildrenMale) { // female
                extendedMarriages.push({
                    mainMarriage: {
                        female: malesFirstSpouse
                    },
                    numberOfAvailableParents: 0
                });
            }

            extendedMarriages.push({ // MALE FEMALE
                secondaryMarriage: haveCommonChildrenMale ? createMarriage(male, malesFirstSpouse, false) : null,
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: 2
            });

            if (haveCommonChildrenFemale) { // - male
                extendedMarriages.push({
                    secondaryMarriage: createMarriage(femalesFirstSpouse, female, false),
                    mainMarriage: {
                        male: femalesFirstSpouse
                    },
                    numberOfAvailableParents: 0
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId != male.id) { // male FEMALE - MALE

            const haveCommonChildrenFemale = this.haveCommonChildren(femalesFirstSpouse, female);

            if (haveCommonChildrenFemale) { // male FEMALE - MALE
                extendedMarriages.push({ // male FEMALE
                    mainMarriage: {
                        male: femalesSecondSpouse,
                        female: female,
                        marriage: createMarriage(femalesSecondSpouse, female, true)
                    },
                    numberOfAvailableParents: 1
                });

                extendedMarriages.push({ // - MALE
                    secondaryMarriage: createMarriage(male, female, false),
                    mainMarriage: {
                        male: male
                    },
                    numberOfAvailableParents: 1
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    },
                    numberOfAvailableParents: 2
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // FEMALE - MALE female

            const haveCommonChildrenMale = this.haveCommonChildren(male, malesSecondSpouse);

            if (haveCommonChildrenMale) { // FEMALE - MALE female
                extendedMarriages.push({ // FEMALE
                    mainMarriage: {
                        female: female
                    },
                    numberOfAvailableParents: 1
                });

                extendedMarriages.push({ // - MALE female
                    secondaryMarriage: createMarriage(male, female, false),
                    mainMarriage: {
                        male: male,
                        female: malesSecondSpouse,
                        marriage: createMarriage(male, malesSecondSpouse, true)
                    },
                    numberOfAvailableParents: 1
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    },
                    numberOfAvailableParents: 2
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId != female.id) { // male FEMALE - MALE female

            const haveCommonChildrenFemale = this.haveCommonChildren(femalesSecondSpouse, female);
            const haveCommonChildrenMale = this.haveCommonChildren(male, malesSecondSpouse);

            if (haveCommonChildrenFemale && haveCommonChildrenMale) { // male FEMALE - MALE female
                extendedMarriages.push({ // male FEMALE
                    mainMarriage: {
                        male: femalesSecondSpouse,
                        female: female,
                        marriage: createMarriage(femalesSecondSpouse, female, true)
                    },
                    numberOfAvailableParents: 1
                });

                extendedMarriages.push({ // - MALE female
                    secondaryMarriage: createMarriage(male, female, false),
                    mainMarriage: {
                        male: male,
                        female: malesSecondSpouse,
                        marriage: createMarriage(male, malesSecondSpouse, true)
                    },
                    numberOfAvailableParents: 1
                });
            }
            else if (haveCommonChildrenFemale) { // male FEMALE - MALE
                extendedMarriages.push({ // male FEMALE
                    mainMarriage: {
                        male: femalesSecondSpouse,
                        female: female,
                        marriage: createMarriage(femalesSecondSpouse, female, true)
                    },
                    numberOfAvailableParents: 1
                });

                extendedMarriages.push({ // - MALE
                    secondaryMarriage: createMarriage(male, female, false),
                    mainMarriage: {
                        male: male,
                    },
                    numberOfAvailableParents: 1
                });
            }
            else if (haveCommonChildrenMale) { // FEMALE - MALE female
                extendedMarriages.push({ // FEMALE
                    mainMarriage: {
                        female: female,
                    },
                    numberOfAvailableParents: 1
                });

                extendedMarriages.push({ // - MALE female
                    secondaryMarriage: createMarriage(male, female, false),
                    mainMarriage: {
                        male: male,
                        female: malesSecondSpouse,
                        marriage: createMarriage(male, malesSecondSpouse, true)
                    },
                    numberOfAvailableParents: 1
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    },
                    numberOfAvailableParents: 2
                });
            }
        }

        return extendedMarriages;
    },

    haveCommonChildren(male, female, childIdToExclude) {
        const childrenOfMale = male.inverseBiologicalFather;
        const childrenOfFemale = female.inverseBiologicalMother;
        const commonChildren = childrenOfMale.filter(malesChild => childrenOfFemale.some(femalesChild => malesChild.id == femalesChild.id) && malesChild.id !== childIdToExclude);
        return commonChildren.length > 0;
    },

    async addUnknownAncestors(generations, person) {
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
            let marriagesToForLoop = children.extendedMarriages;

            // in case the child has parents with other spouses, we don't show the parents of those spouses
            // so create a new extended marriage just for the biological parents and loop through that
            if (childrenLevel == generations.length - 1) {
                const biologicalFather = await getPersonJson(person.biologicalFatherId);
                const biologicalMother = await getPersonJson(person.biologicalMotherId);

                marriagesToForLoop = [
                    {
                        mainMarriage: {
                            male: biologicalFather,
                            female: biologicalMother,
                            marriage: createMarriage(biologicalFather, biologicalMother)
                        },
                        numberOfAvailableParents: 2
                    }
                ]
            }

            marriagesToForLoop.forEach(childExtendedMarriage => {
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
                return;
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
    },

    // returns the biological siblings of the persons direct biological parents
    async createSingleSiblings(context, person) {
        if (context.ancestorsDepth == 0) {
            return [];
        }

        if (!person.biologicalFatherId) {
            return [];
        }

        const biologicalFather = await getPersonJson(person.biologicalFatherId);
        const biologicalMother = await getPersonJson(person.biologicalMotherId);

        const siblings = biologicalFather.inverseBiologicalFather.concat(biologicalMother.inverseBiologicalMother);
        // Szabi: why can't the id be removed from the equation?
        const uniqueSiblings = arrayRemoveDuplicatesWithSameId(siblings).filter(sibling => sibling.id != person.id);

        const extendedMarriages = [];

        for (const sibling of uniqueSiblings) {
            context.processedPersonIds.add(sibling.id);

            extendedMarriages.push({
                mainMarriage: {
                    male: sibling.isMale ? sibling : null,
                    female: !sibling.isMale ? sibling : null,
                },
                numberOfAvailableParents: 1
            });
        }

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        return extendedMarriages;
    }
}