async function createPersonDetails(personId) {
    const person = await getPersonJson(personId);

    createInfoColumn(person);
    await createRelativesColumn(person);
    createTreeColumn(personId);
}

function createInfoColumn(person) {
    const infoColumn = $('.info-column');

    infoColumn
        .append(createPersonDetailsImage(person))
        .append(createPersonDetailsNameSpan(person))
        .append(createPersonDetailsLivedSpan(person));
}

async function createRelativesColumn(person) {
    const relativesColumn = $('.relatives-column');

    const relativesData = await createRelativesData(person)

    addRelatives(
        relativesColumn,
        relativesData.adoptiveGrandParents.length > 0 ? 'Biological grandparents' : 'Grandparents',
        relativesData.biologicalGrandParents);

    addRelatives(
        relativesColumn,
        relativesData.adoptiveParents ? 'Biological Parents' : 'Parents',
        relativesData.biologicalParents);

    addRelatives(relativesColumn, 'Adoptive grandparents', relativesData.adoptiveGrandParents);
    addRelatives(relativesColumn, 'Adoptive Parents', relativesData.adoptiveParents);

    addRelatives(relativesColumn, 'Siblings', relativesData.siblings);
    addRelatives(relativesColumn, 'First cousins', relativesData.cousins);

    if (relativesData.firstSpouseId) {
        addSpouse(
            relativesColumn,
            relativesData.secondSpouseId ? 'First spouse' : 'Spouse',
            person.firstSpouse,
            person.firstMarriageStartDate,
            person.firstMarriageEndDate);
        addRelatives(
            relativesColumn,
            relativesData.firstMarriageAdoptiveChildren.length > 0 ? 'Biological Children' : 'Children',
            relativesData.firstMarriageBiologicalChildren);
        addRelatives(relativesColumn, 'Adoptive Children', relativesData.firstMarriageAdoptiveChildren);
    }

    if (relativesData.secondSpouseId) {
        addSpouse(relativesColumn, 'Second spouse', person.secondSpouse, person.secondMarriageStartDate, person.secondMarriageEndDate);
        addRelatives(
            relativesColumn,
            relativesData.secondMarriageAdoptiveChildren.length > 0 ? 'Biological Children' : 'Children',
            relativesData.secondMarriageBiologicalChildren);
        addRelatives(relativesColumn, 'Adoptive Children', relativesData.secondMarriageAdoptiveChildren);
    }

    addRelatives(relativesColumn, 'Grandchildren', relativesData.grandChildren);
}

function addRelatives(relativesColumn, title, relatives) {

    if (!relatives || relatives.length == 0) {
        return
    }
    const containerWithTitle =
        createPersonDetailsContainerWithTitle()
            .append(createPersonDetailsContainerTitleSpan(title));

    let horizontalFamilyContainer;

    relatives.forEach((relative, i) => {
        if (i % 4 == 0) {
            horizontalFamilyContainer = createPersonDetailsHorizontalRelativesContainer();
            containerWithTitle.append(horizontalFamilyContainer);
        }

        const nonSpouse = createPersonDetailsNonSpouse(relative);
        if (i >= 4) {
            $(nonSpouse).css("width", "25%");
        }

        horizontalFamilyContainer.append(nonSpouse);
    });

    relativesColumn.append(containerWithTitle);
}

function addSpouse(
    relativesColumn,
    title,
    spouse,
    marriageStartDate,
    marriageEndDate) {
    if (spouse) {
        const containerWithTitle =
            createPersonDetailsContainerWithTitle()
                .append(createPersonDetailsContainerTitleSpan(title));

        const horizontalContainer = createPersonDetailsHorizontalRelativesContainer();
        horizontalContainer.append(
            createPersonDetailsSpouse(
                spouse,
                marriageStartDate,
                marriageEndDate));

        containerWithTitle.append(horizontalContainer);
        relativesColumn.append(containerWithTitle);
    }
}

function createTreeColumn(personId) {
    const treeDiagramsContainer = $('#tree-diagrams-container');
    createAndDisplayTreeDiagram(treeDiagramsContainer, personId);
}