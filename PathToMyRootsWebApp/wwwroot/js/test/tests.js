const personIdBuffer = 40;
let testsResultsMap;
const saveTestResults = false;

$(() => {
    (async () => {

        addScrollButtonsListeners();

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

        const testProgressBarDivInner = $('#test-progress-bar-div-inner');
        const numberOfPendingTestsH3 = $('#number-of-pending-tests');
        const numberOfPassedTestsH3 = $('#number-of-passed-tests');
        const numberOfFailedTestsH3 = $('#number-of-failed-tests');

        const testLinesDiv = $('#test-lines-div');

        const hourglassBiologicalTestContexts = getHourglassBiologicalTestContexts();
        const hourglassExtendedTestContexts = getHourglassExtendedTestContexts();
        const completeTestContexts = getCompleteTestContexts();

        const totalNumberOfTests =
            hourglassBiologicalTestContexts.length +
            hourglassExtendedTestContexts.length +
            completeTestContexts.length;

        const testProgressContext =
        {
            totalNumberOfTests,
            testProgressBarDivInner,
            numberOfPendingTests: totalNumberOfTests,
            numberOfPendingTestsH3,
            numberOfPassedTests: 0,
            numberOfPassedTestsH3,
            numberOfFailedTests: 0,
            numberOfFailedTestsH3
        };
        updateTestProgressData(testProgressContext, 0);

        const testNumber = { value: 0 };
        await addTestLines(testNumber, testLinesDiv, hourglassBiologicalTestContexts);
        await addTestLines(testNumber, testLinesDiv, hourglassExtendedTestContexts);
        await addTestLines(testNumber, testLinesDiv, completeTestContexts);

        testNumber.value = 0;
        for (const testContext of
            hourglassBiologicalTestContexts
                .concat(hourglassExtendedTestContexts)
                .concat(completeTestContexts)) {
            await runTest(testNumber, treeDiagramsDiv, testLinesDiv, testContext, testProgressContext);
        }

        if (saveTestResults) {
            const testsResultsObj = Object.fromEntries(testsResultsMap);
            const testsResultsJson = JSON.stringify(testsResultsObj, null, 2);

            // debug: results of tests
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

function getHourglassBiologicalTestContexts() {
    const personIdStart = 5000;
    let personId = personIdStart;
    const testPrefix = treeTypes.HOURGLASS_BIOLOGICAL.displayName;
    const treeType = treeTypes.HOURGLASS_BIOLOGICAL;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When only male ancestors are present, fake ancestors are added' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When only female ancestors are present, fake ancestors are added' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has siblings from multiple parents, only ancestors of biological parents are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are second married and person does not have siblings, other spouses of parents are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are second married and person has sibling only from mothers first marriage, fathers first spouse is not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are second married and person has sibling from fathers first marriage, mothers first spouse is not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are second married and person has siblings from other spouses of parents, other spouses are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are first married and person does not have siblings, other spouses of parents are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are first married and person has sibling from mothers second marriage, fathers second spouse is not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are first married and person has sibling from fathers second marriage, mothers second spouse is not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are first married and person has siblings from other spouses of parents, other spouses are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When male has two wives, but has children only with the first wife, only the first wife and children is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When male has two wives, but has children only with the second wife, only the second wife and children is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When male has two wives, and has children with both, both wives and children are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When male has two wives, but has children with none of them, none of them is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female has two husbands, but has children only with the first husband, only the first husband and children is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female has two husbands, but has children only with the second husband, only the second husband and children is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female has two husbands, and has children with both, both husbands and children are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female has two husbands, but has children with none of them, none of them is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has sibling with spouses, he is displayed without his spouses and siblings are sorted' },
        { ancestorsDepth: 0, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When ancestors depth is 0, siblings of person are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has multiple children, children are sorted by their birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has child with spouse and they do not have children, child without spouse is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has child with spouse and they have children, child with spouse and their children is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: 1, testTitle: 'When person has child with spouse, they have children and descedants depth is 1, children without spouse is displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When children of descedants are married and do not have children, they are displayed only once and separately' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When children of descedants are married and have children, they are displayed only once and married' },
        { ancestorsDepth: 2, descedantsDepth: 2, testTitle: 'When ancestors and descedants depth are both 2, generations until those levels are displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function getHourglassExtendedTestContexts() {
    const personIdStart = 10000;
    let personId = personIdStart;
    const testPrefix = treeTypes.HOURGLASS_EXTENDED.displayName;
    const treeType = treeTypes.HOURGLASS_EXTENDED;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When ancestors have multiple spouses, their spouses are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When ancestors have adoptive parents, the ancestors of the adoptive parents are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents of adoptive parents are displayed, lines are drawn between them' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When adoptive grandparent has hidden biological child, adoptive line is horizontally centered' }, // Szabi
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has biological siblings, they and their spouses and displayed and sorted by birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has adoptive siblings, they and their spouses and displayed and sorted by birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has adoptive and biological siblings, they are all displayed' },
        { ancestorsDepth: 0, descedantsDepth: 0, testTitle: 'When ancestors depth is 0, siblings of person are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has adoptive descedants, its descedants are not displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When person has biological and adoptive descedants, they are all displayed and sorted by birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When sibling is adopting child of person, adoptive line is drawn' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When grandchild is adopted by siblings and first sibling is the biological parent, grandchild is displayed only once' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When children of descedants are married and have children, they are displayed only once and married' },
        { ancestorsDepth: 2, descedantsDepth: 2, testTitle: 'When ancestors and descedants depth are both 2, generations until those levels are displayed' }
    ];

    testsData.forEach(testData => {
        personId += personIdBuffer;
        testContexts.push(createTestContext(testData.testTitle, personId, testPrefix, treeType, testData.ancestorsDepth, testData.descedantsDepth));
    })

    return testContexts;
}

function getCompleteTestContexts() {
    const personIdStart = 15000;
    let personId = personIdStart;
    const testPrefix = treeTypes.COMPLETE.displayName;
    const treeType = treeTypes.COMPLETE;
    const testContexts = [];

    const testsData = [
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When a person has a three generation family, generations are displayed on three levels' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When child has biological and adoptive parents, biological and adoptive lines are drawn' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When sibling groups and siblings are not sorted when loaded, they are sorted after loading' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female is double married, both husbands are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When male is double married, both wives are displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When extended marriages have secondary marriage, they are chained based on the second marriage' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When second wife of male has first spouse, that first spouse is also displayed' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When secondary marriage has biological and adoptive children, biological and adoptive lines are drawn from secondary marriage' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When older parents have younger children, children are sorted by parents first instead of birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When female is loaded first, her first husband is still loaded' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When children have common parents, they are displayed in separate sibling groups' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When parents are orphans on the second level, they are sorted by birthDates' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When extended marriage male has default birthDate, use female birthDate for sorting' },
        { ancestorsDepth: relativesDepth.ALL.index, descedantsDepth: relativesDepth.ALL.index, testTitle: 'When marriage with male having unknown birthDate and null female, use unknown birthDate of male instead of null from female for sorting' },
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

async function runTest(testNumber, treeDiagramsDiv, testLinesDiv, testContext, testProgressContext) {
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
        await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testContext.personId, originalDiagramFrameIdSuffix, treeTypes.COMPLETE, relativesDepth.ALL.index, relativesDepth.ALL.index, viewModes.SMALL);
    }

    const titleResultTree = testsHtmlCreator.createHiddenH3('Result tree');
    treeDiagramsDiv.append(titleResultTree);
    await fadeInElement(titleResultTree);
    await createAndDisplayTreeDiagramFrame(treeDiagramsDiv, testContext.personId, resultDiagramFrameIdSuffix, testContext.treeType, testContext.ancestorsDepth, testContext.descedantsDepth, viewModes.SMALL);

    const diagramFrame = treeDiagramsDiv.find('#diagram-frame-' + resultDiagramFrameIdSuffix);
    const diagramHtml = diagramFrame.find('.diagram').html();

    if (saveTestResults) {
        testsResultsMap.set(resultDiagramFrameIdSuffix, diagramHtml);
        testProgressContext.numberOfPendingTests--;
    }
    else {
        const expectedHtml = testsResultsMap.get(resultDiagramFrameIdSuffix);

        if (expectedHtml == diagramHtml) {
            testProgressContext.numberOfPassedTests++;
        }
        else {
            testProgressContext.numberOfFailedTests++;
        }
        testProgressContext.numberOfPendingTests--;

        const resultIcon = testsHtmlCreator.createIcon((expectedHtml == diagramHtml) ? 'success' : 'error');
        hideElement(resultIcon);

        const testLineDiv = testLinesDiv.find('#' + testContext.personId);

        const pendingIcon = testLineDiv.find('div.svg-div-pending');
        await fadeOutElement(pendingIcon);
        pendingIcon.replaceWith(resultIcon)
        await fadeInElement(resultIcon);

        const scrollToTestButton = testsHtmlCreator.createScrollToTestButton(treeDiagramsDiv, testTitleH2);
        testLineDiv.append(scrollToTestButton);

        fadeInElement(scrollToTestButton);
    }

    updateTestProgressData(testProgressContext, testNumber.value)
}

function updateTestProgressData(testProgressContext, currentTestNumber) {
    testProgressContext.testProgressBarDivInner.css('width', ((100 / testProgressContext.totalNumberOfTests) * currentTestNumber) + '%');
    testProgressContext.numberOfPendingTestsH3.text(testProgressContext.numberOfPendingTests);
    testProgressContext.numberOfPassedTestsH3.text(testProgressContext.numberOfPassedTests);
    testProgressContext.numberOfFailedTestsH3.text(testProgressContext.numberOfFailedTests);
}