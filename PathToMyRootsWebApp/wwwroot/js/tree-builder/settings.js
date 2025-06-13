function addSettingsEventListeners(treeContext) {
    const settingsContext = {};

    settingsContext.settingsDiv = treeContext.treeDiagramFrame.find('.settings-div');
    settingsContext.expandButtonDiv = settingsContext.settingsDiv.find('.expand-button-div');
    settingsContext.horizontalToggleableContainer = settingsContext.settingsDiv.find('.horizontal-toggleable-container');

    const diagramInfoDiv = treeContext.treeDiagramFrame.find('.diagram-info-div');
    settingsContext.treeTypeInfo = diagramInfoDiv.find('.tree-type-value');
    settingsContext.ancestorsDepthInfo = diagramInfoDiv.find('.ancestors-depth-value');
    settingsContext.descedantsDepthInfo = diagramInfoDiv.find('.descedants-depth-value');
    settingsContext.viewModeInfo = diagramInfoDiv.find('.view-mode-value');

    settingsContext.treeTypesFieldSet = settingsContext.settingsDiv.find('.tree-types-fieldset');
    settingsContext.ancestorsDepthFieldSet = settingsContext.settingsDiv.find('.ancestors-depth-fieldset');
    settingsContext.descedantsDepthFieldSet = settingsContext.settingsDiv.find('.descedants-depth-fieldset');

    settingsContext.applyButton = settingsContext.settingsDiv.find('.apply-button');
    settingsContext.viewModesFieldSet = settingsContext.settingsDiv.find('.view-modes-fieldset');

    addTogglingListeners(settingsContext);
    setupRadioButtons(treeContext, settingsContext);
    selectDefaultSettings(treeContext, settingsContext);
    addApplyButtonListener(treeContext, settingsContext);
    addViewModeRadioButtonsListeners(treeContext, settingsContext);

    settingsContext.applyButton[0].dispatchEvent(new CustomEvent('click', {
        detail: {
            fromInitialization: true
        }
    }));
}

function addTogglingListeners(settingsContext) {
    settingsContext.expandButtonDiv.on('click', () => {
        toggleSettingsVisibility(settingsContext);
    });

    $(document).on('click', function (event) {
        const $target = $(event.target)

        const clickedOutsideSettings = !settingsContext.settingsDiv.has($target).length && !settingsContext.settingsDiv.is($target);
        const settingsIsOpen = settingsContext.horizontalToggleableContainer.hasClass('horizontal-toggleable-container-open');

        if (clickedOutsideSettings && settingsIsOpen) {
            toggleSettingsVisibility(settingsContext);
        }

        const clickedOutSideViewModesFieldSet = !settingsContext.viewModesFieldSet.has($target).length && !settingsContext.viewModesFieldSet.is($target);
        if (clickedOutSideViewModesFieldSet) {
            settingsContext.settingsDiv.removeClass('transparent');
        }
    });
}

function toggleSettingsVisibility(settingsContext) {
    settingsContext.expandButtonDiv.toggleClass('expand-button-div-opened');
    settingsContext.horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
}

function setupRadioButtons(treeContext, settingsContext) {
    const radioButtonNameUid = Date.now();

    // Tree types radio buttons

    // add unique names per settings to the tree types radio buttons
    const treeTypesRadioButtons = settingsContext.treeTypesFieldSet.find('input[type="radio"]');
    treeTypesRadioButtons.each((_, radioButton) => {
        // input-radio-tree-type-1-1722960923456

        radioButton.name += `-${treeContext.personId}-${radioButtonNameUid}`;
    });

    // Ancestors radio buttons
    settingsContext.ancestorsDepthFieldSet.append(treeHtmlCreator.createRadioButton(
        `input-radio-ancestors-depth-${treeContext.personId}-${radioButtonNameUid}`,
        'data-ancestors-depth', allRelativesDepthIndex,
        getDepthDisplayText(allRelativesDepthIndex)));

    for (let i = relativesMaxDepth; i >= relativesMinDepth; i--) {
        // <label><input type="radio" name="input-radio-ancestors-depth-0-1722960923456" data-ancestors-depth="5" />5</label>

        settingsContext.ancestorsDepthFieldSet.append(treeHtmlCreator.createRadioButton(
            `input-radio-ancestors-depth-${treeContext.personId}-${radioButtonNameUid}`,
            'data-ancestors-depth', i,
            getDepthDisplayText(i)));
    }

    // Descedants radio buttons
    for (let i = relativesMinDepth; i <= relativesMaxDepth; i++) {
        // <label><input type="radio" name="input-radio-descedants-depth-0-1722960923456" data-descedants-depth="5" />5</label>

        settingsContext.descedantsDepthFieldSet.append(treeHtmlCreator.createRadioButton(
            `input-radio-descedants-depth-${treeContext.personId}-${radioButtonNameUid}`,
            'data-descedants-depth', i,
            getDepthDisplayText(i)));
    }

    settingsContext.descedantsDepthFieldSet.append(treeHtmlCreator.createRadioButton(
        `input-radio-descedants-depth-${treeContext.personId}-${radioButtonNameUid}`,
        'data-descedants-depth', allRelativesDepthIndex,
        getDepthDisplayText(allRelativesDepthIndex)));

    const viewModesRadioButtons = settingsContext.viewModesFieldSet.find('input[type="radio"]');
    viewModesRadioButtons.each((_, radioButton) => {
        // input-radio-view-mode-1-1722960923456

        radioButton.name += `-${treeContext.personId}-${radioButtonNameUid}`;
    });
}

function selectDefaultSettings(treeContext, settingsContext) {
    settingsContext.treeTypesFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt($(this).data('treeTypeIndex'), 10) === treeContext.treeType.index;
    }).prop('checked', true);

    settingsContext.ancestorsDepthFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt(this.dataset.ancestorsDepth, 10) === treeContext.ancestorsDepth;
    }).prop('checked', true);

    settingsContext.descedantsDepthFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt(this.dataset.descedantsDepth, 10) === treeContext.descedantsDepth;
    }).prop('checked', true);

    settingsContext.viewModesFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt(this.dataset.viewModeIndex, 10) === treeContext.viewMode.index;
    }).prop('checked', true);
}

function addApplyButtonListener(treeContext, settingsContext) {
    settingsContext.applyButton.on('click', async function (event) {
        if (!event.originalEvent?.detail?.fromInitialization) {
            toggleSettingsVisibility(settingsContext);
        }
        else {
            // setup view mode on load
            settingsContext.viewModeInfo.text(treeContext.viewMode.displayName);
            setViewModeSizes(treeContext);
        }

        const treeTypeRadioButton = settingsContext.treeTypesFieldSet.find('input[type="radio"]:checked');
        const ancestorsDepthRadioButton = settingsContext.ancestorsDepthFieldSet.find('input[type="radio"]:checked');
        const descedantsDepthRadioButton = settingsContext.descedantsDepthFieldSet.find('input[type="radio"]:checked');

        treeContext.treeType = getTreeTypeByIndex(parseInt(treeTypeRadioButton[0].dataset.treeTypeIndex, 10));
        treeContext.ancestorsDepth = parseInt(ancestorsDepthRadioButton[0].dataset.ancestorsDepth, 10);
        treeContext.descedantsDepth = parseInt(descedantsDepthRadioButton[0].dataset.descedantsDepth, 10);

        settingsContext.treeTypeInfo.text(treeContext.treeType.displayName);
        settingsContext.ancestorsDepthInfo.text(getDepthDisplayText(treeContext.ancestorsDepth));
        settingsContext.descedantsDepthInfo.text(getDepthDisplayText(treeContext.descedantsDepth));

        await calculateDataAndDisplayTree(treeContext);
    });
}

function addViewModeRadioButtonsListeners(treeContext, settingsContext) {
    const viewModeRadioButtons = settingsContext.viewModesFieldSet.find('input[type="radio"]');
    viewModeRadioButtons.each((_, radioButton) => {
        $(radioButton).on('change', function () {
            treeContext.viewMode = getViewModeByIndex(parseInt(this.dataset.viewModeIndex, 10));
            settingsContext.settingsDiv.addClass('transparent');

            settingsContext.viewModeInfo.text(treeContext.viewMode.displayName);
            setViewModeSizes(treeContext);

            drawLines(treeContext);
        })
    });
}

function setViewModeSizes(treeContext) {
    treeContext.treeDiagramFrame.css('--person-node-width', getPersonNodeWidth(treeContext.viewMode));
    treeContext.treeDiagramFrame.css('--marriage-node-width', getMarriageNodeWidth(treeContext.viewMode));
    treeContext.treeDiagramFrame.css('--node-horizontal-margin', getNodeHorizontalMargin(treeContext.viewMode));

    const nodeLinesVerticalOffset = getNodeLinesVerticalOffset(treeContext.viewMode);
    const generations = treeContext.treeDiagramFrame.find('.generation');

    generations.each((index, elem) => {
        const generation = $(elem);
        const isLast = index === generations.length - 1;
        const bottomPaddingMultiplier = parseInt(generation.attr('data-bottom-padding-multiplier'), 10);

        const paddingValue = isLast
            ? '0px'
            : `0px 0px ${bottomPaddingMultiplier * nodeLinesVerticalOffset}px 0px`;

        generation.css('padding', paddingValue);
    });
}