async function createGenerationsData(personId) {
    const generationsMap = new Map();
    await createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);

    const generations = Array.from(generationsMap.entries())
        .sort((a, b) => a[0] - b[0])
        .map(([_, value]) => value);
    sortRowItemsByBirthDates(generations);

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largetGenerationSize = getLargestGenerationSize(generations);

    return generationsData;
}

async function createGenerationsRecursive(personId, processedPersonIds, generationsMap, currentLevel) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();
    const extendedMarriage = {};
    const mainMarriage = {};

    if (person.isMale) {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            mainMarriage.person = person;
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
            const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();

            extendedMarriage.secondaryMarriage = createMarriage(person, firstSpouse, false);

            mainMarriage.person = person;
            mainMarriage.spouse = secondSpouse;
            mainMarriage.mainMarriage = createMarriage(person, secondSpouse, true);

            processedPersonIds.add(person.secondSpouseId);
        }
        else { // single married
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.secondSpouseId != null) {
                if (spouse.secondSpouseId == personId) {
                    mainMarriage.person = person;
                    mainMarriage.spouse = spouse;
                    mainMarriage.mainMarriage = createMarriage(person, spouse, true);

                    processedPersonIds.add(spouseId);
                }
                else {
                    extendedMarriage.secondaryMarriage = createMarriage(person, spouse, false);
                    mainMarriage.person = person;
                }
            }
            else {
                mainMarriage.person = person;
                mainMarriage.spouse = spouse;;
                mainMarriage.mainMarriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
        }
    }
    else {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            mainMarriage.person = person;
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
        }
        else { // single married
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) { // double married man
                mainMarriage.person = person;
            }
            else { // single married man
                mainMarriage.spouse = spouse;
                mainMarriage.person = person;
                mainMarriage.mainMarriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
        }
    }

    // if not double married female
    if (mainMarriage.person != null || mainMarriage.secondaryMarriage != null) {
        extendedMarriage.mainMarriage = mainMarriage;

        if (!generationsMap.has(currentLevel)) {
            generationsMap.set(currentLevel, []);
        }

        // Add to the array at that level
        generationsMap.get(currentLevel).push(extendedMarriage);
    }

    extendedMarriage.numberOfAvailableParents = getNumberOfAvailableParents(extendedMarriage);

    processedPersonIds.add(personId);

    setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

    await createGenerationsRecursive(person.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    await createGenerationsRecursive(person.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);

    if (person.firstSpouse != null) {
        await createGenerationsRecursive(person.firstSpouse.id, processedPersonIds, generationsMap, currentLevel);
        await createGenerationsRecursive(person.firstSpouse.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        await createGenerationsRecursive(person.firstSpouse.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    }

    if (person.secondSpouse != null) {
        await createGenerationsRecursive(person.secondSpouse.id, processedPersonIds, generationsMap, currentLevel);
        await createGenerationsRecursive(person.secondSpouse.biologicalFatherId, processedPersonIds, generationsMap, currentLevel - 1);
        await createGenerationsRecursive(person.secondSpouse.adoptiveFatherId, processedPersonIds, generationsMap, currentLevel - 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);
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

// gets the largest persons with available parents number of all generations
function getLargestGenerationSize(generations) {
    let largestGenerationSize = 0;

    generations.forEach(generation => {
        let currentGenerationSize = 0;
        generation.forEach(extendedMarriage => {
            currentGenerationSize += extendedMarriage.numberOfAvailableParents;
        });

        largestGenerationSize = Math.max(largestGenerationSize, currentGenerationSize);
    })

    return largestGenerationSize;
}

function getNumberOfAvailableParents(extendedMarriage) {
    return getNumOfParents(extendedMarriage.mainMarriage.person) +
        getNumOfParents(extendedMarriage.mainMarriage.spouse) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.person) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.spouse);
}

function getNumOfParents(person) {
    if (person == null) {
        return null;
    }

    let number = 0;

    number += person.biologicalFatherId ? 1 : 0;
    number += person.biologicalMotherId ? 1 : 0;
    number += person.adoptiveFatherId ? 1 : 0;
    number += person.adoptiveMotherId ? 1 : 0;

    return number;
}