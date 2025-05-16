$(() => {
    (async () => {
        const treeDiagramsDiv = $('#tree-diagrams-div');
        treeDiagramsDiv.addClass('test-trees-div');

        // await addTreeTypeCompleteTests(treeDiagramsDiv);
        await addTreeTypeHourglassTests(treeDiagramsDiv);
    })();
});

async function addTreeTypeCompleteTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 1000,
        personIdBuffer: 30,
        testIndex: 1,
        treeType: treeTypes.COMPLETE
    };

    const tests = [
        'When a person has a three generation family, generations are displayed on three levels',
        'When child has biological and adoptive parents, biological and adoptive lines are drawn',
        'When sibling groups and siblings are not sorted when loaded, they are sorted after loading',
        'When female is double married, both husbands are displayed',
        'When male is double married, both wives are displayed',
        'When extended marriages have secondary marriage, they are chained based on the second marriage',
        'When second wife of male has first spouse, that first spouse is also displayed',
        'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage',
        'When older parents have younger children, children are sorted by parents first instead of birthDates',
        'When female is loaded first, her first husband is still loaded',
        'When children have common parents, they are displayed in separate sibling groups',
        'When parents are orphans on the second level, they are sorted by birthDates',
        'When extended marriage male has default birthDate, use female birthDate for sorting'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTreeTypeHourglassTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 2000,
        personIdBuffer: 30,
        testIndex: 1,
        treeType: treeTypes.HOURGLASS_EXTENDED
    };

    const tests = [
        'When only male ancestors are present, fake ancestors are added',
        'When only female ancestors are present, fake ancestors are added',
        'When male has two spouses, both spouses are displayed, and spouses of wives are not displayed',
        'When female has two spouses, both spouses are displayed, and spouses of husbands are not displayed',
        'When children are shown, all children are displayed until their spouses, but not wider than that'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTest(treeDiagramsDiv, testsContext, testTitle) {
    const orderedTestTitle = `${testsContext.testIndex++}. ${testsContext.treeType} - ${testTitle}`;
    const testTitleH2 = createHiddenH2(orderedTestTitle);
    treeDiagramsDiv.append(testTitleH2);
    await fadeInElement(testTitleH2);

    testsContext.personId += testsContext.personIdBuffer;
    await createAndDisplayTreeDiagram(treeDiagramsDiv, testsContext.personId, testsContext.treeType);
}