async function drawLines(linesContainer, largestGenerationSize, childrenGeneration, marriageNodes, childNodes) {
    linesContainer.rect = linesContainer.get(0).getBoundingClientRect();
    const offsetOnTop = { value: (1 + ((largestGenerationSize - childrenGeneration.generationSize) * 0.5)) * linesVerticalOffset };

    //.attr('class', `tree-node-marriage ${marriage.isMainMarriage ? 'main-marriage' : 'left-marriage'}`)
    marriageNodes.filter('.main-marriage').each((_, marriageNode) => {
        someFunc(linesContainer, offsetOnTop, marriageNode, childNodes);
    });
}

function someFunc(linesContainer, offsetOnTop, marriageNode, childNodes) {
    const inversebiologicalParentIds = $(marriageNode).data('inverseBiologicalParentIds');
    const inverseAdoptiveParentIds = $(marriageNode).data('inverseAdoptiveParentIds');
    const inverseParentIds = inversebiologicalParentIds.concat(inverseAdoptiveParentIds);

    const childNodesToDraw = [];

    marriageNode.rect = marriageNode.getBoundingClientRect();
    marriageNode.rectHorizontalCenter = marriageNode.rect.left + (marriageNode.rect.width / 2);

    childNodes.each((_, childNode) => {
        const childId = parseInt($(childNode).attr('id'));

        if (inverseParentIds.includes(childId)) {
            childNode.rect = childNode.getBoundingClientRect();
            childNode.rectHorizontalCenter = childNode.rect.left + (childNode.rect.width / 2);
            childNode.isBiological = inversebiologicalParentIds.includes(childId);

            childNodesToDraw.push(childNode);
        }
    });

    // draw children to the left of the parent
    let leftChildrenCount = 0;
    childNodesToDraw.some(childNode => {
        if (marriageNode.rectHorizontalCenter < childNode.rectHorizontalCenter) {
            return true;
        }
        drawChildLine(linesContainer, marriageNode, childNode, offsetOnTop.value += linesVerticalOffset);
        leftChildrenCount++;
        return false;
    });

    // draw children to the right of the parent
    childNodesToDraw
        .slice(leftChildrenCount)
        .reverse()
        .forEach(childNode => {
            drawChildLine(linesContainer, marriageNode, childNode, offsetOnTop.value += linesVerticalOffset);
        });
}

function drawChildLine(linesContainer, marriageNode, childNode, verticalOffset) {
    let marriageNodeHorizontalCenter = marriageNode.rect.left + marriageNode.rect.width / 2 - linesContainer.rect.left;
    const marriageNodeBottom = marriageNode.rect.top + marriageNode.rect.height - linesContainer.rect.top;
    let childNodeHorizontalCenter = childNode.rect.left + childNode.rect.width / 2 - linesContainer.rect.left;
    const childNodeTop = childNode.rect.top - linesContainer.rect.top;
    const verticalCenter = marriageNodeBottom + verticalOffset;

    const hasBiologicalChildren = $(marriageNode).data('inverseBiologicalParentIds').length > 0;
    const hasAdoptiveChildren = $(marriageNode).data('inverseAdoptiveParentIds').length > 0;

    if (hasBiologicalChildren && hasAdoptiveChildren) {
        marriageNodeHorizontalCenter += childNode.isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);
    }

    // Szabi: what happens if child has only one parent?
    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents)
        childNodeHorizontalCenter += childNode.isBiological ? (-linesVerticalOffset / 2) : (linesVerticalOffset / 2);

    const pathData = `
        M ${marriageNodeHorizontalCenter},${marriageNodeBottom}
        L ${marriageNodeHorizontalCenter},${verticalCenter}
        L ${childNodeHorizontalCenter},${verticalCenter}
        L ${childNodeHorizontalCenter},${childNodeTop}
    `;

    // Szabi: jquery
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', childNode.isBiological ? 'tree-line-biological-svg' : 'tree-line-adoptive-svg');

    linesContainer.append(path);
}

function drawMarriageLines(linesContainer, marriageNode) {
    const marriageRect = marriageNode.get(0).getBoundingClientRect();
    const linesContainerClientRect = linesContainer.get(0).getBoundingClientRect();

    const computedStyle = window.getComputedStyle(marriageNode.get(0));
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