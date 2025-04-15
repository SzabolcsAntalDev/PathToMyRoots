const linesVerticalOffset = 10;

const apiUrl = "https://localhost:7241/api/person/";
const imageApiUrl = "https://localhost:7241/";

async function removeTreeDiagram(treeDiagramsContainer, personId) {
    const loadingTextContainer = treeDiagramsContainer.find('#loading-text-container').get(0);
    if (loadingTextContainer)
        fadeInElement(loadingTextContainer);

    const treeDiagramContainer = treeDiagramsContainer.find('#tree-diagram-container-' + personId).get(0);
    if (treeDiagramContainer) {
        await fadeOutElement(treeDiagramContainer)
        treeDiagramContainer.remove();
    }
}

async function createAndDisplayTreeDiagram(treeDiagramsContainer, personId) {
    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(treeDiagramsContainer);
    treeDiagramsContainer.append(loadingTextContainer);
    fadeInElement(loadingTextContainer);

    const nodesContainer = createNodesContainer();
    const linesContainer = createLinesContainer();
    const treeDiagramContainer = createHiddenTreeDiagramContainer(personId);

    treeDiagramContainer.append(nodesContainer);
    treeDiagramContainer.append(linesContainer);

    await buildTree(nodesContainer, linesContainer, personId);

    treeDiagramsContainer.append(treeDiagramContainer);

    fadeOutElement(loadingTextContainer);
    fadeInElement(treeDiagramContainer);
}