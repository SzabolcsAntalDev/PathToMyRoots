async function createGenerationsData(personId) {
    const generationsMap = new Map();
    await createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);

    const generations = sortByLevelAndConvertToArray(generationsMap);

    sortFirstGenerationByLifeSpan(generations[0]);

    // generation.extendedMarriagesSortedByMarriages
    sortByMarriages(generations);

    // generation.extendedMarriageGroupsByMarriages
    groupByMarriages(generations);

    // sort first level by life span
    groupByParents(generations)

    sortSiblings(generations);
    //sortSiblingGroups();


    // sort rest of levels by life span
    //sortByLifeSpan(generations);

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
        const male = person;
        if (male.firstSpouseId == null && male.secondSpouseId == null) { // single male ---
            mainMarriage.male = male;
        }
        else if (male.secondSpouseId == null) { // single married male
            const firstWifeId = male.firstSpouseId;
            const firstWife = await (await fetch(`${apiUrl}/person/${firstWifeId}`)).json();

            if (firstWife.secondSpouseId == null) { // single married male with single married female ---
                mainMarriage.male = male;
                mainMarriage.female = firstWife;
                mainMarriage.marriage = createMarriage(male, firstWife, true);

                processedPersonIds.add(firstWifeId);
            }
            else { // single married male with double married female
                if (firstWife.firstSpouseId == personId) { // divorced male ---
                    extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);
                    mainMarriage.male = male;
                }
                else { // single male married male with ex-married female ---
                    mainMarriage.male = male;
                    mainMarriage.female = firstWife;
                    mainMarriage.marriage = createMarriage(male, firstWife, true);

                    processedPersonIds.add(firstWifeId);
                }
            }
        }
        else { // double married male ---
            const firstWife = await (await fetch(`${apiUrl}/person/${male.firstSpouseId}`)).json();
            const secondWife = await (await fetch(`${apiUrl}/person/${male.secondSpouseId}`)).json();

            extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);

            mainMarriage.male = male;
            mainMarriage.female = secondWife;
            mainMarriage.marriage = createMarriage(male, secondWife, true);

            processedPersonIds.add(male.secondSpouseId);
        }

    }
    else {
        const female = person;
        if (female.firstSpouseId == null && female.secondSpouseId == null) { // single female ---
            mainMarriage.female = female;
        }
        else if (female.secondSpouseId == null) { // single married female
            const husbandId = female.firstSpouseId;
            const husband = await (await fetch(`${apiUrl}/person/${husbandId}`)).json();

            if (husband.secondSpouseId == null) { // single female with single married man ---
                mainMarriage.male = husband;
                mainMarriage.female = female;
                mainMarriage.marriage = createMarriage(husband, female, true);

                processedPersonIds.add(husbandId);
            }
            else if (husband.firstSpouseId == female.id) { // divorced female from double married man ---
                mainMarriage.female = female;
            }
            else if (husband.secondSpouseId == female.id) { // single married female with double married man ---

            }
        }
        else { // double married female
        }
    }

    // if not double married female
    if (mainMarriage.male != null || mainMarriage.female != null || extendedMarriage.secondaryMarriage != null) {
        if (mainMarriage.male != null || mainMarriage.female != null) {
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

function createMarriage(male, female, isMainMarriage) {
    const marriage = {};

    marriage.isMainMarriage = isMainMarriage;
    marriage.startDate = male.firstSpouseId == female.id ? male.firstMarriageStartDate : male.secondMarriageStartDate;;
    marriage.endDate = male.firstSpouseId == female.id ? male.firstMarriageEndDate : male.secondMarriageEndDate;
    marriage.maleId = male?.id;
    marriage.femaleId = female?.id;
    marriage.inverseBiologicalParentIds = getCommonBiologicalChildren(male, female);
    marriage.inverseAdoptiveParentIds = getCommonAdoptiveChildren(male, female);

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
    return getNumOfParents(extendedMarriage.mainMarriage?.male) +
        getNumOfParents(extendedMarriage.mainMarriage?.female) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.male) +
        getNumOfParents(extendedMarriage.secondaryMarriage?.female);
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