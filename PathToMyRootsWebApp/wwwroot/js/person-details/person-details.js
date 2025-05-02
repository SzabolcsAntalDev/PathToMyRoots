async function createPersonDetails(personId) {
    const treeDiagramsContainer = $('#tree-diagrams-container');
    createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

    const person = await getPersonJson(personId);
    const infoColumn = $('.info-column');
    const relativesColumn = $('.relatives-column');

    infoColumn
        .append(createPersonDetailsImage(person))
        .append(createPersonDetailsNameSpan(person))
        .append(createPersonDetailsLivedSpan(person));

    const familyData = await generateFamilyData(person);

    {
        const withTitleContainer =
            createPersonDetailsRelativesWithTitleContainer()
                .append(createPersonDetailsRelativesContainerTitle('Grandparents'));

        const horizontalContainer = createRelativesHorizontalContainer();

        familyData.grandParents.forEach(grandParent => {
            horizontalContainer
                .append(createPersonDetailsNonSpouse(grandParent));
        });

        withTitleContainer.append(horizontalContainer);
        relativesColumn.append(withTitleContainer);
    }

    {
        const withTitleContainer =
            createPersonDetailsRelativesWithTitleContainer()
                .append(createPersonDetailsRelativesContainerTitle('Biological Parents'));

        const horizontalContainer = createRelativesHorizontalContainer();

        familyData.biologicalParents.forEach(parent => {
            horizontalContainer.append(createPersonDetailsNonSpouse(parent));
        });
        withTitleContainer.append(horizontalContainer);
        relativesColumn.append(withTitleContainer);
    }

    {
        const withTitleContainer =
            createPersonDetailsRelativesWithTitleContainer()
                .append(createPersonDetailsRelativesContainerTitle('Adoptive Parents'));

        const horizontalContainer = createRelativesHorizontalContainer();

        familyData.adoptiveParents.forEach(parent => {
            horizontalContainer.append(createPersonDetailsNonSpouse(parent));
        });
        withTitleContainer.append(horizontalContainer);
        relativesColumn.append(withTitleContainer);
    }

    {
        if (familyData.firstSpouse) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle(
                        familyData.secondSpouse ? 'First spouse' : 'Spouse'));

            const horizontalContainer = createRelativesHorizontalContainer();
            horizontalContainer.append(
                createPersonDetailsSpouse(
                    person.firstSpouse,
                    person.firstMarriageStartDate,
                    person.firstMarriageEndDate));

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }

    {
        if (familyData.firstMarriageBiologicalChildren) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Biological Children'));

            const horizontalContainer = createRelativesHorizontalContainer();

            familyData.firstMarriageBiologicalChildren.forEach(child => {
                horizontalContainer.append(createPersonDetailsNonSpouse(child));
            });

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }

    {
        if (familyData.firstMarriageAdoptiveChildren) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Adoptive Children'));

            const horizontalContainer = createRelativesHorizontalContainer();

            familyData.firstMarriageAdoptiveChildren.forEach(child => {
                horizontalContainer.append(createPersonDetailsNonSpouse(child));
            });

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }


    {
        if (familyData.secondSpouse) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Second Spouse'));

            const horizontalContainer = createRelativesHorizontalContainer();
            horizontalContainer.append(
                createPersonDetailsSpouse(
                    person.secondSpouse,
                    person.secondMarriageStartDate,
                    person.secondMarriageEndDate));

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }

    {
        if (familyData.secondMarriageBiologicalChildren) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Biological Children'));

            const horizontalContainer = createRelativesHorizontalContainer();

            familyData.secondMarriageBiologicalChildren.forEach(child => {
                horizontalContainer.append(createPersonDetailsNonSpouse(child));
            });

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }

    {
        if (familyData.secondMarriageAdoptiveChildren) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Adoptive Children'));

            const horizontalContainer = createRelativesHorizontalContainer();

            familyData.secondMarriageAdoptiveChildren.forEach(child => {
                horizontalContainer.append(createPersonDetailsNonSpouse(child));
            });

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }

    {
        if (familyData.grandChildren) {
            const withTitleContainer =
                createPersonDetailsRelativesWithTitleContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Grandchildren'));

            const horizontalContainer = createRelativesHorizontalContainer();

            familyData.grandChildren.forEach(grandChild => {
                horizontalContainer.append(createPersonDetailsNonSpouse(grandChild));
            });

            withTitleContainer.append(horizontalContainer);
            relativesColumn.append(withTitleContainer);
        }
    }
}

async function generateFamilyData(person) {
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

    const familyData = {};

    familyData.biologicalParents =
        [
            person.biologicalFather ?? unknownMale,
            person.biologicalMother ?? unknownFemale
        ];

    familyData.adoptiveParents =
        [
            person.adoptiveFather ?? unknownMale,
            person.adoptiveMother ?? unknownFemale
        ];

    const grandParent1 = await getPersonJson(person.biologicalFather?.biologicalFatherId) ?? unknownMale;
    const grandParent2 = await getPersonJson(person.biologicalFather?.biologicalMotherId) ?? unknownFemale;
    const grandParent3 = await getPersonJson(person.biologicalMother?.biologicalFatherId) ?? unknownMale;
    const grandParent4 = await getPersonJson(person.biologicalMother?.biologicalMotherId) ?? unknownFemale;

    familyData.grandParents = [grandParent1, grandParent2, grandParent3, grandParent4];

    let firstSpouse;
    if (person.firstSpouseId) {
        firstSpouse = await getPersonJson(person.firstSpouseId);
    }

    let secondSpouse;
    if (person.secondSpouseId) {
        secondSpouse = await getPersonJson(person.secondSpouseId);
    }

    const biologicalChildren = getBiologicalChildren(person);
    const adoptiveChildren = getAdoptiveChildren(person);

    const firstMarriageBiologicalChildren = getBiologicalChildrenIds(firstSpouse);
    const firstMarriageAdoptiveChildren = getAdoptiveChildrenIds(firstSpouse);

    const secondMarriageBiologicalChildren = getBiologicalChildrenIds(secondSpouse);
    const secondMarriageAdoptiveChildren = getAdoptiveChildrenIds(secondSpouse);

    familyData.firstSpouse = firstSpouse;
    familyData.firstMarriageBiologicalChildren =
        biologicalChildren.filter(child => firstMarriageBiologicalChildren.includes(child.id));
    familyData.firstMarriageAdoptiveChildren =
        adoptiveChildren.filter(child => firstMarriageAdoptiveChildren.includes(child.id));

    familyData.secondSpouse = secondSpouse;
    familyData.secondMarriageBiologicalChildren =
        biologicalChildren.filter(child => secondMarriageBiologicalChildren.includes(child.id));
    familyData.secondMarriageAdoptiveChildren =
        adoptiveChildren.filter(child => secondMarriageAdoptiveChildren.includes(child.id));

    const grandChildren = [];

    const children = (biologicalChildren ?? []).concat(adoptiveChildren ?? []);
    for (const child of children) {
        const childObject = await getPersonJson(child.id);
        const allChildren = getAllChildren(childObject);
        for (const grandChild of allChildren) {
            grandChildren.push(grandChild);
        }
    }

    familyData.grandChildren = grandChildren;
    return familyData;
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