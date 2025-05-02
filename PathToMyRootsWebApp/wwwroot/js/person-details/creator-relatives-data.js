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

    const grandParent1 = await getPersonJson(person.biologicalFather?.biologicalFatherId) ?? unknownMale;
    const grandParent2 = await getPersonJson(person.biologicalFather?.biologicalMotherId) ?? unknownFemale;
    const grandParent3 = await getPersonJson(person.biologicalMother?.biologicalFatherId) ?? unknownMale;
    const grandParent4 = await getPersonJson(person.biologicalMother?.biologicalMotherId) ?? unknownFemale;
    relativesData.grandParents = [grandParent1, grandParent2, grandParent3, grandParent4];

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

    const biologicalChildren = getBiologicalChildren(person);
    const adoptiveChildren = getAdoptiveChildren(person);

    if (person.firstSpouseId) {
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
    relativesData.grandChildren = grandChildren;

    return relativesData;
}

function getAllChildren(person) {
    return (person.inverseBiologicalFather ?? [])
        .concat(person.inverseBiologicalMother ?? [])
        .concat(person.inverseAdoptiveFather ?? [])
        .concat(person.inverseAdoptiveMother ?? []);
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