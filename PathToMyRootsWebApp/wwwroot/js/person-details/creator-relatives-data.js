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

async function createRelativesData(person) {
    const relativesData = {};

    relativesData.biologicalGrandParents = await getBiologicalGrandParents(person);
    relativesData.adoptiveGrandParents = await getAdoptiveGrandParents(person);
    relativesData.biologicalParents = getBiologicalParents(person);
    relativesData.adoptiveParents = getAdoptiveParents(person);
    relativesData.siblings = await getSiblings(person);
    relativesData.firstCousins = await getFirstCousins(relativesData, person.id);
    relativesData.secondCousins = await getSecondCousins(relativesData, person.id);

    const biologicalChildren = getBiologicalChildren(person);
    const adoptiveChildren = getAdoptiveChildren(person);

    if (person.firstSpouseId) {
        relativesData.firstSpouseId = person.firstSpouseId;
        relativesData.firstSpouse = await getPersonJson(person.firstSpouseId);
        relativesData.firstMarriageBiologicalChildren = getCommonChildren(biologicalChildren, getBiologicalChildrenIds(relativesData.firstSpouse));
        relativesData.firstMarriageAdoptiveChildren = getCommonChildren(adoptiveChildren, getAdoptiveChildrenIds(relativesData.firstSpouse));
    }

    if (person.secondSpouseId) {
        relativesData.secondSpouseId = person.secondSpouseId;
        relativesData.secondSpouse = await getPersonJson(person.secondSpouseId);
        relativesData.secondMarriageBiologicalChildren = getCommonChildren(biologicalChildren, getBiologicalChildrenIds(relativesData.secondSpouse));
        relativesData.secondMarriageAdoptiveChildren = getCommonChildren(adoptiveChildren, getAdoptiveChildrenIds(relativesData.secondSpouse));
    }

    relativesData.grandChildren = await getGrandChildren(biologicalChildren, adoptiveChildren);

    return relativesData;
}

async function getBiologicalGrandParents(person) {
    const biologicalGrandParent1 = await getPersonJson(person.biologicalFather?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent2 = await getPersonJson(person.biologicalFather?.biologicalMotherId) ?? unknownFemale;
    const biologicalGrandParent3 = await getPersonJson(person.biologicalMother?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent4 = await getPersonJson(person.biologicalMother?.biologicalMotherId) ?? unknownFemale;

    return [biologicalGrandParent1, biologicalGrandParent2, biologicalGrandParent3, biologicalGrandParent4];
}

async function getAdoptiveGrandParents(person) {
    const adoptiveGrandParent1 = await getPersonJson(person.adoptiveFather?.biologicalFatherId) ?? unknownMale;
    const adoptiveGrandParent2 = await getPersonJson(person.adoptiveFather?.biologicalMotherId) ?? unknownFemale;
    const adoptiveGrandParent3 = await getPersonJson(person.adoptiveMother?.biologicalFatherId) ?? unknownMale;
    const adoptiveGrandParent4 = await getPersonJson(person.adoptiveMother?.biologicalMotherId) ?? unknownFemale;

    const adoptiveGrandParents = [adoptiveGrandParent1, adoptiveGrandParent2, adoptiveGrandParent3, adoptiveGrandParent4];
    return adoptiveGrandParents.some(grandParent => grandParent.id != -1) ? adoptiveGrandParents : [];
}

function getBiologicalParents(person) {
    return [
        person.biologicalFather ?? unknownMale,
        person.biologicalMother ?? unknownFemale
    ];
}

function getAdoptiveParents(person) {
    if (person.adoptiveFather || person.adoptiveMother) {
        return [
            person.adoptiveFather ?? unknownMale,
            person.adoptiveMother ?? unknownFemale
        ];
    }

    return null;
}

async function getSiblings(person) {
    const biologicalFather = await getPersonJson(person.biologicalFather?.id);
    const biologicalMother = await getPersonJson(person.biologicalMother?.id);
    const adoptiveFather = await getPersonJson(person.adoptiveFather?.id);
    const adoptiveMother = await getPersonJson(person.adoptiveMother?.id);

    const siblings = (biologicalFather?.inverseBiologicalFather ?? [])
        .concat(biologicalFather?.inverseAdoptiveFather ?? [])
        .concat(biologicalMother?.inverseBiologicalMother ?? [])
        .concat(biologicalMother?.inverseAdoptiveMother ?? [])
        .concat(adoptiveFather?.inverseBiologicalFather ?? [])
        .concat(adoptiveFather?.inverseAdoptiveFather ?? [])
        .concat(adoptiveMother?.inverseBiologicalMother ?? [])
        .concat(adoptiveMother?.inverseAdoptiveMother ?? []);

    return arrayRemoveDuplicatesWithSameId(siblings).filter(sibling => sibling.id != person.id);
}

async function getFirstCousins(relativesData, personId) {
    const grandParents =
        relativesData.biologicalGrandParents
            .concat(relativesData.adoptiveGrandParents)
            .filter(grandParent => grandParent.id != -1);

    const grandChildren = await getGrandChildrenOfGrandParents(grandParents);

    const siblingsIds = relativesData.siblings.map(sibling => sibling.id);
    const nonFirstCousinIds = siblingsIds.concat([personId]);

    return arrayRemoveDuplicatesWithSameId(grandChildren)
        .filter(cousin => !nonFirstCousinIds.includes(cousin.id));
}

async function getSecondCousins(relativesData, personId) {
    const grandParents =
        relativesData.biologicalGrandParents
            .concat(relativesData.adoptiveGrandParents)
            .filter(grandParent => grandParent.id != -1);

    // get parents of grand parents
    const greatGrandParentsWithNulls = [];
    for (const grandParent of grandParents) {
        greatGrandParentsWithNulls.push(grandParent.biologicalFather);
        greatGrandParentsWithNulls.push(grandParent.biologicalMother);
        greatGrandParentsWithNulls.push(grandParent.adoptiveFather);
        greatGrandParentsWithNulls.push(grandParent.adoptiveMother);
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
        extendedGrandParentsShallowNested.push(greatGrandParentJson.inverseAdoptiveFather);
        extendedGrandParentsShallowNested.push(greatGrandParentJson.inverseAdoptiveMother);
    }

    const extendedGrandParentsShallowFlat =
        arrayRemoveDuplicatesWithSameId(
            extendedGrandParentsShallowNested
                .flat()
                .filter(grandParent => grandParent))

    const extendedGrandParents = [];
    for (const grandParentShallow of extendedGrandParentsShallowFlat) {
        const grandParent = await getPersonJson(grandParentShallow.id);
        extendedGrandParents.push(grandParent);
    }

    const greatGrandChildren = await getGrandChildrenOfGrandParents(extendedGrandParents);

    const siblingsIds = relativesData.siblings.map(sibling => sibling.id);
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
        childrenNested.push(grandParent.inverseAdoptiveFather);
        childrenNested.push(grandParent.inverseAdoptiveMother);
    })

    const children = arrayRemoveDuplicatesWithSameId(childrenNested.flat());

    const nestedGrandChildren = [];
    for (const child of children) {
        const childJson = await getPersonJson(child.id);
        nestedGrandChildren.push(childJson.inverseBiologicalFather);
        nestedGrandChildren.push(childJson.inverseBiologicalMother);
        nestedGrandChildren.push(childJson.inverseAdoptiveFather);
        nestedGrandChildren.push(childJson.inverseAdoptiveMother);
    }

    return arrayRemoveDuplicatesWithSameId(nestedGrandChildren.flat());
}

function getBiologicalChildren(person) {
    return (person?.inverseBiologicalFather ?? [])
        .concat(person?.inverseBiologicalMother ?? []);
}

function getAdoptiveChildren(person) {
    return (person?.inverseAdoptiveFather ?? [])
        .concat(person?.inverseAdoptiveMother ?? []);
}

function getAllChildren(person) {
    return getBiologicalChildren(person)
        .concat(getAdoptiveChildren(person));
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

// Szabi: ?
async function getGrandChildren(biologicalChildren, adoptiveChildren) {
    const grandChildrenNested = [];
    const children = (biologicalChildren ?? []).concat(adoptiveChildren ?? []);
    for (const child of children) {
        const childJson = await getPersonJson(child.id);
        const childrenOfChild = getAllChildren(childJson);
        for (const grandChild of childrenOfChild) {
            grandChildrenNested.push(grandChild);
        }
    }
    return arrayRemoveDuplicatesWithSameId(grandChildrenNested);
}