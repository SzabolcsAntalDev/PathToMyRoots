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

            loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const marriageEntitiesWithSpousesOfBiologicalParents = await this.createMarriageEntitiesWithSpousesOfPersons(context, biologicalFather, biologicalMother, currentLevel);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { marriageEntities: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.marriageEntities.push(...marriageEntitiesWithSpousesOfBiologicalParents);

            await this.createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, biologicalFather.adoptiveFatherId, biologicalFather.adoptiveMotherId, currentLevel - 1);
            await this.createKnownAncestorsWithSpousesRecursiveOfPersonIds(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, biologicalMother.adoptiveFatherId, biologicalMother.adoptiveMotherId, currentLevel - 1);
        }

        if (adoptiveFatherId) {
            const adoptiveFather = await getPersonJson(adoptiveFatherId);
            const adoptiveMother = await getPersonJson(adoptiveMotherId);

            context.processedPersonIds.add(currentLevel, adoptiveFather.id);
            context.processedPersonIds.add(currentLevel, adoptiveMother.id);

            loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const marriageEntitiesWithSpousesOfAdoptiveParents = await this.createMarriageEntitiesWithSpousesOfPersons(context, adoptiveFather, adoptiveMother, currentLevel);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                context.ancestorsGenerationsMap.set(currentLevel, { marriageEntities: [] });
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.marriageEntities.push(...marriageEntitiesWithSpousesOfAdoptiveParents);
        }
    },

    async createMarriageEntitiesWithSpousesOfPersons(context, male, female, currentLevel) {
        const marriageEntities = [];

        const firstWife = await getPersonJson(male.firstSpouseId);
        const secondWife = await getPersonJson(male.secondSpouseId);
        const firstHusband = await getPersonJson(female.firstSpouseId);
        const secondHusband = await getPersonJson(female.secondSpouseId);

        if (male && firstWife) {
            marriageEntities.push({
                male: male,
                female: firstWife,
                marriage: createMarriage(male, firstWife, true)
            });
        }

        if (male && secondWife) {
            marriageEntities.push({
                male: male,
                female: secondWife,
                marriage: createMarriage(male, secondWife, true)
            });
        }

        if (firstHusband && female) {
            marriageEntities.push({
                male: firstHusband,
                female: female,
                marriage: createMarriage(firstHusband, female, true)
            });
        }

        if (secondHusband && female) {
            marriageEntities.push({
                male: secondHusband,
                female: female,
                marriage: createMarriage(secondHusband, female, true)
            });
        }

        const distinctMarriageEntities = [
            ...new Map(
                marriageEntities.map(marriageEntity => [
                    `${marriageEntity.male.id}-${marriageEntity.female.id}`,
                    marriageEntity
                ])
            ).values()
        ];

        context.processedPersonIds.add(currentLevel, male.firstSpouseId);
        context.processedPersonIds.add(currentLevel, male.secondSpouseId);
        context.processedPersonIds.add(currentLevel, female.firstSpouseId);
        context.processedPersonIds.add(currentLevel, female.secondSpouseId);

        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return distinctMarriageEntities;
    },

    async createMarriageEntitiesWithSpousesOfPerson(context, person, currentLevel) {
        const marriageEntities = [];

        if (person.isMale) {
            const male = person;
            const firstWife = await getPersonJson(male.firstSpouseId);
            const secondWife = await getPersonJson(male.secondSpouseId);

            if (!firstWife && !secondWife) {
                marriageEntities.push({
                    male: male
                });
            }
            else {
                if (male && firstWife) {
                    marriageEntities.push({
                        male: male,
                        female: firstWife,
                        marriage: createMarriage(male, firstWife, true)
                    });
                }

                if (male && secondWife) {
                    marriageEntities.push({
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true)
                    });
                }
            }
        }
        else {
            const female = person;
            const firstHusband = await getPersonJson(female.firstSpouseId);
            const secondHusband = await getPersonJson(female.secondSpouseId);

            if (!firstHusband && !secondHusband) {
                marriageEntities.push({
                    female: female
                });
            }
            else {
                if (firstHusband && female) {
                    marriageEntities.push({
                        male: firstHusband,
                        female: female,
                        marriage: createMarriage(firstHusband, female, true)
                    });
                }

                if (secondHusband&& female) {
                    marriageEntities.push({
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true)
                    });
                }
            }
        }

        context.processedPersonIds.add(currentLevel, person.id);
        context.processedPersonIds.add(currentLevel, person.firstSpouseId);
        context.processedPersonIds.add(currentLevel, person.secondSpouseId);
        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return marriageEntities;
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

        const marriageEntities = [];

        for (const siblingId of uniqueSiblingIds) {
            const sibling = await getPersonJson(siblingId);

            context.processedPersonIds.add(0, sibling.id);
            loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const marriageEntitiesWithSpousesOfSibling = await this.createMarriageEntitiesWithSpousesOfPerson(context, sibling, 0)
            marriageEntities.push(...marriageEntitiesWithSpousesOfSibling);
        }

        return marriageEntities;
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
        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const marriageEntitiesWithSpousesOfPerson = await this.createMarriageEntitiesWithSpousesOfPerson(context, person, currentLevel);

        if (!context.descendantsGenerationsMap.has(currentLevel)) {
            context.descendantsGenerationsMap.set(currentLevel, { marriageEntities: [] });
        }

        const generation = context.descendantsGenerationsMap.get(currentLevel);
        generation.marriageEntities.push(...marriageEntitiesWithSpousesOfPerson);

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
            loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

            const marriageEntitiesWithSpousesOfPerson = await this.createMarriageEntitiesWithSpousesOfPerson(context, adoptiveChild, currentLevel);

            if (!context.descendantsGenerationsMap.has(currentLevel + 1)) {
                context.descendantsGenerationsMap.set(currentLevel + 1, { marriageEntities: [] });
            }

            const generation = context.descendantsGenerationsMap.get(currentLevel + 1);
            generation.marriageEntities.push(...marriageEntitiesWithSpousesOfPerson);
        }
    },
}