async function createPersonDetails(personId) {
    const person = await getPersonJson(personId);

    createInfoColumn(person);
    await createRelativesColumn(person);
    createTreeColumn(personId);
}

function createInfoColumn(person) {
    const infoColumn = $('.info-column');

    infoColumn
        .append(personDetailsHtmlCreator.createInfoImage(person))
        .append(personDetailsHtmlCreator.createInfoNameText(person))
        .append(personDetailsHtmlCreator.createInfoLivedText(person));
}

async function createRelativesColumn(person) {
    const relativesColumn = $('.relatives-column');

    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(relativesColumn);
    relativesColumn.append(loadingTextContainer);
    await fadeInElement(loadingTextContainer);

    const relativesColumnContent = personDetailsHtmlCreator.createRelativesColumnContent();
    hideElement(relativesColumnContent);

    await addRelativesToRelativesColumnContent(person, relativesColumnContent);

    relativesColumn.append(relativesColumnContent);

    await fadeOutElement(loadingTextContainer);
    await fadeInElement(relativesColumnContent);
}

async function addRelativesToRelativesColumnContent(person, relativesColumnContent) {
    const relativesData = await createRelativesData(person)

    addRelatives(
        relativesColumnContent,
        relativesData.adoptiveGrandParents.length > 0 ? 'Biological grandparents' : 'Grandparents',
        relativesData.biologicalGrandParents);

    addRelatives(
        relativesColumnContent,
        relativesData.adoptiveParents ? 'Biological Parents' : 'Parents',
        relativesData.biologicalParents);

    addRelatives(relativesColumnContent, 'Adoptive grandparents', relativesData.adoptiveGrandParents);
    addRelatives(relativesColumnContent, 'Adoptive Parents', relativesData.adoptiveParents);

    addRelatives(relativesColumnContent, 'Siblings', relativesData.siblings);
    addRelatives(relativesColumnContent, 'First cousins', relativesData.firstCousins);
    addRelatives(relativesColumnContent, 'Second cousins', relativesData.secondCousins);

    if (relativesData.firstSpouseId) {
        addSpouse(
            relativesColumnContent,
            relativesData.secondSpouseId ? 'First spouse' : 'Spouse',
            person.firstSpouse,
            person.firstMarriageStartDate,
            person.firstMarriageEndDate);
        addRelatives(
            relativesColumnContent,
            relativesData.firstMarriageAdoptiveChildren.length > 0 ? 'Biological Children' : 'Children',
            relativesData.firstMarriageBiologicalChildren);
        addRelatives(relativesColumnContent, 'Adoptive Children', relativesData.firstMarriageAdoptiveChildren);
    }

    if (relativesData.secondSpouseId) {
        addSpouse(relativesColumnContent, 'Second spouse', person.secondSpouse, person.secondMarriageStartDate, person.secondMarriageEndDate);
        addRelatives(
            relativesColumnContent,
            relativesData.secondMarriageAdoptiveChildren.length > 0 ? 'Biological Children' : 'Children',
            relativesData.secondMarriageBiologicalChildren);
        addRelatives(relativesColumnContent, 'Adoptive Children', relativesData.secondMarriageAdoptiveChildren);
    }

    addRelatives(relativesColumnContent, 'Grandchildren', relativesData.grandChildren);
}

function addRelatives(relativesColumnContent, title, relatives) {

    if (!relatives || relatives.length == 0) {
        return
    }
    const divWithTitle =
        personDetailsHtmlCreator.createDivWithTitle()
            .append(personDetailsHtmlCreator.createDivTitle(title));

    let horizontalRelativesDiv;

    relatives.forEach((relative, i) => {
        if (i % 4 == 0) {
            horizontalRelativesDiv = personDetailsHtmlCreator.createHorizontalRelativesDiv();
            divWithTitle.append(horizontalRelativesDiv);
        }

        const nonSpouse = personDetailsHtmlCreator.createNonSpouse(relative);
        if (i >= 4) {
            $(nonSpouse).css("width", "25%");
        }

        horizontalRelativesDiv.append(nonSpouse);
    });

    relativesColumnContent.append(divWithTitle);
}

function addSpouse(
    relativesColumnContent,
    title,
    spouse,
    marriageStartDate,
    marriageEndDate) {
    if (spouse) {
        const divWithTitle =
            personDetailsHtmlCreator.createDivWithTitle()
                .append(personDetailsHtmlCreator.createDivTitle(title));

        const horizontalRelativesDiv = personDetailsHtmlCreator.createHorizontalRelativesDiv();
        horizontalRelativesDiv.append(
            personDetailsHtmlCreator.createSpouse(
                spouse,
                marriageStartDate,
                marriageEndDate));

        divWithTitle.append(horizontalRelativesDiv);
        relativesColumnContent.append(divWithTitle);
    }
}

function createTreeColumn(personId) {
    const treeDiagramsDiv = $('#tree-diagrams-div');
    createAndDisplayTreeDiagram(treeDiagramsDiv, personId, treeTypes.HOURGLASS);
}