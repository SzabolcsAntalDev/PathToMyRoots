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
    addRelatives(relativesColumn, 'First cousins', relativesData.firstCousins);
    addRelatives(relativesColumn, 'Second cousins', relativesData.secondCousins);

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

    relativesColumn.append(divWithTitle);
}

function addSpouse(
    relativesColumn,
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
        relativesColumn.append(divWithTitle);
    }
}

function createTreeColumn(personId) {
    const treeDiagramsDiv = $('#tree-diagrams-div');
    createAndDisplayTreeDiagram(treeDiagramsDiv, personId, treeTypes.HOURGLASS);
}