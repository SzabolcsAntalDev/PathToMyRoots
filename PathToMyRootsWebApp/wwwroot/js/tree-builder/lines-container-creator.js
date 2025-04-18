function drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer) {
    setSize(nodesContainer, linesContainer);

    const generationHtmls = $(nodesContainer).find('.tree-generation');
    for (let i = 1; i < generationHtmls.length; i++) {
        const marriageNodes = $(generationHtmls[i - 1]).find('.tree-node-marriage');
        const childNodes = $(generationHtmls[i]).find('.tree-node-male, .tree-node-female');

        drawLines(
            linesContainer,
            generationsData.largestGenerationSize,
            generationsData.generations[i],
            marriageNodes,
            childNodes);
    }
}