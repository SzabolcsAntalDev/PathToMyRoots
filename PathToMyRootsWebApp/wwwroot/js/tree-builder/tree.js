async function removeTreeDiagram(treeDiagramsDiv, personId) {
    const treeDiagram = treeDiagramsDiv.find('#diagram - ' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }
}

function createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, ancestorsDepth, descedantsDepth, viewMode) {
    return {
        treeDiagramFrame: treeDiagramFrame,
        loadingTextContainer: loadingTextContainer,
        personId: personId,
        treeDiagram: treeDiagram,
        treeType: treeType,
        ancestorsDepth: (ancestorsDepth < relativesMinDepth || ancestorsDepth > relativesMaxDepth ? allRelativesDepthIndex : ancestorsDepth),
        descedantsDepth: (descedantsDepth < relativesMinDepth || descedantsDepth > relativesMaxDepth ? allRelativesDepthIndex : descedantsDepth),
        viewMode: viewMode
    };
}

async function createAndDisplayTreeDiagram(treeDiagramsDiv, personId, treeType, ancestorsDepth, descedantsDepth, viewMode) {
    const treeDiagramFrame = treeHtmlCreator.createDiagramFrame();
    hideElement(treeDiagramFrame);
    treeDiagramsDiv.append(treeDiagramFrame);

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(treeDiagramFrame);
    treeDiagramFrame.append(loadingTextContainer);

    const treeDiagramInfo = treeHtmlCreator.createDiagramInfo();
    treeDiagramFrame.append(treeDiagramInfo);

    const treeDiagram = treeHtmlCreator.createDiagram(personId);
    hideElement(treeDiagram);
    treeDiagramFrame.append(treeDiagram);

    await fadeInElement(treeDiagramFrame);

    addSettingsEventListeners(createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, ancestorsDepth, descedantsDepth, viewMode))
}

function addSettingsEventListeners(context) {
    const settingsDiv = context.treeDiagramFrame.find('.settings-div');
    const expandButtonDiv = settingsDiv.find('.expand-button-div');
    const horizontalToggleableContainer = settingsDiv.find('.horizontal-toggleable-container');

    const diagramInfoDiv = context.treeDiagramFrame.find('.diagram-info-div');
    const treeTypeInfo = diagramInfoDiv.find('.tree-type-value');
    const ancestorsDepthInfo = diagramInfoDiv.find('.ancestors-depth-value');
    const descedantsDepthInfo = diagramInfoDiv.find('.descedants-depth-value');
    const viewModeInfo = diagramInfoDiv.find('.view-mode-value');

    const viewModesFieldSet = settingsDiv.find('.view-modes-fieldset');

    function toggleSettingsVisibility() {
        expandButtonDiv.toggleClass('expand-button-div-opened');
        horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
    }

    expandButtonDiv.on('click', () => {
        toggleSettingsVisibility();
    });

    $(document).on('click', function (event) {
        const target = event.target;

        if (!settingsDiv[0].contains(target) &&
            horizontalToggleableContainer[0].classList.contains('horizontal-toggleable-container-open')) {
                toggleSettingsVisibility();
        }

        if (!viewModesFieldSet[0].contains(target)) {
            settingsDiv.removeClass('transparent');
        }
    });

    const radioButtonNameUid = Date.now();

    // add unique names per settings to the tree types radio buttons
    const treeTypesRadioButtons = settingsDiv.find('.tree-types-fieldset input[type="radio"]');
    treeTypesRadioButtons.each((_, radioButton) => {
        radioButton.name += `-${context.personId}-${radioButtonNameUid}`;
    });

    const ancestorsDepthFieldset = settingsDiv.find('.ancestors-depth-fieldset');
    ancestorsDepthFieldset.append(treeHtmlCreator.createRadioButtonWithLabel(
        `input-radio-ancestors-depth-${context.personId}-${radioButtonNameUid}`,
        'data-ancestors-depth',
        allRelativesDepthIndex,
        getDepthDisplayText(allRelativesDepthIndex)));

    for (let i = relativesMaxDepth; i >= relativesMinDepth; i--) {
        // <label><input type="radio" name="input-radio-ancestors-depth-0-1722960923456" data-ancestors-depth="5" />5</label>
        ancestorsDepthFieldset.append(treeHtmlCreator.createRadioButtonWithLabel(
            `input-radio-ancestors-depth-${context.personId}-${radioButtonNameUid}`,
            'data-ancestors-depth',
            i,
            getDepthDisplayText(i)));
    }

    const descedantsDepthFieldset = settingsDiv.find('.descedants-depth-fieldset');
    for (let i = relativesMinDepth; i <= relativesMaxDepth; i++) {
        // <label><input type="radio" name="input-radio-descedants-depth-0-1722960923456" data-descedants-depth="5" />5</label>
        descedantsDepthFieldset.append(treeHtmlCreator.createRadioButtonWithLabel(
            `input-radio-descedants-depth-${context.personId}-${radioButtonNameUid}`,
            'data-descedants-depth',
            i,
            getDepthDisplayText(i)));
    }
    descedantsDepthFieldset.append(treeHtmlCreator.createRadioButtonWithLabel(
        `input-radio-descedants-depth-${context.personId}-${radioButtonNameUid}`,
        'data-descedants-depth',
        allRelativesDepthIndex,
        getDepthDisplayText(allRelativesDepthIndex)));

    const viewModesRadioButtons = settingsDiv.find('.view-modes-fieldset input[type="radio"]');
    viewModesRadioButtons.each((_, radioButton) => {
        radioButton.name += `-${context.personId}-${radioButtonNameUid}`;
    });

    const selectedTreeTypeRadioButton = settingsDiv.find('.tree-types-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.treeTypeIndex, 10) === context.treeType.index;
    })[0];

    const selectedAncestorsDepthRadioButton = settingsDiv.find('.ancestors-depth-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.ancestorsDepth, 10) === context.ancestorsDepth;
    })[0];

    const selectedDescedantsDepthRadioButton = settingsDiv.find('.descedants-depth-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.descedantsDepth, 10) === context.descedantsDepth;
    })[0];

    const selectedViewModeRadioButton = settingsDiv.find('.view-modes-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.viewModeIndex, 10) === context.viewMode.index;
    })[0];

    selectedTreeTypeRadioButton.checked = true;
    selectedAncestorsDepthRadioButton.checked = true;
    selectedDescedantsDepthRadioButton.checked = true;
    selectedViewModeRadioButton.checked = true;

    const applyButton = settingsDiv.find('.apply-button')[0];
    applyButton.addEventListener('click', async (event) => {
        if (!event.detail?.fromInitialization) {
            toggleSettingsVisibility();
        }

        const treeTypeRadioButton = settingsDiv.find('.tree-types-fieldset input[type="radio"]:checked');
        const ancestorsDepthRadioButton = settingsDiv.find('.ancestors-depth-fieldset input[type="radio"]:checked');
        const descedantsDepthRadioButton = settingsDiv.find('.descedants-depth-fieldset input[type="radio"]:checked');
        const viewModeRadioButton = settingsDiv.find('.view-modes-fieldset input[type="radio"]:checked');

        context.treeType = getTreeTypeByIndex(parseInt(treeTypeRadioButton[0].dataset.treeTypeIndex, 10));
        context.ancestorsDepth = parseInt(ancestorsDepthRadioButton[0].dataset.ancestorsDepth, 10);
        context.descedantsDepth = parseInt(descedantsDepthRadioButton[0].dataset.descedantsDepth, 10);
        context.viewMode = getViewModeByIndex(parseInt(viewModeRadioButton[0].dataset.viewModeIndex, 10));

        treeTypeInfo.text(context.treeType.displayName);
        ancestorsDepthInfo.text(getDepthDisplayText(context.ancestorsDepth));
        descedantsDepthInfo.text(getDepthDisplayText(context.descedantsDepth));
        viewModeInfo.text(context.viewMode.displayName);

        await calculateDataAndDisplayTree(context);
    });

    const viewModeRadioButtons = viewModesFieldSet.find('input[type="radio"]');
    viewModeRadioButtons.each((_, radioButton) => {
        $(radioButton).on('change', function () {
            context.viewMode = getViewModeByIndex(parseInt(this.dataset.viewModeIndex, 10));

            settingsDiv.addClass('transparent');
            viewModeInfo.text(context.viewMode.displayName);

            context.treeDiagramFrame[0].style.setProperty('--person-node-width', getPersonNodeWidth(context.viewMode));
            context.treeDiagramFrame[0].style.setProperty('--marriage-node-width', getMarriageNodeWidth(context.viewMode));
            context.treeDiagramFrame[0].style.setProperty('--node-horizontal-margin', getNodeHorizontalMargin(context.viewMode));

            setGenerationsPadding(context);
            drawLines(context);
        })
    });

    applyButton.dispatchEvent(new CustomEvent('click', {
        detail: {
            fromInitialization: true
        }
    }));
}

function setGenerationsPadding(context) {
    const nodeLinesVerticalOffset = getNodeLinesVerticalOffset(context.viewMode);
    const generations = context.treeDiagramFrame.find('.generation');

    generations.each(function (index) {
        const generation = $(this);
        const isLast = index === generations.length - 1;
        const bottomPaddingMultiplier = parseInt(generation.attr('data-bottom-padding-multiplier'), 10);

        const paddingValue = isLast
            ? '0px'
            : `0px 0px ${bottomPaddingMultiplier * nodeLinesVerticalOffset}px 0px`;

        generation.css('padding', paddingValue);
    });
}

async function calculateDataAndDisplayTree(context) {
    await loadingTextManager.fadeIn(context.loadingTextContainer);
    await fadeOutElement(context.treeDiagram);

    context.generationsData = await createGenerationsData(context.personId, context.treeType, context.ancestorsDepth, context.descedantsDepth, context.treeDiagramFrame);

    // Szabi: added multiple times when method is called?
    $(document).on('wheel', function (event) {
        if (event.ctrlKey) {
            drawLines(context);
        }
    });

    const previousNodesContainer = context.treeDiagram.find('.nodes-div');
    const previousLinesContainer = context.treeDiagram.find('.lines-svg');
    previousNodesContainer?.remove();
    previousLinesContainer?.remove();

    const nodesContainer = treeHtmlCreator.createNodesDiv(context.generationsData, context.viewMode);
    const linesContainer = treeHtmlCreator.createEmptyLinesSvg();

    context.nodesContainer = nodesContainer;
    context.linesContainer = linesContainer;

    drawLines(context);

    context.treeDiagram.append(nodesContainer);
    context.treeDiagram.append(linesContainer);

    await fadeInElement(context.treeDiagram);
    await loadingTextManager.fadeOut(context.loadingTextContainer);
}

function drawLines(context) {
    $(context.linesContainer).empty();
    setTimeout(() => {
        $(context.linesContainer).empty();
        drawLinesOntoLinesContainer(context.generationsData, context.viewMode, context.nodesContainer, context.linesContainer);
        // delay drawing the lines so animations can finish
    }, getTransitionIntervalInSeconds() * 1000 + 250);
}

