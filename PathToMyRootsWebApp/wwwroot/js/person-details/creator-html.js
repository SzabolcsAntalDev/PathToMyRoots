const personDetailsHtmlCreator = {
    createInfoImage(person) {
        return creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'image');
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

    createEditPersonButton(personId) {
        return $('<button>')
            .addClass('person-action-button')
            .text('Edit')
            .on('click', function () {
                window.location.href = `/Person/UpdatePerson?id=${personId}`;
            });
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

    createNonSpouseContainer(person) {
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

        const image = creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'non-spouse-img');

        const nonSpouseClass = `${person.id !== -1 ? 'relative-interactive' : 'relative'} ${person.isMale ? 'male-background-color' : 'female-background-color'}`;

        const nonSpouse =
            $('<div>')
                .attr('class', nonSpouseClass)
                .append(textsDiv)
                .append(image)
                .on('click', function () {
                    if (person.id == -1) {
                        return;
                    }

                    window.location.href = `/Person/PersonDetails?id=${person.id}`;
                });

        // add tooltip if necessary
        if (person.id != -1) {
            const tooltipContent =
                $('<div>')
                    .attr('class', 'person-tooltip-content flex-column')
                    .append(creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'image'))
                    .append(textsDiv.clone());

            const tooltipDataId = 'non-spouse-tooltip-id-' + person.id;
            const tooltip =
                $('<div>')
                    .attr('class', 'tooltip')
                    .data('tooltip-id', tooltipDataId)
                    .append(tooltipContent);

            nonSpouse.addClass('tooltip-source');
            nonSpouse
                .data('tooltip-id', tooltipDataId)
                .append(tooltip);
        }

        return $('<div>')
            .attr('class', 'relative-container')
            .append(nonSpouse);
    },

    createSpouseContainer(person, marriageStartDate, marriageEndDate) {
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

        const image = creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'spouse-img');

        const tooltipContent =
            $('<div>')
                .attr('class', 'person-tooltip-content flex-column')
                .append(creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'image'))
                .append(textsDiv.clone());

        const tooltipDataId = 'spouse-tooltip-id-' + person.id;
        const tooltip =
            $('<div>')
                .attr('class', 'tooltip')
                .data('tooltip-id', tooltipDataId)
                .append(tooltipContent);

        const spouseClass = `${person.id != -1 ? 'relative-interactive' : 'relative'} ${person.isMale ? 'male-background-color' : 'female-background-color'}`;

        const spouse =
            $('<div>')
                .attr('class', spouseClass)
                .append(textsDiv)
                .append(image)
                .on('click', function () {
                    if (person.id == -1) {
                        return;
                    }
                    window.location.href = `/Person/PersonDetails?id=${person.id}`;
                });

        // add tooltip if necessary
        if (person.id != -1) {
            const tooltipContent =
                $('<div>')
                    .attr('class', 'person-tooltip-content flex-column')
                    .append(creatorImages.createPersonImageWithFallbackSvg(person.imageUrl, 'image'))
                    .append(textsDiv.clone());

            const tooltipDataId = 'non-spouse-tooltip-id-' + person.id;
            const tooltip =
                $('<div>')
                    .attr('class', 'tooltip')
                    .data('tooltip-id', tooltipDataId)
                    .append(tooltipContent);

            spouse.addClass('tooltip-source');
            spouse
                .data('tooltip-id', tooltipDataId)
                .append(tooltip);
        }

        return $('<div>')
            .attr('class', 'relative-container')
            .append(spouse);
    }
}