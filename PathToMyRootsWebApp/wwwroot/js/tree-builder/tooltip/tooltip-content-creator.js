let treeTypeToolTipTreesInitialized = false;

async function fillTreeTypeTooltipsWithTrees() {

    if (!treeTypeToolTipTreesInitialized) {
        treeTypeToolTipTreesInitialized = true;

        await fillTreeTypeTooltipsWithTree(treeTypes.HOURGLASS_BIOLOGICAL);
        await fillTreeTypeTooltipsWithTree(treeTypes.HOURGLASS_EXTENDED);
        await fillTreeTypeTooltipsWithTree(treeTypes.COMPLETE);
    }
}

async function fillTreeTypeTooltipsWithTree(treeType) {
    const treeTypeId = treeType.id.toLowerCase();
    const viewMode = viewModes.EXTRASMALL;
    const diagram = treeHtmlCreator.createHiddenDiagram();

    const treeDiv = $(`.${treeTypeId}-tooltip-content .tree-div`);
    treeDiv.append(diagram);

    diagram.css('padding', '0px');
    diagram.css('--person-node-width', getPersonNodeWidth(viewMode));
    diagram.css('--marriage-date-node-width', getMarriageDateNodeWidth(viewMode));
    diagram.css('--marriage-node-height', getMarriageNodeHeight(viewMode));
    diagram.css('--node-horizontal-margin', getNodeHorizontalMargin(viewMode));
    diagram.css('--tree-person-image-width', getTreePersonImageWidth(viewMode));
    diagram.css('--tree-person-image-height', getTreePersonImageHeight(viewMode));
    diagram.css('--tree-node-texts-div-display', 'none');

    const response = await fetch(`/js/tree-builder/tooltip/${treeTypeId}.json`);
    const generationsData = await response.json();

    const nodesContainer = treeHtmlCreator.createNodesDiv(generationsData, viewMode);
    const pathsContainer = treeHtmlCreator.createEmptyPathsSvg();

    diagram.append(nodesContainer);
    diagram.append(pathsContainer);

    drawPathsOntoPathsContainer(generationsData, viewMode, nodesContainer, pathsContainer);

    await fadeInElement(diagram);
}