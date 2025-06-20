const linesDrawingRequests = new Map();

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
    loadingTextManager.fadeIn(treeContext.loadingTextContainer);
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

    treeContext.treeDiagram.append(nodesContainer);
    treeContext.treeDiagram.append(linesContainer);

    redrawLines(treeContext);

    loadingTextManager.fadeOut(treeContext.loadingTextContainer);
    await fadeInElement(treeContext.treeDiagram);
}

function redrawLines(treeContext, redrawAfterTreeSizeTransition) {
    $(treeContext.linesContainer).empty();

    // used to skip the drawing in case another request came before the previous one finished
    registerLinesDrawingRequest(treeContext);

    if (redrawAfterTreeSizeTransition) {
        setTimeout(() => {
            if (shouldDrawLines(treeContext)) {
                drawLinesOntoLinesContainer(treeContext.generationsData, treeContext.viewMode, treeContext.nodesContainer, treeContext.linesContainer);
            }
        }, (getTreeSizeTransitionIntervalInSeconds(treeContext.linesContainer) + getTransitionBufferIntervalInSeconds()) * 1000);
    }
    else {
        if (shouldDrawLines(treeContext)) {
            drawLinesOntoLinesContainer(treeContext.generationsData, treeContext.viewMode, treeContext.nodesContainer, treeContext.linesContainer);
        }
    }
}

function registerLinesDrawingRequest(treeContext) {
    const currentCount = linesDrawingRequests.get(treeContext) || 0;
    linesDrawingRequests.set(treeContext, currentCount + 1);
}

function shouldDrawLines(treeContext) {
    const updatedCount = linesDrawingRequests.get(treeContext) - 1;
    linesDrawingRequests.set(treeContext, updatedCount);
    return updatedCount == 0;
}