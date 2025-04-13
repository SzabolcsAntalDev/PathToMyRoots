const linesVerticalOffset = 10;

const apiUrl = "https://localhost:7241/api/person/";
const imageApiUrl = "https://localhost:7241/";

async function removeTreeDiagram(personId) {
    const loadingTextContainer = document.getElementById("loading-text-container");
    if (loadingTextContainer)
        fadeInElement(loadingTextContainer);

    const nodesAndLinesContainer = document.getElementById('tree-diagram-and-lines-container' + personId);
    if (nodesAndLinesContainer) {
        await fadeOutElement(nodesAndLinesContainer)
        nodesAndLinesContainer.remove();
    }
}

async function createAndDisplayTreeDiagram(personId) {
    // create container with nodes and lines containers
    const treeContainer = $('#tree-container');
    const loadingTextContainer = getOrCreateLoadingTextContainer(treeContainer);
    fadeInElement(loadingTextContainer);

    const nodesContainer = createNodesContainer();
    const linesContainer = createLinesContainer();
    const nodesAndLinesContainer = createHiddenNodesAndLinesContainer(personId);

    nodesAndLinesContainer.append(nodesContainer);
    nodesAndLinesContainer.append(linesContainer);

    treeContainer.append(nodesAndLinesContainer);

    await buildTree(nodesContainer, linesContainer);

    // Szabi: this doesn't work
    //scrollToMiddle(nodesAndLinesContainer, nodesContainerDom);

    fadeOutElement(loadingTextContainer);
    fadeInElement(nodesAndLinesContainer);
}

async function buildTree(nodesContainer, linesContainer) {
    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    const levelIndexesToRowsMap = new Map();
    await createRowsFrom(personId, processedPersonIds, levelIndexesToRowsMap, 0);

    levelIndexesToRowsMap.forEach((value, _) => {
        sortGroupNodeContainers(value);
    });

    let maxChildrenWithParentsOnRows = 0;
    levelIndexesToRowsMap.forEach((value, _) => {
        maxChildrenWithParentsOnRows = Math.max(maxChildrenWithParentsOnRows, getNumberOfChildrenWithParents(value));
    });

    const descSortedLevelIndexes = [...levelIndexesToRowsMap.keys()]
        .map(Number)
        .sort((a, b) => b - a);

    // sort children
    let parentsRow = createRow();
    for (let i = 0; i < descSortedLevelIndexes.length; i++) {
        const childrenLevelIndex = descSortedLevelIndexes[i];
        const childrenRow = levelIndexesToRowsMap.get(childrenLevelIndex);

        let sortedChildrenRow = createRow();
        nodesContainer.append(sortedChildrenRow);
        parentsRow = await fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow);
    }

    // set bottom padding to each child except the last one
    // Szabi: should be without get, but it fails at runtime
    // Szabi: delete all unused indexes from the js files
    const rows = nodesContainer.find(".tree-level-row");
    rows.each((index, row) => {
        if (index !== rows.length - 1) {
            $(row).css('padding', "0px 0px " + ((maxChildrenWithParentsOnRows + 3) * linesVerticalOffset) + "px 0px");
        }
    });

    const nodesContainerDom = nodesContainer.get(0);

    // draw lines
    const treeNodesContainerStyle = window.getComputedStyle(nodesContainerDom);
    const treeNodesContainerWidth = nodesContainerDom.offsetWidth || parseFloat(treeNodesContainerStyle.width);
    const treeNodesContainerHeight = nodesContainerDom.offsetHeight || parseFloat(treeNodesContainerStyle.height);

    linesContainer.css('width', `${treeNodesContainerWidth}px`);
    linesContainer.css('height', `${treeNodesContainerHeight}px`);

    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = $(rows[i - 1]);
        const childrenRowInner = $(rows[i]);

        await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxChildrenWithParentsOnRows);
    }
}

function sortGroupNodeContainers(row) {
    var nodeGroupContainers = row.find('.tree-nodes-group-container');
    sortedNodes = sortGroupNodeContainersByBirthDates(nodeGroupContainers);

    row.innerHTML = '';

    sortedNodes.forEach(node => {
        let date = node.querySelector('.tree-node-male')?.birthDate;
        row.append(node);
    });
}

function sortGroupNodeContainersByBirthDates(nodeGroupContainers) {
    return Array.from(nodeGroupContainers).sort((a, b) => {
        let maleA = a.querySelector('.tree-node-male');
        let femaleA = a.querySelector('.tree-node-female');
        let birthDateA = maleA?.birthDate || femaleA?.birthDate;

        let maleB = b.querySelector('.tree-node-male');
        let femaleB = b.querySelector('.tree-node-female');
        let birthDateB = maleB?.birthDate || femaleB?.birthDate;

        const parseDate = (date) => {
            if (!date)
                return Infinity;

            if (date === "+yyyymmdd")
                return 99999999;

            date = date.replace("mm", "00").replace("dd", "00");

            return parseInt(date.slice(1), 10) || 99999999;
        };

        let dateA = parseDate(birthDateA);
        let dateB = parseDate(birthDateB);

        return dateA - dateB;
    });
}

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}

async function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    const parentsNodeGroupContainers = parentsRow.find('.tree-nodes-group-container');

    parentsNodeGroupContainers.each((_, parentsNodeGroupContainer) => {
        let leftMarriageNode = $(parentsNodeGroupContainer).find('.left-marriage');
        let mainMarriageNode = $(parentsNodeGroupContainer).find('.main-marriage');

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

        const takenSpouseNodeGroupContainers = [];
        const childrenNodeGroupContainers = childrenRow.find('.tree-nodes-group-container');
        const siblings = [];

        // Szabi: continue here
        // Szabi: use each here
        childrenNodeGroupContainers.each((_, element) => {
            const childrenNodeGroupContainer = $(element);
            if (takenSpouseNodeGroupContainers.includes(childrenNodeGroupContainer))
                return;

            const childMaleNode = childrenNodeGroupContainer.find('.tree-node-male');
            const childFemaleNode = childrenNodeGroupContainer.find('.tree-node-female');

            let childMaleId = childMaleNode.length ? Number(childMaleNode.attr('id')) : null;
            let childFemaleId = childFemaleNode.left ? Number(childFemaleNode.attr('id')) : null;

            // Szabi: can this ever be undefined?
            if (leftMarriageBiologicalChildrenIds != undefined &&
                (leftMarriageBiologicalChildrenIds.includes(childMaleId) || leftMarriageBiologicalChildrenIds.includes(childFemaleId))) {

                const isMale = leftMarriageBiologicalChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);

                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (leftMarriageAdoptiveChildrenIds != null &&
                (leftMarriageAdoptiveChildrenIds.includes(childMaleId) || leftMarriageAdoptiveChildrenIds.includes(childFemaleId))) {

                const isMale = leftMarriageAdoptiveChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);

                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (mainMarriageBiologicalChildrenIds != null &&
                (mainMarriageBiologicalChildrenIds.includes(childMaleId) || mainMarriageBiologicalChildrenIds.includes(childFemaleId))) {

                const isMale = mainMarriageBiologicalChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (mainMarriageAdoptiveChildrenIds != null &&
                (mainMarriageAdoptiveChildrenIds.includes(childMaleId) || mainMarriageAdoptiveChildrenIds.includes(childFemaleId))) {

                const isMale = mainMarriageAdoptiveChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }
        });

        const treeSiblingsContainer =
            $('<div>')
                .attr('class', 'tree-siblings-container');

        let added = false;
        siblings.forEach(s => {
            treeSiblingsContainer.append(s);
            added = true;
        });

        if (added) {
            sortedChildrenRow.append(treeSiblingsContainer);
        }
    });

    // orphans
    const childrenNodeGroupContainers = childrenRow.find('.tree-nodes-group-container');
    const firstSpousesNodeGroupContainers = [];
    childrenNodeGroupContainers.each((_, element) => {
        const childrenNodeGroupContainer = $(element);
        if (firstSpousesNodeGroupContainers.includes(childrenNodeGroupContainer))
            return;

        let childMaleNode = childrenNodeGroupContainer.find('.tree-node-male').first();
        let childFemaleNode = childrenNodeGroupContainer.find('.tree-node-female').first();

        let childMaleId = Number(childMaleNode?.id);
        let childFemaleId = Number(childFemaleNode?.id);
        let added = false;

        if (childMaleId) {
            const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

            if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                const treeSiblingsContainer =
                    $('<div>')
                        .attr('class', 'tree-siblings-container')
                        .append(firstSpouseNodeGroupContainerOfDoubleMarriedMale)
                        .append(childrenNodeGroupContainer);

                sortedChildrenRow.append(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                added = true;
            }
        }

        if (childFemaleId) {
            const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

            if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                const treeSiblingsContainer =
                    $('<div>')
                        .attr('class', 'tree-siblings-container')
                        .append(childrenNodeGroupContainer)
                        .append(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);

                sortedChildrenRow.append(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                added = true;
            }
        }

        if (!added) {
            const treeSiblingsContainer =
                $('<div>')
                    .attr('class', 'tree-siblings-container')
                    .append(childrenNodeGroupContainer);

            sortedChildrenRow.append(treeSiblingsContainer);
        }
    });

    return sortedChildrenRow;
}

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