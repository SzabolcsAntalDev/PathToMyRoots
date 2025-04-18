const linesVerticalOffset = 10;

const apiUrl = "https://localhost:7241/api/person/";
const imageApiUrl = "https://localhost:7241/";

async function removeTreeDiagram(treeDiagramsContainer, personId) {
    const treeDiagram = treeDiagramsContainer.find('#tree-diagram-' + personId).get(0);
    if (treeDiagram) {
        await fadeOutElement(treeDiagram)
        treeDiagram.remove();
    }

    const loadingTextContainer = treeDiagramsContainer.find('#loading-text-container').get(0);
    if (loadingTextContainer)
        await fadeInElement(loadingTextContainer);
}

async function createAndDisplayTreeDiagram(treeDiagramsContainer, personId) {
    const loadingTextContainer = getOrCreateHiddenLoadingTextContainer(treeDiagramsContainer);
    treeDiagramsContainer.append(loadingTextContainer);
    await fadeInElement(loadingTextContainer);

    const treeDiagram = await createTreeDiagram(personId);
    hideElement(treeDiagram);

    treeDiagramsContainer.append(treeDiagram);

    await fadeOutElement(loadingTextContainer);
    await fadeInElement(treeDiagram);
}