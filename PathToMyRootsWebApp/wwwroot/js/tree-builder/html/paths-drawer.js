const duplicatedPathToNodeWidthMultiplier = 1 / 3;
const roundToOneDecimal = v => v.toFixed(1);

function drawMarriagesChildrenPaths(pathsContainer, nodePathsVerticalOffset, largestGenerationSize, largestDuplicatedPersonsOnSameLevelCount, childrenGeneration, marriageDateNodes, childNodes) {
    pathsContainer.clientRect = pathsContainer.get(0).getBoundingClientRect();

    const offsetOnTop =
    {
        value:
            (1 +
                (
                    (
                        (largestGenerationSize + largestDuplicatedPersonsOnSameLevelCount) -
                        (childrenGeneration.generationSize + childrenGeneration.duplicatedPersonsOnSameLevelCount)
                    )
                    * 0.5
                )
            )
            * nodePathsVerticalOffset
    };

    marriageDateNodes
        .filter((_, marriageDateNode) => !$(marriageDateNode).data('isHidden'))
        .each((_, marriageDateNode) => drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageDateNode, childNodes));
}

function drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageDateNode, childNodes) {
    const inverseBiologicalParentIds = $(marriageDateNode).data('inverseBiologicalParentIds');
    const inverseAdoptiveParentIds = $(marriageDateNode).data('inverseAdoptiveParentIds') ?? [];
    const inverseParentIds = inverseBiologicalParentIds.concat(inverseAdoptiveParentIds);

    const targetChildNodes = [];

    marriageDateNode.clientRect = marriageDateNode.getBoundingClientRect();
    marriageDateNode.clientRectHorizontalCenter = marriageDateNode.clientRect.left + (marriageDateNode.clientRect.width / 2);

    // keep track of consumed children to skip the duplicated ones
    // so parent child lines will be drawn only towards the first child of the duplicates
    const consumedChildrenIds = new Set();

    childNodes.each((_, childNode) => {
        const childId = parseInt($(childNode).attr('id'));

        if (consumedChildrenIds.has(childId)) {
            return;
        }

        consumedChildrenIds.add(childId);

        if (inverseParentIds.includes(childId)) {
            childNode.clientRect = childNode.getBoundingClientRect();
            childNode.clientRectHorizontalCenter = childNode.clientRect.left + (childNode.clientRect.width / 2);
            childNode.isBiological = inverseBiologicalParentIds.includes(childId);

            targetChildNodes.push(childNode);
        }
    });

    const leftChildNodes = targetChildNodes.filter(chilNode => chilNode.clientRectHorizontalCenter <= marriageDateNode.clientRectHorizontalCenter);
    const rightChildNodes = targetChildNodes.filter(chilNode => chilNode.clientRectHorizontalCenter > marriageDateNode.clientRectHorizontalCenter);

    leftChildNodes.forEach(childNode => {
        drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageDateNode, childNode, offsetOnTop.value += nodePathsVerticalOffset);
    });

    rightChildNodes.reverse().forEach(childNode => {
        drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageDateNode, childNode, offsetOnTop.value += nodePathsVerticalOffset);
    });
}

function drawMarriageChildPath(pathsContainer, nodePathsVerticalOffset, marriageDateNode, childNode, verticalOffset) {

    let marriageDateNodeHorizontalCenter = marriageDateNode.clientRect.left + marriageDateNode.clientRect.width / 2 - pathsContainer.clientRect.left;
    let marriageDateNodeBottom = marriageDateNode.clientRect.top + marriageDateNode.clientRect.height - pathsContainer.clientRect.top;
    let childNodeHorizontalCenter = childNode.clientRect.left + childNode.clientRect.width / 2 - pathsContainer.clientRect.left;
    let childNodeTop = childNode.clientRect.top - pathsContainer.clientRect.top;
    let horizontalLineY = marriageDateNodeBottom + verticalOffset;

    const hasBiologicalChildren = $(marriageDateNode).data('inverseBiologicalParentIds').length > 0;
    const hasAdoptiveChildren = $(marriageDateNode).data('inverseAdoptiveParentIds').length > 0;

    if (hasBiologicalChildren && hasAdoptiveChildren) {
        marriageDateNodeHorizontalCenter += childNode.isBiological ? (-nodePathsVerticalOffset / 2) : (nodePathsVerticalOffset / 2);
    }

    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents) {
        childNodeHorizontalCenter += childNode.isBiological ? (-nodePathsVerticalOffset / 2) : (nodePathsVerticalOffset / 2);
    }

    const pathData = `
        M ${roundToOneDecimal(marriageDateNodeHorizontalCenter)},${roundToOneDecimal(marriageDateNodeBottom)}
        L ${roundToOneDecimal(marriageDateNodeHorizontalCenter)},${roundToOneDecimal(horizontalLineY)}
        L ${roundToOneDecimal(childNodeHorizontalCenter)},${roundToOneDecimal(horizontalLineY)}
        L ${roundToOneDecimal(childNodeHorizontalCenter)},${roundToOneDecimal(childNodeTop)}
    `;

    addPathWithInteractiveLayer(pathsContainer, treeHtmlCreator.createMarriageChildPath(pathData, childNode.isBiological));
}

function drawDuplicatedPersonPaths(pathsContainer, nodePathsVerticalOffset, generationsHtmls) {
    const containerRect = pathsContainer.get(0).getBoundingClientRect();

    const pathsByPersonIdOnSameLevels = getPathsByPersonIdOnSameLevels(containerRect, nodePathsVerticalOffset, generationsHtmls);
    const pathsByPersonIdOnDifferentLevels = getPathsByPersonIdOnDifferentLevels(containerRect, generationsHtmls);

    const duplicatedPathsByPersonId = new Map();

    for (const [personId, paths] of pathsByPersonIdOnSameLevels) {
        if (!duplicatedPathsByPersonId.has(personId)) {
            duplicatedPathsByPersonId.set(personId, []);
        }

        duplicatedPathsByPersonId.get(personId).push(...paths);
    }

    for (const [personId, path] of pathsByPersonIdOnDifferentLevels) {
        if (!duplicatedPathsByPersonId.has(personId)) {
            duplicatedPathsByPersonId.set(personId, []);
        }

        duplicatedPathsByPersonId.get(personId).push(path);
    }

    for (const pathsOfSameNodes of duplicatedPathsByPersonId.values()) {
        const pathData = pathsOfSameNodes.join(' ');

        addPathWithInteractiveLayer(pathsContainer, treeHtmlCreator.createDuplicatedPersonPath(pathData));
    }
}


function getPathsByPersonIdOnSameLevels(containerRect, nodePathsVerticalOffset, generationsHtmls) {
    const pathsByPersonIdOnSameLevels = new Map();

    for (const generationHtml of generationsHtmls) {
        const duplicatedNodesByPersonIdInCurrentGeneration = getDuplicatedNodesByPersonIdInCurrentGeneration(generationHtml);
        const duplicatedPathByPersonIdInCurrentGeneration = getDuplicatedPathByPersonIdInCurrentGeneration(containerRect, duplicatedNodesByPersonIdInCurrentGeneration, nodePathsVerticalOffset)

        for (const [personId, path] of duplicatedPathByPersonIdInCurrentGeneration) {

            if (!pathsByPersonIdOnSameLevels.has(personId)) {
                pathsByPersonIdOnSameLevels.set(personId, []);
            }

            pathsByPersonIdOnSameLevels.get(personId).push(path);
        }
    }

    return pathsByPersonIdOnSameLevels;
}

function getDuplicatedNodesByPersonIdInCurrentGeneration(generationHtml) {
    const nodesByPersonIdInCurrentGeneration = new Map();
    const nodesInCurrentGeneration = $(generationHtml).find('.person-node');

    for (const node of nodesInCurrentGeneration) {
        const personId = node.id;

        if (!nodesByPersonIdInCurrentGeneration.has(personId)) {
            nodesByPersonIdInCurrentGeneration.set(personId, []);
        }

        nodesByPersonIdInCurrentGeneration.get(personId).push(node);
    }

    const duplicatedNodesByPersonIdInCurrentGeneration = new Map();

    for (const [personId, nodes] of nodesByPersonIdInCurrentGeneration) {
        if (nodes.length > 1) {
            duplicatedNodesByPersonIdInCurrentGeneration.set(personId, nodes);
        }
    }

    return duplicatedNodesByPersonIdInCurrentGeneration;
}

function getDuplicatedPathByPersonIdInCurrentGeneration(containerRect, duplicatedNodesByPersonIdInCurrentGeneration, nodePathsVerticalOffset) {
    const duplicatedPathByPersonIdInCurrentGeneration = new Map();

    let numberOfHorizontalDuplicates = 0;
    for (const [personId, nodes] of duplicatedNodesByPersonIdInCurrentGeneration) {
        const pathOfSameNodesOnSameLevel = getPathOfSameNodesOnSameLevel(containerRect, nodes, numberOfHorizontalDuplicates, nodePathsVerticalOffset);
        duplicatedPathByPersonIdInCurrentGeneration.set(personId, pathOfSameNodesOnSameLevel);

        numberOfHorizontalDuplicates++;
    }

    return duplicatedPathByPersonIdInCurrentGeneration;
}

function getPathOfSameNodesOnSameLevel(containerRect, sameNodesOnSameLevel, numberOfHorizontalDuplicatesDrawn, nodePathsVerticalOffset) {
    let path = '';

    // sort them to draw from left to right
    sameNodesOnSameLevel.sort((node1, node2) => node1.getBoundingClientRect().left - node2.getBoundingClientRect().left);

    // vertical lines
    sameNodesOnSameLevel.forEach(node => {
        node.classList.add('duplicated-node');
        const nodeRect = node.getBoundingClientRect();

        const x1 = (nodeRect.left - containerRect.left) + (nodeRect.width / 3);
        const y1 = nodeRect.top - containerRect.top;

        const x2 = x1;
        const y2 = nodeRect.top - containerRect.top - ((numberOfHorizontalDuplicatesDrawn + 2) * nodePathsVerticalOffset);

        path += `M ${roundToOneDecimal(x1)},${roundToOneDecimal(y1)} L ${roundToOneDecimal(x2)},${roundToOneDecimal(y2)} `;
    })

    // horizontal line
    const leftNode = sameNodesOnSameLevel[0];
    const rightNode = sameNodesOnSameLevel[sameNodesOnSameLevel.length - 1]

    const leftNodeRect = leftNode.getBoundingClientRect();
    const rightNodeRect = rightNode.getBoundingClientRect();

    const x1 = (leftNodeRect.left - containerRect.left) + (leftNodeRect.width * duplicatedPathToNodeWidthMultiplier);
    const y1 = leftNodeRect.top - containerRect.top - ((numberOfHorizontalDuplicatesDrawn + 2) * nodePathsVerticalOffset);

    const x2 = (rightNodeRect.left - containerRect.left) + (rightNodeRect.width * duplicatedPathToNodeWidthMultiplier);
    const y2 = y1;

    path += `M ${roundToOneDecimal(x1)},${roundToOneDecimal(y1)} L ${roundToOneDecimal(x2)},${roundToOneDecimal(y2)} `;

    return path;
}


function getPathsByPersonIdOnDifferentLevels(containerRect, generationsHtmls) {
    const duplicatedNodesByPersonIdInAllGenerations = getDuplicatedNodesByPersonIdInAllGenerations(generationsHtmls);
    const duplicatedPathByPersonIdInAllGenerations = getDuplicatedPathByPersonIdInAllGenerations(containerRect, duplicatedNodesByPersonIdInAllGenerations);

    return duplicatedPathByPersonIdInAllGenerations;
}

function getDuplicatedNodesByPersonIdInAllGenerations(generationsHtmls) {
    const nodesByPersonIdInAllGenerations = new Map();

    for (const generationHtml of generationsHtmls) {
        const nodesInCurrentGenearation = $(generationHtml).find('.person-node');

        for (const node of nodesInCurrentGenearation) {
            const personId = node.id;

            if (!nodesByPersonIdInAllGenerations.has(personId)) {
                nodesByPersonIdInAllGenerations.set(personId, []);
            }

            nodesByPersonIdInAllGenerations.get(personId).push(node);
        }
    }

    const duplicatedNodesByPersonIdInAllGenerations = new Map();

    for (const [personId, nodes] of nodesByPersonIdInAllGenerations) {
        if (nodes.length > 1) {
            duplicatedNodesByPersonIdInAllGenerations.set(personId, nodes);
        }
    }

    return duplicatedNodesByPersonIdInAllGenerations;
}

function getDuplicatedPathByPersonIdInAllGenerations(containerRect, duplicatedNodesByPersonIdInAllGenerations) {
    const duplicatedPathByPersonIdInAllGenerations = new Map();

    for (const [personId, nodes] of duplicatedNodesByPersonIdInAllGenerations) {
        const pathOfSameNodesOnDifferentsLevels = getPathOfSameNodesOnDifferentLevels(containerRect, nodes);
        duplicatedPathByPersonIdInAllGenerations.set(personId, pathOfSameNodesOnDifferentsLevels);
    }

    return duplicatedPathByPersonIdInAllGenerations;
}

function getPathOfSameNodesOnDifferentLevels(containerRect, sameNodesOnDifferentLevels) {
    let path = '';

    // sort them from top to bottom
    sameNodesOnDifferentLevels.sort((node1, node2) => node1.getBoundingClientRect().top - node2.getBoundingClientRect().bottom);

    for (let i = 0; i < sameNodesOnDifferentLevels.length; i++) {
        for (let j = i + 1; j < sameNodesOnDifferentLevels.length; j++) {
            const nodeTop = sameNodesOnDifferentLevels[i];
            const nodeBottom = sameNodesOnDifferentLevels[j];

            const rectNodeTop = nodeTop.getBoundingClientRect();
            const rectNodeBottom = nodeBottom.getBoundingClientRect();

            if (rectNodeTop.top == rectNodeBottom.top) {
                continue;
            }

            nodeTop.classList.add('duplicated-node');
            nodeBottom.classList.add('duplicated-node');

            const x1 = (rectNodeTop.left - containerRect.left) + (rectNodeTop.width * duplicatedPathToNodeWidthMultiplier);
            const y1 = rectNodeTop.bottom - containerRect.top;

            const x2 = (rectNodeBottom.left - containerRect.left) + (rectNodeTop.width * duplicatedPathToNodeWidthMultiplier);
            const y2 = rectNodeBottom.top - containerRect.top;

            path += `M ${roundToOneDecimal(x1)},${roundToOneDecimal(y1)} L ${roundToOneDecimal(x2)},${roundToOneDecimal(y2)} `;
        }
    }

    return path;
}


function addPathWithInteractiveLayer(pathsContainer, path) {
    // create the actual path
    // and another thicker one used for hovering
    const interactivePath =
        path
            .clone()
            .attr('class', 'path-interactive');

    pathsContainer.append(interactivePath);
    pathsContainer.append(path);
}