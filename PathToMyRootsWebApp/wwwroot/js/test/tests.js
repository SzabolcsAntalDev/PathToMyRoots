const personIdBuffer = 40;
let testsResultsMap;
const saveTestResults = false;

$(() => {
    (async () => {

        if (saveTestResults) {
            testsResultsMap = new Map();
        }
        else {
            const response = await fetch('/js/test/expected-results.json');
            const testsResultsJson = await response.json();
            testsResultsMap = new Map(Object.entries(testsResultsJson));
        }

        const treeDiagramsDiv = $('#tree-diagrams-div');
        treeDiagramsDiv.addClass('test-trees-div');

        const testLinesDiv = $('#test-lines-div');

        const hourglassCommonTestContexts = getHourglassCommonTestContexts();
        const hourglassBiologicalTestContexts = getHourglassBiologicalTestContexts();
        const hourglassExtendedTestContexts = getHourglassExtendedTestContexts();
        const completeTestContexts = getCompleteTestContexts();

        const testNumber = { value: 0 };
        await addTestLines(testNumber, testLinesDiv, hourglassCommonTestContexts);
        await addTestLines(testNumber, testLinesDiv, hourglassBiologicalTestContexts);
        await addTestLines(testNumber, testLinesDiv, hourglassExtendedTestContexts);
        await addTestLines(testNumber, testLinesDiv, completeTestContexts);

        testNumber.value = 0;
        for (const testContext of
            hourglassCommonTestContexts
                .concat(hourglassBiologicalTestContexts)
                .concat(hourglassExtendedTestContexts)
                .concat(completeTestContexts)) {
            await runTest(testNumber, treeDiagramsDiv, testLinesDiv, testContext);
        }

        if (saveTestResults) {
            const testsResultsObj = Object.fromEntries(testsResultsMap);
            const testsResultsJson = JSON.stringify(testsResultsObj, null, 2);

            // go to Chrome, enter the testsResultsJson into the Watch
            // right click on the value and select Copy string contents
            const toSave = testsResultsJson;
        }
    })();
});

async function addTestLines(testNumber, testLinesDiv, testContexts) {
    const testGroupTitleH2 = testsHtmlCreator.createHiddenH2(testContexts[0].testPrefix);
    testLinesDiv.append(testGroupTitleH2);
    await fadeInElement(testGroupTitleH2);

    for (const testContext of testContexts) {
        testNumber.value++;

        const testLineDiv = testsHtmlCreator.createHiddenTestLineDiv(testContext.personId);
        const testIcon = testsHtmlCreator.createIcon('pending');
        const testTitleP = testsHtmlCreator.createP(`${testNumber.value}. ${testContext.testTitle}`);

        testLineDiv.append(testIcon);
        testLineDiv.append(testTitleP);
        testLinesDiv.append(testLineDiv);

        await fadeInElement(testLineDiv);
    };
}

function getHourglassCommonTestContexts() {
    const personIdStart = 1000;
    let personId = personIdStart;
    const testPrefix = 'Hourglass-common';
    const treeType = treeTypes.HOURGLASS_BIOLOGICAL;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When male has two wives, both wives are displayed, and husbands of wives are not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When female has two husbands, both husbands are displayed, and wives of husbands are not displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function getHourglassBiologicalTestContexts() {
    const personIdStart = 2000;
    let personId = personIdStart;
    const testPrefix = treeTypes.HOURGLASS_BIOLOGICAL.displayName;
    const treeType = treeTypes.HOURGLASS_BIOLOGICAL;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When only male ancestors are present, fake ancestors are added' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When only female ancestors are present, fake ancestors are added' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has siblings from multiple parents, only parents of biological parents are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are second married and person does not have siblings, other spouses of parents are not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are second married and person has siblings from other spouse of mother side, other spouse of father is not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are second married and person has siblings from other spouse of father side, other spouse of mother is not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are second married and person has siblings from other spouses of parents, other spouses are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are first married and person does not have siblings, other spouses of parents are not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are first married and person has siblings from other spouse of mother side, other spouse of father is not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are first married and person has siblings from other spouse of father side, other spouse of mother is not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are first married and person has siblings from other spouses of parents, other spouses are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has multiple spouses and siblings, they are all displayed and sorted in his/her generation' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has multiple children, children are sorted by their birthDates' },
        { ancestorsDepth: 2, descedantsDepth: 2, testTitle: 'When ancestors and descedants depth are both 2, generations until those levels are displayed' },
        { ancestorsDepth: 0, descedantsDepth: 0, testTitle: 'When ancestors depth is 0, siblings of person are not displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function getHourglassExtendedTestContexts() {
    const personIdStart = 3000;
    let personId = personIdStart;
    const testPrefix = treeTypes.HOURGLASS_EXTENDED.displayName;
    const treeType = treeTypes.HOURGLASS_EXTENDED;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When ancestors have multiple spouses, their spouses are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When ancestors have adoptive parents, the ancestors of the adoptive parents are not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has biological siblings, they and their spouses and displayed and sorted by birthDates' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has adoptive siblings, they and their spouses and displayed and sorted by birthDates' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has adoptive descedants, its descedants are not displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When person has biological and adoptive descedants, they are all displayed and sorted by birthDates' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents of adoptive parents are displayed, lines are not drawn between them' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When grandchild is adopted by siblings and first sibling is the biological parent, grandchild is displayed only once' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When grandchild is adopted by siblings and first sibling is the adoptive parent, grandchild is displayed only once' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When sibling is adopting child of person, adoptive line is omitted' },
        { ancestorsDepth: 2, descedantsDepth: 2, testTitle: 'When ancestors and descedants depth are both 2, generations until those levels are displayed' },
        { ancestorsDepth: 0, descedantsDepth: 0, testTitle: 'When ancestors depth is 0, siblings of person are not displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function getCompleteTestContexts() {
    const personIdStart = 4000;
    let personId = personIdStart;
    const testPrefix = treeTypes.COMPLETE.displayName;
    const treeType = treeTypes.COMPLETE;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When a person has a three generation family, generations are displayed on three levels' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When child has biological and adoptive parents, biological and adoptive lines are drawn' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When sibling groups and siblings are not sorted when loaded, they are sorted after loading' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When female is double married, both husbands are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When male is double married, both wives are displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When extended marriages have secondary marriage, they are chained based on the second marriage' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When second wife of male has first spouse, that first spouse is also displayed' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When older parents have younger children, children are sorted by parents first instead of birthDates' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When female is loaded first, her first husband is still loaded' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When children have common parents, they are displayed in separate sibling groups' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When parents are orphans on the second level, they are sorted by birthDates' },
        { ancestorsDepth: allRelativesDepthIndex, descedantsDepth: allRelativesDepthIndex, testTitle: 'When extended marriage male has default birthDate, use female birthDate for sorting' },
        { ancestorsDepth: 2, descedantsDepth: 2, testTitle: 'When ancestors and descedants depth are both 2, generations until those levels are displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function createTestContext(testTitle, personId, testPrefix, treeType, ancestorsDepth, descedantsDepth) {
    return {
        testTitle: testTitle,
        personId: personId,
        testPrefix: testPrefix,
        treeType: treeType,
        ancestorsDepth: ancestorsDepth,
        descedantsDepth: descedantsDepth
    };
}

async function runTest(testNumber, treeDiagramsDiv, testLinesDiv, testContext) {
    testNumber.value++;
    const orderedTestTitle = `${testNumber.value}. ${testContext.testPrefix} - ${testContext.testTitle}`;
    const testTitleH2 = testsHtmlCreator.createHiddenH2(orderedTestTitle);
    treeDiagramsDiv.append(testTitleH2);
    await fadeInElement(testTitleH2);

    const originalDiagramFrameIdSuffix = testContext.personId + '-original';
    const resultDiagramFrameIdSuffix = testContext.personId + '-result';

    if (testContext.treeType != treeTypes.COMPLETE) {
        const titleOriginalTree = testsHtmlCreator.createHiddenH3('Original tree');
        treeDiagramsDiv.append(titleOriginalTree);
        await fadeInElement(titleOriginalTree);
        await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testContext.personId, originalDiagramFrameIdSuffix, treeTypes.COMPLETE, allRelativesDepthIndex, allRelativesDepthIndex, viewModes.SMALL);
    }

    const titleResultTree = testsHtmlCreator.createHiddenH3('Result tree');
    treeDiagramsDiv.append(titleResultTree);
    await fadeInElement(titleResultTree);
    await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testContext.personId, resultDiagramFrameIdSuffix, testContext.treeType, testContext.ancestorsDepth, testContext.descedantsDepth, viewModes.SMALL);

    const diagramFrame = treeDiagramsDiv.find('#diagram-frame-' + resultDiagramFrameIdSuffix);
    const diagramHtml = diagramFrame.find('.diagram').html();

    if (saveTestResults) {
        testsResultsMap.set(resultDiagramFrameIdSuffix, diagramHtml);
    }
    else {
        const expectedHtml = testsResultsMap.get(resultDiagramFrameIdSuffix);
        const resultIcon = testsHtmlCreator.createIcon((expectedHtml == diagramHtml) ? 'success' : 'error');
        hideElement(resultIcon);
        const pendingIcon = testLinesDiv.find('#' + testContext.personId).find('div.pending-svg-div');

        await fadeOutElement(pendingIcon);
        pendingIcon.replaceWith(resultIcon)
        await fadeInElement(resultIcon);
    }
}