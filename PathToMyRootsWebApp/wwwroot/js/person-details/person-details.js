const MaximumNumberOfPersonsInRow = 4;

async function createPersonDetails(personId) {
    const person = await personsCache.getPersonJson(personId);

    createInfoColumn(person);
    // await createRelativesColumn(person);
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

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(relativesColumn);
    relativesColumn.append(loadingTextContainer);
    await loadingTextManager.fadeIn(loadingTextContainer);

    const relativesColumnContent = personDetailsHtmlCreator.createRelativesColumnContent();
    hideElement(relativesColumnContent);

    relativesColumnContent.append(personDetailsHtmlCreator.createEditPersonButton(person.id));

    await addRelativesToRelativesColumnContent(person, relativesColumnContent, relativesColumn);

    relativesColumn.append(relativesColumnContent);
    registerTooltips();

    loadingTextManager.fadeOut(loadingTextContainer);
    await fadeInElement(relativesColumnContent);
}

async function addRelativesToRelativesColumnContent(person, relativesColumnContent, relativesColumn) {
    const relativesData = await createRelativesData(person, relativesColumn);

    addRelatives(relativesColumnContent, 'Grandparents', relativesData.biologicalGrandParents);

    addRelatives(relativesColumnContent, relativesData.adoptiveParents.length > 0 ? 'Biological parents' : 'Parents', relativesData.biologicalParents);
    addRelatives(relativesColumnContent, relativesData.siblingsByAdoptiveParents.length > 0 ? 'Siblings by biological parents' : 'Siblings', relativesData.siblingsByBiologicalParents);

    addRelatives(relativesColumnContent, 'Adoptive parents', relativesData.adoptiveParents);
    addRelatives(relativesColumnContent, 'Siblings by adoptive parents', relativesData.siblingsByAdoptiveParents);

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
            relativesData.firstMarriageAdoptiveChildren.length > 0 ? 'Biological children' : 'Children',
            relativesData.firstMarriageBiologicalChildren);
        addRelatives(relativesColumnContent, 'Adoptive children', relativesData.firstMarriageAdoptiveChildren);
    }

    if (relativesData.secondSpouseId) {
        addSpouse(
            relativesColumnContent,
            'Second spouse',
            person.secondSpouse,
            person.secondMarriageStartDate,
            person.secondMarriageEndDate);
        addRelatives(
            relativesColumnContent,
            relativesData.secondMarriageAdoptiveChildren.length > 0 ? 'Biological children' : 'Children',
            relativesData.secondMarriageBiologicalChildren);
        addRelatives(relativesColumnContent, 'Adoptive children', relativesData.secondMarriageAdoptiveChildren);
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
    const widthPercentage = 100 / Math.min(relatives.length, MaximumNumberOfPersonsInRow)

    relatives.forEach((relative, i) => {
        if (i % MaximumNumberOfPersonsInRow == 0) {
            horizontalRelativesDiv = personDetailsHtmlCreator.createHorizontalRelativesDiv();
            divWithTitle.append(horizontalRelativesDiv);
        }

        const nonSpouseContainer = personDetailsHtmlCreator.createNonSpouseContainer(relative);
        $(nonSpouseContainer).css('width', widthPercentage + '%');
        $(nonSpouseContainer).css('max-width', widthPercentage + '%');

        horizontalRelativesDiv.append(nonSpouseContainer);
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
            personDetailsHtmlCreator.createSpouseContainer(
                spouse,
                marriageStartDate,
                marriageEndDate));

        divWithTitle.append(horizontalRelativesDiv);
        relativesColumnContent.append(divWithTitle);
    }
}

function createTreeColumn(personId) {
    const diagramsDiv = $('#diagrams-div');
    createAndDisplayDiagramFrame(diagramsDiv, personId, personId, treeTypes.HOURGLASS_EXTENDED, 2, 1, viewModes.MEDIUM);
}