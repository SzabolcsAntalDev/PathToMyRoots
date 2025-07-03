const treeHtmlCreator = {

    createHiddenDiagramFrame(idSuffix) {
        const diagramSettings = $($('#diagram-settings-template').html());
        const treeDiagramFrame = $('<div>')
            .attr('id', 'diagram-frame-' + idSuffix)
            .attr('class', 'diagram-frame')
            .append(diagramSettings);

        hideElement(treeDiagramFrame);

        return treeDiagramFrame;
    },

    createRadioButton(name, dataId, dataValue, displayText) {
        const radioButton = $('<input>')
            .attr('type', 'radio')
            .attr('name', name)
            .attr(dataId, dataValue);

        return $('<label>')
            .append(radioButton)
            .append(displayText);
    },

    createDiagramInfo() {
        const treeTypeTextLabel = $('<label>').attr('class', 'text').text('Tree type:');
        const treeTypeValueLabel = $('<label>').attr('class', 'value tree-type-value');

        const ancestorsDepthTextLabel = $('<label>').attr('class', 'text').text('Ancestors depth:');
        const ancestorsDepthValueLabel = $('<label>').attr('class', 'value ancestors-depth-value');

        const descedantsDepthTextLabel = $('<label>').attr('class', 'text').text('Descedants depth:');
        const descedantsDepthValueLabel = $('<label>').attr('class', 'value descedants-depth-value');

        const viewModeTextLabel = $('<label>').attr('class', 'text').text('View mode:');
        const viewModeValueLabel = $('<label>').attr('class', 'value view-mode-value');

        return $('<div>')
            .attr('class', 'diagram-info-div')
            .append(treeTypeTextLabel)
            .append(treeTypeValueLabel)
            .append(ancestorsDepthTextLabel)
            .append(ancestorsDepthValueLabel)
            .append(descedantsDepthTextLabel)
            .append(descedantsDepthValueLabel)
            .append(viewModeTextLabel)
            .append(viewModeValueLabel);
    },

    createHiddenDiagram() {
        const diagram = $('<div>')
            .attr('class', 'diagram');

        hideElement(diagram);

        return diagram;
    },

    createNodesDiv(generationsData, viewMode) {
        const nodesDiv = $('<div>')
            .attr('class', 'nodes-div');

        generationsData.generations.forEach((generation, index) => {
            nodesDiv.append(this.createGeneration(generation, viewMode, generationsData.largestGenerationSize, index == generationsData.generations.length - 1));
        });

        return nodesDiv;
    },

    createGeneration(generation, viewMode, largestGenerationSize, isLast) {
        const nodeLinesVerticalOffset = getNodeLinesVerticalOffset(viewMode);
        const bottomPaddingMultiplier = largestGenerationSize + 3;

        const generationDiv = $('<div>')
            .attr('class', 'generation')
            .attr('data-bottom-padding-multiplier', bottomPaddingMultiplier)
            .css('padding', isLast ? '0px' : '0px 0px ' + (bottomPaddingMultiplier * nodeLinesVerticalOffset) + 'px 0px');

        generation.siblingsChains.forEach(siblingsChain => {
            generationDiv.append(this.createSiblingsChain(siblingsChain));
        })

        return generationDiv;
    },

    createSiblingsChain(siblingsChain) {
        const siblingsChainDiv = $('<div>')
            .attr('class', 'siblings-chain');

        siblingsChain.forEach(sibling => {
            siblingsChainDiv.append(this.createSibling(sibling));
        });

        return siblingsChainDiv;
    },

    createSibling(sibling) {
        const siblingDiv = $('<div>')
            .attr('class', 'sibling');

        sibling.forEach(extendedMarriage => {
            siblingDiv.append(this.createExtendedMarriage(extendedMarriage));
        })

        return siblingDiv;
    },

    createExtendedMarriage(extendedMarriage) {
        const extendedMarriageDiv = $('<div>')
            .attr('class', 'extended-marriage');

        if (extendedMarriage.secondaryMarriage != null) {
            extendedMarriageDiv.append(this.createMarriageNode(extendedMarriage.secondaryMarriage));
        }

        if (extendedMarriage.mainMarriage != null) {
            extendedMarriageDiv.append(this.createMainMarriage(extendedMarriage.mainMarriage));
        }

        return extendedMarriageDiv;
    },

    createMarriageNode(marriage) {
        const marriageText = `m. ${formatTimePeriod(marriage.startDate, marriage.endDate)}`;
        const marriageSpan =
            $('<span>')
                .attr('class', 'marriage-text')
                .html(marriageText);

        const textsDiv =
            $('<div>')
                .attr('class', 'texts-div')
                .append(marriageSpan);

        const marriageNode = $('<div>')
            .attr('class', `marriage-node ${marriage.isStaticMarriage ? 'static-marriage-node' : 'floating-marriage-node'} ${marriage.isFake ? '' : 'interactive'}`)
            .attr('title', marriageText)
            .data('inverseBiologicalParentIds', marriage.inverseBiologicalParentIds)
            .data('inverseAdoptiveParentIds', marriage.inverseAdoptiveParentIds)
            .append(textsDiv);

        if (marriage.isStaticMarriage) {
            return marriageNode;
        }

        const hiddenMarriageNode = marriageNode.clone()
            .attr('class', 'hidden-marriage-node');

        return $('<div>')
            .attr('class', 'floating-and-hidden-marriage-nodes-div')
            .append(marriageNode)
            .append(hiddenMarriageNode);
    },

    createMainMarriage(mainMarriage) {
        const mainMarriageDiv = $('<div>')
            .attr('class', 'main-marriage');

        if (mainMarriage.male == null || mainMarriage.female == null) {
            if (mainMarriage.male != null) {
                mainMarriageDiv.append(this.createPersonNode(mainMarriage.male));
            }

            if (mainMarriage.female != null) {
                mainMarriageDiv.append(this.createPersonNode(mainMarriage.female));
            }
        }
        else {
            const couple = $('<div>')
                .attr('class', 'couple')
                .append(this.createPersonNode(mainMarriage.male))
                .append(this.createPersonNode(mainMarriage.female));

            mainMarriageDiv.append(couple);
            mainMarriageDiv.append(this.createMarriageNode(mainMarriage.marriage));
        }

        return mainMarriageDiv;
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

        const nodeClass = `person-node ${person.isMale ? 'male-node' : 'female-node'} ${person.fakeId ? '' : 'interactive'} ${person.isHighlighted ? 'highlighted-node' : ''}`;

        return $('<div>')
            .attr('id', person.id)
            .attr('class', nodeClass)
            .attr('title', `${personNameText}\n${personLivedText}`)
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
    },

    createEmptyLinesSvg() {
        // no jquery creational method for this
        const linesSvg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        return $(linesSvg)
            .attr('class', 'lines-svg');
    },

    createMarriageChildLinePath(pathData, isBiological) {
        const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

        return $(path)
            .attr('d', pathData)
            .attr('class', isBiological ? 'biological-line-svg' : 'adoptive-line-svg');
    },

    createMarriageLinePath(pathData) {
        const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');

        return $(path)
            .attr('d', pathData)
            .attr('class', 'marriage-line-svg');
    },
}