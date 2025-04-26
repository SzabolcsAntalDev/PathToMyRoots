function createTreeDiagramHtml(personId) {
    return $('<div>')
        .attr('id', 'tree-diagram-' + personId)
        .attr('class', 'tree-diagram');
}

function createNodesContainerHtml(generationsData) {
    const nodesContainerHtml = createNodesContainerHtmlInner();

    generationsData.generations.forEach(generation => {
        nodesContainerHtml.append(createGenerationHtml(generation, generationsData.largestGenerationSize));
    });

    return nodesContainerHtml;
}

function createGenerationHtml(generation, largestGenerationSize) {
    const generationHtml = createGenerationHtmlInner(largestGenerationSize);

    generation.siblingsChains.forEach(siblings => {
        generationHtml.append(createSiblingsHtml(siblings));
    })

    return generationHtml;
}

function createSiblingsHtml(siblings) {
    const siblingsHtml = createSiblingsHtmlInner();

    siblings.forEach(extendedMarriages => {
        siblingsHtml.append(createExtendedMarriagesHtml(extendedMarriages));
    });

    return siblingsHtml;
}

function createExtendedMarriagesHtml(extendedMarriages) {
    const extendedMarriagesHtml = createExtendedMarriagesHtmlInner();

    extendedMarriages.forEach(extendedMarriage => {
        extendedMarriagesHtml.append(createExtendedMarriageHtml(extendedMarriage));
    })

    return extendedMarriagesHtml;
}

function createExtendedMarriageHtml(extendedMarriage) {
    const extendedMarriageHtml = createExtendedMarriageHtmlInner();

    if (extendedMarriage.secondaryMarriage != null) {
        extendedMarriageHtml.append(createNodeMarriageHtml(extendedMarriage.secondaryMarriage));
    }

    if (extendedMarriage.mainMarriage != null) {
        extendedMarriageHtml.append(createMainMarriageHtml(extendedMarriage.mainMarriage));
    }

    return extendedMarriageHtml;
}

function createMainMarriageHtml(mainMarriage) {
    const mainMarriageHtml = createMainMarriageHtmlInner();

    if (mainMarriage.male == null || mainMarriage.female == null) {
        if (mainMarriage.male != null) {
            mainMarriageHtml.append(createNodeHtml(mainMarriage.male));
        }

        if (mainMarriage.female != null) {
            mainMarriageHtml.append(createNodeHtml(mainMarriage.female));
        }
    }
    else {
        mainMarriageHtml.append(createNodeHtml(mainMarriage.male))
        mainMarriageHtml.append(createNodeHtml(mainMarriage.female))
        mainMarriageHtml.append(createLineBreakHtml());
        mainMarriageHtml.append(createNodeMarriageHtml(mainMarriage.marriage));
    }

    return mainMarriageHtml;
}

function createNodesContainerHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-nodes-container');
}

function createGenerationHtmlInner(largestGenerationSize) {
    return $('<div>')
        .attr('class', 'tree-generation')
        .css('padding', "0px 0px " + ((largestGenerationSize + 3) * linesVerticalOffset) + "px 0px");
}

function createSiblingsHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-siblings');
}

function createExtendedMarriagesHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-extended-marriages');
}

function createExtendedMarriageHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-extended-marriage');
}

function createMainMarriageHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-main-marriage');
}

function createNodeHtml(person) {
    const imgPerson =
        $('<img>')
            .attr('class', 'tree-node-image')
            .attr('src', apiUrl + '/image/get/' + person.imageUrl)
            .on('error', function () {
                const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
                use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

                const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
                svg.setAttribute('class', 'tree-node-image');
                svg.setAttribute('viewBox', '0 0 3 4'); // keep 3:4 aspect ratio
                svg.setAttribute('preserveAspectRatio', 'xMidYMid meet');

                svg.appendChild(use);
                $(this).replaceWith(svg);
            });

    const personNameNodeText = personToPersonNameNodeText(person);
    const spanPersonName =
        $('<span>')
            .text(personNameNodeText)
            .attr('class', 'tree-node-main-name-text');

    const personLivedNodeText = datesToPeriodText(person.birthDate, person.deathDate);
    const spanPersonLived =
        $('<span>')
            .text(personLivedNodeText)
            .attr('class', 'tree-node-main-lived-text');

    const textsContainer =
        $('<div>')
            .attr('class', 'tree-node-texts')
            .append(spanPersonName)
            .append(spanPersonLived);

    const use =
        $(document.createElementNS('http://www.w3.org/2000/svg', 'use'))
            .attr('href', '/icons/icons.svg#update');

    const svg =
        $(document.createElementNS('http://www.w3.org/2000/svg', 'svg'))
            .attr('class', 'small-svg')
            .attr('width', '20')
            .attr('height', '20')
            .append(use);

    const buttonUpdatePerson =
        $('<button>')
            .attr('class', 'tree-action-button')
            .css('visibility', 'hidden')
            .append(svg)
            .on('click', function () {
                const url = `/Person/UpdatePerson?id=${person.id}`;
                window.location.href = url;
            });

    // Szabi: extract one for node-male and node-female for better find selector?
    return $('<div>')
        .attr('id', person.id)
        .attr('class', 'tree-node ' + (person.isMale ? 'tree-node-male' : 'tree-node-female'))
        .attr('title', `${personNameNodeText}\n${personLivedNodeText}`)
        .data('biologicalFatherId', person.biologicalFatherId)
        .data('biologicalMotherId', person.biologicalMotherId)
        .data('adoptiveFatherId', person.adoptiveFatherId)
        .data('adoptiveMotherId', person.adoptiveMotherId)
        .append(imgPerson)
        .append(textsContainer)
        .append(buttonUpdatePerson)
        .on({
            mouseenter: function () {
                $(buttonUpdatePerson).css('visibility', 'visible');
            },
            mouseleave: function () {
                $(buttonUpdatePerson).css('visibility', 'hidden');
            }
        });
}

function createLineBreakHtml() {
    return $('<br>');
}

function createNodeMarriageHtml(marriage) {

    const marriageText = 'marriage';
    const spanMarriage =
        $('<span>')
            .attr('class', 'tree-node-marriage-text')
            .html(`${marriageText} <br> ${marriage.maleId}-${marriage.femaleId}`);

    const marriageDateText = datesToPeriodText(marriage.startDate, marriage.endDate);
    const spanMarriageDate =
        $('<span>')
            .attr('class', 'tree-node-marriage-date-text')
            .text(marriageDateText);

    const textsContainer =
        $('<div>')
            .attr('class', 'tree-node-texts')
            .append(spanMarriage)
            .append(spanMarriageDate);

    return $('<div>')
        .attr('class', `tree-node-marriage ${marriage.isMainMarriage ? 'main-marriage' : 'secondary-marriage'}`)
        .attr('title', `${marriageText}\n${marriageDateText}`)
        .data('inverseBiologicalParentIds', marriage.inverseBiologicalParentIds)
        .data('inverseAdoptiveParentIds', marriage.inverseAdoptiveParentIds)
        .append(textsContainer);
}

function createEmptyLinesContainerHtml() {
    // no jquery creational method for this
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    return $(linesContainer)
        .attr('class', 'tree-lines-container');
}

function createMarriageChildLinePathHtml(pathData, isBiological) {
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

    return $(path)
        .attr('d', pathData)
        .attr('class', isBiological ? 'tree-line-biological-svg' : 'tree-line-adoptive-svg');
}

function createMarriagesLinePathHtml(pathData, isBiological) {
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

    return $(path)
        .attr('d', pathData)
        .attr('class', 'tree-line-marriage-svg');
}

function createTestTitleHtml(testIndex, testTitle) {
    return $('<h2>')
        .text(`${testIndex}. ${testTitle}`);
}