async function createTreeDiagram(personId) {

    const treeDiagram = createTreeDiagramHtml(personId);

    const generationsData = await createGenerationsData(personId);
    const nodesContainer = createNodesContainerHtml(generationsData);

    treeDiagram.append(nodesContainer);
    return treeDiagram;

    //const nodesContainerDom = nodesContainer.get(0);

    //// draw lines
    //const treeNodesContainerStyle = window.getComputedStyle(nodesContainerDom);
    //const treeNodesContainerWidth = nodesContainerDom.offsetWidth || parseFloat(treeNodesContainerStyle.width);
    //const treeNodesContainerHeight = nodesContainerDom.offsetHeight || parseFloat(treeNodesContainerStyle.height);

    //linesContainer.css('width', `${treeNodesContainerWidth}px`);
    //linesContainer.css('height', `${treeNodesContainerHeight}px`);

    //for (let i = 1; i < rows.length; i++) {
    //    const parentsRowInner = $(rows[i - 1]);
    //    const childrenRowInner = $(rows[i]);

    //    await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxNumberOfChildrenWithParentsOnRows);
    //}
}