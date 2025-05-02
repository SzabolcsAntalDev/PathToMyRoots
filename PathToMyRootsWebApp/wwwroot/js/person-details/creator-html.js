function createPersonDetailsImage(person) {
    return createPersonImageWithFallbackSvg('img', person.imageUrl);
}

function createPersonDetailsNameSpan(person) {
    return $('<span>')
        .attr('class', 'name')
        .text(formatPersonName(person));
}

function createPersonDetailsLivedSpan(person) {
    return $('<span>')
        .attr('class', 'lived')
        .text(formatTimePeriod(person.birthDate, person.deathDate));
}

function createPersonDetailsContainerWithTitle() {
    return $('<div>')
        .attr('class', 'container-with-title');
}

function createPersonDetailsContainerTitleSpan(title) {
    return $('<span>')
        .attr('class', 'container-title')
        .text(title);
}

function createPersonDetailsHorizontalRelativesContainer() {
    return $('<div>')
        .attr('class', 'horizontal-relatives-container');
}

function createPersonDetailsNonSpouse(person) {
    const personNameText = formatPersonName(person);
    const personNameSpan =
        $('<span>')
            .text(personNameText)
            .attr('class', 'relative-name-span');

    const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
    const personLivedSpan =
        $('<span>')
            .text(personLivedText)
            .attr('class', 'relative-lived-span');

    const spansContainer =
        $('<div>')
            .attr('class', 'relative-spans-container')
            .append(personNameSpan)
            .append(personLivedSpan);

    const imgPerson = createPersonImageWithFallbackSvg('relative-non-spouse-img', person.imageUrl);

    const classes =
        (person.id !== -1 ? 'relative-interactive' : 'relative') + ' ' +
        (person.isMale ? 'male-background-color' : 'female-background-color');

    return $('<div>')
        .attr('class', classes)
        .attr('title', `${personNameText}\n${personLivedText}`)
        .append(spansContainer)
        .append(imgPerson)
        .on('click', function () {
            const url = `/Person/PersonDetails?id=${person.id}`;
            window.location.href = url;
        });
}

function createPersonDetailsSpouse(person, marriageStartDate, marriageEndDate) {
    const personNameText = formatPersonName(person);
    const personNameSpan =
        $('<span>')
            .text(personNameText)
            .attr('class', 'relative-name-span');

    const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
    const personLivedSpan =
        $('<span>')
            .text(personLivedText)
            .attr('class', 'relative-lived-span');

    const personMarriageText = `m. ${formatTimePeriod(marriageStartDate, marriageEndDate)}`;
    const personMarriageSpan =
        $('<span>')
            .attr('class', 'relative-marriage-span')
            .html(personMarriageText);

    const spansContainer =
        $('<div>')
            .attr('class', 'relative-spans-container')
            .append(personNameSpan)
            .append(personLivedSpan)
            .append(personMarriageSpan);

    const imgPerson = createPersonImageWithFallbackSvg('relative-spouse-img', person.imageUrl);

    const classes =
        (person.id !== -1 ? 'relative-interactive' : 'relative') + ' ' +
        (person.isMale ? 'male-background-color' : 'female-background-color');

    return $('<div>')
        .attr('class', classes)
        .attr('title', `${personNameText}\n${personLivedText}\n${personMarriageText}`)
        .append(spansContainer)
        .append(imgPerson)
        .on('click', function () {
            const url = `/Person/PersonDetails?id=${person.id}`;
            window.location.href = url;
        });
}