// creates a generation with extended marriages with the persons first and second spouses
// the numberOfAvailableParents is set to the number of biological parents of the couples
async function createPersonWithSpousesExtendedMarriages(context, person) {
    let extendedMarriageLeft;
    let extendedMarriageRight;

    context.processedPersonIds.add(person.id);
    context.processedPersonIds.add(person.firstSpouseId);
    context.processedPersonIds.add(person.secondSpouseId);

    const numberOfAvailableParents =
        context.includeAdoptive
            ? ((person.biologicalFatherId ? 1 : 0) + (person.adoptiveFatherId ? 1 : 0))
            : (person.biologicalFatherId ? 1 : 0);

    if (person.isMale) {
        const male = person;

        if (male.firstSpouseId == null && male.secondSpouseId == null) { // | MALE | -----
            extendedMarriageLeft = {
                mainMarriage: {
                    male: male
                },
                numberOfAvailableParents: numberOfAvailableParents
            }
        }

        if (male.firstSpouseId != null && male.secondSpouseId == null) { // | MALE | female | ----
            const female = await getPersonJson(male.firstSpouseId);

            extendedMarriageLeft = {
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: numberOfAvailableParents
            }
        }

        if (male.firstSpouseId != null && male.secondSpouseId != null) { // | female | - l l - | MALE | female | -----
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
                numberOfAvailableParents: numberOfAvailableParents
            }
        }
    }
    else {
        const female = person;

        if (female.firstSpouseId == null && female.secondSpouseId == null) { // | FEMALE | -----
            extendedMarriageLeft = {
                mainMarriage: {
                    female: female
                },
                numberOfAvailableParents: numberOfAvailableParents
            }
        }

        if (female.firstSpouseId != null && female.secondSpouseId == null) { // | FEMALE | male | ----
            const male = await getPersonJson(female.firstSpouseId);

            extendedMarriageLeft = {
                mainMarriage: {
                    male: male,
                    female: female,
                    marriage: createMarriage(male, female, true)
                },
                numberOfAvailableParents: numberOfAvailableParents
            }
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
                numberOfAvailableParents: numberOfAvailableParents
            }

            extendedMarriageRight = {
                secondaryMarriage: createMarriage(firstHusband, female, false),
                mainMarriage: {
                    male: firstHusband,
                },
                numberOfAvailableParents: 0
            }
        }
    }

    const extendedMarriages = [];
    if (extendedMarriageLeft != null) {
        extendedMarriages.push(extendedMarriageLeft);
    }

    if (extendedMarriageRight != null) {
        extendedMarriages.push(extendedMarriageRight);
    }

    loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

    return extendedMarriages;
}

// gets all the biological/adoptive descedants with their spouses recursively
async function createDescedants(context, person) {
    const currentLevel = 0;

    const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
    for (const child of biologicalChildren) {
        await createDescedantsRecursive(context, child.id, currentLevel + 1);
    }

    if (currentLevel + 1 > context.descedantsDepth) {
        return;
    }

    if (context.includeAdoptive) {
        await addAdoptiveChildrenToExtendedMarriages(context, person, currentLevel);
    }
}

async function createDescedantsRecursive(context, personId, currentLevel) {
    if (!personId || context.processedPersonIds.has(personId)) {
        return;
    }

    if (currentLevel > context.descedantsDepth) {
        return;
    }

    const person = await getPersonJson(personId);
    const personWithSpousesExtendedMarriages = await createPersonWithSpousesExtendedMarriages(context, person);

    if (!context.descedantsGenerationsMap.has(currentLevel)) {
        const newGeneration = {};
        newGeneration.extendedMarriages = [];
        context.descedantsGenerationsMap.set(currentLevel, newGeneration);
    }

    const generation = context.descedantsGenerationsMap.get(currentLevel);
    generation.extendedMarriages.push(...personWithSpousesExtendedMarriages);

    loadingTextManager.setLoadingProgressText(context.loadingTextContainerParent, `Number of persons found:<br>${context.processedPersonIds.size}`);

    const biologicalChildren = (person.inverseBiologicalFather ?? []).concat(person.inverseBiologicalMother ?? []);
    for (const child of biologicalChildren) {
        await this.createDescedantsRecursive(context, child.id, currentLevel + 1);
    }

    if (currentLevel + 1 > context.descedantsDepth) {
        return;
    }

    if (context.includeAdoptive) {
        await addAdoptiveChildrenToExtendedMarriages(context, person, currentLevel);
    }
}

async function addAdoptiveChildrenToExtendedMarriages(context, person, currentLevel) {
    const adoptiveChildrenIds = (person.inverseAdoptiveFather ?? []).concat(person.inverseAdoptiveMother ?? []).map(child => child.id);

    for (const childId of adoptiveChildrenIds) {
        const child = await getPersonJson(childId);
        const personWithSpousesExtendedMarriages = await createPersonWithSpousesExtendedMarriages(context, child);

        if (!context.descedantsGenerationsMap.has(currentLevel + 1)) {
            const newGeneration = {};
            newGeneration.extendedMarriages = [];
            context.descedantsGenerationsMap.set(currentLevel + 1, newGeneration);
        }

        const generation = context.descedantsGenerationsMap.get(currentLevel + 1);
        generation.extendedMarriages.push(...personWithSpousesExtendedMarriages);
    }
}