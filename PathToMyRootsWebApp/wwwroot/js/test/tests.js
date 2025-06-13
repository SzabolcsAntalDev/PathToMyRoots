const personIdBuffer = 40;

$(() => {
    (async () => {
        const treeDiagramsDiv = $('#tree-diagrams-div');
        treeDiagramsDiv.addClass('test-trees-div');

        await addTreeTypeHourglassCommonTests(treeDiagramsDiv);
        await addTreeTypeHourglassBiologicalTests(treeDiagramsDiv);
        await addTreeTypeHourglassExtendedTests(treeDiagramsDiv);
        await addTreeTypeCompleteTests(treeDiagramsDiv);
    })();
});

async function addTreeTypeHourglassCommonTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 1000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: "Hourglass-common",
        treeType: treeTypes.HOURGLASS_BIOLOGICAL,
        ancestorsDepth: allRelativesDepthIndex,
        descedantsDepth: allRelativesDepthIndex
    };

    const tests = [
        'Generation0 - When male has two wives, both wives are displayed, and husbands of wives are not displayed',
        'Generation0 - When female has two husbands, both husbands are displayed, and wives of husbands are not displayed'
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
        testPrefix: treeTypes.HOURGLASS_BIOLOGICAL.displayName,
        treeType: treeTypes.HOURGLASS_BIOLOGICAL,
        ancestorsDepth: allRelativesDepthIndex,
        descedantsDepth: allRelativesDepthIndex
    };

    const tests = [
        'When only male ancestors are present, fake ancestors are added',
        'When only female ancestors are present, fake ancestors are added',
        'When person has siblings from multiple parents, only parents of biological parents are displayed',
        'When parents are second married and person does not have siblings, other spouses of parents are not displayed',
        'When parents are second married and person has siblings from other spouse of mother side, other spouse of father is not displayed',
        'When parents are second married and person has siblings from other spouse of father side, other spouse of mother is not displayed',
        'When parents are second married and person has siblings from other spouses of parents, other spouses are displayed',
        'When parents are first married and person does not have siblings, other spouses of parents are not displayed',
        'When parents are first married and person has siblings from other spouse of mother side, other spouse of father is not displayed',
        'When parents are first married and person has siblings from other spouse of father side, other spouse of mother is not displayed',
        'When parents are first married and person has siblings from other spouses of parents, other spouses are displayed',
        'When person has multiple spouses and siblings, they are all displayed and sorted in his/her generation',
        'When person has multiple children, children are sorted by their birthDates'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }

    testsContext.ancestorsDepth = 2;
    testsContext.descedantsDepth = 2;
    await addTest(treeDiagramsDiv, testsContext, 'When ancestors and descedants depth are both 2, generations until those levels are displayed');

    testsContext.ancestorsDepth = 0;
    testsContext.descedantsDepth = 0;
    await addTest(treeDiagramsDiv, testsContext, 'When ancestors depth is 0, siblings of person are not displayed');
}

async function addTreeTypeHourglassExtendedTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 3000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: treeTypes.HOURGLASS_EXTENDED.displayName,
        treeType: treeTypes.HOURGLASS_EXTENDED,
        ancestorsDepth: allRelativesDepthIndex,
        descedantsDepth: allRelativesDepthIndex
    };

    const tests = [
        'When ancestors have multiple spouses, their spouses are displayed',
        'When ancestors have adoptive parents, the ancestors of the adoptive parents are not displayed', // Szabi: complete tree is not working well in this case
        'When person has biological siblings, they and their spouses and displayed and sorted by birthDates',
        'When person has adoptive siblings, they and their spouses and displayed and sorted by birthDates',
        'When person has adoptive descedants, its descedants are not displayed',
        'When person has biological and adoptive descedants, they are all displayed and sorted by birthDates',
        'When parents of adoptive parents are displayed, lines are not drawn between them',
        'When grandchild is adopted by siblings and first sibling is the biological parent, grandchild is displayed only once',
        'When grandchild is adopted by siblings and first sibling is the adoptive parent, grandchild is displayed only once',
        'When sibling is adopting child of person, adoptive line is omitted'
    ];

    for (const testTitle of tests) {
        await addTest(treeDiagramsDiv, testsContext, testTitle);
    }

    testsContext.ancestorsDepth = 2;
    testsContext.descedantsDepth = 2;
    await addTest(treeDiagramsDiv, testsContext, 'When ancestors and descedants depth are both 2, generations until those levels are displayed');

    testsContext.ancestorsDepth = 0;
    testsContext.descedantsDepth = 0;
    await addTest(treeDiagramsDiv, testsContext, 'When ancestors depth is 0, siblings of person are not displayed');
}

async function addTreeTypeCompleteTests(treeDiagramsDiv) {
    const testsContext = {
        personId: 4000,
        personIdBuffer: personIdBuffer,
        testIndex: 1,
        testPrefix: treeTypes.COMPLETE.displayName,
        treeType: treeTypes.COMPLETE,
        ancestorsDepth: allRelativesDepthIndex,
        descedantsDepth: allRelativesDepthIndex
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

    testsContext.ancestorsDepth = 2;
    testsContext.descedantsDepth = 2;
    await addTest(treeDiagramsDiv, testsContext, 'When ancestors and descedants depth are both 2, generations until those levels are displayed');
}

async function addTest(treeDiagramsDiv, testsContext, testTitle) {
    const orderedTestTitle = `${testsContext.testIndex++}. ${testsContext.testPrefix} - ${testTitle}`;
    const testTitleH2 = createHiddenH2(orderedTestTitle);
    treeDiagramsDiv.append(testTitleH2);
    await fadeInElement(testTitleH2);

    testsContext.personId += testsContext.personIdBuffer;

    if (testsContext.treeType != treeTypes.COMPLETE) {
        const titleOriginalTree = createHiddenH3('Original tree');
        treeDiagramsDiv.append(titleOriginalTree);
        await fadeInElement(titleOriginalTree);
        await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testsContext.personId, treeTypes.COMPLETE, allRelativesDepthIndex, allRelativesDepthIndex, viewModes.SMALL);
    }

    const titleResultTree = createHiddenH3('Result tree');
    treeDiagramsDiv.append(titleResultTree);
    await fadeInElement(titleResultTree);
    await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testsContext.personId, testsContext.treeType, testsContext.ancestorsDepth, testsContext.descedantsDepth, viewModes.SMALL);
}