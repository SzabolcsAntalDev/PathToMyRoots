async function buildTree(nodesContainer, linesContainer, personId) {
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