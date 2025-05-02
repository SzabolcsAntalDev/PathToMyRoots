async function createRelativesData(person) {
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

    const relativesData = {};

    const biologicalGrandParent1 = await getPersonJson(person.biologicalFather?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent2 = await getPersonJson(person.biologicalFather?.biologicalMotherId) ?? unknownFemale;
    const biologicalGrandParent3 = await getPersonJson(person.biologicalMother?.biologicalFatherId) ?? unknownMale;
    const biologicalGrandParent4 = await getPersonJson(person.biologicalMother?.biologicalMotherId) ?? unknownFemale;
    relativesData.biologicalGrandParents = [biologicalGrandParent1, biologicalGrandParent2, biologicalGrandParent3, biologicalGrandParent4];

    const adoptiveGrandParent1 = await getPersonJson(person.adoptiveFather?.biologicalFatherId) ?? unknownMale;
    const adoptiveGrandParent2 = await getPersonJson(person.adoptiveFather?.biologicalMotherId) ?? unknownFemale;
    const adoptiveGrandParent3 = await getPersonJson(person.adoptiveMother?.biologicalFatherId) ?? unknownMale;
    const adoptiveGrandParent4 = await getPersonJson(person.adoptiveMother?.biologicalMotherId) ?? unknownFemale;
    const adoptiveGrandParents = [adoptiveGrandParent1, adoptiveGrandParent2, adoptiveGrandParent3, adoptiveGrandParent4];
    relativesData.adoptiveGrandParents =
        adoptiveGrandParents.some(grandParent => grandParent.id != -1)
            ? adoptiveGrandParents : [];

    relativesData.biologicalParents =
        [
            person.biologicalFather ?? unknownMale,
            person.biologicalMother ?? unknownFemale
        ];

    if (person.adoptiveFather || person.adoptiveMother) {
        relativesData.adoptiveParents =
            [
                person.adoptiveFather ?? unknownMale,
                person.adoptiveMother ?? unknownFemale
            ];
    }

    relativesData.siblings = await getSiblings(person);
    relativesData.cousins = await getCousins(relativesData, person.id);

    const biologicalChildren = getBiologicalChildren(person);
    const adoptiveChildren = getAdoptiveChildren(person);

    if (person.firstSpouseId) {
        relativesData.firstSpouseId = person.firstSpouseId;

        const firstSpouse = await getPersonJson(person.firstSpouseId);

        const firstMarriageBiologicalChildren = getBiologicalChildrenIds(firstSpouse);
        const firstMarriageAdoptiveChildren = getAdoptiveChildrenIds(firstSpouse);

        relativesData.firstSpouse = firstSpouse;
        relativesData.firstMarriageBiologicalChildren =
            biologicalChildren.filter(child => firstMarriageBiologicalChildren.includes(child.id));
        relativesData.firstMarriageAdoptiveChildren =
            adoptiveChildren.filter(child => firstMarriageAdoptiveChildren.includes(child.id));
    }

    if (person.secondSpouseId) {
        relativesData.secondSpouseId = person.secondSpouseId;

        const secondSpouse = await getPersonJson(person.secondSpouseId);

        const secondMarriageBiologicalChildren = getBiologicalChildrenIds(secondSpouse);
        const secondMarriageAdoptiveChildren = getAdoptiveChildrenIds(secondSpouse);

        relativesData.secondSpouse = secondSpouse;
        relativesData.secondMarriageBiologicalChildren =
            biologicalChildren.filter(child => secondMarriageBiologicalChildren.includes(child.id));
        relativesData.secondMarriageAdoptiveChildren =
            adoptiveChildren.filter(child => secondMarriageAdoptiveChildren.includes(child.id));
    }

    const grandChildren = [];
    const children = (biologicalChildren ?? []).concat(adoptiveChildren ?? []);
    for (const child of children) {
        const childJson = await getPersonJson(child.id);
        const allChildren = getAllChildren(childJson);
        for (const grandChild of allChildren) {
            grandChildren.push(grandChild);
        }
    }
    relativesData.grandChildren = arrayRemoveDuplicatesWithSameId(grandChildren);

    return relativesData;
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
    const allGrandParents =
        relativesData.biologicalGrandParents
            .concat(relativesData.adoptiveGrandParents)
            .filter(grandParent => grandParent.id != -1);

    const allParentsNested = [];
    allGrandParents.forEach(grandParent => {
        allParentsNested.push(grandParent.inverseBiologicalFather);
        allParentsNested.push(grandParent.inverseBiologicalMother);
        allParentsNested.push(grandParent.inverseAdoptiveFather);
        allParentsNested.push(grandParent.inverseAdoptiveMother);
    })

    const allParents = arrayRemoveDuplicatesWithSameId(allParentsNested.flat());

    const allNestedCousins = [];
    for (const parent of allParents) {
        const parentJson = await getPersonJson(parent.id);
        allNestedCousins.push(parentJson.inverseBiologicalFather);
        allNestedCousins.push(parentJson.inverseBiologicalMother);
        allNestedCousins.push(parentJson.inverseAdoptiveFather);
        allNestedCousins.push(parentJson.inverseAdoptiveMother);
    }

    const siblingsIds = relativesData.siblings.map(sibling => sibling.id);
    return arrayRemoveDuplicatesWithSameId(allNestedCousins.flat())
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

function getBiologicalChildrenIds(person) {
    return getBiologicalChildren(person).map(child => child.id);
}

function getAdoptiveChildrenIds(person) {
    return getAdoptiveChildren(person).map(child => child.id);
}

function getAllChildren(person) {
    return (person.inverseBiologicalFather ?? [])
        .concat(person.inverseBiologicalMother ?? [])
        .concat(person.inverseAdoptiveFather ?? [])
        .concat(person.inverseAdoptiveMother ?? []);
}