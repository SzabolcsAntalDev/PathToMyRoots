function drawPathsOntoPathsContainer(generationsData, viewMode, nodesContainer, pathsContainer) {
    setSize(nodesContainer, pathsContainer);

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(viewMode);
    const generationsHtmls = $(nodesContainer).find('.generation');

    drawMarriagesChildrenPathsInner(generationsData, nodesContainer, pathsContainer, nodePathsVerticalOffset, generationsHtmls);
    drawMarriagesPathsInner(pathsContainer, generationsHtmls);
}

function drawMarriagesChildrenPathsInner(generationsData, nodesContainer, pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    for (let i = 1; i < generationsHtmls.length; i++) {
        const marriageNodes = $(generationsHtmls[i - 1]).find('.marriage-node');
        const childNodes = $(generationsHtmls[i]).find('.person-node');

        drawMarriagesChildrenPaths(
            pathsContainer,
            nodePathsVerticalOffset,
            generationsData.largestGenerationSize,
            generationsData.generations[i],
            marriageNodes,
            childNodes);
    }
}

function drawMarriagesPathsInner(pathsContainer, generationsHtmls) {
    generationsHtmls.each((_, generationHtml) => {
        const marriageNodes = $(generationHtml).find('.marriage-node');
        drawMarriagesPaths(pathsContainer, marriageNodes);
    });
}