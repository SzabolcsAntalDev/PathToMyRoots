async function createGenerationsData(personId) {
    const generationsMap = new Map();
    await createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);

    const generations = sortByLevelAndConvertToArray(generationsMap);
    sortRowItemsByBirthDates(generations);

    const generationsData = {};
    generationsData.generations = generations;
    generationsData.largestGenerationSize = getLargestGenerationSize(generations);
    generationsData.generations.forEach(generation => {
        generation.generationSize = getGenerationSize(generation);
    });
    return generationsData;
}

function sortByLevelAndConvertToArray(generationsMap) {
    return Array.from(generationsMap.entries())
        .sort((a, b) => a[0] - b[0])
        .map(([_, value]) => value);
}

async function createGenerationsRecursive(personId, processedPersonIds, generationsMap, currentLevel) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}/person/${personId}`)).json();
    const extendedMarriage = {};
    const mainMarriage = {};

    if (person.isMale) {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single male ---
            mainMarriage.person = person;
        }
        else if (person.secondSpouseId == null) { // single married male
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}/person/${spouseId}`)).json();

            if (spouse.secondSpouseId == null) { // single married male with single married female ---
                mainMarriage.person = person;
                mainMarriage.spouse = spouse;
                mainMarriage.marriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
            else { // single married male with double married female
                if (spouse.firstSpouseId == personId) { // divorced male ---
                    extendedMarriage.secondaryMarriage = createMarriage(person, spouse, false);
                    mainMarriage.person = person;
                }
                else { // male married with ex-married female ---
                    mainMarriage.person = person;
                    mainMarriage.spouse = spouse;
                    mainMarriage.marriage = createMarriage(person, spouse, true);

                    processedPersonIds.add(spouseId);
                }
            }
        }
        else { // double married male ---
            const firstSpouse = await (await fetch(`${apiUrl}/person/${person.firstSpouseId}`)).json();
            const secondSpouse = await (await fetch(`${apiUrl}/person/${person.secondSpouseId}`)).json();

            extendedMarriage.secondaryMarriage = createMarriage(person, firstSpouse, false);

            mainMarriage.person = person;
            mainMarriage.spouse = secondSpouse;
            mainMarriage.marriage = createMarriage(person, secondSpouse, true);

            processedPersonIds.add(person.secondSpouseId);
        }

    }
    else {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single female ---
            mainMarriage.person = person;
        }
        else if (person.secondSpouseId == null) { // single married female
            const spouseId = person.firstSpouseId;
            const spouse = await (await fetch(`${apiUrl}/person/${spouseId}`)).json();

            if (spouse.secondSpouseId == null) { // single female with single married man ---
                mainMarriage.spouse = spouse;
                mainMarriage.person = person;
                mainMarriage.marriage = createMarriage(person, spouse, true);

                processedPersonIds.add(spouseId);
            }
            else { // divorced female ---
                mainMarriage.person = person;
            }
        }
        else { // double married female
        }
    }

    // if not double married female
    if (mainMarriage.person != null || extendedMarriage.secondaryMarriage != null) {
        if (mainMarriage.person != null) {
            extendedMarriage.mainMarriage = mainMarriage;
        }

        if (!generationsMap.has(currentLevel)) {
            const newGeneration = {};
            newGeneration.extendedMarriages = [];
            generationsMap.set(currentLevel, newGeneration);
        }

        const generation = generationsMap.get(currentLevel);
        generation.extendedMarriages.push(extendedMarriage);
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

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createGenerationsRecursive(child.id, processedPersonIds, generationsMap, currentLevel + 1);
}

function createMarriage(person, spouse, isMainMarriage) {
    const marriage = {};

    marriage.isMainMarriage = isMainMarriage;
    marriage.startDate = person.firstSpouseId == spouse.id ? person.firstMarriageStartDate : person.secondMarriageStartDate;;
    marriage.endDate = person.firstSpouseId == spouse.id ? person.firstMarriageEndDate : person.secondMarriageEndDate;
    marriage.maleId = person.isMale ? person.id : spouse.id;
    marriage.femaleId = !person.isMale ? person.id : spouse.id;
    marriage.inverseBiologicalParentIds = getCommonBiologicalChildren(person, spouse);
    marriage.inverseAdoptiveParentIds = getCommonAdoptiveChildren(person, spouse);

    return marriage;
}

// gets the largest persons with available parents number of all generations
function getLargestGenerationSize(generations) {
    let largestGenerationSize = 0;

    generations.forEach(generation => {
        largestGenerationSize = Math.max(largestGenerationSize, getGenerationSize(generation));
    })

    return largestGenerationSize;
}

function getGenerationSize(generation) {
    let size = 0;
    generation.extendedMarriages.forEach(extendedMarriage => {
        size += extendedMarriage.numberOfAvailableParents;
    });

    return size;
}

function getNumberOfAvailableParents(extendedMarriage) {
    // Szabi: mainMarriage is null when all people??
    return getNumOfParents(extendedMarriage.mainMarriage?.person) +
        getNumOfParents(extendedMarriage.mainMarriage?.spouse) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.person) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.spouse);
}

function getNumOfParents(person) {
    if (person == null) {
        return null;
    }

    let number = 0;

    number += person.biologicalFatherId || person.biologicalMotherId ? 1 : 0;
    number += person.adoptiveFatherId || person.adoptiveMotherId ? 1 : 0;

    return number;
}