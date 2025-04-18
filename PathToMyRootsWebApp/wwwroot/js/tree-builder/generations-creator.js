async function createGenerations(personId) {
    const generationsMap = new Map();
    await createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);

    const generations = Array.from(generationsMap.entries())
        .sort((a, b) => a[0] - b[0])
        .map(([_, value]) => value);
    sortRowItemsByBirthDates(generations);

    return generations;
}

async function createGenerationsRecursive(personId, processedPersonIds, nodesMap, currentLevel) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();
    const extendedMarriage = {};
    const simpleMarriage = {};

    if (person.isMale) {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            simpleMarriage.person = person;
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
            const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();

            extendedMarriage.leftMarriage = createMarriage(person, firstSpouse, false);

            simpleMarriage.person = person;
            simpleMarriage.spouse = secondSpouse;
            simpleMarriage.mainMarriage = createMarriage(person, secondSpouse, true);

            processedPersonIds.add(person.secondSpouseId);
        }
        else { // single married
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.secondSpouseId != null) {
                if (spouse.secondSpouseId == personId) {
                    simpleMarriage.person = person;
                    simpleMarriage.spouse = spouse;
                    simpleMarriage.mainMarriage = createMarriage(person, spouse, true);

                    processedPersonIds.add(spouseId);
                }
                else {
                    extendedMarriage.leftMarriage = createMarriage(person, spouse, false);
                    simpleMarriage.person = person;
                }
            }
            else {
                simpleMarriage.person = person;
                simpleMarriage.spouse = spouse;;
                simpleMarriage.mainMarriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
        }
    }
    else {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            simpleMarriage.person = person;
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
        }
        else { // single married
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) { // double married man
                simpleMarriage.person = person;
            }
            else { // single married man
                simpleMarriage.spouse = spouse;
                simpleMarriage.person = person;
                simpleMarriage.mainMarriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
        }
    }

    // if not double married female
    if (simpleMarriage.person != null || simpleMarriage.leftMarriage != null) {
        extendedMarriage.simpleMarriage = simpleMarriage;

        if (!nodesMap.has(currentLevel)) {
            nodesMap.set(currentLevel, []);
        }

        // Add to the array at that level
        nodesMap.get(currentLevel).push(extendedMarriage);
    }

    processedPersonIds.add(personId);

    setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

    await createGenerationsRecursive(person.biologicalFatherId, processedPersonIds, nodesMap, currentLevel - 1);
    await createGenerationsRecursive(person.adoptiveFatherId, processedPersonIds, nodesMap, currentLevel - 1);

    if (person.firstSpouse != null) {
        await createGenerationsRecursive(person.firstSpouse.id, processedPersonIds, nodesMap, currentLevel);
        await createGenerationsRecursive(person.firstSpouse.biologicalFatherId, processedPersonIds, nodesMap, currentLevel - 1);
        await createGenerationsRecursive(person.firstSpouse.adoptiveFatherId, processedPersonIds, nodesMap, currentLevel - 1);
    }

    if (person.secondSpouse != null) {
        await createGenerationsRecursive(person.secondSpouse.id, processedPersonIds, nodesMap, currentLevel);
        await createGenerationsRecursive(person.secondSpouse.biologicalFatherId, processedPersonIds, nodesMap, currentLevel - 1);
        await createGenerationsRecursive(person.secondSpouse.adoptiveFatherId, processedPersonIds, nodesMap, currentLevel - 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createGenerationsRecursive(child.id, processedPersonIds, nodesMap, currentLevel + 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createGenerationsRecursive(child.id, processedPersonIds, nodesMap, currentLevel + 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createGenerationsRecursive(child.id, processedPersonIds, nodesMap, currentLevel + 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createGenerationsRecursive(child.id, processedPersonIds, nodesMap, currentLevel + 1);
}


function createMarriage(person, spouse, isMainMarriage) {
    const marriage = {};

    marriage.isMainMarriage = isMainMarriage;
    marriage.startDate = person.firstSpouseId == spouse.id ? person.firstMarriageStartDate : person.secondMarriageStartDate;;
    marriage.endDate = person.firstSpouseId == spouse.id ? person.firstMarriageEndDate : person.secondMarriageEndDate;
    marriage.maleId = person.isMale ? person.id : spouse.id;
    marriage.femaleId = !person.isMale ? person.id : spouse.id;
    marriage.inverseBiologicalParents = getCommonBiologicalChildren(person, spouse);
    marriage.inverseAdoptiveParents = getCommonAdoptiveChildren(person, spouse);

    return marriage;
}