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

    addSettingsEventListeners(createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, 2, 2))
}

function addSettingsEventListeners(context) {
    const treeTypesRadioButtons = context.treeDiagramFrame.find('.tree-types-fieldset input[type="radio"]');

    treeTypesRadioButtons.each((index, radioButton) => {
        radioButton.addEventListener('change', async () => {
            context.treeType = getTreeTypeByIndex(parseInt(radioButton.dataset.treeTypeIndex, 10));
            await showTree(context);
        });
    });

    const radioButton = treeTypesRadioButtons.filter(function () {
        return parseInt(this.dataset.treeTypeIndex, 10) === context.treeType.index;
    })[0];

    radioButton.checked = true;
    radioButton.dispatchEvent(new Event('change', { bubbles: true }));
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

    context.treeDiagram.append(nodesContainer);
    context.treeDiagram.append(linesContainer);

    drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);

    await fadeInElement(context.treeDiagram);
    await loadingTextManager.fadeOut(context.loadingTextContainer);
}