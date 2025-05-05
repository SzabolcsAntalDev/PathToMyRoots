function drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer) {
    setSize(nodesContainer, linesContainer);
    const generationsHtmls = $(nodesContainer).find('.generation');
    drawMarriagesChildrenLinesInner(generationsData, nodesContainer, linesContainer, generationsHtmls);
    drawMarriagesLinesInner(linesContainer, generationsHtmls);
}

function drawMarriagesChildrenLinesInner(generationsData, nodesContainer, linesContainer, generationsHtmls) {
    for (let i = 1; i < generationsHtmls.length; i++) {
        const marriageNodes = $(generationsHtmls[i - 1]).find('.marriage-node');
        const childNodes = $(generationsHtmls[i]).find('.person-node');

        drawMarriagesChildrenLines(
            linesContainer,
            generationsData.largestGenerationSize,
            generationsData.generations[i],
            marriageNodes,
            childNodes);
    }
}

function drawMarriagesLinesInner(linesContainer, generationsHtmls) {
    

    generationsHtmls.each((_, generationHtml) => {
        const marriageNodes = $(generationHtml).find('.marriage-node');
        drawMarriagesLines(linesContainer, marriageNodes);
    });
}