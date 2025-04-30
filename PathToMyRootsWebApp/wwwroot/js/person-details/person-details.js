async function createPersonDetails(personId) {
    const treeDiagramsContainer = $('#tree-diagrams-container');
    //createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

    const person = await getPersonJson(personId);
    const infoColumn = $('.info-column');
    const relativesColumn = $('.relatives-column');

    infoColumn
        .append(createPersonDetailsImage(person))
        .append(createPersonDetailsNameSpan(person))
        .append(createPersonDetailsLivedSpan(person));

    const familyData = await generateFamilyData(person);

    {
        const grandParentsContainer =
            createPersonDetailsRelativesContainer()
                .append(createPersonDetailsRelativesContainerTitle('Grandparents'));

        const container = createRelativesHorizontal();

        familyData.grandParents.forEach(grandParent => {
            container.append(createPersonDetailsNonSpouse(grandParent));
        });

        grandParentsContainer.append(container);
        relativesColumn.append(grandParentsContainer);
    }

    {
        const biologicalParentsContainer =
            createPersonDetailsRelativesContainer()
                .append(createPersonDetailsRelativesContainerTitle('Biological Parents'));

        const container = createRelativesHorizontal();

        familyData.biologicalParents.forEach(parent => {
            container.append(createPersonDetailsNonSpouse(parent));
        });
        biologicalParentsContainer.append(container);
        relativesColumn.append(biologicalParentsContainer);
    }

    {
        const adoptiveParentsContainer =
            createPersonDetailsRelativesContainer()
                .append(createPersonDetailsRelativesContainerTitle('Adoptive Parents'));

        const container = createRelativesHorizontal();

        familyData.adoptiveParents.forEach(parent => {
            container.append(createPersonDetailsNonSpouse(parent));
        });
        adoptiveParentsContainer.append(container);
        relativesColumn.append(adoptiveParentsContainer);
    }

    {
        if (familyData.firstSpouse) {
            const spouseContainer =
                createPersonDetailsRelativesContainer()
                    .append(createPersonDetailsRelativesContainerTitle(
                        familyData.secondSpouse ? 'First spouse' : 'Spouse'));

            const spouse = createRelativesHorizontal();
            spouse.append(
                createPersonDetailsSpouse(
                    person.firstSpouse,
                    person.firstMarriageStartDate,
                    person.firstMarriageEndDate));

            spouseContainer.append(spouse);
            relativesColumn.append(spouseContainer);
        }

        if (familyData.firstMarriageBiologicalChildren) {
            const childrenContainer =
                createPersonDetailsRelativesContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Biological children'));

            const container = createRelativesHorizontal();

            familyData.firstMarriageBiologicalChildren.forEach(child => {
                container.append(createPersonDetailsNonSpouse(child));
            });

            childrenContainer.append(container);
            relativesColumn.append(childrenContainer);
        }

        if (familyData.firstMarriageAdoptiveChildren) {
            const childrenContainer =
                createPersonDetailsRelativesContainer()
                    .append(createPersonDetailsRelativesContainerTitle('Adoptive children'));

            const container = createRelativesHorizontal();

            familyData.firstMarriageAdoptiveChildren.forEach(child => {
                container.append(createPersonDetailsNonSpouse(child));
            });

            childrenContainer.append(container);
            relativesColumn.append(childrenContainer);
        }







        if (familyData.firstSpouseChildren)

            if (person.secondSpouse) {
                const spouseContainer =
                    createPersonDetailsRelativesContainer()
                        .append(createPersonDetailsRelativesContainerTitle('Second spouse'));

                const spouse = createRelativesHorizontal();
                spouse.append(
                    createPersonDetailsSpouse(
                        person.secondSpouse,
                        person.secondMarriageStartDate,
                        person.secondMarriageEndDate));

                spouseContainer.append(spouse);
                relativesColumn.append(spouseContainer);
            }
    }
    //const childrenObjects = (person.inverseBiologicalFather ?? [])
    //    .concat(person.inverseBiologicalMother ?? [])
    //    .concat(person.inverseAdoptiveFather ?? [])
    //    .concat(person.inverseAdoptiveMother ?? [])

    //if (childrenObjects) {
    //    const childrenContainer =
    //        createPersonDetailsRelativesContainer()
    //            .append(createPersonDetailsRelativesContainerTitle('Children'))

    //    const children = createRelatives();
    //    childrenObjects.forEach(child => {
    //        children.append(createPersonDetailsChild(child));
    //    })

    //    childrenContainer.append(children);
    //    relativesColumn.append(childrenContainer);
    //}
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

    return familyData;
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