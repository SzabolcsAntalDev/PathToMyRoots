$(() => {
    (async () => {
        const treeDiagramsContainer = $('#tree-diagrams-container');
        treeDiagramsContainer.addClass('test-trees-container');

        const testsContext = {
            personId: -1000000,
            personIdBuffer: 30,
            testIndex: 1
        };

        const tests = [
            'When a person has a three generation family, generations are displayed on three levels',
            //'When child has biological and adoptive parents, biological and adoptive lines are drawn',
            //'When sibling groups and siblings are not sorted when loaded, they are sorted after loading',
            //'When extended marriages have secondary marriage, they are chained based on the second marriage',
            //'When female is double married, both husbands are displayed',
            //'When male is double married, both wives are displayed',
            //'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage',
            //'When older parents have younger children, children are sorted by parents first instead of birthDates',
            //'When female is loaded first, her first husband is still loaded',
            //'When children have common parents, they are displayed in separate sibling groups',
            //'When parents are orphans on the second level, they are sorted by birthDates',
            //'When extended marriage male has default birthDate, use female birthDate for sorting'
        ];

        for (const testTitle of tests) {
            await addTest(treeDiagramsContainer, testsContext, testTitle);
        }
    })();
});


async function addTest(treeDiagramsContainer, testsContext, testTitle) {
    const testTitleHtml = createHiddenTestTitleHtml(testsContext.testIndex++, testTitle);
    treeDiagramsContainer.append(testTitleHtml);
    await fadeInElement(testTitleHtml);

    testsContext.personId += testsContext.personIdBuffer;
    await createAndDisplayTreeDiagram(treeDiagramsContainer, testsContext.personId);
}