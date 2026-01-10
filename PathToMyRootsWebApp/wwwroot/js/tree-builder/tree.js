const serializeGenerationsDataForToolTipSetting = false;
const pathsDrawingRequests = new Map();

async function removeDiagramFrame(diagramsDiv, personId) {
    const diagramFrame = diagramsDiv.find('#diagram-frame-' + personId).get(0);
    if (diagramFrame) {
        await fadeOutElement(diagramFrame)
        diagramFrame.remove();
    }
}

async function createAndDisplayDiagramFrame(diagramsDiv, personId, treeFrameIdSuffix, treeType, isBalanced, ancestorsDepth, descendantsDepth, viewMode) {
    const diagramFrame = treeHtmlCreator.createHiddenDiagramFrame(treeFrameIdSuffix);
    diagramsDiv.append(diagramFrame);

    await fillTreeTypeTooltipsWithTrees();
    registerTooltips();

    const loadingTextContainer = loadingTextManager.getOrCreateHiddenLoadingTextContainer(diagramFrame);

    // create diagram object first so it can be passed to the download button
    const diagram = treeHtmlCreator.createHiddenDiagram();

    const treeContext = createTreeContext(
        personId, diagramFrame, diagram, loadingTextContainer,
        treeType, isBalanced, ancestorsDepth, descendantsDepth, viewMode,
        calculateDataAndDisplayTree,
        redrawPaths);

    const diagramInfo = treeHtmlCreator.createDiagramInfo(treeContext);

    diagramFrame.append(diagramInfo);
    diagramFrame.append(diagram);
    diagramFrame.append(loadingTextContainer);

    await fadeInElement(diagramFrame);

    addZoomingEventListener(treeContext);
    await addSettingsEventListeners(treeContext);
}

function createTreeContext(
    personId, diagramFrame, diagram, loadingTextContainer,
    treeType, isBalanced, ancestorsDepth, descendantsDepth, viewMode) {
    return {
        personId: personId,
        loadingTextContainer: loadingTextContainer,
        diagramFrame: diagramFrame,
        diagram: diagram,
        treeType: treeType,
        isBalanced: isBalanced,
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
    await fadeOutElement(treeContext.diagram);

    const previousNodesContainer = treeContext.diagram.find('.nodes-div');
    const previousPathsContainer = treeContext.diagram.find('.paths-svg');
    previousNodesContainer?.remove();
    previousPathsContainer?.remove();

    treeContext.generationsData = await createGenerationsData(treeContext);

    if (serializeGenerationsDataForToolTipSetting) {
        const generationsJsonStringForToolTip = JSON.stringify(treeContext.generationsData, null, 2);

        console.info(generationsJsonStringForToolTip);
    }

    const nodesContainer = treeHtmlCreator.createNodesDiv(treeContext.generationsData, treeContext.viewMode);

    if (databaseScriptHelper.executeSqlScriptHelpersSetting) {
        databaseScriptHelper.executeSqlScriptHelpers(nodesContainer);
    }

    const pathsContainer = treeHtmlCreator.createEmptyPathsSvg();

    treeContext.nodesContainer = nodesContainer;
    treeContext.pathsContainer = pathsContainer;

    treeContext.diagram.append(nodesContainer);
    treeContext.diagram.append(pathsContainer);
    registerTooltips();

    redrawPaths(treeContext);

    loadingTextManager.fadeOut(treeContext.loadingTextContainer);
    await fadeInElement(treeContext.diagram);
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