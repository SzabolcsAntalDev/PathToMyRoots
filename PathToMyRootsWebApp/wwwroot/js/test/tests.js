$(() => {
    (async () => {
        const treeDiagramsContainer = $('#tree-diagrams-container');

        let personId = -1000000;
        let personIdBuffer = 30;
        let testIndex = 1;

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When a person has a three generaion family, generations are displayed on three levels'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When child has biological and adoptive parents, biological and adoptive lines are drawn'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When sibling groups and siblings are not sorted when loaded, they are sorted after loading'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When extended marriages have secondary marriage, they are chained based on the second marriage'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When female is double married, both husbands are displayed'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When male is double married, both wives are displayed'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When older parents have younger children, children are sorted by parents first instead of birthDates'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When female is loaded first, her first husband is still loaded'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When children have common parents, they are displayed in separate sibling groups'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When parents are orphans on the second level, they are sorted by birthDates'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

        personId += personIdBuffer;
        treeDiagramsContainer.append(createTestTitleHtml(testIndex++, 'When extended marriage male has default birthDate, use female birthDate for sorting'));
        await createAndDisplayTreeDiagram(treeDiagramsContainer, personId);
    })();
});
