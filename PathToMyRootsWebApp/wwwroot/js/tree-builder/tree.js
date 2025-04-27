async function removeTreeDiagram(treeDiagramsContainer, personId) {
    const treeDiagram = treeDiagramsContainer.find('#tree-diagram-' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }
}

let generationsData;
let nodesContainer;
let linesContainer;

async function createAndDisplayTreeDiagram(treeDiagramsContainer, personId) {
    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(treeDiagramsContainer);
    treeDiagramsContainer.append(loadingTextContainer);
    await fadeInElement(loadingTextContainer);

    const treeDiagram = createTreeDiagramHtml(personId);
    hideElement(treeDiagram);

    generationsData = await createGenerationsData(personId);
    nodesContainer = createNodesContainerHtml(generationsData);
    linesContainer = createEmptyLinesContainerHtml();

    treeDiagram.append(nodesContainer);
    treeDiagram.append(linesContainer);
    treeDiagramsContainer.append(treeDiagram);

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