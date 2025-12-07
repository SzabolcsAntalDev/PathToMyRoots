const hourglassExtended = {
    async createKnownAncestorsOf(context) {
        await hourglassExtended.createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, context.person.biologicalFatherId, context.person.biologicalMotherId, context.person.adoptiveFatherId, context.person.adoptiveMotherId, -1);
    },

    async createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, biologicalFatherId, biologicalMotherId, adoptiveFatherId, adoptiveMotherId, currentLevel) {
        if (context.ancestorsDepth != relativesDepth.ALL.index && currentLevel < -context.ancestorsDepth) {
            return;
        }

        if (!biologicalFatherId && !adoptiveFatherId) {
            return;
        }

        if (biologicalFatherId) {
            const biologicalFather = await getPersonJson(biologicalFatherId);
            const biologicalMother = await getPersonJson(biologicalMotherId);

            context.processedPersonIds.add(currentLevel, biologicalFather.id);
            context.processedPersonIds.add(currentLevel, biologicalMother.id);

            loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const extendedMarriagesWithSpousesOfBiologicalParents = await this.createExtendedMarriagesWithSpousesOfPersons(context, biologicalFather, biologicalMother, currentLevel);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesWithSpousesOfBiologicalParents);

            await this.createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, biologicalFather.adoptiveFatherId, biologicalFather.adoptiveMotherId, currentLevel - 1);
            await this.createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, biologicalMother.adoptiveFatherId, biologicalMother.adoptiveMotherId, currentLevel - 1);
        }

        if (adoptiveFatherId) {
            const adoptiveFather = await getPersonJson(adoptiveFatherId);
            const adoptiveMother = await getPersonJson(adoptiveMotherId);

            context.processedPersonIds.add(currentLevel, adoptiveFather.id);
            context.processedPersonIds.add(currentLevel, adoptiveMother.id);

            loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const extendedMarriagesWithSpousesOfAdoptiveParents = await this.createExtendedMarriagesWithSpousesOfPersons(context, adoptiveFather, adoptiveMother, currentLevel);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesWithSpousesOfAdoptiveParents);
        }
    },

    async createExtendedMarriagesWithSpousesOfPersons(context, male, female, currentLevel) {
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

        context.processedPersonIds.add(currentLevel, male.firstSpouseId);
        context.processedPersonIds.add(currentLevel, male.secondSpouseId);
        context.processedPersonIds.add(currentLevel, female.firstSpouseId);
        context.processedPersonIds.add(currentLevel, female.secondSpouseId);

        loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return extendedMarriages;
    },

    async createExtendedMarriagesWithSpousesOfPerson(context, person, currentLevel) {
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

                context.processedPersonIds.add(currentLevel, person.firstSpouseId);
            }

            else if (male.firstSpouseId != null && male.secondSpouseId != null) { // firstWife - MALE secondWife
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                extendedMarriages.push({ // firstWife
                    mainMarriage: {
                        female: firstWife
                    }
                });

                context.processedPersonIds.add(currentLevel, person.firstSpouseId);

                extendedMarriages.push({ // - MALE secondWife
                    secondaryMarriage: createMarriage(male, firstWife, false, true),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true, true)
                    }
                });

                context.processedPersonIds.add(currentLevel, person.secondSpouseId);
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

                context.processedPersonIds.add(currentLevel, person.firstSpouseId);
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

                context.processedPersonIds.add(currentLevel, person.firstSpouseId);

                extendedMarriages.push({ // - firstHusband
                    secondaryMarriage: createMarriage(firstHusband, female, false, true),
                    mainMarriage: {
                        male: firstHusband,
                    }
                });

                context.processedPersonIds.add(currentLevel, person.secondSpouseId);
            }
        }

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

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

            context.processedPersonIds.add(0, sibling.id);
            loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const extendedMarriagesWithSpousesOfSibling = await this.createExtendedMarriagesWithSpousesOfPerson(context, sibling, 0)
            extendedMarriages.push(...extendedMarriagesWithSpousesOfSibling);
        }

        return extendedMarriages;
    },

    async createDescendantsOf(context) {
        if (context.descendantsDepth == 0) {
            return;
        }

        const currentLevel = 0;

        const biologicalChildren = (context.person.inverseBiologicalFather ?? []).concat(context.person.inverseBiologicalMother ?? []);
        for (const biologicalChild of biologicalChildren) {
            await this.createDescendantsWithSpousesRecursiveOfPersonId(context, biologicalChild.id, currentLevel + 1);
        }

        if (context.descendantsDepth != relativesDepth.ALL.index && currentLevel + 1 > context.descendantsDepth) {
            return;
        }

        await this.addAdoptiveChildrenWithSpousesOf(context, context.person, currentLevel);
    },

    async createDescendantsWithSpousesRecursiveOfPersonId(context, personId, currentLevel) {
        if (context.descendantsDepth != relativesDepth.ALL.index && currentLevel > context.descendantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const extendedMarriagesWithSpousesOfPerson = await this.createExtendedMarriagesWithSpousesOfPerson(context, person, currentLevel);

        if (!context.descendantsGenerationsMap.has(currentLevel)) {
            context.descendantsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
        }

        const generation = context.descendantsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(...extendedMarriagesWithSpousesOfPerson);

        const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const biologicalChild of biologicalChildren) {
            await this.createDescendantsWithSpousesRecursiveOfPersonId(context, biologicalChild.id, currentLevel + 1);
        }

        if (context.descendantsDepth != relativesDepth.ALL.index && currentLevel + 1 > context.descendantsDepth) {
            return;
        }

        await this.addAdoptiveChildrenWithSpousesOf(context, person, currentLevel);
    },

    async addAdoptiveChildrenWithSpousesOf(context, person, currentLevel) {
        const adoptiveChildrenIds = (person.inverseAdoptiveFather ?? []).concat(person.inverseAdoptiveMother ?? []).map(child => child.id);

        for (const adoptiveChildId of adoptiveChildrenIds) {
            const adoptiveChild = await getPersonJson(adoptiveChildId);

            context.processedPersonIds.add(currentLevel, adoptiveChild.id);
            loadingTextManager.setLoadingProgressText(context.treeDiagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const extendedMarriagesWithSpousesOfPerson = await this.createExtendedMarriagesWithSpousesOfPerson(context, adoptiveChild, currentLevel);

            if (!context.descendantsGenerationsMap.has(currentLevel + 1)) {
                context.descendantsGenerationsMap.set(currentLevel + 1, { extendedMarriages: [] });
            }

            const generation = context.descendantsGenerationsMap.get(currentLevel + 1);
            generation.extendedMarriages.push(...extendedMarriagesWithSpousesOfPerson);
        }
    },
}