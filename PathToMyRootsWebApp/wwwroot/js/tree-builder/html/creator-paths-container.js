function drawPathsOntoPathsContainer(generationsData, viewMode, nodesContainer, pathsContainer) {
    setSize(nodesContainer, pathsContainer, 2 * getThicknessLargeValue());

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(viewMode);
    const generationsHtmls = $(nodesContainer).find('.generation');

    drawMarriagesChildrenPathsInner(generationsData, pathsContainer, nodePathsVerticalOffset, generationsHtmls);
    drawDuplicatedPersonPathsInner(pathsContainer, nodePathsVerticalOffset, generationsHtmls);
}

function drawMarriagesChildrenPathsInner(generationsData, pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    for (let i = 1; i < generationsHtmls.length; i++) {
        const marriageDateNodes = $(generationsHtmls[i - 1]).find('.marriage-date-node');
        const childNodes = $(generationsHtmls[i]).find('.person-node');

        drawMarriagesChildrenPaths(
            pathsContainer,
            nodePathsVerticalOffset,
            generationsData.largestGenerationSize,
            generationsData.generations[i],
            marriageDateNodes,
            childNodes);
    }
}

function drawDuplicatedPersonPathsInner(pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    drawDuplicatedPersonPaths(pathsContainer, nodePathsVerticalOffset, generationsHtmls);
}