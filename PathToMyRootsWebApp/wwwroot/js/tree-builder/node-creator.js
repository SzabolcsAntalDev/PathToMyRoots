function createRow() {
    return $('<div>')
        .attr('class', 'tree-level-row');
}

function createNodesGroupContainer() {
    return $('<div>')
        .attr('class', 'tree-nodes-group-container');
}

function createNodesGroup() {
    return $('<div>')
        .attr('class', 'tree-nodes-group');
}

function createNode(person) {
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
        .data('birthDate', person.birthDate)
        .data('biologicalMotherId', person.biologicalMotherId)
        .data('biologicalFatherId', person.biologicalFatherId)
        .data('adoptiveMotherId', person.adoptiveMotherId)
        .data('adoptiveFatherId', person.adoptiveFatherId)
        .data('firstSpouseId', person.firstSpouseId)
        .data('secondSpouseId', person.secondSpouseId)
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

function createLineBreak() {
    return $('<br>');
}

function createNodeMarriage(person, spouse, isMainMarriage) {
    const startDate = person.firstSpouseId == spouse.id ? person.firstMarriageStartDate : person.secondMarriageStartDate;
    const endDate = person.firstSpouseId == spouse.id ? person.firstMarriageEndDate : person.secondMarriageEndDate;

    const marriageText = 'marriage';
    const spanMarriage =
        $('<span>')
            .attr('class', 'tree-node-marriage-text')
            .text(marriageText);

    const marriageDateText = datesToPeriodText(startDate, endDate);
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
        .attr('class', `tree-node-marriage ${isMainMarriage ? 'main-marriage' : 'left-marriage'}`)
        .attr('title', `${marriageText}\n${marriageDateText}`)
        .data('inverseBiologicalParents', getCommonBiologicalChildren(person, spouse))
        .data('inverseAdoptiveParents', getCommonAdoptiveChildren(person, spouse))
        .data('maleId', person.isMale ? person.id : spouse.id)
        .data('femaleId', !person.isMale ? person.id : spouse.id)
        .append(textsContainer);
}