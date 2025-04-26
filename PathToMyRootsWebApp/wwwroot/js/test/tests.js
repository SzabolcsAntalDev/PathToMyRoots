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

        treeDiagramsContainer.append(createTestTitleHtml('Order correctly younger children with older parents'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 82);

        treeDiagramsContainer.append(createTestTitleHtml('Orpan parents on second level are added'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 100);

        treeDiagramsContainer.append(createTestTitleHtml('Double married females first husband is displayed'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 110);

        treeDiagramsContainer.append(createTestTitleHtml('Step siblings grouping'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, 120);
    })();
});
