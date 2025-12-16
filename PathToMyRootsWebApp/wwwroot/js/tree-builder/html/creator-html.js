const treeHtmlCreator = {

    createHiddenDiagramFrame(idSuffix) {
        const diagramSettings = $($('#diagram-settings-template').html());
        const diagramFrame = $('<div>')
            .attr('id', 'diagram-frame-' + idSuffix)
            .attr('class', 'diagram-frame')
            .append(diagramSettings);

        hideElement(diagramFrame);

        return diagramFrame;
    },

    createOption(name, dataId, dataValue, displayText) {
        const radioInput = $('<input>')
            .attr('type', 'radio')
            .attr('name', name)
            .attr(dataId, dataValue);

        const label = $('<label>')
            .append(radioInput)
            .append(displayText);

        return $('<div>')
            .attr('class', 'option')
            .append(label);
    },

    createDiagramInfo(treeContext) {
        const treeTypeTextLabel = $('<label>').attr('class', 'text').text('Tree type:');
        const treeTypeValueLabel = $('<label>').attr('class', 'value tree-type-value');

        const ancestorsDepthTextLabel = $('<label>').attr('class', 'text').text('Ancestors depth:');
        const ancestorsDepthValueLabel = $('<label>').attr('class', 'value ancestors-depth-value');

        const descendantsDepthTextLabel = $('<label>').attr('class', 'text').text('Descendants depth:');
        const descendantsDepthValueLabel = $('<label>').attr('class', 'value descendants-depth-value');

        const viewModeTextLabel = $('<label>').attr('class', 'text').text('View mode:');
        const viewModeValueLabel = $('<label>').attr('class', 'value view-mode-value');

        const downloadButton =
            $('<button>')
                .attr('class', 'download-button')
                .attr('title', 'Download diagram')
                .append(createSvg('download'));

        downloadButton.on('click', async () => {
            await loadingTextManager.fadeIn(treeContext.loadingTextContainer, 'Creating the tree diagram image for download');
            await downloadDiagramAsPng(treeContext);
            loadingTextManager.fadeOut(treeContext.loadingTextContainer);
        });

        return $('<div>')
            .attr('class', 'diagram-info-div')
            .append(treeTypeTextLabel)
            .append(treeTypeValueLabel)
            .append(ancestorsDepthTextLabel)
            .append(ancestorsDepthValueLabel)
            .append(descendantsDepthTextLabel)
            .append(descendantsDepthValueLabel)
            .append(viewModeTextLabel)
            .append(viewModeValueLabel)
            .append(downloadButton);
    },

    createHiddenDiagram() {
        const diagram = $('<div>')
            .attr('class', 'diagram');

        hideElement(diagram);

        return diagram;
    },

    createDiagramWrapperForDownload() {
        const diagramWrapper = $('<div>')
            .attr('class', 'diagram-wrapper-for-download');

        return diagramWrapper;
    },

    createNodesDiv(generationsData, viewMode) {
        const nodesDiv = $('<div>')
            .attr('class', 'nodes-div');

        generationsData.generations.forEach((generation, index) => {
            nodesDiv.append(
                this.createGeneration(
                    generation,
                    viewMode,
                    generationsData.duplicatedPersonsOnFirstLevelCount,
                    generationsData.largestGenerationSize,
                    generationsData.largestDuplicatedPersonsOnSameLevelCount,
                    index == 0,
                    index == generationsData.generations.length - 1));
        });

        return nodesDiv;
    },

    createGeneration(
        generation,
        viewMode,
        duplicatedPersonsOnFirstLevelCount,
        largestGenerationSize,
        largestDuplicatedPersonsOnSameLevelCount,
        isFirst,
        isLast) {

        const nodePathsVerticalOffset = getNodePathsVerticalOffset(viewMode);

        const topPaddingMultiplier = duplicatedPersonsOnFirstLevelCount ? (duplicatedPersonsOnFirstLevelCount + 1) : 0;
        const topPadding = isFirst ? topPaddingMultiplier * nodePathsVerticalOffset : 0;

        const bottomPaddingMultiplier = largestGenerationSize + largestDuplicatedPersonsOnSameLevelCount + 3;
        const bottomPadding = isLast ? 0 : bottomPaddingMultiplier * nodePathsVerticalOffset;

        const generationDiv = $('<div>')
            .attr('class', 'generation')
            .attr('data-top-padding-multiplier', topPaddingMultiplier)
            .attr('data-bottom-padding-multiplier', bottomPaddingMultiplier)
            .css('padding', `${topPadding}px 0px ${bottomPadding}px 0px`);

        generation.siblingsGroups.forEach(siblingsGroup => {
            generationDiv.append(this.createSiblingsGroup(siblingsGroup));
        })

        return generationDiv;
    },

    createSiblingsGroup(siblingsGroup) {
        const siblingsGroupDiv = $('<div>')
            .attr('class', 'siblings-group');

        siblingsGroup.forEach(sibling => {
            siblingsGroupDiv.append(this.createSibling(sibling));
        });

        return siblingsGroupDiv;
    },

    createSibling(sibling) {
        const siblingDiv = $('<div>')
            .attr('class', 'sibling');

        sibling.forEach(marriageEntity => {
            siblingDiv.append(this.createMarriageEntityNode(marriageEntity));
        })

        return siblingDiv;
    },

    createMarriageEntityNode(marriageEntity) {
        const marriageEntityDiv = $('<div>')
            .attr('class', 'marriage-entity-node');

        if (marriageEntity.male == null || marriageEntity.female == null) {
            if (marriageEntity.male != null) {
                marriageEntityDiv.append(this.createPersonNode(marriageEntity.male));
            }

            if (marriageEntity.female != null) {
                marriageEntityDiv.append(this.createPersonNode(marriageEntity.female));
            }
        }
        else {
            const couple = $('<div>')
                .attr('class', 'couple')
                .append(this.createPersonNode(marriageEntity.male))
                .append(this.createPersonNode(marriageEntity.female));

            marriageEntityDiv.append(couple);
            marriageEntityDiv.append(this.createMarriageNode(marriageEntity.marriage));
        }

        return marriageEntityDiv;
    },

    createPersonNode(person) {
        const image = createPersonImageWithFallbackSvg(person.imageUrl, 'image');

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

        const personNodeClass = [
            'person-node',
            person.isMale ? 'male-node' : 'female-node',
            person.fakeId ? '' : 'interactive',
            person.isHighlighted ? 'highlighted-node' : ''
        ].filter(Boolean).join(' ');

        const personNode =
            $('<div>')
                .attr('id', person.id)
                .attr('class', personNodeClass)
                .data('biologicalFatherId', person.biologicalFatherId)
                .data('biologicalMotherId', person.biologicalMotherId)
                .data('adoptiveFatherId', person.adoptiveFatherId)
                .data('adoptiveMotherId', person.adoptiveMotherId)
                .append(image)
                .append(textsDiv)
                .on('click', function () {
                    if (person.fakeId) {
                        return;
                    }
                    const url = `/Person/PersonDetails?id=${person.id}`;
                    window.location.href = url;
                });

        // add tooltip if necessary
        if (!person.fakeId) {
            const tooltipDataId = 'person-tooltip-id-' + person.id;
            const tooltipContent =
                $('<div>')
                    .attr('class', 'person-tooltip-content flex-column')
                    .append(createPersonImageWithFallbackSvg(person.imageUrl, 'image'))
                    .append(textsDiv.clone());

            const tooltip =
                $('<div>')
                    .attr('class', 'tooltip')
                    .data('tooltip-id', tooltipDataId)
                    .append(tooltipContent);

            personNode.addClass('tooltip-source');
            personNode
                .data('tooltip-id', tooltipDataId)
                .append(person.fakeId ? null : tooltip);
        }

        return personNode;
    },

    createMarriageNode(marriage) {
        const marriageDateText = `m. ${formatTimePeriod(marriage.startDate, marriage.endDate)}`;

        const marriageDateSpan =
            $('<span>')
                .attr('class', 'marriage-text')
                .html(marriageDateText);

        const textsDiv =
            $('<div>')
                .attr('class', 'texts-div')
                .append(marriageDateSpan);

        const marriageDateNode = $('<div>')
            .attr('class', `marriage-date-node ${marriage.isFake ? '' : 'interactive'}`)
            .data('inverseBiologicalParentIds', marriage.inverseBiologicalParentIds)
            .data('inverseAdoptiveParentIds', marriage.inverseAdoptiveParentIds)
            .append(textsDiv);

        // add tooltip is necessary
        if (!marriage.isFake) {

            const tooltipContent =
                $('<div>')
                    .attr('class', 'marriage-tooltip-content')
                    .append(textsDiv.clone());

            const tooltipDataId = 'marriage-tooltip-id-' + marriage.maleId + marriage.femaleId
            const tooltip =
                $('<div>')
                    .attr('class', 'tooltip')
                    .data('tooltip-id', tooltipDataId)
                    .append(tooltipContent);

            marriageDateNode.addClass('tooltip-source');
            marriageDateNode
                .data('tooltip-id', tooltipDataId)
                .append(tooltip);
        }

        const marriageNode = $('<div>')
            .attr('class', 'marriage-node')
            .append(this.createSpouseNumberNode(marriage.leftSpouseNumber))
            .append(marriageDateNode)
            .append(this.createSpouseNumberNode(marriage.rightSpouseNumber));

        return marriageNode;
    },

    createSpouseNumberNode(spouseNumber) {
        const spouseNumberSpan =
            $('<span>')
                .attr('class', 'spouse-number-text')
                .html(`${spouseNumber ?? '1'}.`);

        const spouseNumberTextsDiv =
            $('<div>')
                .attr('class', 'texts-div')
                .append(spouseNumberSpan);

        const spouseNumberNode = $('<div>')
            .attr('class', `spouse-number-node ${!spouseNumber ? 'hidden' : ''}`)
            .append(spouseNumberTextsDiv);

        return spouseNumberNode;
    },

    createEmptyPathsSvg() {
        // no jquery creational method for this
        const pathsSvg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        return $(pathsSvg)
            .attr('class', 'paths-svg');
    },

    createMarriageChildPath(pathData, isBiological) {
        const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

        return $(path)
            .attr('d', pathData)
            .attr('class', isBiological ? 'biological-path' : 'adoptive-path');
    },

    createDuplicatedPersonPath(pathData) {
        const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

        return $(path)
            .attr('d', pathData)
            .attr('class', 'duplicated-path');
    },
}