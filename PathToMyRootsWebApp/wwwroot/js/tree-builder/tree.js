async function removeTreeDiagramFrame(treeDiagramsDiv, personId) {
    const treeDiagramFrame = treeDiagramsDiv.find('#diagram-frame-' + personId).get(0);
    if (treeDiagramFrame) {
        await fadeOutElement(treeDiagramFrame)
        treeDiagramFrame.remove();
    }
}

async function createAndDisplayTreeDiagramFrame(treeDiagramsDiv, personId, treeType, ancestorsDepth, descedantsDepth, viewMode) {
    const treeDiagramFrame = treeHtmlCreator.createHiddenDiagramFrame(personId);
    treeDiagramsDiv.append(treeDiagramFrame);

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(treeDiagramFrame);
    const treeDiagramInfo = treeHtmlCreator.createDiagramInfo();
    const treeDiagram = treeHtmlCreator.createHiddenDiagram();

    treeDiagramFrame.append(loadingTextContainer);
    treeDiagramFrame.append(treeDiagramInfo);
    treeDiagramFrame.append(treeDiagram);

    await fadeInElement(treeDiagramFrame);

    addSettingsEventListeners(createContext(treeDiagramFrame, loadingTextContainer, personId, treeDiagram, treeType, ancestorsDepth, descedantsDepth, viewMode))
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

