$(() => {
    (async () => {
        const treeDiagramsContainer = $('#tree-diagrams-container');
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 1);
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 8);
    })();
});
