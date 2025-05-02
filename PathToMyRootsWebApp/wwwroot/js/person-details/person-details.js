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

    addRelatives(relativesColumn, 'Grandparents', relativesData.grandParents);
    addRelatives(relativesColumn, 'Biological Parents', relativesData.biologicalParents);
    addRelatives(relativesColumn, 'Adoptive Parents', relativesData.adoptiveParents);

    addSpouse(
        relativesColumn,
        relativesData.secondSpouse ? 'First spouse' : 'Spouse',
        person.firstSpouse,
        person.firstMarriageStartDate,
        person.firstMarriageEndDate);
    addRelatives(relativesColumn, 'Biological Children', relativesData.firstMarriageBiologicalChildren);
    addRelatives(relativesColumn, 'Adoptive Children', relativesData.firstMarriageAdoptiveChildren);

    addSpouse(
        relativesColumn,
        'Second spouse',
        person.secondSpouse,
        person.secondMarriageStartDate,
        person.secondMarriageEndDate);
    addRelatives(relativesColumn, 'Biological Children', relativesData.secondMarriageBiologicalChildren);
    addRelatives(relativesColumn, 'Adoptive Children', relativesData.secondMarriageAdoptiveChildren);

    addRelatives(relativesColumn, 'Grandchildren', relativesData.grandChildren);
}

function addRelatives(relativesColumn, title, relatives) {

    if (!relatives || relatives.length == 0) {
        return
    }
    const containerWithTitle =
        createPersonDetailsContainerWithTitle()
            .append(createPersonDetailsContainerTitleSpan(title));

    const horizontalFamilyContainer = createPersonDetailsHorizontalRelativesContainer();

    relatives.forEach(relative => {
        horizontalFamilyContainer
            .append(createPersonDetailsNonSpouse(relative));
    });

    containerWithTitle.append(horizontalFamilyContainer);
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