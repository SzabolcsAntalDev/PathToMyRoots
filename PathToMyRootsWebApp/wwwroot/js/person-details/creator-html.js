const personDetailsHtmlCreator = {
    createInfoImage(person) {
        return createPersonImageWithFallbackSvg(person.imageUrl, 'image');
    },

    createInfoNameText(person) {
        return $('<span>')
            .attr('class', 'name')
            .text(formatPersonName(person));
    },

    createInfoLivedText(person) {
        return $('<span>')
            .attr('class', 'lived')
            .text(formatTimePeriod(person.birthDate, person.deathDate));
    },

    createRelativesColumnContent() {
        return $('<div>')
            .attr('class', 'relatives-column-content');
    },

    createDivWithTitle() {
        return $('<div>')
            .attr('class', 'div-with-title');
    },

    createDivTitle(title) {
        return $('<span>')
            .attr('class', 'div-title')
            .text(title);
    },

    createHorizontalRelativesDiv() {
        return $('<div>')
            .attr('class', 'horizontal-relatives-div');
    },

    createNonSpouse(person) {
        const personNameText = formatPersonName(person);
        const personNameSpan =
            $('<span>')
                .text(personNameText)
                .attr('class', 'name-text');

        const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
        const personLivedSpan =
            $('<span>')
                .text(personLivedText)
                .attr('class', 'lived-text');

        const textsDiv =
            $('<div>')
                .attr('class', 'texts-div')
                .append(personNameSpan)
                .append(personLivedSpan);

        const image = createPersonImageWithFallbackSvg(person.imageUrl, 'non-spouse-img');

        const classes =
            (person.id !== -1 ? 'relative-interactive' : 'relative') + ' ' +
            (person.isMale ? 'male-background-color' : 'female-background-color');

        return $('<div>')
            .attr('class', classes)
            .attr('title', `${personNameText}\n${personLivedText}`)
            .append(textsDiv)
            .append(image)
            .on('click', function () {
                if (person.id == -1) {
                    return;
                }

                window.location.href = `/Person/PersonDetails?id=${person.id}`;
            });
    },

    createSpouse(person, marriageStartDate, marriageEndDate) {
        const personNameText = formatPersonName(person);
        const personNameSpan =
            $('<span>')
                .text(personNameText)
                .attr('class', 'name-text');

        const personLivedText = formatTimePeriod(person.birthDate, person.deathDate);
        const personLivedSpan =
            $('<span>')
                .text(personLivedText)
                .attr('class', 'lived-text');

        const personMarriageText = `m. ${formatTimePeriod(marriageStartDate, marriageEndDate)}`;
        const personMarriageSpan =
            $('<span>')
                .attr('class', 'marriage-text')
                .html(personMarriageText);

        const textsDiv =
            $('<div>')
                .attr('class', 'texts-div')
                .append(personNameSpan)
                .append(personLivedSpan)
                .append(personMarriageSpan);

        const image = createPersonImageWithFallbackSvg(person.imageUrl, 'spouse-img');

        const classes =
            (person.id !== -1 ? 'relative-interactive' : 'relative') + ' ' +
            (person.isMale ? 'male-background-color' : 'female-background-color');

        return $('<div>')
            .attr('class', classes)
            .attr('title', `${personNameText}\n${personLivedText}\n${personMarriageText}`)
            .append(textsDiv)
            .append(image)
            .on('click', function () {
                if (person.id == -1) {
                    return;
                }
                window.location.href = `/Person/PersonDetails?id=${person.id}`;
            });
    }
}