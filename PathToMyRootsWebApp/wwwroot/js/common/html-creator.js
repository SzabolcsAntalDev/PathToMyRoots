function createPersonDetailsImage(person) {
    return createPersonImageWithFallbackSvg('person-details-img', person.imageUrl);
}

function createPersonDetailsNameSpan(person) {
    const personNameSpan =
        $('<span>')
            .attr('class', 'person-details-name-span')
            .text(formatPersonName(person));

    return personNameSpan;
}

function createPersonDetailsLivedSpan(person) {
    const livedSpan =
        $('<span>')
            .attr('class', 'person-details-lived-span')
            .text(formatTimePeriod(person.birthDate, person.deathDate));

    return livedSpan;
}

function createPersonDetailsRelativesWithTitleContainer() {
    const relativesContainer =
        $('<div>')
            .attr('class', 'person-details-relatives-with-title-container');

    return relativesContainer;
}

function createPersonDetailsRelativesContainerTitle(title) {
    const relativesContainerTitleSpan =
        $('<span>')
            .attr('class', 'person-details-relatives-container-title-span')
            .text(title);

    return relativesContainerTitleSpan;
}

function createRelativesHorizontalContainer() {
    const relatives =
        $('<div>')
            .attr('class', 'person-details-relatives-horizontal-container');

    return relatives;
}

function createRelativesVertical() {
    const relatives =
        $('<div>')
            .attr('class', 'person-details-relatives-vertical');

    return relatives;
}

function createPersonDetailsSpouse(person, marriageStartDate, marriageEndDate) {
    const personNameText = formatPersonName(person);
    const personNameSpan =
        $('<span>')
            .text(personNameText)
            .attr('class', 'persons-relative-name-span');

    const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
    const personLivedSpan =
        $('<span>')
            .text(personLivedText)
            .attr('class', 'persons-relative-lived-span');

    const personMarriageText = `m. ${formatTimePeriod(marriageStartDate, marriageEndDate)}`;
    const personMarriageSpan =
        $('<span>')
            .attr('class', 'persons-relative-marriage-span')
            .html(personMarriageText);

    const textsContainer =
        $('<div>')
            .attr('class', 'persons-relative-texts-container')
            .append(personNameSpan)
            .append(personLivedSpan)
            .append(personMarriageSpan);

    const imgPerson = createPersonImageWithFallbackSvg('person-details-spouse-img', person.imageUrl);

    return $('<div>')
        .attr('id', person.id)
        .attr('class', 'person-details-relative ' + (person.isMale ? 'male-background-color' : 'female-background-color'))
        .attr('title', `${personNameText}\n${personLivedText}\n${personMarriageText}`)
        .append(textsContainer)
        .append(imgPerson)
        .on('click', function () {
            const url = `/Person/PersonDetails?id=${person.id}`;
            window.location.href = url;
        });
}

function createPersonDetailsNonSpouse(person) {
    const personNameText = formatPersonName(person);
    const personNameSpan =
        $('<span>')
            .text(personNameText)
            .attr('class', 'persons-relative-name-span');

    const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
    const personLivedSpan =
        $('<span>')
            .text(personLivedText)
            .attr('class', 'persons-relative-lived-span');

    const textsContainer =
        $('<div>')
            .attr('class', 'persons-relative-texts-container')
            .append(personNameSpan)
            .append(personLivedSpan);

    const imgPerson = createPersonImageWithFallbackSvg('person-details-non-spouse-img', person.imageUrl);

    return $('<div>')
        .attr('id', person.id)
        .attr('class', 'person-details-relative ' + (person.isMale ? 'male-background-color' : 'female-background-color'))
        .attr('title', `${personNameText}\n${personLivedText}`)
        .append(textsContainer)
        .append(imgPerson)
        .on('click', function () {
            const url = `/Person/PersonDetails?id=${person.id}`;
            window.location.href = url;
        });
}

// Szabi: reuse this everywhere
function createPersonImageWithFallbackSvg(className, imageUrl) {
    return $('<img>')
        .attr('class', className)
        .attr('src', apiUrl + '/image/get/' + imageUrl)
        .on('error', function () {
            const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
            use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

            const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
            svg.setAttribute('class', className);
            svg.setAttribute('viewBox', '0 0 3 4');
            svg.setAttribute('preserveAspectRatio', 'xMidYMid meet');

            svg.appendChild(use);
            $(this).replaceWith(svg);
        });
}