async function createTreeDiagram(personId) {

    //treeDiagramContainer.append(nodesContainer);
    //treeDiagramContainer.append(linesContainer);
    //treeDiagramsContainer.append(treeDiagramContainer);

    const generations = await createGenerations(personId);
    const nodesContainer = createNodesContainerHtml(generations);

    return nodesContainer;

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