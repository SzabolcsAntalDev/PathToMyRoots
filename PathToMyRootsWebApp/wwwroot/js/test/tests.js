$(() => {
    (async () => {
        const treeDiagramsContainer = $('#tree-diagrams-container');

        treeDiagramsContainer.append(createTestTitleHtml('Three simple generations'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 1);

        treeDiagramsContainer.append(createTestTitleHtml('Child with biological and adoptive parents'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 10);

        treeDiagramsContainer.append(createTestTitleHtml('Sort two generations by birthdays'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 20);

        treeDiagramsContainer.append(createTestTitleHtml('Tie spouses in two generations'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 30);

        treeDiagramsContainer.append(createTestTitleHtml('Double married female'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 50);

        treeDiagramsContainer.append(createTestTitleHtml('Double married male'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 60);

        treeDiagramsContainer.append(createTestTitleHtml('Divorced female with biological and adoptive children'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 70);
    })();
});
