async function drawLines(linesContainer, parentsRow, childrenRow, maxChildrenWithParentsOnRows) {

    const numOfChildrensWithParentOnRow = getNumberOfChildrenWithParents(childrenRow);
    let offsetOnTop = (1 + ((maxChildrenWithParentsOnRows - numOfChildrensWithParentOnRow) * 0.5)) * linesVerticalOffset;

    let parentsNodesGroupContainers = parentsRow.find('.tree-nodes-group-container');
    parentsNodesGroupContainers.each((_, element) => {
        const parentsNodeGroupContainer = $(element);
        let leftMarriageNode = parentsNodeGroupContainer.find('.left-marriage');
        let mainMarriageNode = parentsNodeGroupContainer.find('.main-marriage');

        let oneTreeNodeRect =
            parentsNodeGroupContainer.find('.tree-node-male, .tree-node-female').first().get(0)
                .getBoundingClientRect();

        let leftMarriageBiologicalChildrenIds;
        let leftMarriageAdoptiveChildrenIds;
        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;

        if (leftMarriageNode.length) {
            leftMarriageBiologicalChildrenIds = leftMarriageNode.data('inverseBiologicalParents');
            leftMarriageAdoptiveChildrenIds = leftMarriageNode.data('inverseAdoptiveParents');
        }

        if (mainMarriageNode.length) {
            mainMarriageBiologicalChildrenIds = mainMarriageNode.data('inverseBiologicalParents');
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.data('inverseAdoptiveParents');
        }

        const mainMarriageBiologicalChildrenNodes = [];
        const mainMarriageAdoptiveChildrenNodes = [];
        const leftMarriageBiologicalChildrenNodes = [];
        const leftMarriageAdoptiveChildrenNodes = [];

        let childrenNodesGroupContainers = childrenRow.find('.tree-nodes-group-container');

        for (let childrenNodesGroupContainer of childrenNodesGroupContainers) {
            let childMaleNode = childrenNodesGroupContainer.querySelector('.tree-node-male');
            let childFemaleNode = childrenNodesGroupContainer.querySelector('.tree-node-female');

            let childMaleId = Number(childMaleNode?.id);
            let childFemaleId = Number(childFemaleNode?.id);

            if (mainMarriageBiologicalChildrenIds != null && mainMarriageBiologicalChildrenIds.includes(childMaleId))
                mainMarriageBiologicalChildrenNodes.push(childMaleNode);

            if (mainMarriageBiologicalChildrenIds != null && mainMarriageBiologicalChildrenIds.includes(childFemaleId))
                mainMarriageBiologicalChildrenNodes.push(childFemaleNode);

            if (mainMarriageAdoptiveChildrenIds != null && mainMarriageAdoptiveChildrenIds.includes(childMaleId))
                mainMarriageAdoptiveChildrenNodes.push(childMaleNode);

            if (mainMarriageAdoptiveChildrenIds != null && mainMarriageAdoptiveChildrenIds.includes(childFemaleId))
                mainMarriageAdoptiveChildrenNodes.push(childFemaleNode);


            if (leftMarriageBiologicalChildrenIds != null && leftMarriageBiologicalChildrenIds.includes(childMaleId))
                leftMarriageBiologicalChildrenNodes.push(childMaleNode);

            if (leftMarriageBiologicalChildrenIds != null && leftMarriageBiologicalChildrenIds.includes(childFemaleId))
                leftMarriageBiologicalChildrenNodes.push(childFemaleNode);

            if (leftMarriageAdoptiveChildrenIds != null && leftMarriageAdoptiveChildrenIds.includes(childMaleId))
                leftMarriageAdoptiveChildrenNodes.push(childMaleNode);

            if (leftMarriageAdoptiveChildrenIds != null && leftMarriageAdoptiveChildrenIds.includes(childFemaleId))
                leftMarriageAdoptiveChildrenNodes.push(childFemaleNode);
        }

        const leftMarriageBiologicalChildrenOnLeft = [];
        const leftMarriageBiologicalChildrenOnRight = [];
        const leftMarriageAdoptiveChildrenOnLeft = [];
        const leftMarriageAdoptiveChildrenOnRight = [];

        const mainMarriageBiologicalChildrenOnLeft = [];
        const mainMarriageBiologicalChildrenOnRight = [];
        const mainMarriageAdoptiveChildrenOnLeft = [];
        const mainMarriageAdoptiveChildrenOnRight = [];

        const leftMarriageRect = leftMarriageNode.length ? leftMarriageNode.get(0).getBoundingClientRect() : null;
        const mainMarriageRect = mainMarriageNode.length ? mainMarriageNode.get(0).getBoundingClientRect() : null;

        let leftMarriageRectHorizontalCenter;
        let mainMarriageRectHorizontalCenter;

        if (leftMarriageRect)
            leftMarriageRectHorizontalCenter = leftMarriageRect.left + (leftMarriageRect.width / 2);

        if (mainMarriageRect)
            mainMarriageRectHorizontalCenter = mainMarriageRect.left + (mainMarriageRect.width / 2);

        leftMarriageBiologicalChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (leftMarriageRectHorizontalCenter > childRectHorizontalCenter)
                leftMarriageBiologicalChildrenOnLeft.push(child);
            else
                leftMarriageBiologicalChildrenOnRight.push(child);
        });

        leftMarriageAdoptiveChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (leftMarriageRectHorizontalCenter > childRectHorizontalCenter)
                leftMarriageAdoptiveChildrenOnLeft.push(child);
            else
                leftMarriageAdoptiveChildrenOnRight.push(child);
        });


        mainMarriageBiologicalChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (mainMarriageRectHorizontalCenter > childRectHorizontalCenter)
                mainMarriageBiologicalChildrenOnLeft.push(child);
            else
                mainMarriageBiologicalChildrenOnRight.push(child);
        });

        mainMarriageAdoptiveChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (mainMarriageRectHorizontalCenter > childRectHorizontalCenter)
                mainMarriageAdoptiveChildrenOnLeft.push(child);
            else
                mainMarriageAdoptiveChildrenOnRight.push(child);
        });

        mainMarriageBiologicalChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offsetOnTop += linesVerticalOffset, true);
        });

        mainMarriageBiologicalChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offsetOnTop += linesVerticalOffset, true);
        });

        mainMarriageAdoptiveChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offsetOnTop += linesVerticalOffset, false);
        });

        mainMarriageAdoptiveChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offsetOnTop += linesVerticalOffset, false);
        });

        let leftMarriageExtraOffset;
        if (leftMarriageRect) {
            leftMarriageExtraOffset = (oneTreeNodeRect.top + oneTreeNodeRect.height) - leftMarriageRect.top;
        }

        leftMarriageBiologicalChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), true);
        });

        leftMarriageBiologicalChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), true);
        });

        leftMarriageAdoptiveChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), false);
        });

        leftMarriageAdoptiveChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), false);
        });


        if (leftMarriageNode.length)
            drawMarriageLines(linesContainer, leftMarriageNode);
    });
}

function drawMarriageLines(linesContainer, marriageNode) {
    const marriageRect = marriageNode.get(0).getBoundingClientRect();
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
    const marriageRect = marriageNode.get(0).getBoundingClientRect();
    // Szabi: child should be query object here
    const childRect = child.getBoundingClientRect();

    const linesContainerClientRect = linesContainer.get(0).getBoundingClientRect();

    const hasBiologicalChildren = marriageNode.data('inverseBiologicalParents').length > 0;
    const hasAdoptiveChildren = marriageNode.data('inverseAdoptiveParents').length > 0;

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

    // Szabi: jquery
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', isBiological ? 'tree-line-biological-svg' : 'tree-line-adoptive-svg');

    linesContainer.append(path);
}