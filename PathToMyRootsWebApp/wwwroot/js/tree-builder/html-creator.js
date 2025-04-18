function createNodesContainerHtml(generations) {
    const nodesContainerHtml = createNodesContainerHtmlInner();

    generations.forEach(generation => {
        nodesContainerHtml.append(createGenerationHtml(generation));
    });

    return nodesContainerHtml;
}

function createGenerationHtml(generation) {
    const generationHtml = createGenerationHtmlInner();

    generation.forEach(nondesGroupContainer => {
        generationHtml.append(createExtendedMarriageHtml(nondesGroupContainer));
    })

    return generationHtml;
}

function createExtendedMarriageHtml(extendedMarriage) {
    const extendedMarriageHtml = createExtendedMarriageHtmlInner();

    if (extendedMarriage.leftMarriage != null) {
        extendedMarriageHtml.append(createNodeMarriageHtml(extendedMarriage.leftMarriage));
    }

    if (extendedMarriage.simpleMarriage != null) {
        extendedMarriageHtml.append(createSimpleMarriageHtml(extendedMarriage.simpleMarriage));
    }

    return extendedMarriageHtml;
}

function createSimpleMarriageHtml(simpleMarriage) {
    const simpleMarriageHtml = createSimpleMarriageHtmlInner();

    if (simpleMarriage.person != null) {
        simpleMarriageHtml.append(createNodeHtml(simpleMarriage.person))
    }

    if (simpleMarriage.spouse != null) {
        simpleMarriageHtml.append(createNodeHtml(simpleMarriage.spouse))
        simpleMarriageHtml.append(createLineBreakHtml());
        simpleMarriageHtml.append(createNodeMarriageHtml(simpleMarriage.mainMarriage));
    }

    return simpleMarriageHtml;
}

function createNodesContainerHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-nodes-container');
}

function createGenerationHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-generation');
}

function createExtendedMarriageHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-extended-marriage');
}

function createSimpleMarriageHtmlInner() {
    return $('<div>')
        .attr('class', 'tree-simple-marriage');
}

function createNodeHtml(person) {
    const imgPerson =
        $('<img>')
            .attr('class', 'tree-node-image')
            .attr('src', 'https://localhost:7241/api/Image/get/' + person.imageUrl);

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

    return $('<div>')
        .attr('id', person.id)
        .attr('class', person.isMale ? 'tree-node-male' : 'tree-node-female')
        .attr('title', `${personNameNodeText}\n${personLivedNodeText}`)
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
            .text(marriageText);

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
        .attr('class', `tree-node-marriage ${marriage.isMainMarriage ? 'main-marriage' : 'left-marriage'}`)
        .attr('title', `${marriageText}\n${marriageDateText}`)
        .append(textsContainer);
}