function drawPathsOntoPathsContainer(generationsData, viewMode, nodesContainer, pathsContainer) {
    setSize(nodesContainer, pathsContainer);

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(viewMode);
    const generationsHtmls = $(nodesContainer).find('.generation');

    drawMarriagesChildrenPathsInner(generationsData, pathsContainer, nodePathsVerticalOffset, generationsHtmls);
    drawMarriagesPathsInner(pathsContainer, generationsHtmls);
    drawDuplicatedPersonPathsInner(pathsContainer, nodePathsVerticalOffset, generationsHtmls);
}

function drawMarriagesChildrenPathsInner(generationsData, pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    for (let i = 1; i < generationsHtmls.length; i++) {
        const marriageNodes = $(generationsHtmls[i - 1]).find('.marriage-node');
        const childNodes = $(generationsHtmls[i]).find('.person-node');

        drawMarriagesChildrenPaths(
            pathsContainer,
            nodePathsVerticalOffset,
            generationsData.largestGenerationSize,
            generationsData.largestDuplicatedGroupsOnSameLevelCount,
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

function drawDuplicatedPersonPathsInner(pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    drawDuplicatedPersonPaths(pathsContainer, nodePathsVerticalOffset, generationsHtmls);
}