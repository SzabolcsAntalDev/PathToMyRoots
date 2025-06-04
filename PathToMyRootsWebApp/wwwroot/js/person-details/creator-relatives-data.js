const unknownMale = {
    id: -1,
    firstName: "Unknown",
    isMale: true
};

const unknownFemale = {
    id: -1,
    firstName: "Unknown",
    isMale: false
};

async function createRelativesData(person, relativesColumn) {
    const relativesData = {};

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading biological grandparents');
    relativesData.biologicalGrandParents = await getBiologicalGrandParents(person);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading biological parents');
    relativesData.biologicalParents = getBiologicalParents(person);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading siblings by biological parents');
    relativesData.siblingsByBiologicalParents = await getSiblingsByBiologicalParents(person);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading adoptive parents');
    relativesData.adoptiveParents = getAdoptiveParents(person);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading siblings by adoptive parents');
    relativesData.siblingsByAdoptiveParents = await getSiblingsByAdoptiveParents(person);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading first cousins');
    relativesData.firstCousins = await getFirstCousins(relativesData, person.id);

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading second cousins');
    relativesData.secondCousins = await getSecondCousins(relativesData, person.id);

    const biologicalChildren = getBiologicalChildren(person);
    const adoptiveChildren = getAdoptiveChildren(person);

    if (person.firstSpouseId) {
        loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading' + (person.secondSpouseId ? ' first ' : ' ') + 'marriage');
        relativesData.firstSpouseId = person.firstSpouseId;
        relativesData.firstSpouse = await getPersonJson(person.firstSpouseId);
        relativesData.firstMarriageBiologicalChildren = getCommonChildren(biologicalChildren, getBiologicalChildrenIds(relativesData.firstSpouse));
        relativesData.firstMarriageAdoptiveChildren = getCommonChildren(adoptiveChildren, getAdoptiveChildrenIds(relativesData.firstSpouse));
    }

    if (person.secondSpouseId) {
        loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading second marriage');
        relativesData.secondSpouseId = person.secondSpouseId;
        relativesData.secondSpouse = await getPersonJson(person.secondSpouseId);
        relativesData.secondMarriageBiologicalChildren = getCommonChildren(biologicalChildren, getBiologicalChildrenIds(relativesData.secondSpouse));
        relativesData.secondMarriageAdoptiveChildren = getCommonChildren(adoptiveChildren, getAdoptiveChildrenIds(relativesData.secondSpouse));
    }

    loadingTextManager.setLoadingProgressText(relativesColumn, 'Loading granchildren');
    relativesData.grandChildren = await getGrandChildren(biologicalChildren);

    return relativesData;
}

async function getBiologicalGrandParents(person) {
    const biologicalGrandParent1 = await getPersonJson(person.biologicalFather?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent2 = await getPersonJson(person.biologicalFather?.biologicalMotherId) ?? unknownFemale;
    const biologicalGrandParent3 = await getPersonJson(person.biologicalMother?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent4 = await getPersonJson(person.biologicalMother?.biologicalMotherId) ?? unknownFemale;

    return [biologicalGrandParent1, biologicalGrandParent2, biologicalGrandParent3, biologicalGrandParent4];
}

function getBiologicalParents(person) {
    return [
        person.biologicalFather ?? unknownMale,
        person.biologicalMother ?? unknownFemale
    ];
}

function getAdoptiveParents(person) {
    if (person.adoptiveFather) {
        return [
            person.adoptiveFather ?? unknownMale,
            person.adoptiveMother ?? unknownFemale
        ];
    }

    return [];
}

async function getSiblingsByBiologicalParents(person) {
    const biologicalFather = await getPersonJson(person.biologicalFather?.id);
    const biologicalMother = await getPersonJson(person.biologicalMother?.id);

    const siblings = (biologicalFather?.inverseBiologicalFather ?? [])
        .concat(biologicalFather?.inverseAdoptiveFather ?? [])
        .concat(biologicalMother?.inverseBiologicalMother ?? [])
        .concat(biologicalMother?.inverseAdoptiveMother ?? []);

    return arrayRemoveDuplicatesWithSameId(siblings).filter(sibling => sibling.id != person.id);
}

async function getSiblingsByAdoptiveParents(person) {
    const adoptiveFather = await getPersonJson(person.adoptiveFather?.id);
    const adoptiveMother = await getPersonJson(person.adoptiveMother?.id);

    const siblings = (adoptiveFather?.inverseBiologicalFather ?? [])
        .concat(adoptiveFather?.inverseAdoptiveFather ?? [])
        .concat(adoptiveMother?.inverseBiologicalMother ?? [])
        .concat(adoptiveMother?.inverseAdoptiveMother ?? []);

    return arrayRemoveDuplicatesWithSameId(siblings).filter(sibling => sibling.id != person.id);
}

async function getFirstCousins(relativesData, personId) {
    const grandParents =
        relativesData.biologicalGrandParents
            .filter(grandParent => grandParent.id != -1);

    const grandChildren = await getGrandChildrenOfGrandParents(grandParents);

    const siblingsIds = relativesData.siblingsByBiologicalParents.map(sibling => sibling.id);
    const nonFirstCousinIds = siblingsIds.concat([personId]);

    return arrayRemoveDuplicatesWithSameId(grandChildren)
        .filter(cousin => !nonFirstCousinIds.includes(cousin.id));
}

async function getSecondCousins(relativesData, personId) {
    const grandParents =
        relativesData.biologicalGrandParents
            .filter(grandParent => grandParent.id != -1);

    // get parents of grand parents
    const greatGrandParentsWithNulls = [];
    for (const grandParent of grandParents) {
        greatGrandParentsWithNulls.push(grandParent.biologicalFather);
        greatGrandParentsWithNulls.push(grandParent.biologicalMother);
    }

    const greatGrandParents =
        arrayRemoveDuplicatesWithSameId(
            greatGrandParentsWithNulls.filter(greatGrandParent => greatGrandParent));

    // get children of great grand parents
    const extendedGrandParentsShallowNested = [];
    for (const greatGrandParent of greatGrandParents) {
        const greatGrandParentJson = await getPersonJson(greatGrandParent.id);
        extendedGrandParentsShallowNested.push(greatGrandParentJson.inverseBiologicalFather);
        extendedGrandParentsShallowNested.push(greatGrandParentJson.inverseBiologicalMother);
    }

    const extendedGrandParentsShallowFlat =
        arrayRemoveDuplicatesWithSameId(
            extendedGrandParentsShallowNested
                .flat()
                .filter(grandParent => grandParent))

    // retrieve all grand parents
    const extendedGrandParents = [];
    for (const grandParentShallow of extendedGrandParentsShallowFlat) {
        const grandParent = await getPersonJson(grandParentShallow.id);
        extendedGrandParents.push(grandParent);
    }

    const greatGrandChildren = await getGrandChildrenOfGrandParents(extendedGrandParents);

    const siblingsIds = relativesData.siblingsByBiologicalParents.map(sibling => sibling.id);
    const firstCousinIds = relativesData.firstCousins.map(firstCousin => firstCousin.id);
    const nonSecondCousinIds = firstCousinIds.concat(siblingsIds).concat([personId]);

    return arrayRemoveDuplicatesWithSameId(greatGrandChildren)
        .filter(secondCousin =>
            !nonSecondCousinIds.includes(secondCousin.id));
}

async function getGrandChildrenOfGrandParents(grandParents) {
    const childrenNested = [];
    grandParents.forEach(grandParent => {
        childrenNested.push(grandParent.inverseBiologicalFather);
        childrenNested.push(grandParent.inverseBiologicalMother);
    })

    const children = arrayRemoveDuplicatesWithSameId(childrenNested.flat());

    const grandChildrenNested = [];
    for (const child of children) {
        const childJson = await getPersonJson(child.id);
        grandChildrenNested.push(childJson.inverseBiologicalFather);
        grandChildrenNested.push(childJson.inverseBiologicalMother);
    }

    return arrayRemoveDuplicatesWithSameId(grandChildrenNested.flat());
}

function getBiologicalChildren(person) {
    return (person?.inverseBiologicalFather ?? [])
        .concat(person?.inverseBiologicalMother ?? []);
}

function getAdoptiveChildren(person) {
    return (person?.inverseAdoptiveFather ?? [])
        .concat(person?.inverseAdoptiveMother ?? []);
}

function getBiologicalChildrenIds(person) {
    return getBiologicalChildren(person).map(child => child.id);
}

function getAdoptiveChildrenIds(person) {
    return getAdoptiveChildren(person).map(child => child.id);
}

function getCommonChildren(children, spouseChildrenIds) {
    return children.filter(child => spouseChildrenIds.includes(child.id));
}

async function getGrandChildren(biologicalChildren) {
    const grandChildrenNested = [];

    for (const child of biologicalChildren) {
        const childJson = await getPersonJson(child.id);

        const childrenOfChild = getBiologicalChildren(childJson);
        for (const grandChild of childrenOfChild) {
            grandChildrenNested.push(grandChild);
        }
    }

    return arrayRemoveDuplicatesWithSameId(grandChildrenNested);
}