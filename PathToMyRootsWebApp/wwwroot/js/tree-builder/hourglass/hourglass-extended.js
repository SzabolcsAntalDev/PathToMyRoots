const hourglassExtended = {
    async createKnownAncestorsRecursive(context, biologicalFatherId, biologicalMotherId, adoptiveFatherId, adoptiveMotherId, currentLevel) {
        if (!biologicalFatherId && !adoptiveFatherId)
            return;

        if (currentLevel < -context.ancestorsDepth) {
            return;
        }

        if (biologicalFatherId) {
            const biologicalFather = await getPersonJson(biologicalFatherId);
            const biologicalMother = await getPersonJson(biologicalMotherId);
            const extendedMarriagesOfBiologicalParents = await this.getExtendedMarriagesOf(context, biologicalFather, biologicalMother);

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                context.ancestorsGenerationsMap.set(currentLevel, newGeneration);
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesOfBiologicalParents);

            loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

            await this.createKnownAncestorsRecursive(context, biologicalFather.biologicalFatherId, biologicalFather.biologicalMotherId, biologicalFather.adoptiveFatherId, biologicalFather.adoptiveMotherId, currentLevel - 1);
            await this.createKnownAncestorsRecursive(context, biologicalMother.biologicalFatherId, biologicalMother.biologicalMotherId, biologicalMother.adoptiveFatherId, biologicalMother.adoptiveMotherId, currentLevel - 1);
        }

        if (adoptiveFatherId) {
            const adoptiveFather = await getPersonJson(adoptiveFatherId);
            const adoptiveMother = await getPersonJson(adoptiveMotherId);
            const extendedMarriagesOfAdoptiveParents = await this.getExtendedMarriagesOf(context, adoptiveFather, adoptiveMother);

            for (const extendedMarriage of extendedMarriagesOfAdoptiveParents) {
                extendedMarriage.numberOfAvailableParents = 0;
            }

            if (!context.ancestorsGenerationsMap.has(currentLevel)) {
                const newGeneration = {};
                newGeneration.extendedMarriages = [];
                context.ancestorsGenerationsMap.set(currentLevel, newGeneration);
            }

            const generation = context.ancestorsGenerationsMap.get(currentLevel);
            generation.extendedMarriages.push(...extendedMarriagesOfAdoptiveParents);
        }
    },

    // returns the extended marriage the contains the first and second spouses of the father and mother
    async getExtendedMarriagesOf(context, male, female) {
        const extendedMarriages = [];
        const malesFirstSpouse = await getPersonJson(male.firstSpouseId);
        const malesSecondSpouse = await getPersonJson(male.secondSpouseId);
        const femalesFirstSpouse = await getPersonJson(female.firstSpouseId);
        const femalesSecondSpouse = await getPersonJson(female.secondSpouseId);

        const malesNumberOfAvailableParents =
            context.includeAdoptive
                ? ((male.biologicalFatherId ? 1 : 0) + (male.adoptiveFatherId ? 1 : 0))
                : ((male.biologicalFatherId ? 1 : 0));

        const femalesNumberOfAvailableParents =
            context.includeAdoptive
                ? ((female.biologicalFatherId ? 1 : 0) + (female.adoptiveFatherId ? 1 : 0))
                : ((female.biologicalFatherId ? 1 : 0));

        const totalNumberOfAvailableParents = malesNumberOfAvailableParents + femalesNumberOfAvailableParents;

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
                numberOfAvailableParents: totalNumberOfAvailableParents
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // MALE FEMALE - male

            extendedMarriages.push({
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: totalNumberOfAvailableParents
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(femalesFirstSpouse, female, false),
                mainMarriage: {
                    male: femalesFirstSpouse
                },
                numberOfAvailableParents: 0
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // female - MALE FEMALE

            extendedMarriages.push({
                mainMarriage: {
                    female: malesFirstSpouse
                },
                numberOfAvailableParents: 0
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(male, malesFirstSpouse, false),
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: totalNumberOfAvailableParents
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // female - MALE FEMALE - male

            extendedMarriages.push({
                mainMarriage: {
                    female: malesFirstSpouse
                },
                numberOfAvailableParents: 0
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(male, malesFirstSpouse, false),
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: totalNumberOfAvailableParents
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(femalesFirstSpouse, female, false),
                mainMarriage: {
                    male: femalesFirstSpouse
                },
                numberOfAvailableParents: 0
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId != male.id) { // male FEMALE - MALE

            extendedMarriages.push({
                mainMarriage: {
                    male: femalesSecondSpouse,
                    female: female,
                    marriage: createMarriage(femalesSecondSpouse, female, true)
                },
                numberOfAvailableParents: femalesNumberOfAvailableParents
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(male, female, false),
                mainMarriage: {
                    male: male
                },
                numberOfAvailableParents: malesNumberOfAvailableParents
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // FEMALE - MALE female

            extendedMarriages.push({
                mainMarriage: {
                    female: female
                },
                numberOfAvailableParents: femalesNumberOfAvailableParents
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(male, female, false),
                mainMarriage: {
                    male: male,
                    female: malesSecondSpouse,
                    marriage: createMarriage(male, malesSecondSpouse, true)
                },
                numberOfAvailableParents: malesNumberOfAvailableParents
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId != female.id) { // male FEMALE - MALE female

            extendedMarriages.push({
                mainMarriage: {
                    male: femalesSecondSpouse,
                    female: female,
                    marriage: createMarriage(femalesSecondSpouse, female, true)
                },
                numberOfAvailableParents: femalesNumberOfAvailableParents
            });

            extendedMarriages.push({
                secondaryMarriage: createMarriage(male, female, false),
                mainMarriage: {
                    male: male,
                    female: malesSecondSpouse,
                    marriage: createMarriage(male, malesSecondSpouse, true)
                },
                numberOfAvailableParents: malesNumberOfAvailableParents
            });
        }

        return extendedMarriages;
    },

    // returns the biological and adoptive siblings and their spouses
    async createSiblings(context, person) {
        if (!person.biologicalFatherId && !person.adoptiveFatherId) {
            return [];
        }

        const biologicalFather = await getPersonJson(person.biologicalFatherId);
        const biologicalMother = await getPersonJson(person.biologicalMotherId);
        const adoptiveFather = await getPersonJson(person.adoptiveFatherId);
        const adoptiveMother = await getPersonJson(person.adoptiveMotherId);

        const siblings =
            (biologicalFather?.inverseBiologicalFather ?? [])
                .concat(biologicalMother?.inverseBiologicalMother ?? [])
                .concat(adoptiveFather?.inverseAdoptiveFather ?? [])
                .concat(adoptiveMother?.inverseAdoptiveMother ?? []);

        // Szabi: why can't the id be removed from the equation?
        const uniqueSiblingIds =
            arrayRemoveDuplicatesWithSameId(siblings)
                .filter(sibling => sibling.id != person.id)
                .map(sibling => sibling.id);

        const extendedMarriages = [];

        for (const siblingId of uniqueSiblingIds) {
            const sibling = await getPersonJson(siblingId);
            const siblingWithSpousesExtendedMarriages = await createPersonWithSpousesExtendedMarriages(context, sibling)
            extendedMarriages.push(...siblingWithSpousesExtendedMarriages);
        }

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

        return extendedMarriages;
    }
}