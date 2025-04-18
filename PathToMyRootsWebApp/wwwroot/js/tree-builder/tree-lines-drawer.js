async function drawLines(linesContainer, parentsRow, childrenRow, maxChildrenWithParentsOnRows) {

    const numOfChildrensWithParentOnRow = getNumberOfChildrenWithParents(childrenRow);
    let offsetOnTop = (1 + ((maxChildrenWithParentsOnRows - numOfChildrensWithParentOnRow) * 0.5)) * linesVerticalOffset;

    let parentsExtendedMarriages = parentsRow.find('.tree-extended-marriage');
    parentsExtendedMarriages.each((_, element) => {
        const parentsNodeGroupContainer = $(element);
        let secondaryMarriageNode = parentsNodeGroupContainer.find('.left-marriage');
        let mainMarriageNode = parentsNodeGroupContainer.find('.main-marriage');

        let oneTreeNodeRect =
            parentsNodeGroupContainer.find('.tree-node-male, .tree-node-female').first().get(0)
                .getBoundingClientRect();

        let secondaryMarriageBiologicalChildrenIds;
        let secondaryMarriageAdoptiveChildrenIds;
        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;

        if (secondaryMarriageNode.length) {
            secondaryMarriageBiologicalChildrenIds = secondaryMarriageNode.data('inverseBiologicalParents');
            secondaryMarriageAdoptiveChildrenIds = secondaryMarriageNode.data('inverseAdoptiveParents');
        }

        if (mainMarriageNode.length) {
            mainMarriageBiologicalChildrenIds = mainMarriageNode.data('inverseBiologicalParents');
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.data('inverseAdoptiveParents');
        }

        const mainMarriageBiologicalChildrenNodes = [];
        const mainMarriageAdoptiveChildrenNodes = [];
        const secondaryMarriageBiologicalChildrenNodes = [];
        const secondaryMarriageAdoptiveChildrenNodes = [];

        let childrenExtendedMarriages = childrenRow.find('.tree-extended-marriage');

        for (let childrenExtendedMarriage of childrenExtendedMarriages) {
            let childMaleNode = childrenExtendedMarriage.querySelector('.tree-node-male');
            let childFemaleNode = childrenExtendedMarriage.querySelector('.tree-node-female');

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


            if (secondaryMarriageBiologicalChildrenIds != null && secondaryMarriageBiologicalChildrenIds.includes(childMaleId))
                secondaryMarriageBiologicalChildrenNodes.push(childMaleNode);

            if (secondaryMarriageBiologicalChildrenIds != null && secondaryMarriageBiologicalChildrenIds.includes(childFemaleId))
                secondaryMarriageBiologicalChildrenNodes.push(childFemaleNode);

            if (secondaryMarriageAdoptiveChildrenIds != null && secondaryMarriageAdoptiveChildrenIds.includes(childMaleId))
                secondaryMarriageAdoptiveChildrenNodes.push(childMaleNode);

            if (secondaryMarriageAdoptiveChildrenIds != null && secondaryMarriageAdoptiveChildrenIds.includes(childFemaleId))
                secondaryMarriageAdoptiveChildrenNodes.push(childFemaleNode);
        }

        const secondaryMarriageBiologicalChildrenOnLeft = [];
        const secondaryMarriageBiologicalChildrenOnRight = [];
        const secondaryMarriageAdoptiveChildrenOnLeft = [];
        const secondaryMarriageAdoptiveChildrenOnRight = [];

        const mainMarriageBiologicalChildrenOnLeft = [];
        const mainMarriageBiologicalChildrenOnRight = [];
        const mainMarriageAdoptiveChildrenOnLeft = [];
        const mainMarriageAdoptiveChildrenOnRight = [];

        const secondaryMarriageRect = secondaryMarriageNode.length ? secondaryMarriageNode.get(0).getBoundingClientRect() : null;
        const mainMarriageRect = mainMarriageNode.length ? mainMarriageNode.get(0).getBoundingClientRect() : null;

        let secondaryMarriageRectHorizontalCenter;
        let mainMarriageRectHorizontalCenter;

        if (secondaryMarriageRect)
            secondaryMarriageRectHorizontalCenter = secondaryMarriageRect.left + (secondaryMarriageRect.width / 2);

        if (mainMarriageRect)
            mainMarriageRectHorizontalCenter = mainMarriageRect.left + (mainMarriageRect.width / 2);

        secondaryMarriageBiologicalChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (secondaryMarriageRectHorizontalCenter > childRectHorizontalCenter)
                secondaryMarriageBiologicalChildrenOnLeft.push(child);
            else
                secondaryMarriageBiologicalChildrenOnRight.push(child);
        });

        secondaryMarriageAdoptiveChildrenNodes.forEach(child => {
            const childRect = child.getBoundingClientRect();
            const childRectHorizontalCenter = childRect.left + (childRect.width / 2);

            if (secondaryMarriageRectHorizontalCenter > childRectHorizontalCenter)
                secondaryMarriageAdoptiveChildrenOnLeft.push(child);
            else
                secondaryMarriageAdoptiveChildrenOnRight.push(child);
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

        let secondaryMarriageExtraOffset;
        if (secondaryMarriageRect) {
            secondaryMarriageExtraOffset = (oneTreeNodeRect.top + oneTreeNodeRect.height) - secondaryMarriageRect.top;
        }

        secondaryMarriageBiologicalChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, secondaryMarriageNode, child, secondaryMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), true);
        });

        secondaryMarriageBiologicalChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, secondaryMarriageNode, child, secondaryMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), true);
        });

        secondaryMarriageAdoptiveChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, secondaryMarriageNode, child, secondaryMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), false);
        });

        secondaryMarriageAdoptiveChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, secondaryMarriageNode, child, secondaryMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), false);
        });


        if (secondaryMarriageNode.length)
            drawMarriageLines(linesContainer, secondaryMarriageNode);
    });
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