async function removeTreeDiagram(treeDiagramsDiv, personId) {
    const treeDiagram = treeDiagramsDiv.find('#diagram - ' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }
}

function createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, ancestorsDepth, descedantsDepth) {
    return {
        treeDiagramFrame: treeDiagramFrame,
        loadingTextContainer: loadingTextContainer,
        personId: personId,
        treeDiagram: treeDiagram,
        treeType: treeType,
        ancestorsDepth: (ancestorsDepth < relativesMinDepth || ancestorsDepth > relativesMaxDepth ? allRelativesDepthIndex : ancestorsDepth),
        descedantsDepth: (descedantsDepth < relativesMinDepth || descedantsDepth > relativesMaxDepth ? allRelativesDepthIndex : descedantsDepth)
    };
}

async function createAndDisplayTreeDiagram(treeDiagramsDiv, personId, treeType, ancestorsDepth, descedantsDepth) {
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

    addSettingsEventListeners(createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, ancestorsDepth, descedantsDepth))
}

function addSettingsEventListeners(context) {
    const settingsDiv = context.treeDiagramFrame.find('.settings-div');
    const expandButtonDiv = settingsDiv.find('.expand-button-div');
    const horizontalToggleableContainer = settingsDiv.find('.horizontal-toggleable-container');

    const diagramInfoDiv = context.treeDiagramFrame.find('.diagram-info-div');
    const treeTypeInfo = diagramInfoDiv.find('.tree-type-value');
    const ancestorsDepthInfo = diagramInfoDiv.find('.ancestors-depth-value');
    const descedantsDepthInfo = diagramInfoDiv.find('.descedants-depth-value');

    function toggleSettingsVisibility() {
        expandButtonDiv.toggleClass('expand-button-div-opened');
        horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
    }

    expandButtonDiv.on('click', () => {
        toggleSettingsVisibility();
    });

    $(document).on('click', function (event) {
        if (!settingsDiv[0].contains(event.target) && horizontalToggleableContainer[0].classList.contains('horizontal-toggleable-container-open')) {
            toggleSettingsVisibility();
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

    const selectedTreeTypeRadioButton = settingsDiv.find('.tree-types-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.treeTypeIndex, 10) === context.treeType.index;
    })[0];

    const selectedAncestorsDepthRadioButton = settingsDiv.find('.ancestors-depth-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.ancestorsDepth, 10) === context.ancestorsDepth;
    })[0];

    const selectedDescedantsDepthRadioButton = settingsDiv.find('.descedants-depth-fieldset input[type="radio"]').filter(function () {
        return parseInt(this.dataset.descedantsDepth, 10) === context.descedantsDepth;
    })[0];

    selectedTreeTypeRadioButton.checked = true;
    selectedAncestorsDepthRadioButton.checked = true;
    selectedDescedantsDepthRadioButton.checked = true;

    const applyButton = settingsDiv.find('.apply-button')[0];
    applyButton.addEventListener('click', async (event) => {
        if (!event.detail?.fromInitialization) {
            toggleSettingsVisibility();
        }

        const treeTypeRadioButton = settingsDiv.find('.tree-types-fieldset input[type="radio"]:checked');
        const ancestorsDepthRadioButton = settingsDiv.find('.ancestors-depth-fieldset input[type="radio"]:checked');
        const descedantsDepthRadioButton = settingsDiv.find('.descedants-depth-fieldset input[type="radio"]:checked');

        context.treeType = getTreeTypeByIndex(parseInt(treeTypeRadioButton[0].dataset.treeTypeIndex, 10));
        context.ancestorsDepth = parseInt(ancestorsDepthRadioButton[0].dataset.ancestorsDepth, 10);
        context.descedantsDepth = parseInt(descedantsDepthRadioButton[0].dataset.descedantsDepth, 10);

        treeTypeInfo.text(context.treeType.displayName);
        ancestorsDepthInfo.text(getDepthDisplayText(context.ancestorsDepth));
        descedantsDepthInfo.text(getDepthDisplayText(context.descedantsDepth));

        await showTree(context);
    });

    applyButton.dispatchEvent(new CustomEvent('click', {
        detail: {
            fromInitialization: true
        }
    }));
}

async function showTree(context) {
    await loadingTextManager.fadeIn(context.loadingTextContainer);
    await fadeOutElement(context.treeDiagram);

    const previousNodesContainer = context.treeDiagram.find('.nodes-div');
    const previousLinesContainer = context.treeDiagram.find('.lines-svg');
    previousNodesContainer?.remove();
    previousLinesContainer?.remove();

    const generationsData = await createGenerationsData(context.personId, context.treeType, context.ancestorsDepth, context.descedantsDepth, context.treeDiagramFrame);
    const nodesContainer = treeHtmlCreator.createNodesDiv(generationsData);
    const linesContainer = treeHtmlCreator.createEmptyLinesSvg();

    $(document).on('wheel', function (event) {
        if (event.ctrlKey) {
            $(linesContainer).empty();
            drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);
        }
    });

    context.treeDiagram.append(nodesContainer);
    context.treeDiagram.append(linesContainer);

    drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);

    await fadeInElement(context.treeDiagram);
    await loadingTextManager.fadeOut(context.loadingTextContainer);
}

