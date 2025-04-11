function drawMarriageLines(linesContainer, marriageNode) {
    const marriageRect = marriageNode.getBoundingClientRect();
    const linesContainerClientRect = linesContainer.get(0).getBoundingClientRect();

    const computedStyle = window.getComputedStyle(marriageNode);
    const marginLeft = parseFloat(computedStyle.marginLeft) || 0;
    const marginRight = parseFloat(computedStyle.marginRight) || 0;

    const y = marriageRect.top + marriageRect.height / 2 - linesContainerClientRect.top;

    const x1 = marriageRect.left - marginLeft - linesContainerClientRect.left;
    const x2 = x1 + marginLeft;

    const x3 = marriageRect.left + marriageRect.width - linesContainerClientRect.left;
    const x4 = x3 + marginRight;

    const pathData = `
        M ${x1},${y} L ${x2},${y}
        M ${x3},${y} L ${x4},${y}
    `;

    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', 'tree-line-marriage-svg');

    linesContainer.append(path);
}

function drawChildLine(linesContainer, marriageNode, child, verticalOffset, isBiological) {
    const marriageRect = marriageNode.getBoundingClientRect();
    const childRect = child.getBoundingClientRect();

    const linesContainerClientRect = linesContainer.get(0).getBoundingClientRect();

    const hasBiologicalChildren = marriageNode.inverseBiologicalParents.length > 0;
    const hasAdoptiveChildren = marriageNode.inverseAdoptiveParents.length > 0;

    let marriageX = marriageRect.left + marriageRect.width / 2 - linesContainerClientRect.left;
    const marriageY = marriageRect.top + marriageRect.height - linesContainerClientRect.top;
    let childX = childRect.left + childRect.width / 2 - linesContainerClientRect.left;
    const childY = childRect.top - linesContainerClientRect.top;
    const middleY = marriageY + verticalOffset;

    if (hasBiologicalChildren && hasAdoptiveChildren)
        marriageX += isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);

    const hasBiologicalParents = child.biologicalFatherId != null && child.biologicalMotherId != null;
    const hasAdoptiveParents = child.adoptiveFatherId != null && child.adoptiveMotherId != null;

    if (hasBiologicalParents && hasAdoptiveParents)
        childX += isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);

    const pathData = `
        M ${marriageX},${marriageY}
        L ${marriageX},${middleY}
        L ${childX},${middleY}
        L ${childX},${childY}
    `;

    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', isBiological ? 'tree-line-biological-svg' : 'tree-line-adoptive-svg');

    linesContainer.append(path);
}