const serializeGenerationsDataForToolTipSetting = false;
const pathsDrawingRequests = new Map();

async function removeTreeDiagramFrame(treeDiagramsDiv, personId) {
    const treeDiagramFrame = treeDiagramsDiv.find('#diagram-frame-' + personId).get(0);
    if (treeDiagramFrame) {
        await fadeOutElement(treeDiagramFrame)
        treeDiagramFrame.remove();
    }
}

async function createAndDisplayTreeDiagramFrame(treeDiagramsDiv, personId, treeFrameIdSuffix, treeType, ancestorsDepth, descendantsDepth, viewMode) {
    const treeDiagramFrame = treeHtmlCreator.createHiddenDiagramFrame(treeFrameIdSuffix);
    treeDiagramsDiv.append(treeDiagramFrame);

    await fillTreeTypeTooltipsWithTrees();
    registerTooltips();

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(treeDiagramFrame);

    // create diagram object first so it can be passed to the download button
    const treeDiagram = treeHtmlCreator.createHiddenDiagram();

    const treeContext = createTreeContext(
        personId, treeDiagramFrame, treeDiagram, loadingTextContainer,
        treeType, ancestorsDepth, descendantsDepth, viewMode,
        calculateDataAndDisplayTree,
        redrawPaths);

    const treeDiagramInfo = treeHtmlCreator.createDiagramInfo(treeContext);

    treeDiagramFrame.append(treeDiagramInfo);
    treeDiagramFrame.append(treeDiagram);
    treeDiagramFrame.append(loadingTextContainer);

    await fadeInElement(treeDiagramFrame);

    addZoomingEventListener(treeContext);
    await addSettingsEventListeners(treeContext);
}

function createTreeContext(
    personId, treeDiagramFrame, treeDiagram, loadingTextContainer,
    treeType, ancestorsDepth, descendantsDepth, viewMode) {
    return {
        personId: personId,
        loadingTextContainer: loadingTextContainer,
        treeDiagramFrame: treeDiagramFrame,
        treeDiagram: treeDiagram,
        treeType: treeType,
        ancestorsDepth: (ancestorsDepth < relativesDepth.MIN.index || ancestorsDepth > relativesDepth.MAX.index ? relativesDepth.ALL.index : ancestorsDepth),
        descendantsDepth: (descendantsDepth < relativesDepth.MIN.index || descendantsDepth > relativesDepth.MAX.index ? relativesDepth.ALL.index : descendantsDepth),
        viewMode: viewMode,
        calculateDataAndDisplayTree: calculateDataAndDisplayTree,
        redrawPaths: redrawPaths
    };
}

function addZoomingEventListener(treeContext) {
    $(document).on('wheel', function (event) {
        if (event.ctrlKey) {
            redrawPaths(treeContext);
        }
    });
}

async function calculateDataAndDisplayTree(treeContext) {
    loadingTextManager.fadeIn(treeContext.loadingTextContainer);
    await fadeOutElement(treeContext.treeDiagram);

    const previousNodesContainer = treeContext.treeDiagram.find('.nodes-div');
    const previousPathsContainer = treeContext.treeDiagram.find('.paths-svg');
    previousNodesContainer?.remove();
    previousPathsContainer?.remove();

    treeContext.generationsData = await createGenerationsData(treeContext);

    if (serializeGenerationsDataForToolTipSetting) {
        const generationsJsonStringForToolTip = JSON.stringify(treeContext.generationsData, null, 2);

        // debug: result string for tree tooltip contents
        const generationsJsonStringForToolTipCopy = generationsJsonStringForToolTip;
    }

    const nodesContainer = treeHtmlCreator.createNodesDiv(treeContext.generationsData, treeContext.viewMode);

    if (databaseScriptHelper.executeSqlScriptHelpersSetting) {
        databaseScriptHelper.executeSqlScriptHelpers(nodesContainer);
    }

    const pathsContainer = treeHtmlCreator.createEmptyPathsSvg();

    treeContext.nodesContainer = nodesContainer;
    treeContext.pathsContainer = pathsContainer;

    treeContext.treeDiagram.append(nodesContainer);
    treeContext.treeDiagram.append(pathsContainer);
    registerTooltips();

    redrawPaths(treeContext);

    loadingTextManager.fadeOut(treeContext.loadingTextContainer);
    await fadeInElement(treeContext.treeDiagram);
}

function redrawPaths(treeContext, redrawAfterTreeSizeTransition) {
    $(treeContext.pathsContainer).empty();

    // used to skip the drawing in case another request came before the previous one finished
    registerPathsDrawingRequest(treeContext);

    if (redrawAfterTreeSizeTransition) {
        setTimeout(() => {
            if (shouldDrawPaths(treeContext)) {
                drawPathsOntoPathsContainer(treeContext.generationsData, treeContext.viewMode, treeContext.nodesContainer, treeContext.pathsContainer);
            }
        }, (getTreeSizeTransitionIntervalInSeconds(treeContext.pathsContainer) + getTransitionBufferIntervalInSeconds()) * 1000);
    }
    else {
        if (shouldDrawPaths(treeContext)) {
            drawPathsOntoPathsContainer(treeContext.generationsData, treeContext.viewMode, treeContext.nodesContainer, treeContext.pathsContainer);
        }
    }
}

function registerPathsDrawingRequest(treeContext) {
    const currentCount = pathsDrawingRequests.get(treeContext) || 0;
    pathsDrawingRequests.set(treeContext, currentCount + 1);
}

function shouldDrawPaths(treeContext) {
    const updatedCount = pathsDrawingRequests.get(treeContext) - 1;
    pathsDrawingRequests.set(treeContext, updatedCount);
    return updatedCount == 0;
}