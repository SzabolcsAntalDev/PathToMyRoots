function createLinesContainer(generationsData, nodesContainer) {

    const linesContainer = createLinesContainerHtml(getSize(nodesContainer));
    var a = linesContainer.get(0).getBoundingClientRect();

    const generations = generationsData.generations;

    const generationHtmls = $(nodesContainer).find('.tree-generation');

    for (let i = 1; i < generations.length; i++) {
        const a = $(generationHtmls).get(i - 1);
        const marriageNodes = $(a).find('.tree-node-marriage');
        const b = generationHtmls.get(i);
        const personNodes = $(b).find('.tree-node-male, .tree-node-female');
        drawLines(linesContainer, generationsData, generationsData.generations[i], marriageNodes, personNodes);
    }

    return linesContainer;
}

function getSize(nodesContainer) {
    const nodesContainerDomElement = nodesContainer.get(0);

    const nodesContainerStyle = window.getComputedStyle(nodesContainerDomElement);
    const nodesContainerWidth = nodesContainerDomElement.offsetWidth || parseFloat(nodesContainerStyle.width);
    const nodesContainerHeight = nodesContainerDomElement.offsetHeight || parseFloat(nodesContainerStyle.height);

    return { width: nodesContainerWidth, height: nodesContainerHeight };
}