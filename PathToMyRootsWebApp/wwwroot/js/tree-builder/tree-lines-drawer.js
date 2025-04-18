async function drawLines(linesContainer, generationsData, childrenGeneration, marriageNodes, personNodes) {

    let offsetOnTop = (1 + ((generationsData.largestGenerationSize - childrenGeneration.generationSize) * 0.5)) * linesVerticalOffset;

    marriageNodes.each((_, marriageNode) => {

        // Szabi inverseBiologicalParentIds instead?
        const inverseBiologicalParents = $(marriageNode).data('inverseBiologicalParents')
        const inverseAdoptiveParents = $(marriageNode).data('inverseAdoptiveParents');

        personNodes.each((_, personNode) => {
            const personId = parseInt($(personNode).attr('id'));

            if (inverseBiologicalParents.includes(personId)) {
                const marriageRect = marriageNode.getBoundingClientRect();
                // Szabi these should be used
                const marriageRectHorizontalCenter = marriageRect.left + (marriageRect.width / 2);

                const personRect = personNode.getBoundingClientRect();
                const personRectHorizontalCenter = personRect.left + (personRect.width / 2);

                drawChildLine(linesContainer, marriageRect, personRect, offsetOnTop += linesVerticalOffset, true);
            }
        });

        //let oneTreeNodeRect =
        //    parentsNodeGroupContainer.find('.tree-node-male, .tree-node-female').first().get(0)
        //        .getBoundingClientRect();

        //let secondaryMarriageExtraOffset;
        //if (secondaryMarriageRect) {
        //    secondaryMarriageExtraOffset = (oneTreeNodeRect.top + oneTreeNodeRect.height) - secondaryMarriageRect.top;
        //}

        //personNodes.each(personNode => {
        //    const personId = parseInt($(personNode).attr('id'));

        //    if (inverseAdoptiveParents.includes(personId)) {
        //        const marriageRect = marriageNode.getBoundingClientRect();
        //        const marriageRectHorizontalCenter = marriageRect.left + (marriageRect.width / 2);

        //        const personRect = personNode.getBoundingClientRect();
        //        const personRectHorizontalCenter = personRect.left + (personRect.width / 2);

        //        drawChildLine(linesContainer, secondaryMarriage, child, secondaryMarriageExtraOffset + (offsetOnTop += linesVerticalOffset), false);
        //    }
        //});

        //if (secondaryMarriage.length)
        //    drawMarriageLines(linesContainer, secondaryMarriage);
    });
}

function drawChildLine(linesContainer, marriageNodeRect, personNodeRect, verticalOffset, isBiological) {
    const linesContainerRect = linesContainer.get(0).getBoundingClientRect();

    const marriageNodeX = marriageNodeRect.left + marriageNodeRect.width / 2 - linesContainerRect.left;
    const marriageNodeY = marriageNodeRect.top + marriageNodeRect.height - linesContainerRect.top;
    const personNodeX = personNodeRect.left + personNodeRect.width / 2 - linesContainerRect.left;
    const personNodeY = personNodeRect.top - linesContainerRect.top;
    const middleY = marriageNodeY + verticalOffset;

    const pathData = `
        M ${marriageNodeX},${marriageNodeY}
        L ${marriageNodeX},${middleY}
        L ${personNodeX},${middleY}
        L ${personNodeX},${personNodeY}
    `;

    // Szabi: jquery
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', isBiological ? 'tree-line-biological-svg' : 'tree-line-adoptive-svg');

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