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

async function createTreeDiagram(personId) {

    // create container with nodes and lines containers
    const treesContainer = document.getElementById('trees-container');

    const loadingTextContainer = await createOrGetLoadingTextContainer(treesContainer);
    fadeInElement(loadingTextContainer);

    const nodesAndLinesContainer = createNodesAndLinesContainer();
    hideElement(nodesAndLinesContainer);
    nodesAndLinesContainer.id = 'tree-diagram-and-lines-container' + personId;

    const nodesContainer = createNodesContainer();
    const linesContainer = createLinesContainer();

    nodesAndLinesContainer.appendChild(nodesContainer);
    nodesAndLinesContainer.appendChild(linesContainer);

    treesContainer.appendChild(nodesAndLinesContainer);

    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    const levelIndexesToRowsMap = new Map();
    let baseLevelIndex = 0;
    await createRowsFrom(personId, processedPersonIds, levelIndexesToRowsMap, baseLevelIndex);

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
        nodesContainer.appendChild(sortedChildrenRow);
        parentsRow = await fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow);
    }

    // set bottom padding to each child except the last one
    const rows = nodesContainer.querySelectorAll(".tree-level-row");
    rows.forEach((row, index) => {
        if (index !== rows.length - 1) {
            row.style.padding = "0px 0px " + ((maxChildrenWithParentsOnRows + 3) * linesVerticalOffset) + "px 0px";
        }
    });

    // draw lines
    const treenodesContainerStyle = window.getComputedStyle(nodesContainer);
    const treenodesContainerWidth = nodesContainer.offsetWidth || parseFloat(treenodesContainerStyle.width);
    const treenodesContainerHeight = nodesContainer.offsetHeight || parseFloat(treenodesContainerStyle.height);

    linesContainer.style.width = `${treenodesContainerWidth}px`;
    linesContainer.style.height = `${treenodesContainerHeight}px`;

    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = rows[i - 1];
        const childrenRowInner = rows[i];

        await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxChildrenWithParentsOnRows);
    }

    // Szabi: this doesn't work
    scrollToMiddle(nodesAndLinesContainer, nodesContainer);

    fadeOutElement(loadingTextContainer);
    fadeInElement(nodesAndLinesContainer);
}

function sortGroupNodeContainers(row) {
    var nodeGroupContainers = row.querySelectorAll('.tree-nodes-group-container');
    sortedNodes = sortGroupNodeContainersByBirthDates(nodeGroupContainers);

    row.innerHTML = '';

    sortedNodes.forEach(node => {
        let date = node.querySelector('.tree-node-male')?.birthDate;
        row.appendChild(node);
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

async function createRowsFrom(personId, processedPersonIds, levelIndexesToRowsMap, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();
    const nodesGroupContainer = createNodesGroupContainer();
    const nodesGroup = createNodesGroup();

    if (person.isMale) {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            nodesGroup.appendChild(createNode(person));
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
            const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();

            nodesGroupContainer.appendChild(createNodeMarriage(person, firstSpouse, false));
            nodesGroupContainer.style.paddingLeft = "0px";
            nodesGroupContainer.style.marginLeft = "0px";
            nodesGroup.appendChild(createNode(person));
            nodesGroup.appendChild(createNode(secondSpouse));
            nodesGroup.appendChild(createLineBreak());
            nodesGroup.appendChild(createNodeMarriage(person, secondSpouse, true));

            processedPersonIds.add(person.secondSpouseId);
        }
        else { // single married
            const spouseId = person.firstSpouseId ?? person.secondSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) {
                if (spouse.secondSpouseId == personId) {
                    nodesGroup.appendChild(createNode(person));
                    nodesGroup.appendChild(createNode(spouse));
                    nodesGroup.appendChild(createLineBreak());
                    nodesGroup.appendChild(createNodeMarriage(person, spouse, true));

                    nodesGroupContainer.style.paddingRight = "0px";
                    nodesGroupContainer.style.marginRight = "0px";

                    processedPersonIds.add(spouseId);
                }
                else {
                    nodesGroupContainer.appendChild(createNodeMarriage(person, spouse, false));
                    nodesGroupContainer.style.paddingLeft = "0px";
                    nodesGroupContainer.style.marginLeft = "0px";
                    nodesGroup.appendChild(createNode(person));
                }
            }
            else {
                nodesGroup.appendChild(createNode(person));
                nodesGroup.appendChild(createNode(spouse));
                nodesGroup.appendChild(createLineBreak());
                nodesGroup.appendChild(createNodeMarriage(person, spouse, true));

                processedPersonIds.add(spouseId);
            }
        }
    }
    else {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            nodesGroup.appendChild(createNode(person));
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
        }
        else { // single married
            const spouseId = person.firstSpouseId ?? person.secondSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) { // double married man
                nodesGroup.appendChild(createNode(person));
                nodesGroupContainer.style.paddingRight = "0px";
                nodesGroupContainer.style.marginRight = "0px";
            }
            else { // single married man
                nodesGroup.appendChild(createNode(spouse));
                nodesGroup.appendChild(createNode(person));
                nodesGroup.appendChild(createLineBreak());
                nodesGroup.appendChild(createNodeMarriage(person, spouse, true));

                processedPersonIds.add(spouseId);
            }
        }
    }

    // if not double married female
    if (nodesGroup.childElementCount > 0) {
        nodesGroupContainer.appendChild(nodesGroup);

        if (!levelIndexesToRowsMap.has(level))
            levelIndexesToRowsMap.set(level,createRow());

        levelIndexesToRowsMap.get(level).appendChild(nodesGroupContainer);
    }

    processedPersonIds.add(personId);

    await createRowsFrom(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    await createRowsFrom(person.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);

    if (person.firstSpouse != null) {
        await createRowsFrom(person.firstSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createRowsFrom(person.firstSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createRowsFrom(person.firstSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.secondSpouse != null) {
        await createRowsFrom(person.secondSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createRowsFrom(person.secondSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createRowsFrom(person.secondSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);
}

async function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    const parentsNodeGroupContainers = parentsRow.querySelectorAll('.tree-nodes-group-container');

    for (let parentsNodeGroupContainer of parentsNodeGroupContainers) {

        let leftMarriageNode = parentsNodeGroupContainer.querySelector('.left-marriage');
        let mainMarriageNode = parentsNodeGroupContainer.querySelector('.main-marriage');

        let leftMarriageBiologicalChildrenIds;
        let leftMarriageAdoptiveChildrenIds;
        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;

        if (leftMarriageNode) {
            leftMarriageBiologicalChildrenIds = leftMarriageNode.inverseBiologicalParents;
            leftMarriageAdoptiveChildrenIds = leftMarriageNode.inverseAdoptiveParents;
        }

        if (mainMarriageNode) {
            mainMarriageBiologicalChildrenIds = mainMarriageNode.inverseBiologicalParents;
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.inverseAdoptiveParents;
        }

        const takenSpouseNodeGroupContainers = [];
        const childrenNodeGroupContainers = childrenRow.querySelectorAll('.tree-nodes-group-container');

        const siblings = [];

        for (let childrenNodeGroupContainer of childrenNodeGroupContainers) {

            if (takenSpouseNodeGroupContainers.includes(childrenNodeGroupContainer))
                continue;

            let childMaleNode = childrenNodeGroupContainer.querySelector('.tree-node-male');
            let childFemaleNode = childrenNodeGroupContainer.querySelector('.tree-node-female');

            let childMaleId = Number(childMaleNode?.id);
            let childFemaleId = Number(childFemaleNode?.id);

            if (leftMarriageBiologicalChildrenIds != null &&
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
                continue;
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
                continue;
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
                continue;
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
                continue;
            }
        }

        const treeSiblingsContainer = document.createElement('div')
        treeSiblingsContainer.className = 'tree-siblings-container';

        let added = false;
        siblings.forEach((s, i) => {
            treeSiblingsContainer.appendChild(s);
            added = true;
        });

        if (added)
            sortedChildrenRow.appendChild(treeSiblingsContainer);
    }

    // orphans
    const childrenNodeGroupContainers = childrenRow.querySelectorAll('.tree-nodes-group-container');
    const firstSpousesNodeGroupContainers = [];
    childrenNodeGroupContainers.forEach(childrenNodeGroupContainer => {
        if (firstSpousesNodeGroupContainers.includes(childrenNodeGroupContainer))
            return;

        let childMaleNode = childrenNodeGroupContainer.querySelector('.tree-node-male');
        let childFemaleNode = childrenNodeGroupContainer.querySelector('.tree-node-female');

        let childMaleId = Number(childMaleNode?.id);
        let childFemaleId = Number(childFemaleNode?.id);
        let added = false;

        if (childMaleId) {
            const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

            if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {

                const treeSiblingsContainer = document.createElement('div')
                treeSiblingsContainer.className = 'tree-siblings-container';

                treeSiblingsContainer.appendChild(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                treeSiblingsContainer.appendChild(childrenNodeGroupContainer);
                sortedChildrenRow.appendChild(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                added = true;
            }
        }

        if (childFemaleId) {
            const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

            if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {

                const treeSiblingsContainer = document.createElement('div')
                treeSiblingsContainer.className = 'tree-siblings-container';

                treeSiblingsContainer.appendChild(childrenNodeGroupContainer);
                treeSiblingsContainer.appendChild(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                sortedChildrenRow.appendChild(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                added = true;
            }
        }

        if (!added) {
            const treeSiblingsContainer = document.createElement('div')
            treeSiblingsContainer.className = 'tree-siblings-container';

            treeSiblingsContainer.appendChild(childrenNodeGroupContainer);

            sortedChildrenRow.appendChild(treeSiblingsContainer);
        }
    });

    return sortedChildrenRow;
}
async function drawLines(linesContainer, parentsRow, childrenRow, maxChildrenWithParentsOnRows) {

    const numOfChildrensWithParentOnRow = getNumberOfChildrenWithParents(childrenRow);
    let offsetOnTop = (1 + ((maxChildrenWithParentsOnRows - numOfChildrensWithParentOnRow) * 0.5)) * linesVerticalOffset;

    let parentsNodesGroupContainers = parentsRow.querySelectorAll('.tree-nodes-group-container');
    for (let parentsNodeGroupContainer of parentsNodesGroupContainers) {

        let leftMarriageNode = parentsNodeGroupContainer.querySelector('.left-marriage');
        let mainMarriageNode = parentsNodeGroupContainer.querySelector('.main-marriage');

        let oneTreeNodeRect =
            (parentsNodeGroupContainer.querySelector('.tree-node-male') ?? parentsNodeGroupContainer.querySelector('.tree-node-female'))
                .getBoundingClientRect();

        let leftMarriageBiologicalChildrenIds;
        let leftMarriageAdoptiveChildrenIds;
        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;

        if (leftMarriageNode) {
            leftMarriageBiologicalChildrenIds = leftMarriageNode.inverseBiologicalParents;
            leftMarriageAdoptiveChildrenIds = leftMarriageNode.inverseAdoptiveParents;
        }

        if (mainMarriageNode) {
            mainMarriageBiologicalChildrenIds = mainMarriageNode.inverseBiologicalParents;
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.inverseAdoptiveParents;
        }

        const mainMarriageBiologicalChildrenNodes = [];
        const mainMarriageAdoptiveChildrenNodes = [];
        const leftMarriageBiologicalChildrenNodes = [];
        const leftMarriageAdoptiveChildrenNodes = [];

        let childrenNodesGroupContainers = childrenRow.querySelectorAll('.tree-nodes-group-container');

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

        const leftMarriageRect = leftMarriageNode?.getBoundingClientRect()
        const mainMarriageRect = mainMarriageNode?.getBoundingClientRect();

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


        if (leftMarriageNode)
            drawMarriageLines(linesContainer, leftMarriageNode);
    }
}