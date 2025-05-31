let fakeId = -10000;

const hourglassBiological = {
    async createKnownAncestorsRecursive(context, childId, biologicalFatherId, currentLevel) {
        if (!biologicalFatherId)
            return;

        if (context.ancestorsDepth >= 0 && currentLevel < -context.ancestorsDepth) {
            return;
        }

        const biologicalFather = await getPersonJson(biologicalFatherId);
        let biologicalMother;

        // just retrieve biological mother, then use it after
        if (biologicalFather.firstSpouseId != null && biologicalFather.secondSpouseId == null) { // single married male
            biologicalMother = await getPersonJson(biologicalFather.firstSpouseId);
        }

        if (biologicalFather.firstSpouseId != null && biologicalFather.secondSpouseId != null) { // double married male
            const firstWife = await getPersonJson(biologicalFather.firstSpouseId);
            biologicalMother = (firstWife.inverseBiologicalMother.map(e => e.id).includes(childId))
                ? firstWife
                : await getPersonJson(biologicalFather.secondSpouseId);
        }

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

        await this.createKnownAncestorsRecursive(context, biologicalFather.id, biologicalFather.biologicalFatherId, currentLevel - 1);
        await this.createKnownAncestorsRecursive(context, biologicalMother.id, biologicalMother.biologicalFatherId, currentLevel - 1);
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