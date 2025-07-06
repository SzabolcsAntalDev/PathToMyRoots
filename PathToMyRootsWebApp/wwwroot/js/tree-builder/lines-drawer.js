function drawMarriagesChildrenLines(linesContainer, nodeLinesVerticalOffset, largestGenerationSize, childrenGeneration, marriageNodes, childNodes) {
    linesContainer.clientRect = linesContainer.get(0).getBoundingClientRect();
    const offsetOnTop = { value: (1 + ((largestGenerationSize - childrenGeneration.generationSize) * 0.5)) * nodeLinesVerticalOffset };

    marriageNodes.filter('.marriage-node').each((_, marriageNode) => {
        drawMarriageChildrenLines(linesContainer, nodeLinesVerticalOffset, offsetOnTop, marriageNode, childNodes);
    });
}

function drawMarriageChildrenLines(linesContainer, nodeLinesVerticalOffset, offsetOnTop, marriageNode, childNodes) {
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
        drawMarriageChildLine(linesContainer, nodeLinesVerticalOffset, marriageNode, childNode, offsetOnTop.value += nodeLinesVerticalOffset);
    });

    rightChildNodes.reverse().forEach(childNode => {
        drawMarriageChildLine(linesContainer, nodeLinesVerticalOffset, marriageNode, childNode, offsetOnTop.value += nodeLinesVerticalOffset);
    });
}

function drawMarriageChildLine(linesContainer, nodeLinesVerticalOffset, marriageNode, childNode, verticalOffset) {

    let marriageNodeHorizontalCenter = marriageNode.clientRect.left + marriageNode.clientRect.width / 2 - linesContainer.clientRect.left;
    let marriageNodeBottom = marriageNode.clientRect.top + marriageNode.clientRect.height - linesContainer.clientRect.top;
    let childNodeHorizontalCenter = childNode.clientRect.left + childNode.clientRect.width / 2 - linesContainer.clientRect.left;
    let childNodeTop = childNode.clientRect.top - linesContainer.clientRect.top;

    let verticalCenter;
    if ($(marriageNode).hasClass('floating-marriage-node')) {
        const hiddenMarriageNodeClientRect = $(marriageNode).siblings('.hidden-marriage-node').get(0).getBoundingClientRect();
        const hiddenMarriageNodeBottom = hiddenMarriageNodeClientRect.top + hiddenMarriageNodeClientRect.height - linesContainer.clientRect.top
        verticalCenter = hiddenMarriageNodeBottom + verticalOffset;
    } else {
        verticalCenter = marriageNodeBottom + verticalOffset;
    }

    const hasBiologicalChildren = $(marriageNode).data('inverseBiologicalParentIds').length > 0;
    const hasAdoptiveChildren = $(marriageNode).data('inverseAdoptiveParentIds').length > 0;

    if (hasBiologicalChildren && hasAdoptiveChildren) {
        marriageNodeHorizontalCenter += childNode.isBiological ? (-nodeLinesVerticalOffset / 2) : (nodeLinesVerticalOffset / 2);
    }

    // Szabi: what happens if child has only one parent?
    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents) {
        childNodeHorizontalCenter += childNode.isBiological ? (-nodeLinesVerticalOffset / 2) : (nodeLinesVerticalOffset / 2);
    }

    const pathData = `
        M ${r1(marriageNodeHorizontalCenter)},${r1(marriageNodeBottom)}
        L ${r1(marriageNodeHorizontalCenter)},${r1(verticalCenter)}
        L ${r1(childNodeHorizontalCenter)},${r1(verticalCenter)}
        L ${r1(childNodeHorizontalCenter)},${r1(childNodeTop)}
    `;

    // create the actual path
    // and another thicker one to be used for hovering
    const marriageChildPath = treeHtmlCreator.createMarriageChildPath(pathData, childNode.isBiological);
    const marriageChildPathInteractive =
        marriageChildPath
            .clone()
            .attr('class', 'path-interactive');
    
    linesContainer.append(marriageChildPathInteractive);
    linesContainer.append(marriageChildPath);
}

const r1 = v => v.toFixed(1);

function drawMarriagesLines(linesContainer, marriageNodes) {
    linesContainer.clientRect = linesContainer.get(0).getBoundingClientRect();

    marriageNodes.filter('.floating-marriage-node').each((_, marriageNode) => {
        drawMarriageLines(linesContainer, marriageNode);
    });
}

function drawMarriageLines(linesContainer, marriageNode) {
    const marriageClientRect = marriageNode.getBoundingClientRect();

    const marriageNodeStyle = window.getComputedStyle(marriageNode);
    const marginLeft = parseFloat(marriageNodeStyle.marginLeft) || 0;
    const marginRight = parseFloat(marriageNodeStyle.marginRight) || 0;

    const y = marriageClientRect.top + marriageClientRect.height / 2 - linesContainer.clientRect.top;

    const x1 = marriageClientRect.left - marginLeft - linesContainer.clientRect.left;
    const x2 = x1 + marginLeft;

    const x3 = marriageClientRect.left + marriageClientRect.width - linesContainer.clientRect.left;
    const x4 = x3 + marginRight;

    const pathData = `
        M ${r1(x1)},${r1(y)} L ${r1(x2)},${r1(y)}
        M ${r1(x3)},${r1(y)} L ${r1(x4)},${r1(y)}
    `;

    linesContainer.append(treeHtmlCreator.createMarriagePath(pathData));
}