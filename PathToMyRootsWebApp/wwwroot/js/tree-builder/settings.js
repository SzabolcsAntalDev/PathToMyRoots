async function addSettingsEventListeners(treeContext) {
    const settingsContext = createSettingsContext(treeContext);

    addTogglingListeners(settingsContext);
    setupRadioButtons(settingsContext, treeContext);
    selectDefaultSettings(settingsContext, treeContext);
    addApplyButtonListener(settingsContext, treeContext);
    addViewModeRadioButtonsListeners(settingsContext, treeContext);

    await apply(settingsContext, treeContext, true);
}

function createSettingsContext(treeContext) {
    const settingsDiv = treeContext.treeDiagramFrame.find('.settings-div');
    const diagramInfoDiv = treeContext.treeDiagramFrame.find('.diagram-info-div');

    return {
        settingsDiv: settingsDiv,
        expandButton: settingsDiv.find('.expand-button'),
        horizontalToggleableContainer: settingsDiv.find('.horizontal-toggleable-container'),

        treeTypeInfo: diagramInfoDiv.find('.tree-type-value'),
        ancestorsDepthInfo: diagramInfoDiv.find('.ancestors-depth-value'),
        descedantsDepthInfo: diagramInfoDiv.find('.descedants-depth-value'),
        viewModeInfo: diagramInfoDiv.find('.view-mode-value'),

        treeTypesFieldSet: settingsDiv.find('.tree-types-fieldset'),
        ancestorsDepthFieldSet: settingsDiv.find('.ancestors-depth-fieldset'),
        descedantsDepthFieldSet: settingsDiv.find('.descedants-depth-fieldset'),

        applyButton: settingsDiv.find('.apply-button'),
        viewModesFieldSet: settingsDiv.find('.view-modes-fieldset'),
    }
}

function addTogglingListeners(settingsContext) {
    settingsContext.expandButton.on('click', () => {
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
    settingsContext.expandButton.toggleClass('expand-button-opened');
    settingsContext.horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
}

function setupRadioButtons(settingsContext, treeContext) {
    const radioButtonNameUid = Date.now();

    // Tree types radio buttons

    // add unique names per settings to the tree types radio buttons
    const treeTypesRadioButtons = settingsContext.treeTypesFieldSet.find('input[type="radio"]');
    treeTypesRadioButtons.each((_, radioButton) => {
        // input-radio-tree-type-1-1722960923456

        radioButton.name += `-${treeContext.personId}-${radioButtonNameUid}`;
    });

    // Ancestors radio buttons
    settingsContext.ancestorsDepthFieldSet.append(treeHtmlCreator.createOption(
        `input-radio-ancestors-depth-${treeContext.personId}-${radioButtonNameUid}`,
        'data-ancestors-depth', relativesDepth.ALL.index,
        relativesDepth.getDisplayText(relativesDepth.ALL.index)));

    for (let i = relativesDepth.MAX.index; i >= relativesDepth.MIN.index; i--) {
        // <label><input type="radio" name="input-radio-ancestors-depth-0-1722960923456" data-ancestors-depth="5" />5</label>

        settingsContext.ancestorsDepthFieldSet.append(treeHtmlCreator.createOption(
            `input-radio-ancestors-depth-${treeContext.personId}-${radioButtonNameUid}`,
            'data-ancestors-depth', i,
            relativesDepth.getDisplayText(i)));
    }

    // Descedants radio buttons
    for (let i = relativesDepth.MIN.index; i <= relativesDepth.MAX.index; i++) {
        // <label><input type="radio" name="input-radio-descedants-depth-0-1722960923456" data-descedants-depth="5" />5</label>

        settingsContext.descedantsDepthFieldSet.append(treeHtmlCreator.createOption(
            `input-radio-descedants-depth-${treeContext.personId}-${radioButtonNameUid}`,
            'data-descedants-depth', i,
            relativesDepth.getDisplayText(i)));
    }

    settingsContext.descedantsDepthFieldSet.append(treeHtmlCreator.createOption(
        `input-radio-descedants-depth-${treeContext.personId}-${radioButtonNameUid}`,
        'data-descedants-depth', relativesDepth.ALL.index,
        relativesDepth.getDisplayText(relativesDepth.ALL.index)));

    const viewModesRadioButtons = settingsContext.viewModesFieldSet.find('input[type="radio"]');
    viewModesRadioButtons.each((_, radioButton) => {
        // input-radio-view-mode-1-1722960923456

        radioButton.name += `-${treeContext.personId}-${radioButtonNameUid}`;
    });
}

function selectDefaultSettings(settingsContext, treeContext) {
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

function addApplyButtonListener(settingsContext, treeContext) {
    settingsContext.applyButton.on('click', () => apply(settingsContext, treeContext));
}

async function apply(settingsContext,treeContext ,fromInitialization) {
    if (!fromInitialization) {
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

    treeContext.treeType = treeTypes.getTreeTypeByIndex(parseInt(treeTypeRadioButton[0].dataset.treeTypeIndex, 10));
    treeContext.ancestorsDepth = parseInt(ancestorsDepthRadioButton[0].dataset.ancestorsDepth, 10);
    treeContext.descedantsDepth = parseInt(descedantsDepthRadioButton[0].dataset.descedantsDepth, 10);

    settingsContext.treeTypeInfo.text(treeContext.treeType.displayName);
    settingsContext.ancestorsDepthInfo.text(relativesDepth.getDisplayText(treeContext.ancestorsDepth));
    settingsContext.descedantsDepthInfo.text(relativesDepth.getDisplayText(treeContext.descedantsDepth));

    await treeContext.calculateDataAndDisplayTree(treeContext);
}

function addViewModeRadioButtonsListeners(settingsContext, treeContext) {
    const viewModeRadioButtons = settingsContext.viewModesFieldSet.find('input[type="radio"]');
    viewModeRadioButtons.each((_, radioButton) => {
        $(radioButton).on('change', function () {
            treeContext.viewMode = getViewModeByIndex(parseInt(this.dataset.viewModeIndex, 10));
            settingsContext.settingsDiv.addClass('transparent');

            settingsContext.viewModeInfo.text(treeContext.viewMode.displayName);
            setViewModeSizes(treeContext);

            treeContext.redrawPaths(treeContext, true);
        })
    });
}

function setViewModeSizes(treeContext) {
    treeContext.treeDiagram.css('--person-node-width', getPersonNodeWidth(treeContext.viewMode));
    treeContext.treeDiagram.css('--marriage-node-width', getMarriageNodeWidth(treeContext.viewMode));
    treeContext.treeDiagram.css('--node-horizontal-margin', getNodeHorizontalMargin(treeContext.viewMode));

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(treeContext.viewMode);
    const generations = treeContext.treeDiagram.find('.generation');

    generations.each((index, elem) => {
        const generation = $(elem);
        const isLast = index === generations.length - 1;
        const bottomPaddingMultiplier = parseInt(generation.attr('data-bottom-padding-multiplier'), 10);

        const paddingValue = isLast
            ? '0px'
            : `0px 0px ${bottomPaddingMultiplier * nodePathsVerticalOffset}px 0px`;

        generation.css('padding', paddingValue);
    });
}