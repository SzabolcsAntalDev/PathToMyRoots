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
        ancestorsDepth: ancestorsDepth,
        descedantsDepth: descedantsDepth
    };
}

async function createAndDisplayTreeDiagram(treeDiagramsDiv, personId, treeType) {
    const treeDiagramFrame = treeHtmlCreator.createDiagramFrame();
    hideElement(treeDiagramFrame);
    treeDiagramsDiv.append(treeDiagramFrame);

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(treeDiagramFrame);
    treeDiagramFrame.append(loadingTextContainer);

    const treeDiagram = treeHtmlCreator.createDiagram(personId);
    hideElement(treeDiagram);
    treeDiagramFrame.append(treeDiagram);

    await fadeInElement(treeDiagramFrame);

    addSettingsEventListeners(createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, 10, 10))
}

function addSettingsEventListeners(context) {

    const settingsDiv = context.treeDiagramFrame.find('.settings-div');

    const expandButtonDiv = $(settingsDiv).find('.expand-button-div');
    const horizontalToggleableContainer = $(settingsDiv).find('.horizontal-toggleable-container');

    function toggleSettingsVisibility() {
        expandButtonDiv.toggleClass('expand-button-div-opened');
        horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
    }
    expandButtonDiv.on('click', () => {
        toggleSettingsVisibility();
    });

    const treeTypesRadioButtons = context.treeDiagramFrame.find('.tree-types-fieldset input[type="radio"]');

    treeTypesRadioButtons.each((index, radioButton) => {
        radioButton.addEventListener('change', async (event) => {
            context.treeType = getTreeTypeByIndex(parseInt(radioButton.dataset.treeTypeIndex, 10));

            if (!event.detail.fromInitialization) {
                toggleSettingsVisibility();
            }

            await showTree(context);
        });
    });

    const radioButton = treeTypesRadioButtons.filter(function () {
        return parseInt(this.dataset.treeTypeIndex, 10) === context.treeType.index;
    })[0];

    radioButton.checked = true;
    radioButton.dispatchEvent(new CustomEvent('change', {
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

