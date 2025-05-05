function drawMarriagesChildrenLines(linesContainer, largestGenerationSize, childrenGeneration, marriageNodes, childNodes) {
    linesContainer.clientRect = linesContainer.get(0).getBoundingClientRect();
    const offsetOnTop = { value: (1 + ((largestGenerationSize - childrenGeneration.generationSize) * 0.5)) * linesVerticalOffset };

    marriageNodes.filter('.marriage-node').each((_, marriageNode) => {
        drawMarriageChildrenLines(linesContainer, offsetOnTop, marriageNode, childNodes);
    });
}

function drawMarriagesLines(linesContainer, marriageNodes) {
    linesContainer.clientRect = linesContainer.get(0).getBoundingClientRect();

    marriageNodes.filter('.floating-marriage-node').each((_, marriageNode) => {
        drawMarriageLines(linesContainer, marriageNode);
    });
}

function drawMarriageChildrenLines(linesContainer, offsetOnTop, marriageNode, childNodes) {
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
        drawMarriageChildLine(linesContainer, marriageNode, childNode, offsetOnTop.value += linesVerticalOffset);
    });

    rightChildNodes.reverse().forEach(childNode => {
        drawMarriageChildLine(linesContainer, marriageNode, childNode, offsetOnTop.value += linesVerticalOffset);
    });
}

function drawMarriageChildLine(linesContainer, marriageNode, childNode, verticalOffset) {

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
        marriageNodeHorizontalCenter += childNode.isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);
    }

    // Szabi: what happens if child has only one parent?
    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents) {
        childNodeHorizontalCenter += childNode.isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);
    }

    const pathData = `
        M ${marriageNodeHorizontalCenter},${marriageNodeBottom}
        L ${marriageNodeHorizontalCenter},${verticalCenter}
        L ${childNodeHorizontalCenter},${verticalCenter}
        L ${childNodeHorizontalCenter},${childNodeTop}
    `;

    linesContainer.append(treeHtmlCreator.createMarriageChildLinePath(pathData, childNode.isBiological));
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
        M ${x1},${y} L ${x2},${y}
        M ${x3},${y} L ${x4},${y}
    `;

    linesContainer.append(treeHtmlCreator.createMarriageLinePath(pathData));
}