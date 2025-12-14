const duplicatedPathToNodeWidthMultiplier = 1 / 3;
const roundToOneDecimal = v => v.toFixed(1);

// Szabi: theory: what if women is second wife of two males, and vice versa
function drawMarriagesChildrenPaths(pathsContainer, nodePathsVerticalOffset, largestGenerationSize, largestDuplicatedGroupsOnSameLevelCount, childrenGeneration, marriageNodes, childNodes) {
    pathsContainer.clientRect = pathsContainer.get(0).getBoundingClientRect();

    const offsetOnTop =
    {
        value:
            (1 +
                (
                    (
                        (largestGenerationSize + largestDuplicatedGroupsOnSameLevelCount) -
                        (childrenGeneration.generationSize + childrenGeneration.duplicatedGroupsOnSameLevelCount)
                    )
                    * 0.5
                )
            )
            * nodePathsVerticalOffset
    };

    marriageNodes.filter('.marriage-node').each((_, marriageNode) => {
        drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageNode, childNodes);
    });
}

function drawMarriageChildrenPaths(pathsContainer, nodePathsVerticalOffset, offsetOnTop, marriageNode, childNodes) {
    const inverseBiologicalParentIds = $(marriageNode).data('inverseBiologicalParentIds');
    const inverseAdoptiveParentIds = $(marriageNode).data('inverseAdoptiveParentIds') ?? [];
    const inverseParentIds = inverseBiologicalParentIds.concat(inverseAdoptiveParentIds);

    const targetChildNodes = [];

    marriageNode.clientRect = marriageNode.getBoundingClientRect();
    marriageNode.clientRectHorizontalCenter = marriageNode.clientRect.left + (marriageNode.clientRect.width / 2);

    childNodes.each((_, childNode) => {
        const childId = parseInt($(childNode).attr('id'));

        if (inverseParentIds.includes(childId)) {
            childNode.clientRect = childNode.getBoundingClientRect();
            childNode.clientRectHorizontalCenter = childNode.clientRect.left + (childNode.clientRect.width / 2);
            childNode.isBiological = inverseBiologicalParentIds.includes(childId);

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

    const hasBiologicalParents = $(childNode).data('biologicalFatherId') != null && $(childNode).data('biologicalMotherId') != null;
    const hasAdoptiveParents = $(childNode).data('adoptiveFatherId') != null && $(childNode).data('adoptiveMotherId') != null;

    if (hasBiologicalParents && hasAdoptiveParents) {
        childNodeHorizontalCenter += childNode.isBiological ? (-nodePathsVerticalOffset / 2) : (nodePathsVerticalOffset / 2);
    }

    const pathData = `
        M ${roundToOneDecimal(marriageNodeHorizontalCenter)},${roundToOneDecimal(marriageNodeBottom)}
        L ${roundToOneDecimal(marriageNodeHorizontalCenter)},${roundToOneDecimal(verticalCenter)}
        L ${roundToOneDecimal(childNodeHorizontalCenter)},${roundToOneDecimal(verticalCenter)}
        L ${roundToOneDecimal(childNodeHorizontalCenter)},${roundToOneDecimal(childNodeTop)}
    `;

    addPathWithInteractiveLayer(pathsContainer, treeHtmlCreator.createMarriageChildPath(pathData, childNode.isBiological));
}

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
        M ${roundToOneDecimal(x1)},${roundToOneDecimal(y)} L ${roundToOneDecimal(x2)},${roundToOneDecimal(y)}
        M ${roundToOneDecimal(x3)},${roundToOneDecimal(y)} L ${roundToOneDecimal(x4)},${roundToOneDecimal(y)}
    `;

    pathsContainer.append(treeHtmlCreator.createMarriagePath(pathData));
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