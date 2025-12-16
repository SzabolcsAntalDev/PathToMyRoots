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
    const settingsDiv = treeContext.diagramFrame.find('.settings-div');
    const diagramInfoDiv = treeContext.diagramFrame.find('.diagram-info-div');

    return {
        settingsDiv: settingsDiv,
        expandButton: settingsDiv.find('.expand-button'),
        horizontalToggleableContainer: settingsDiv.find('.horizontal-toggleable-container'),

        treeTypeInfo: diagramInfoDiv.find('.tree-type-value'),
        ancestorsDepthInfo: diagramInfoDiv.find('.ancestors-depth-value'),
        descendantsDepthInfo: diagramInfoDiv.find('.descendants-depth-value'),
        viewModeInfo: diagramInfoDiv.find('.view-mode-value'),

        treeTypesFieldSet: settingsDiv.find('.tree-types-fieldset'),
        ancestorsDepthFieldSet: settingsDiv.find('.ancestors-depth-fieldset'),
        descendantsDepthFieldSet: settingsDiv.find('.descendants-depth-fieldset'),

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

    // Descendants radio buttons
    for (let i = relativesDepth.MIN.index; i <= relativesDepth.MAX.index; i++) {
        // <label><input type="radio" name="input-radio-descendants-depth-0-1722960923456" data-descendants-depth="5" />5</label>

        settingsContext.descendantsDepthFieldSet.append(treeHtmlCreator.createOption(
            `input-radio-descendants-depth-${treeContext.personId}-${radioButtonNameUid}`,
            'data-descendants-depth', i,
            relativesDepth.getDisplayText(i)));
    }

    settingsContext.descendantsDepthFieldSet.append(treeHtmlCreator.createOption(
        `input-radio-descendants-depth-${treeContext.personId}-${radioButtonNameUid}`,
        'data-descendants-depth', relativesDepth.ALL.index,
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

    settingsContext.descendantsDepthFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt(this.dataset.descendantsDepth, 10) === treeContext.descendantsDepth;
    }).prop('checked', true);

    settingsContext.viewModesFieldSet.find('input[type="radio"]').filter(function () {
        return parseInt(this.dataset.viewModeIndex, 10) === treeContext.viewMode.index;
    }).prop('checked', true);
}

function addApplyButtonListener(settingsContext, treeContext) {
    settingsContext.applyButton.on('click', () => apply(settingsContext, treeContext));
}

async function apply(settingsContext, treeContext, fromInitialization) {
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
    const descendantsDepthRadioButton = settingsContext.descendantsDepthFieldSet.find('input[type="radio"]:checked');

    treeContext.treeType = treeTypes.getTreeTypeByIndex(parseInt(treeTypeRadioButton[0].dataset.treeTypeIndex, 10));
    treeContext.ancestorsDepth = parseInt(ancestorsDepthRadioButton[0].dataset.ancestorsDepth, 10);
    treeContext.descendantsDepth = parseInt(descendantsDepthRadioButton[0].dataset.descendantsDepth, 10);

    settingsContext.treeTypeInfo.text(treeContext.treeType.displayName);
    settingsContext.ancestorsDepthInfo.text(relativesDepth.getDisplayText(treeContext.ancestorsDepth));
    settingsContext.descendantsDepthInfo.text(relativesDepth.getDisplayText(treeContext.descendantsDepth));

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
    treeContext.diagram.css('--person-node-width', getPersonNodeWidth(treeContext.viewMode));
    treeContext.diagram.css('--marriage-date-node-width', getMarriageDateNodeWidth(treeContext.viewMode));
    treeContext.diagram.css('--node-horizontal-margin', getNodeHorizontalMargin(treeContext.viewMode));

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(treeContext.viewMode);
    const generations = treeContext.diagram.find('.generation');

    generations.each((index, elem) => {
        const generation = $(elem);

        const isFirst = index == 0;
        const isLast = index == generations.length - 1;

        const topPaddingMultiplier = parseInt(generation.attr('data-top-padding-multiplier'), 10);
        const bottomPaddingMultiplier = parseInt(generation.attr('data-bottom-padding-multiplier'), 10);

        const topPadding = isFirst ? topPaddingMultiplier * nodePathsVerticalOffset : 0;
        const bottomPadding = isLast ? 0 : bottomPaddingMultiplier * nodePathsVerticalOffset;

        generation.css('padding', `${topPadding}px 0px ${bottomPadding}px 0px`);
    });
}