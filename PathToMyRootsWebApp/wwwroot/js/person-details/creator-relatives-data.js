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
    relativesData.cousins = await getCousins(relativesData, person.id);

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

async function getCousins(relativesData, personId) {
    const grandParents =
        relativesData.biologicalGrandParents
            .concat(relativesData.adoptiveGrandParents)
            .filter(grandParent => grandParent.id != -1);

    const parentsNested = [];
    grandParents.forEach(grandParent => {
        parentsNested.push(grandParent.inverseBiologicalFather);
        parentsNested.push(grandParent.inverseBiologicalMother);
        parentsNested.push(grandParent.inverseAdoptiveFather);
        parentsNested.push(grandParent.inverseAdoptiveMother);
    })

    const parents = arrayRemoveDuplicatesWithSameId(parentsNested.flat());

    const nestedCousins = [];
    for (const parent of parents) {
        const parentJson = await getPersonJson(parent.id);
        nestedCousins.push(parentJson.inverseBiologicalFather);
        nestedCousins.push(parentJson.inverseBiologicalMother);
        nestedCousins.push(parentJson.inverseAdoptiveFather);
        nestedCousins.push(parentJson.inverseAdoptiveMother);
    }

    const siblingsIds = relativesData.siblings.map(sibling => sibling.id);
    return arrayRemoveDuplicatesWithSameId(nestedCousins.flat())
        .filter(cousin =>
            !siblingsIds.includes(cousin.id) &&
            cousin.id != personId);
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