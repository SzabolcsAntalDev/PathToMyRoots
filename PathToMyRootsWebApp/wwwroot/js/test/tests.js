$(() => {
    (async () => {
        const treeDiagramsContainer = $('#tree-diagrams-container');

        treeDiagramsContainer.append(createTestTitleHtml('Three simple generations'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 0);

        treeDiagramsContainer.append(createTestTitleHtml('Child with biological and adoptive parents'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 10);

        treeDiagramsContainer.append(createTestTitleHtml('Sort two generations by birthdays'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 20);

        treeDiagramsContainer.append(createTestTitleHtml('Tie spouses in two generations'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 30);
    })();
});
