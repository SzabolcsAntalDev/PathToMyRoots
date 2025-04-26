async function createGenerationsWithExtendedMarriages(personId) {
    const generationsMap = new Map();
    await createGenerationsRecursive(personId, new Set([null]), generationsMap, 0);
    return sortByLevelAndConvertToArray(generationsMap);
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
    let firstWifesFirstSpouseId;

    if (person.isMale) {
        const male = person;

        if (male.firstSpouseId == null && male.secondSpouseId == null) { // | male | -----
            mainMarriage.male = male;
            processedPersonIds.add(male.id);
        }

        if (male.firstSpouseId != null && male.secondSpouseId == null) { // single married male
            const firstWifeId = male.firstSpouseId;
            const firstWife = await (await fetch(`${apiUrl}/person/${firstWifeId}`)).json();

            if (firstWife.firstSpouseId != null && firstWife.secondSpouseId == null) { // | MALE | female | -----

                mainMarriage.male = male;
                mainMarriage.female = firstWife;
                mainMarriage.marriage = createMarriage(male, firstWife, true);

                processedPersonIds.add(male.id);
                processedPersonIds.add(firstWife.id);
            }

            if (firstWife.firstSpouseId != null && firstWife.secondSpouseId != null) { // single married male with double married female

                if (firstWife.firstSpouseId == male.id) { // | ???? | ???? | -  l l - | MALE | -----
                    extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);
                    mainMarriage.male = male;

                    processedPersonIds.add(male.id);
                    // firstWife should be processed in a later iteration
                }

                if (firstWife.secondSpouseId == male.id) { // | MALE | female | - l l - | ???? | -----
                    mainMarriage.male = male;
                    mainMarriage.female = firstWife;
                    mainMarriage.marriage = createMarriage(male, firstWife, true);

                    processedPersonIds.add(male.id);
                    processedPersonIds.add(firstWife.id);

                    // if | MALE | female | - l l - | male | then firstWife's firstSpouse should be created inclusively
                    firstWifesFirstSpouseId = firstWife.firstSpouseId;
                }
            }
        }
        if (male.firstSpouseId != null && male.secondSpouseId != null) { // | ???? | - l l - | MALE | female | -----
            const firstWife = await (await fetch(`${apiUrl}/person/${male.firstSpouseId}`)).json();
            const secondWife = await (await fetch(`${apiUrl}/person/${male.secondSpouseId}`)).json();

            extendedMarriage.secondaryMarriage = createMarriage(male, firstWife, false);

            mainMarriage.male = male;
            mainMarriage.female = secondWife;
            mainMarriage.marriage = createMarriage(male, secondWife, true);

            processedPersonIds.add(male.id);
            processedPersonIds.add(secondWife.id);
        }

    }
    else {
        const female = person;

        if (female.firstSpouseId == null && female.secondSpouseId == null) { // | FEMALE | -----
            mainMarriage.female = female;
            processedPersonIds.add(female.id);
        }

        if (female.firstSpouseId != null && female.secondSpouseId == null) { // single married female
            const husbandId = female.firstSpouseId;
            const husband = await (await fetch(`${apiUrl}/person/${husbandId}`)).json();

            if (husband.firstSpouseId != null && husband.secondSpouseId == null) { // | male | FEMALE | -----
                mainMarriage.male = husband;
                mainMarriage.female = female;
                mainMarriage.marriage = createMarriage(husband, female, true);

                processedPersonIds.add(female.id);
                processedPersonIds.add(husband.id);
            }

            if (husband.firstSpouseId == female.id && husband.secondSpouseId != null) { // | FEMALE | - l l - | ???? | ???? | -----
                mainMarriage.female = female;
                processedPersonIds.add(female.id);
            }

            if (husband.firstSpouseId != null && husband.secondSpouseId == female.id) { // | ???? | - l l - | m??? | FEM??? | -----
                // female will be added in the husbands iteration
            }
        }

        if (female.firstSpouseId != null && female.secondSpouseId != null) { // | m??? | FEM??? | - l l - | ???? | -----
            // female will be added in the husbands iteration
        }
    }

    if (extendedMarriage.secondaryMarriage != null || mainMarriage.male != null || mainMarriage.female != null) {
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

    if (firstWifesFirstSpouseId) {
        await createGenerationsRecursive(firstWifesFirstSpouseId, processedPersonIds, generationsMap, currentLevel);
    }
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

function getCommonBiologicalChildren(male, female) {
    return male.inverseBiologicalFather
        .filter(maleChild => female.inverseBiologicalMother.some(femaleChild => maleChild.id === femaleChild.id))
        .map(child => child.id);
}

function getCommonAdoptiveChildren(male, female) {
    return male.inverseAdoptiveFather
        .filter(maleChild => female.inverseAdoptiveMother.some(femaleChild => maleChild.id === femaleChild.id))
        .map(child => child.id);
}

function getNumberOfAvailableParents(extendedMarriage) {
    return getNumberOfParents(extendedMarriage.mainMarriage?.male) +
        getNumberOfParents(extendedMarriage.mainMarriage?.female) +
        getNumberOfParents(extendedMarriage.secondaryMarriage?.male) +
        getNumberOfParents(extendedMarriage.secondaryMarriage?.female);
}

function getNumberOfParents(person) {
    if (person == null) {
        return null;
    }

    let number = 0;

    number += person.biologicalFatherId || person.biologicalMotherId ? 1 : 0;
    number += person.adoptiveFatherId || person.adoptiveMotherId ? 1 : 0;

    return number;
}