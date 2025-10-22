function drawMarriagesChildrenPaths(pathsContainer, nodePathsVerticalOffset, largestGenerationSize, childrenGeneration, marriageNodes, childNodes) {
    pathsContainer.clientRect = pathsContainer.get(0).getBoundingClientRect();
    const offsetOnTop = { value: (1 + ((largestGenerationSize - childrenGeneration.generationSize) * 0.5)) * nodePathsVerticalOffset };

    marriageNodes.filter('.marriage-node').each((_, marriageNode) => {
        drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageNode, childNodes);
    });
}

function drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageNode, childNodes) {
    const inversebiologicalParentIds = $(marriageNode).data('inverseBiologicalParentIds');
    const inverseAdoptiveParentIds = $(marriageNode).data('inverseAdoptiveParentIds');
    const inverseParentIds = inversebiologicalParentIds.concat(inverseAdoptiveParentIds);

    const targetChildNodes = [];

    marriageNode.clientRect = marriageNode.getBoundingClientRect();
    marriageNode.clientRectHorizontalCenter = marriageNode.clientRect.left + (marriageNode.clientRect.width / 2);

    childNodes.each((_, childNode) => {
        const childId = parseInt($(childNode).attr('id'));

        if (inverseParentIds.includes(childId)) {
            childNode.clientRect = childNode.getBoundingClientRect();
            childNode.clientRectHorizontalCenter = childNode.clientRect.left + (childNode.clientRect.width / 2);
            childNode.isBiological = inversebiologicalParentIds.includes(childId);

            targetChildNodes.push(childNode);
        }
    });

    const leftChildNodes = targetChildNodes.filter(chilNode => chilNode.clientRectHorizontalCenter <= marriageNode.clientRectHorizontalCenter);
    const rightChildNodes = targetChildNodes.filter(chilNode => chilNode.clientRectHorizontalCenter > marriageNode.clientRectHorizontalCenter);

    leftChildNodes.forEach(childNode => {
        drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageNode, childNode, offsetOnTop.value += nodePathsVerticalOffset);
    });

    rightChildNodes.reverse().forEach(childNode => {
        drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageNode, childNode, offsetOnTop.value += nodePathsVerticalOffset);
    });
}

function drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageNode, childNode, verticalOffset) {

    let marriageNodeHorizontalCenter = marriageNode.clientRect.left + marriageNode.clientRect.width / 2 - pathsContainer.clientRect.left;
    let marriageNodeBottom = marriageNode.clientRect.top + marriageNode.clientRect.height - pathsContainer.clientRect.top;
    let childNodeHorizontalCenter = childNode.clientRect.left + childNode.clientRect.width / 2 - pathsContainer.clientRect.left;
    let childNodeTop = childNode.clientRect.top - pathsContainer.clientRect.top;

    let verticalCenter;
    if ($(marriageNode).hasClass('floating-marriage-node')) {
        const hiddenMarriageNodeClientRect = $(marriageNode).siblings('.hidden-marriage-node').get(0).getBoundingClientRect();
        const hiddenMarriageNodeBottom = hiddenMarriageNodeClientRect.top + hiddenMarriageNodeClientRect.height - pathsContainer.clientRect.top
        verticalCenter = hiddenMarriageNodeBottom + verticalOffset;
    } else {
        verticalCenter = marriageNodeBottom + verticalOffset;
    }

    const hasBiologicalChildren = $(marriageNode).data('inverseBiologicalParentIds').length > 0;
    const hasAdoptiveChildren = $(marriageNode).data('inverseAdoptiveParentIds').length > 0;

    if (hasBiologicalChildren && hasAdoptiveChildren) {
        marriageNodeHorizontalCenter += childNode.isBiological ? (-nodePathsVerticalOffset / 2) : (nodePathsVerticalOffset / 2);
    }

    // Szabi: what happens if child has only one parent?
    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents) {
        childNodeHorizontalCenter += childNode.isBiological ? (-nodePathsVerticalOffset / 2) : (nodePathsVerticalOffset / 2);
    }

    const pathData = `
        M ${r1(marriageNodeHorizontalCenter)},${r1(marriageNodeBottom)}
        L ${r1(marriageNodeHorizontalCenter)},${r1(verticalCenter)}
        L ${r1(childNodeHorizontalCenter)},${r1(verticalCenter)}
        L ${r1(childNodeHorizontalCenter)},${r1(childNodeTop)}
    `;

    // create the actual path
    // and another thicker one to be used for hovering
    createPathAndInteractive(treeHtmlCreator.createMarriageChildPath(pathData, childNode.isBiological), pathsContainer);
}

// Szabi: rename this
const r1 = v => v.toFixed(1);

function drawMarriagesPaths(pathsContainer, marriageNodes) {
    pathsContainer.clientRect = pathsContainer.get(0).getBoundingClientRect();

    marriageNodes.filter('.floating-marriage-node').each((_, marriageNode) => {
        drawMarriagePaths(pathsContainer, marriageNode);
    });
}

function drawMarriagePaths(pathsContainer, marriageNode) {
    const marriageClientRect = marriageNode.getBoundingClientRect();

    const marriageNodeStyle = window.getComputedStyle(marriageNode);
    const marginLeft = parseFloat(marriageNodeStyle.marginLeft) || 0;
    const marginRight = parseFloat(marriageNodeStyle.marginRight) || 0;

    const y = marriageClientRect.top + marriageClientRect.height / 2 - pathsContainer.clientRect.top;

    const x1 = marriageClientRect.left - marginLeft - pathsContainer.clientRect.left;
    const x2 = x1 + marginLeft;

    const x3 = marriageClientRect.left + marriageClientRect.width - pathsContainer.clientRect.left;
    const x4 = x3 + marginRight;

    const pathData = `
        M ${r1(x1)},${r1(y)} L ${r1(x2)},${r1(y)}
        M ${r1(x3)},${r1(y)} L ${r1(x4)},${r1(y)}
    `;

    pathsContainer.append(treeHtmlCreator.createMarriagePath(pathData));
}

function drawDuplicatedPersonPaths(pathsContainer, duplicatedPersonNodes) {
    pathsContainer.clientRect = pathsContainer.get(0).getBoundingClientRect();
    for (const [id, nodes] of duplicatedPersonNodes.entries()) {

        for (let i = 0; i < nodes.length - 1; i++) {
            let nodeTop = nodes[i];
            let nodeBottom = nodes[i + 1];

            if (nodeTop.getBoundingClientRect().top > nodeBottom.getBoundingClientRect().top) {
                nodeTop = nodes[i + 1];
                nodeBottom = nodes[i];
            }

            const rectTop = nodeTop.getBoundingClientRect();
            const rectBottom = nodeBottom.getBoundingClientRect();

            // Calculate center points relative to pathsContainer
            const containerRect = pathsContainer.clientRect;

            const x1 = rectTop.left + rectTop.width / 2 - containerRect.left;
            const y1 = rectTop.bottom - containerRect.top;

            const x2 = rectBottom.left + rectBottom.width / 2 - containerRect.left;
            const y2 = rectBottom.top - containerRect.top;

            // Create simple line path from (x1,y1) to (x2,y2)
            const pathData = `M ${x1},${y1} L ${x2},${y2}`;
            createPathAndInteractive(treeHtmlCreator.createDuplicatedPersonPath(pathData), pathsContainer);
        }
    }
}

function createPathAndInteractive(path, pathsContainer) {
    // create the actual path
    // and another thicker one to be used for hovering
    const interactivePath =
        path
            .clone()
            .attr('class', 'path-interactive');

    pathsContainer.append(interactivePath);
    pathsContainer.append(path);
}