let fakeId = -10000;

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

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const extendedMarriagesOfParents = await this.createExtendedMarriagesWithSpousesWithCommonChildrenOfPersons(context, father, mother, directParentsLevel);

        context.ancestorsGenerationsMap.set(directParentsLevel, { extendedMarriages: extendedMarriagesOfParents });

        await this.createKnownBiologicalAncestorsRecursiveOf(context, father, directParentsLevel - 1);
        await this.createKnownBiologicalAncestorsRecursiveOf(context, mother, directParentsLevel - 1);
    },

    async createExtendedMarriagesWithSpousesWithCommonChildrenOfPersons(context, male, female, currentLevel) {
        const extendedMarriages = [];

        if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // MALE FEMALE

            extendedMarriages.push({
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                }
            });
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // MALE FEMALE - firstHusband

            extendedMarriages.push({ // MALE FEMALE
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                }
            });

            const firstHusband = await getPersonJson(female.firstSpouseId);
            const haveCommonChildrenFemaleAndFirstHusband = this.haveCommonChildren(firstHusband, female);

            if (haveCommonChildrenFemaleAndFirstHusband) { // - firstHusband
                extendedMarriages.push({
                    secondaryMarriage: createMarriage(firstHusband, female),
                    mainMarriage: {
                        male: firstHusband
                    }
                });
            }
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // firstWife - MALE FEMALE

            const firstWife = await getPersonJson(male.firstSpouseId);
            const haveCommonChildrenMaleAndFirstWife = this.haveCommonChildren(male, firstWife);

            if (haveCommonChildrenMaleAndFirstWife) { // firstWife
                extendedMarriages.push({
                    mainMarriage: {
                        female: firstWife
                    }
                });
            }

            extendedMarriages.push({ // - MALE FEMALE
                secondaryMarriage: haveCommonChildrenMaleAndFirstWife ? createMarriage(male, firstWife) : null,
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                }
            });
        }

        else if (male.firstSpouseId != female.id && male.secondSpouseId == female.id &&
            female.firstSpouseId != male.id && female.secondSpouseId == male.id) { // firstWife - MALE FEMALE - firstHusband

            const firstWife = await getPersonJson(male.firstSpouseId);
            const firstHusband = await getPersonJson(female.firstSpouseId);
            const haveCommonChildrenMaleAndFirstWife = this.haveCommonChildren(male, firstWife);
            const haveCommonChildrenFemaleAndFirstHusband = this.haveCommonChildren(firstHusband, female);

            if (haveCommonChildrenMaleAndFirstWife) { // firstWife
                extendedMarriages.push({
                    mainMarriage: {
                        female: firstWife
                    }
                });
            }

            extendedMarriages.push({ // - MALE FEMALE
                secondaryMarriage: haveCommonChildrenMaleAndFirstWife ? createMarriage(male, firstWife) : null,
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                }
            });

            if (haveCommonChildrenFemaleAndFirstHusband) { // - firstHusband
                extendedMarriages.push({
                    secondaryMarriage: createMarriage(firstHusband, female),
                    mainMarriage: {
                        male: firstHusband
                    }
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId == null &&
            female.firstSpouseId == male.id && female.secondSpouseId != male.id) { // secondHusband FEMALE - MALE

            const secondHusband = await getPersonJson(female.secondSpouseId);
            const haveCommonChildrenFemaleAndSecondHusband = this.haveCommonChildren(secondHusband, female);

            if (haveCommonChildrenFemaleAndSecondHusband) { // secondHusband FEMALE - MALE
                extendedMarriages.push({ // secondHusband FEMALE
                    mainMarriage: {
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true)
                    }
                });

                extendedMarriages.push({ // - MALE
                    secondaryMarriage: createMarriage(male, female),
                    mainMarriage: {
                        male: male
                    }
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({ // MALE FEMALE
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    }
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId == null) { // FEMALE - MALE secondWife

            const secondWife = await getPersonJson(male.secondSpouseId);
            const haveCommonChildrenMaleAndSecondWife = this.haveCommonChildren(male, secondWife);

            if (haveCommonChildrenMaleAndSecondWife) { // FEMALE - MALE secondWife
                extendedMarriages.push({ // FEMALE
                    mainMarriage: {
                        female: female
                    }
                });

                extendedMarriages.push({ // - MALE secondWife
                    secondaryMarriage: createMarriage(male, female),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true)
                    }
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({ // MALE FEMALE
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    }
                });
            }
        }

        else if (male.firstSpouseId == female.id && male.secondSpouseId != female.id &&
            female.firstSpouseId == male.id && female.secondSpouseId != female.id) { // secondHusband FEMALE - MALE secondWife

            const secondHusband = await getPersonJson(female.secondSpouseId);
            const secondWife = await getPersonJson(male.secondSpouseId);
            const haveCommonChildrenFemaleAndSecondHusband = this.haveCommonChildren(secondHusband, female);
            const haveCommonChildrenMaleAndSecondWife = this.haveCommonChildren(male, secondWife);

            if (haveCommonChildrenFemaleAndSecondHusband && haveCommonChildrenMaleAndSecondWife) { // secondHusband FEMALE - MALE secondWife
                extendedMarriages.push({ // secondHusband FEMALE
                    mainMarriage: {
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true)
                    }
                });

                extendedMarriages.push({ // - MALE secondWife
                    secondaryMarriage: createMarriage(male, female),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true)
                    }
                });
            }
            else if (haveCommonChildrenFemaleAndSecondHusband) { // secondHusband FEMALE - MALE
                extendedMarriages.push({ // secondHusband FEMALE
                    mainMarriage: {
                        male: secondHusband,
                        female: female,
                        marriage: createMarriage(secondHusband, female, true)
                    }
                });

                extendedMarriages.push({ // - MALE
                    secondaryMarriage: createMarriage(male, female),
                    mainMarriage: {
                        male: male,
                    }
                });
            }
            else if (haveCommonChildrenMaleAndSecondWife) { // FEMALE - MALE secondWife
                extendedMarriages.push({ // FEMALE
                    mainMarriage: {
                        female: female,
                    }
                });

                extendedMarriages.push({ // - MALE secondWife
                    secondaryMarriage: createMarriage(male, female),
                    mainMarriage: {
                        male: male,
                        female: secondWife,
                        marriage: createMarriage(male, secondWife, true)
                    }
                });
            }
            else { // MALE FEMALE
                extendedMarriages.push({ // MALE FEMALE
                    mainMarriage: {
                        male: male,
                        female: female,
                        marriage: createMarriage(male, female, true)
                    }
                });
            }
        }

        context.processedPersonIds.add(currentLevel, male.firstSpouseId);
        context.processedPersonIds.add(currentLevel, male.secondSpouseId);
        context.processedPersonIds.add(currentLevel, female.firstSpouseId);
        context.processedPersonIds.add(currentLevel, female.secondSpouseId);

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return extendedMarriages;
    },

    haveCommonChildren(male, female) {
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

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        const extendedMarriage = {
            mainMarriage: {
                male: father,
                female: mother,
                marriage: createMarriage(father, mother, true)
            }
        }

        if (!context.ancestorsGenerationsMap.has(currentLevel)) {
            context.ancestorsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
        }

        const generation = context.ancestorsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(extendedMarriage);

        await this.createKnownBiologicalAncestorsRecursiveOf(context, father, currentLevel - 1);
        await this.createKnownBiologicalAncestorsRecursiveOf(context, mother, currentLevel - 1);
    },

    async addUnknownAncestorsOf(ancestorsGenerations, person) {
        // if only the direct parents displayed then there's nothing to add
        if (ancestorsGenerations.length < 2) {
            return;
        }

        let childrenLevel = ancestorsGenerations.length - 1;

        while (true) {
            const parents = ancestorsGenerations[childrenLevel - 1];
            const children = ancestorsGenerations[childrenLevel];

            if (!parents) {
                return;
            }

            let coupleIndex = 0;
            let childrenExtendedMarriages = children.extendedMarriages;

            // if the child level is the direct parents level
            // direct parents can have their other spouses shown
            // to omit them create a new extendedMarriage just from the actual parents
            if (childrenLevel == ancestorsGenerations.length - 1) {
                const father = await getPersonJson(person.biologicalFatherId);
                const mother = await getPersonJson(person.biologicalMotherId);

                childrenExtendedMarriages = [
                    {
                        mainMarriage: {
                            male: father,
                            female: mother,
                            // this marriage it's not displayed anywhere, so it doesn't have to be static
                            marriage: createMarriage(father, mother)
                        },
                    }
                ]
            }

            childrenExtendedMarriages.forEach(childExtendedMarriage => {
                const maleId = childExtendedMarriage.mainMarriage.male?.id;
                const femaleId = childExtendedMarriage.mainMarriage.female?.id;

                const malesFatherId = childExtendedMarriage.mainMarriage.male?.biologicalFatherId;
                const femalesFatherId = childExtendedMarriage.mainMarriage.female?.biologicalFatherId;

                const malesParentsExtendedMarriageIndex = coupleIndex * 2;
                const femalesParentsExtendedMarriageIndex = malesParentsExtendedMarriageIndex + 1;

                // if male does not have a father, create the fake parents
                if (!malesFatherId) {
                    const malesFakeFather = this.createFakeMale(maleId);
                    const malesFakeMother = this.createFakeFemale(maleId);
                    const malesFakeParentsExtendedMarriage = this.createFakeExtendedMarriage(malesFakeFather, malesFakeMother);
                    parents.extendedMarriages.splice(malesParentsExtendedMarriageIndex, 0, malesFakeParentsExtendedMarriage);
                }

                // if female does not have a father, create the fake parents
                if (!femalesFatherId) {
                    const femalesFakeFather = this.createFakeMale(femaleId);
                    const femalesFakeMother = this.createFakeFemale(femaleId);
                    const femalesFakeParentsExtendedMarriage = this.createFakeExtendedMarriage(femalesFakeFather, femalesFakeMother);
                    parents.extendedMarriages.splice(femalesParentsExtendedMarriageIndex, 0, femalesFakeParentsExtendedMarriage);
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
                marriage: createMarriage(male, female, true, false, true)
            }
        };
    },

    async createExtendedMarriagesWithSpousesWithCommonChildrenOfPerson(context, person, currentLevel) {
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

            if (male.firstSpouseId != null && male.secondSpouseId == null) { // MALE female
                const female = await getPersonJson(male.firstSpouseId);

                const haveCommonChildrenWithFirstWife = this.haveCommonChildren(male, female);

                if (haveCommonChildrenWithFirstWife) { // MALE female
                    extendedMarriages.push({
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }
                else {
                    extendedMarriages.push({ // MALE
                        mainMarriage: {
                            male: male,
                        }
                    });
                }
            }

            if (male.firstSpouseId != null && male.secondSpouseId != null) { // firstWife - MALE secondWife
                const firstWife = await getPersonJson(male.firstSpouseId);
                const secondWife = await getPersonJson(male.secondSpouseId);

                const haveCommonChildrenWithFirstWife = this.haveCommonChildren(male, firstWife);
                const haveCommonChildrenWithSecondWife = this.haveCommonChildren(male, secondWife);

                if (haveCommonChildrenWithFirstWife && haveCommonChildrenWithSecondWife) { // firstWife - MALE secondWife
                    extendedMarriages.push({ // firstWife
                        mainMarriage: {
                            female: firstWife
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);

                    extendedMarriages.push({ // - MALE secondWife
                        secondaryMarriage: createMarriage(male, firstWife),
                        mainMarriage: {
                            male: male,
                            female: secondWife,
                            marriage: createMarriage(male, secondWife, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);
                }
                else if (haveCommonChildrenWithSecondWife) { // MALE secondWife
                    extendedMarriages.push({ // MALE secondWife
                        mainMarriage: {
                            male: male,
                            female: secondWife,
                            marriage: createMarriage(male, secondWife, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);
                }
                else if (haveCommonChildrenWithFirstWife) { // MALE firstWife
                    extendedMarriages.push({ // MALE firstWife
                        mainMarriage: {
                            male: male,
                            female: firstWife,
                            marriage: createMarriage(male, firstWife, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }
                else {
                    extendedMarriages.push({
                        mainMarriage: { // MALE
                            male: male
                        }
                    });
                }
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

            if (female.firstSpouseId != null && female.secondSpouseId == null) { // FEMALE male
                const male = await getPersonJson(female.firstSpouseId);

                const haveCommonChildrenWithFirstHusband = this.haveCommonChildren(male, female);

                if (haveCommonChildrenWithFirstHusband) { // FEMALE male
                    extendedMarriages.push({
                        mainMarriage: {
                            male: male,
                            female: female,
                            marriage: createMarriage(male, female, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }
                else {
                    extendedMarriages.push({ // FEMALE
                        mainMarriage: {
                            female: female
                        }
                    });
                }
            }

            if (female.firstSpouseId != null && female.secondSpouseId != null) { // secondHusband FEMALE - firstHusband
                const firstHusband = await getPersonJson(female.firstSpouseId);
                const secondHusband = await getPersonJson(female.secondSpouseId);

                const haveCommonChildrenWithFirstHusband = this.haveCommonChildren(firstHusband, female);
                const haveCommonChildrenWithSecondHusband = this.haveCommonChildren(secondHusband, female);

                if (haveCommonChildrenWithFirstHusband && haveCommonChildrenWithSecondHusband) { // secondHusband FEMALE - firstHusband
                    extendedMarriages.push({ // secondHusband FEMALE
                        mainMarriage: {
                            male: secondHusband,
                            female: female,
                            marriage: createMarriage(secondHusband, female, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);

                    extendedMarriages.push({ // - firstHusband
                        secondaryMarriage: createMarriage(firstHusband, female),
                        mainMarriage: {
                            male: firstHusband,
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }
                else if (haveCommonChildrenWithSecondHusband) { // secondHusband FEMALE
                    extendedMarriages.push({ // secondHusband FEMALE
                        mainMarriage: {
                            male: secondHusband,
                            female: female,
                            marriage: createMarriage(secondHusband, female, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.secondSpouseId);
                }
                else if (haveCommonChildrenWithFirstHusband) { // firstHusband FEMALE
                    extendedMarriages.push({
                        mainMarriage: {
                            male: firstHusband,
                            female: female,
                            marriage: createMarriage(firstHusband, female, true)
                        }
                    });

                    context.processedPersonIds.add(currentLevel, person.firstSpouseId);
                }
                else { // FEMALE
                    extendedMarriages.push({ // FEMALE
                        mainMarriage: {
                            female: female,
                        }
                    });
                }
            }
        }

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return extendedMarriages;
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
        const extendedMarriages = [];

        for (const sibling of uniqueSiblings) {
            // if person has child with its sibling then the sibling is already add to the generation
            if (context.processedPersonIds.containsOnSameLevel(0, sibling.id)) {
                continue;
            }

            // the sibling here is taken directly from the parents, not from the cache
            // retrieve the sibling from the server and put into the cache so it can be properly duplicated
            const cachedSibling = await getPersonJson(sibling.id);
            context.processedPersonIds.add(0, cachedSibling.id);

            extendedMarriages.push({
                mainMarriage: {
                    male: cachedSibling.isMale ? cachedSibling : null,
                    female: !cachedSibling.isMale ? cachedSibling : null,
                },
            });
        }

        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        return extendedMarriages;
    },

    async createDescedantsOf(context) {
        if (context.descedantsDepth == 0) {
            return;
        }

        const currentLevel = 0;

        const children = (context.person.inverseBiologicalFather ?? []).concat(context.person.inverseBiologicalMother ?? []);
        for (const child of children) {
            await this.createDescedantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, child.id, currentLevel + 1);
        }
    },

    async createDescedantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, personId, currentLevel) {
        if (context.descedantsDepth != relativesDepth.ALL.index && currentLevel > context.descedantsDepth) {
            return;
        }

        const person = await getPersonJson(personId);

        context.processedPersonIds.add(currentLevel, person.id);
        loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.getDistinctPersonsSize()}`);

        // if is last level then add only the person, without his spouses
        const currentLevelDescedants =
            (currentLevel == context.descedantsDepth)
                ?
                [{
                    mainMarriage: {
                        male: person.isMale ? person : null,
                        female: !person.isMale ? person : null,
                    },
                }]
                : await this.createExtendedMarriagesWithSpousesWithCommonChildrenOfPerson(context, person, currentLevel);

        if (!context.descedantsGenerationsMap.has(currentLevel)) {
            context.descedantsGenerationsMap.set(currentLevel, { extendedMarriages: [] });
        }

        const generation = context.descedantsGenerationsMap.get(currentLevel);
        generation.extendedMarriages.push(...currentLevelDescedants);

        const children = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
        for (const child of children) {
            await this.createDescedantsWithSpousesAndCommonChildrenRecursiveOfPersonId(context, child.id, currentLevel + 1);
        }
    },
}