function drawPathsOntoPathsContainer(generationsData, viewMode, nodesContainer, pathsContainer) {
    setSize(nodesContainer, pathsContainer);

    const nodePathsVerticalOffset = getNodePathsVerticalOffset(viewMode);
    const generationsHtmls = $(nodesContainer).find('.generation');

    drawMarriagesChildrenPathsInner(generationsData, nodesContainer, pathsContainer, nodePathsVerticalOffset, generationsHtmls);
    drawMarriagesPathsInner(pathsContainer, generationsHtmls);
    drawDuplicatedPersonPathsInner(pathsContainer, generationsHtmls)
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

function drawDuplicatedPersonPathsInner(pathsContainer, generationsHtmls) {
    const duplicatedPersonNodes = getDuplicatedPersonNodes(generationsHtmls);
    drawDuplicatedPersonPaths(pathsContainer, duplicatedPersonNodes);
}

function getDuplicatedPersonNodes(generationsHtmls) {
    const personNodesById = new Map();

    generationsHtmls.each((_, generationHtml) => {
        const personNodes = $(generationHtml).find('.person-node');
        personNodes.each(function () {
            const personId = this.id;

            if (!personNodesById.has(personId)) {
                personNodesById.set(personId, []);
            }

            personNodesById.get(personId).push(this);
        });
    });

    const duplicatedPersonNodes = new Map(
        Array.from(personNodesById.entries())
            .filter(([personId, personNodes]) => personNodes.length > 1)
    );

    return duplicatedPersonNodes;
}