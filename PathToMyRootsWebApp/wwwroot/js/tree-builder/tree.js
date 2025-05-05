async function removeTreeDiagram(treeDiagramsDiv, personId) {
    const treeDiagram = treeDiagramsDiv.find('#diagram - ' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }
}

let generationsData;
let nodesContainer;
let linesContainer;

async function createAndDisplayTreeDiagram(treeDiagramsDiv, personId) {
    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(treeDiagramsDiv);
    treeDiagramsDiv.append(loadingTextContainer);
    await fadeInElement(loadingTextContainer);

    const treeDiagram = treeHtmlCreator.createDiagram(personId);
    hideElement(treeDiagram);

    generationsData = await createGenerationsData(personId);
    nodesContainer = treeHtmlCreator.createNodesDiv(generationsData);
    linesContainer = treeHtmlCreator.createEmptyLinesSvg();

    treeDiagram.append(nodesContainer);
    treeDiagram.append(linesContainer);
    treeDiagramsDiv.append(treeDiagram);

    drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);

    await fadeOutElement(loadingTextContainer);
    await fadeInElement(treeDiagram);
}

document.addEventListener('wheel', (event) => {
    if (event.ctrlKey) {
        $(linesContainer).empty();
        drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);
    }
});