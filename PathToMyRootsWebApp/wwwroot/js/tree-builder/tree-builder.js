const linesVerticalOffset = 10;

const apiUrl = "https://localhost:7241/api/person/";
const imageApiUrl = "https://localhost:7241/";

async function removeTreeDiagram(personId) {
    const loadingTextContainer = document.getElementById("loading-text-container");
    if (loadingTextContainer)
        fadeInElement(loadingTextContainer);

    const nodesAndLinesContainer = document.getElementById('tree-diagram-and-lines-container' + personId);
    if (nodesAndLinesContainer) {
        await fadeOutElement(nodesAndLinesContainer)
        nodesAndLinesContainer.remove();
    }
}

async function createAndDisplayTreeDiagram(personId) {
    // create container with nodes and lines containers
    const treeContainer = $('#tree-container');
    const loadingTextContainer = getOrCreateLoadingTextContainer(treeContainer);
    fadeInElement(loadingTextContainer);

    const nodesContainer = createNodesContainer();
    const linesContainer = createLinesContainer();
    const nodesAndLinesContainer = createHiddenNodesAndLinesContainer(personId);

    nodesAndLinesContainer.append(nodesContainer);
    nodesAndLinesContainer.append(linesContainer);

    treeContainer.append(nodesAndLinesContainer);

    await buildTree(nodesContainer, linesContainer);

    // Szabi: this doesn't work
    //scrollToMiddle(nodesAndLinesContainer, nodesContainerDom);

    fadeOutElement(loadingTextContainer);
    fadeInElement(nodesAndLinesContainer);
}

async function buildTree(nodesContainer, linesContainer) {
    const levelIndexesToRowsMap = new Map();

    await createRowsFrom(personId, new Set([null]), levelIndexesToRowsMap, 0);
    sortByBirthdates(levelIndexesToRowsMap);

    let maxNumberOfChildrenWithParentsOnRows = getMaxNumberOfChildrenWithParentsOnRows(levelIndexesToRowsMap);
    const descSortedLevelIndexes = [...levelIndexesToRowsMap.keys()]
        .map(Number)
        .sort((a, b) => b - a);

    sortByParents(nodesContainer, levelIndexesToRowsMap, descSortedLevelIndexes);

    // set bottom padding to each child except the last one
    // Szabi: delete all unused indexes from the js files
    const rows = nodesContainer.find(".tree-level-row");
    rows.each((index, row) => {
        if (index !== rows.length - 1) {
            $(row).css('padding', "0px 0px " + ((maxNumberOfChildrenWithParentsOnRows + 3) * linesVerticalOffset) + "px 0px");
        }
    });

    const nodesContainerDom = nodesContainer.get(0);

    // draw lines
    const treeNodesContainerStyle = window.getComputedStyle(nodesContainerDom);
    const treeNodesContainerWidth = nodesContainerDom.offsetWidth || parseFloat(treeNodesContainerStyle.width);
    const treeNodesContainerHeight = nodesContainerDom.offsetHeight || parseFloat(treeNodesContainerStyle.height);

    linesContainer.css('width', `${treeNodesContainerWidth}px`);
    linesContainer.css('height', `${treeNodesContainerHeight}px`);

    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = $(rows[i - 1]);
        const childrenRowInner = $(rows[i]);

        await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxNumberOfChildrenWithParentsOnRows);
    }
}

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}