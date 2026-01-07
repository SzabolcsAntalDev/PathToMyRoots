const hourglassBiological = {
    async createKnownAncestorsOf(context) {
        if (context.ancestorsDepth == 0) {
            return;
        }

        if (!context.person.biologicalFatherId) {
            return;
        }

        const directParentsLevel = -1;

        const father = await getPersonJson(context.person.biologicalFatherId);
        const mother = await getPersonJson(context.person.biologicalMotherId);

        context.processedPersonIds.add(directParentsLevel, father.id);
        context.processedPersonIds.add(directParentsLevel, mother.id);

        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const marriageEntitiesOfParents = await this.createMarriageEntitiesWithSpousesWithCommonChildrenOfPersons(context, father, mother, directParentsLevel);

        context.ancestorsGenerationsMap.set(directParentsLevel, { marriageEntities: marriageEntitiesOfParents });

        await this.createKnownBiologicalAncestorsRecursiveOf(context, father, directParentsLevel - 1);
        await this.createKnownBiologicalAncestorsRecursiveOf(context, mother, directParentsLevel - 1);
    },

    async createMarriageEntitiesWithSpousesWithCommonChildrenOfPersons(context, male, female, currentLevel) {
        const marriageEntities = [];

        const firstWife = await getPersonJson(male.firstSpouseId);
        const secondWife = await getPersonJson(male.secondSpouseId);
        const firstHusband = await getPersonJson(female.firstSpouseId);
        const secondHusband = await getPersonJson(female.secondSpouseId);

        if (this.haveCommonChildren(male, firstWife)) {
            marriageEntities.push({
                male: male,
                female: firstWife,
                marriage: createMarriage(male, firstWife)
            });
        }

        if (this.haveCommonChildren(male, secondWife)) {
            marriageEntities.push({
                male: male,
                female: secondWife,
                marriage: createMarriage(male, secondWife)
            });
        }

        if (this.haveCommonChildren(firstHusband, female)) {
            marriageEntities.push({
                male: firstHusband,
                female: female,
                marriage: createMarriage(firstHusband, female)
            });
        }

        if (this.haveCommonChildren(secondHusband, female)) {
            marriageEntities.push({
                male: secondHusband,
                female: female,
                marriage: createMarriage(secondHusband, female)
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

    haveCommonChildren(male, female) {
        if (!male || !female) {
            return false;
        }

        const childrenOfMale = male.inverseBiologicalFather;
        const childrenOfFemale = female.inverseBiologicalMother;
        const commonChildren = childrenOfMale.filter(malesChild => childrenOfFemale.some(femalesChild => malesChild.id == femalesChild.id));

        return commonChildren.length > 0;
    },

    async createKnownBiologicalAncestorsRecursiveOf(context, person, currentLevel) {
        if (context.ancestorsDepth != relativesDepth.ALL.index && context.ancestorsDepth < -currentLevel) {
            return;
        }

        if (!person.biologicalFatherId) {
            return;
        }

        const father = await getPersonJson(person.biologicalFatherId);
        const mother = await getPersonJson(person.biologicalMotherId);

        context.processedPersonIds.add(currentLevel, father.id);
        context.processedPersonIds.add(currentLevel, mother.id);

        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const marriageEntity = {
            male: father,
            female: mother,
            marriage: createMarriage(father, mother)
        }

        if (!context.ancestorsGenerationsMap.has(currentLevel)) {
            context.ancestorsGenerationsMap.set(currentLevel, { marriageEntities: [] });
        }

        const generation = context.ancestorsGenerationsMap.get(currentLevel);
        generation.marriageEntities.push(marriageEntity);

        await this.createKnownBiologicalAncestorsRecursiveOf(context, father, currentLevel - 1);
        await this.createKnownBiologicalAncestorsRecursiveOf(context, mother, currentLevel - 1);
    },

    async createMarriageEntitiesWithSpousesWithCommonChildrenOfPerson(context, person, currentLevel) {
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
                if (this.haveCommonChildren(male, firstWife)) {
                    marriageEntities.push({
                        male: male,
                        female: firstWife,
                        marriage: createMarriage(male, firstWife)
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }

                if (this.haveCommonChildren(male, secondWife)) {
                    marriageEntities.push({
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife)
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);
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
                if (this.haveCommonChildren(firstHusband, female)) {
                    marriageEntities.push({
                        male: firstHusband,
                        female: female,
                        marriage: createMarriage(firstHusband, female)
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }

                if (this.haveCommonChildren(secondHusband, female)) {
                    marriageEntities.push({
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female)
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);
                }
            }
        }

        // person has spose but does not have children
        if (marriageEntities.length == 0) {
            marriageEntities.push({
                male: person?.isMale ? person : null,
                female: person?.isMale ? null : person
            });
        }

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return marriageEntities;
    },

    async createSiblingsOf(context) {
        if (context.ancestorsDepth == 0) {
            return [];
        }

        if (!context.person.biologicalFatherId) {
            return [];
        }

        const father = await getPersonJson(context.person.biologicalFatherId);
        const mother = await getPersonJson(context.person.biologicalMotherId);
        // no need to change loading text here, parents were already loaded previously

        const siblings = father.inverseBiologicalFather.concat(mother.inverseBiologicalMother);
        const uniqueSiblings = arrayRemoveDuplicatesWithSameId(siblings).filter(sibling => sibling.id != context.person.id);
        const marriageEntities = [];

        for (const sibling of uniqueSiblings) {
            // if person has child with its sibling then the sibling is already add to the generation
            if (context.processedPersonIds.containsOnSameLevel(0, sibling.id)) {
                continue;
            }

            // the sibling here is taken directly from the parents, not from the cache
            // retrieve the sibling from the server and put into the cache so it can be properly duplicated
            const cachedSibling = await getPersonJson(sibling.id);
            context.processedPersonIds.add(0, cachedSibling.id);

            marriageEntities.push({
                male: cachedSibling.isMale ? cachedSibling : null,
                female: !cachedSibling.isMale ? cachedSibling : null,
            });
        }

        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return marriageEntities;
    },

    async createDescendantsOf(context) {
        if (context.descendantsDepth == 0) {
            return;
        }

        const currentLevel = 0;

        const children = (context.person.inverseBiologicalFather ?? []).concat(context.person.inverseBiologicalMother ?? []);
        for (const child of children) {
            await this.createDescendantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, child.id, currentLevel + 1);
        }
    },

    async createDescendantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, personId, currentLevel) {
        if (context.descendantsDepth != relativesDepth.ALL.index && currentLevel > context.descendantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.diagramFrame, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        // if is last level then add only the person, without his spouses
        const currentLevelDescendants =
            (currentLevel == context.descendantsDepth)
                ?
                [{
                    male: person.isMale ? person : null,
                    female: !person.isMale ? person : null
                }]
                : await this.createMarriageEntitiesWithSpousesWithCommonChildrenOfPerson(context, person, currentLevel);

        if (!context.descendantsGenerationsMap.has(currentLevel)) {
            context.descendantsGenerationsMap.set(currentLevel, { marriageEntities: [] });
        }

        const generation = context.descendantsGenerationsMap.get(currentLevel);
        generation.marriageEntities.push(...currentLevelDescendants);

        const children = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const child of children) {
            await this.createDescendantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, child.id, currentLevel + 1);
        }
    },
}