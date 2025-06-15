async function removeTreeDiagramFrame(treeDiagramsDiv, personId) {
    const treeDiagramFrame = treeDiagramsDiv.find('#diagram-frame-' + personId).get(0);
    if (treeDiagramFrame) {
        await fadeOutElement(treeDiagramFrame)
        treeDiagramFrame.remove();
    }
}

async function createAndDisplayTreeDiagramFrame(treeDiagramsDiv, personId, treeFrameIdSuffix, treeType, ancestorsDepth, descedantsDepth, viewMode) {
    const treeDiagramFrame = treeHtmlCreator.createHiddenDiagramFrame(treeFrameIdSuffix);
    treeDiagramsDiv.append(treeDiagramFrame);

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(treeDiagramFrame);
    const treeDiagramInfo = treeHtmlCreator.createDiagramInfo();
    const treeDiagram = treeHtmlCreator.createHiddenDiagram();

    treeDiagramFrame.append(loadingTextContainer);
    treeDiagramFrame.append(treeDiagramInfo);
    treeDiagramFrame.append(treeDiagram);

    await fadeInElement(treeDiagramFrame);

    const treeContext = createTreeContext(
        personId, treeDiagramFrame, loadingTextContainer,
        treeType, ancestorsDepth, descedantsDepth, viewMode, treeDiagram,
        calculateDataAndDisplayTree,
        redrawLines);

    addZoomingEventListener(treeContext);
    await addSettingsEventListeners(treeContext);
}

function createTreeContext(personId, treeDiagramFrame, loadingTextContainer, treeType, ancestorsDepth, descedantsDepth, viewMode, treeDiagram) {
    return {
        personId: personId,
        treeDiagramFrame: treeDiagramFrame,
        loadingTextContainer: loadingTextContainer,
        treeType: treeType,
        ancestorsDepth: (ancestorsDepth < relativesMinDepth || ancestorsDepth > relativesMaxDepth ? allRelativesDepthIndex : ancestorsDepth),
        descedantsDepth: (descedantsDepth < relativesMinDepth || descedantsDepth > relativesMaxDepth ? allRelativesDepthIndex : descedantsDepth),
        viewMode: viewMode,
        treeDiagram: treeDiagram,
        calculateDataAndDisplayTree: calculateDataAndDisplayTree,
        redrawLines: redrawLines
    };
}

function addZoomingEventListener(treeContext) {
    $(document).on('wheel', function (event) {
        if (event.ctrlKey) {
            redrawLines(treeContext);
        }
    });
}

async function calculateDataAndDisplayTree(treeContext) {
    await loadingTextManager.fadeIn(treeContext.loadingTextContainer);
    await fadeOutElement(treeContext.treeDiagram);

    treeContext.generationsData = await createGenerationsData(treeContext.personId, treeContext.treeType, treeContext.ancestorsDepth, treeContext.descedantsDepth, treeContext.treeDiagramFrame);

    const previousNodesContainer = treeContext.treeDiagram.find('.nodes-div');
    const previousLinesContainer = treeContext.treeDiagram.find('.lines-svg');
    previousNodesContainer?.remove();
    previousLinesContainer?.remove();

    const nodesContainer = treeHtmlCreator.createNodesDiv(treeContext.generationsData, treeContext.viewMode);
    const linesContainer = treeHtmlCreator.createEmptyLinesSvg();

    treeContext.nodesContainer = nodesContainer;
    treeContext.linesContainer = linesContainer;

    redrawLines(treeContext);

    treeContext.treeDiagram.append(nodesContainer);
    treeContext.treeDiagram.append(linesContainer);

    await fadeInElement(treeContext.treeDiagram);
    await loadingTextManager.fadeOut(treeContext.loadingTextContainer);
}

function redrawLines(treeContext) {
    $(treeContext.linesContainer).empty();

    setTimeout(() => {
        $(treeContext.linesContainer).empty();
        drawLinesOntoLinesContainer(treeContext.generationsData, treeContext.viewMode, treeContext.nodesContainer, treeContext.linesContainer);
        // delay drawing the lines so animations can finish
    }, (getTransitionIntervalInSeconds(treeContext.linesContainer) + getLinesDrawStartDelayAfterTransitionInSeconds()) * 1000);
}

