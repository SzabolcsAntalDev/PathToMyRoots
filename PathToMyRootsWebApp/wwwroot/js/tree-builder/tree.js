async function removeTreeDiagram(treeDiagramsContainer, personId) {
    const treeDiagram = treeDiagramsContainer.find('#tree-diagram-' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }
}

async function createAndDisplayTreeDiagram(treeDiagramsContainer, personId) {
    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(treeDiagramsContainer);
    treeDiagramsContainer.append(loadingTextContainer);
    await fadeInElement(loadingTextContainer);

    const treeDiagram = createTreeDiagramHtml(personId);
    hideElement(treeDiagram);

    const generationsData = await createGenerationsData(personId);
    const nodesContainer = createNodesContainer(generationsData);
    const linesContainer = createEmptyLinesContainerHtml();

    treeDiagram.append(nodesContainer);
    treeDiagram.append(linesContainer);
    treeDiagramsContainer.append(treeDiagram);

    drawLinesOntoLinesContainer(generationsData, nodesContainer, linesContainer);

    await fadeOutElement(loadingTextContainer);
    await fadeInElement(treeDiagram);
}