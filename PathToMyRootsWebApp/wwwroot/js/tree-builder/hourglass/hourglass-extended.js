const hourglassExtended = {
    async createKnownAncestorsOf(context) {
        await hourglassExtended.createKnownAncestorsRecursive(context, context.person.biologicalFatherId, context.person.biologicalMotherId, context.person.adoptiveFatherId, context.person.adoptiveMotherId, -1);
    },

    async createKnownAncestorsRecursive(context, biologicalFatherId, biologicalMotherId, adoptiveFatherId, adoptiveMotherId, currentLevel) {
        if (context.ancestorsDepth != relativesDepth.ALL.index && currentLevel < -context.ancestorsDepth) {
            return;
        }

        if (!biologicalFatherId && !adoptiveFatherId) {
            return;
        }

        if (biologicalFatherId) {
            const biologicalFather = await getPersonJson(biologicalFatherId);
            const biologicalMother = await getPersonJson(biologicalMotherId);

            context.processedPersonIds.add(biologicalFather.id);
            context.processedPersonIds.add(biologicalMother.id);

            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            const extendedMarriagesOfBiologicalParents = await this.createExtendedMarriagesOfPersons(context, biologicalFather, biologicalMother);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesOfBiologicalParents);

            await this.createKnownAncestorsRecursive(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, biologicalFather.adoptiveFatherId, biologicalFather.adoptiveMotherId, currentLevel - 1);
            await this.createKnownAncestorsRecursive(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, biologicalMother.adoptiveFatherId, biologicalMother.adoptiveMotherId, currentLevel - 1);
        }

        if (adoptiveFatherId) {
            const adoptiveFather = await getPersonJson(adoptiveFatherId);
            const adoptiveMother = await getPersonJson(adoptiveMotherId);

            context.processedPersonIds.add(adoptiveFather.id);
            context.processedPersonIds.add(adoptiveMother.id);

            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            const extendedMarriagesOfAdoptiveParents = await this.createExtendedMarriagesOfPersons(context, adoptiveFather, adoptiveMother);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesOfAdoptiveParents);
        }
    },

    async createExtendedMarriagesOfPersons(context, male, female) {
        const extendedMarriages = [];

        if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // MALE FEMALE

            extendedMarriages.push({ // MALE FEMALE
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true, true)
                }
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // MALE FEMALE - firstHusband

            extendedMarriages.push({ // MALE FEMALE
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true, true)
                }
            });

            const firstHusband = await getPersonJson(female.firstSpouseId);

            extendedMarriages.push({ // - firstHusband
                secondaryMarriage: createMarriage(firstHusband, female, false, true),
                mainMarriage: {
                    male: firstHusband
                }
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // firstWife - MALE FEMALE

            const firstWife = await getPersonJson(male.firstSpouseId);

            extendedMarriages.push({ // firstWife
                mainMarriage: {
                    female: firstWife
                }
            });

            extendedMarriages.push({ // - MALE FEMALE
                secondaryMarriage: createMarriage(male, firstWife, false, true),
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true, true)
                }
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // firstWife - MALE FEMALE - firstHusband

            const firstWife = await getPersonJson(male.firstSpouseId);

            extendedMarriages.push({ // firstWife
                mainMarriage: {
                    female: firstWife
                }
            });

            extendedMarriages.push({ // - MALE FEMALE
                secondaryMarriage: createMarriage(male, firstWife, false, true),
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true, true)
                },
            });

            const firstHusband = await getPersonJson(female.firstSpouseId);

            extendedMarriages.push({ // - firstHusband
                secondaryMarriage: createMarriage(firstHusband, female, false, true),
                mainMarriage: {
                    male: firstHusband
                }
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId != male.id) { // secondHusband FEMALE - MALE

            const secondHusband = await getPersonJson(female.secondSpouseId);

            extendedMarriages.push({ // secondHusband FEMALE
                mainMarriage: {
                    male: secondHusband,
                    female: female,
                    marriage: createMarriage(secondHusband, female, true, true)
                }
            });

            extendedMarriages.push({ // - MALE
                secondaryMarriage: createMarriage(male, female, false, true),
                mainMarriage: {
                    male: male
                }
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // FEMALE - MALE secondWife

            extendedMarriages.push({ // FEMALE
                mainMarriage: {
                    female: female
                }
            });

            const secondWife = await getPersonJson(male.secondSpouseId);

            extendedMarriages.push({ // - MALE secondWife
                secondaryMarriage: createMarriage(male, female, false, true),
                mainMarriage: {
                    male: male,
                    female: secondWife,
                    marriage: createMarriage(male, secondWife, true, true)
                }
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId != female.id) { // secondHusband FEMALE - MALE secondWife

            const secondHusband = await getPersonJson(female.secondSpouseId);

            extendedMarriages.push({ // secondHusband FEMALE
                mainMarriage: {
                    male: secondHusband,
                    female: female,
                    marriage: createMarriage(secondHusband, female, true, true)
                }
            });

            const secondWife = await getPersonJson(male.secondSpouseId);

            extendedMarriages.push({ // - MALE secondWife
                secondaryMarriage: createMarriage(male, female, false, true),
                mainMarriage: {
                    male: male,
                    female: secondWife,
                    marriage: createMarriage(male, secondWife, true, true)
                }
            });
        }

        context.processedPersonIds.add(male.firstSpouseId);
        context.processedPersonIds.add(male.secondSpouseId);
        context.processedPersonIds.add(female.firstSpouseId);
        context.processedPersonIds.add(female.secondSpouseId);

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        return extendedMarriages;
    },

    async createExtendedMarriagesOfPerson(context, person) {
        const extendedMarriages = [];

        if (person.isMale) {
            const male = person;

            if (male.firstSpouseId == null && male.secondSpouseId == null) { // MALE
                extendedMarriages.push({ // MALE
                    mainMarriage: {
                        male: male
                    }
                });
            }

            else if (male.firstSpouseId != null && male.secondSpouseId == null) { // MALE female
                const female = await getPersonJson(male.firstSpouseId);

                extendedMarriages.push({
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true, true)
                    }
                });
            }

            else if (male.firstSpouseId != null && male.secondSpouseId != null) { // firstWife - MALE secondWife
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriages.push({ // firstWife
                    mainMarriage: {
                        female: firstWife
                    }
                });

                extendedMarriages.push({ // - MALE secondWife
                    secondaryMarriage: createMarriage(male, firstWife, false, true),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true, true)
                    }
                });
            }
        }
        else {
            const female = person;

            if (female.firstSpouseId == null && female.secondSpouseId == null) { // FEMALE
                extendedMarriages.push({ // FEMALE
                    mainMarriage: {
                        female: female
                    }
                });
            }

            else if (female.firstSpouseId != null && female.secondSpouseId == null) { // FEMALE male
                const male = await getPersonJson(female.firstSpouseId);

                extendedMarriages.push({ // FEMALE male
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true, true)
                    }
                });
            }

            else if (female.firstSpouseId != null && female.secondSpouseId != null) { // secondHusband FEMALE - firstHusband
                const firstHusband = await getPersonJson(female.firstSpouseId);
                const secondHusband = await getPersonJson(female.secondSpouseId);

                extendedMarriages.push({ // secondHusband FEMALE
                    mainMarriage: {
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true, true)
                    }
                });

                extendedMarriages.push({ // - firstHusband
                    secondaryMarriage: createMarriage(firstHusband, female, false, true),
                    mainMarriage: {
                        male: firstHusband,
                    }
                });
            }
        }

        context.processedPersonIds.add(person.firstSpouseId);
        context.processedPersonIds.add(person.secondSpouseId);

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        return extendedMarriages;
    },

    async createSiblingsOf(context) {
        if (context.ancestorsDepth == 0) {
            return [];
        }

        if (!context.person.biologicalFatherId && !context.person.adoptiveFatherId) {
            return [];
        }

        const biologicalFather = await getPersonJson(context.person.biologicalFatherId);
        const biologicalMother = await getPersonJson(context.person.biologicalMotherId);
        const adoptiveFather = await getPersonJson(context.person.adoptiveFatherId);
        const adoptiveMother = await getPersonJson(context.person.adoptiveMotherId);
        // no need to change loading text here, parents were already loaded previously

        const siblings =
            (biologicalFather?.inverseBiologicalFather ?? [])
                .concat(biologicalMother?.inverseBiologicalMother ?? [])
                .concat(biologicalFather?.inverseAdoptiveFather ?? [])
                .concat(biologicalMother?.inverseAdoptiveMother ?? [])
                .concat(adoptiveFather?.inverseBiologicalFather ?? [])
                .concat(adoptiveMother?.inverseBiologicalMother ?? [])
                .concat(adoptiveFather?.inverseAdoptiveFather ?? [])
                .concat(adoptiveMother?.inverseAdoptiveMother ?? []);

        const uniqueSiblingIds =
            arrayRemoveDuplicatesWithSameId(siblings)
                .filter(sibling => sibling.id != context.person.id)
                .map(sibling => sibling.id);

        const extendedMarriages = [];

        for (const siblingId of uniqueSiblingIds) {
            const sibling = await getPersonJson(siblingId);

            context.processedPersonIds.add(sibling.id);
            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            const extendedMarriagesOfSibling = await this.createExtendedMarriagesOfPerson(context, sibling)
            extendedMarriages.push(...extendedMarriagesOfSibling);
        }

        return extendedMarriages;
    },

    async createDescedantsOf(context) {
        if (context.descedantsDepth == 0) {
            return;
        }

        const currentLevel = 0;

        const biologicalChildren = (context.person.inverseBiologicalFather ?? []).concat(context.person.inverseBiologicalMother ?? []);
        for (const child of biologicalChildren) {
            await this.createDescedantsOfRecursive(context, child.id, currentLevel + 1);
        }

        if (context.descedantsDepth != relativesDepth.ALL.index == currentLevel + 1 > context.descedantsDepth) {
            return;
        }

        await this.addAdoptiveChildrenOf(context, context.person, currentLevel);
    },

    async createDescedantsOfRecursive(context, personId, currentLevel) {
        if (context.descedantsDepth != relativesDepth.ALL.index && currentLevel > context.descedantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);
        context.processedPersonIds.add(person.id);
        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        const personWithSpousesExtendedMarriages = await this.createExtendedMarriagesOfPerson(context, person);

        if (!context.descedantsGenerationsMap.has(currentLevel)) {
            context.descedantsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
        }

        const generation = context.descedantsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(...personWithSpousesExtendedMarriages);

        const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const child of biologicalChildren) {
            await this.createDescedantsOfRecursive(context, child.id, currentLevel + 1);
        }

        if (currentLevel + 1 > context.descedantsDepth) {
            return;
        }

        await this.addAdoptiveChildrenOf(context, person, currentLevel);
    },

    async addAdoptiveChildrenOf(context, person, currentLevel) {
        const adoptiveChildrenIds = (person.inverseAdoptiveFather ?? []).concat(person.inverseAdoptiveMother ?? []).map(child => child.id);

        for (const childId of adoptiveChildrenIds) {
            const child = await getPersonJson(childId);
            context.processedPersonIds.add(child.id);
            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            const personWithSpousesExtendedMarriages = await this.createExtendedMarriagesOfPerson(context, child);

            if (!context.descedantsGenerationsMap.has(currentLevel + 1)) {
                context.descedantsGenerationsMap.set(currentLevel + 1, { extendedMarriages: [] });
            }

            const generation = context.descedantsGenerationsMap.get(currentLevel + 1);
            generation.extendedMarriages.push(...personWithSpousesExtendedMarriages);
        }
    },
}