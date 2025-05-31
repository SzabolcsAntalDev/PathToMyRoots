const personIdBuffer = 40;

$(() => {
    (async () => {
        const treeDiagramsDiv = $('#tree-diagrams-div');
        treeDiagramsDiv.addClass('test-trees-div');

        await addTreeTypeHourglassCommonTests(treeDiagramsDiv);
        //await addTreeTypeHourglassBiologicalTests(treeDiagramsDiv);
        //await addTreeTypeHourglassExtendedTests(treeDiagramsDiv);
        await addTreeTypeCompleteTests(treeDiagramsDiv);
    })();
});

async function addTreeTypeHourglassCommonTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 1000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: "HOURGLASS_COMMON",
        treeType: treeTypes.HOURGLASS_BIOLOGICAL
    };

    const tests = [
        'Generation0 - When male has two wives, both wives are displayed, and husbands of wives are not displayed',
        // 'Generation0 - When female has two husbands, both husbands are displayed, and wives of husbands are not displayed'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTreeTypeHourglassBiologicalTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 2000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: treeTypes.HOURGLASS_BIOLOGICAL.id,
        treeType: treeTypes.HOURGLASS_BIOLOGICAL
    };

    const tests = [
        'When only male ancestors are present, fake ancestors are added',
        'When only female ancestors are present, fake ancestors are added',
        'When person has multiple spouses and siblings, they are all displayed and sorted in his/her generation',
        'When person has multiple children, children are sorted by their birthDates',
        'When ancestors and descedants depth are both 2, generations until those levels are displayed'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTreeTypeHourglassExtendedTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 3000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: treeTypes.HOURGLASS_EXTENDED.id,
        treeType: treeTypes.HOURGLASS_EXTENDED
    };

    const tests = [
        'When ancestors have multiple spouses, their spouses are displayed', // Szabi: complete tree is not working well in this case
        'When ancestors have adoptive parents, the ancestors of the adoptive parents are not displayed', // Szabi: complete tree is not working well in this case
        'When person has biological siblings, they and their spouses and displayed and sorted by birthDates',
        'When person has adoptive siblings, they and their spouses and displayed and sorted by birthDates',
        'When person has adoptive descedants, its descedants are not displayed',
        'When person has biological and adoptive descedants, they are all displayed and sorted by birthDates',
        'When ancestors and descedants depth are both 2, generations until those levels are displayed'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTreeTypeCompleteTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 4000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: treeTypes.COMPLETE.id,
        treeType: treeTypes.COMPLETE
    };

    const tests = [
        'When a person has a three generation family, generations are displayed on three levels',
        'When child has biological and adoptive parents, biological and adoptive lines are drawn',
        'When sibling groups and siblings are not sorted when loaded, they are sorted after loading',
        //'When female is double married, both husbands are displayed',
        //'When male is double married, both wives are displayed',
        //'When extended marriages have secondary marriage, they are chained based on the second marriage',
        //'When second wife of male has first spouse, that first spouse is also displayed',
        //'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage',
        //'When older parents have younger children, children are sorted by parents first instead of birthDates',
        //'When female is loaded first, her first husband is still loaded',
        //'When children have common parents, they are displayed in separate sibling groups',
        //'When parents are orphans on the second level, they are sorted by birthDates',
        //'When extended marriage male has default birthDate, use female birthDate for sorting',
        //'When ancestors depth and descedants depth are both 2, generations until those levels are displayed'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }
}

async function addTest(treeDiagramsDiv, testsContext, testTitle) {
    const orderedTestTitle = `${testsContext.testIndex++}. ${testsContext.testPrefix} - ${testTitle}`;
    const testTitleH2 = createHiddenH2(orderedTestTitle);
    treeDiagramsDiv.append(testTitleH2);
    await fadeInElement(testTitleH2);

    testsContext.personId += testsContext.personIdBuffer;

    const titleOriginalTree = createHiddenH3('Original tree');
    treeDiagramsDiv.append(titleOriginalTree);
    await fadeInElement(titleOriginalTree);
    await createAndDisplayTreeDiagram(treeDiagramsDiv, testsContext.personId, treeTypes.COMPLETE, -1, -1);

    //const titleResultTree = createHiddenH3('Result tree');
    //treeDiagramsDiv.append(titleResultTree);
    //await fadeInElement(titleResultTree);
    //await createAndDisplayTreeDiagram(treeDiagramsDiv, testsContext.personId, testsContext.treeType);
}