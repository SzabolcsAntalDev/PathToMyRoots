const linesVerticalOffset = 8;
const sleepInterval = 0;

const apiUrl = "https://localhost:7241/api/person/getfamily/";
const imageApiUrl = "https://localhost:7241/";

async function removeTreeDiagram(personId) {
    const loadingTextContainer = document.getElementById("loading-text-container");
    if (loadingTextContainer)
        fadeInElement(loadingTextContainer);

    const diagramAndLinesContainer = document.getElementById('tree-diagram-and-lines-container' + personId);
    if (diagramAndLinesContainer) {
        await fadeOutElement(diagramAndLinesContainer)
        diagramAndLinesContainer.remove();
    }
}

async function createTreeDiagram(personId) {
    const treesContainer = document.getElementById("trees-container");

    const loadingTextContainer = await createOrGetLoadingTextContainer(treesContainer);
    fadeInElement(loadingTextContainer);

    const diagramAndLinesContainer = document.createElement('div');
    diagramAndLinesContainer.className = 'tree-diagram-and-lines-container';
    hideElement(diagramAndLinesContainer);
    diagramAndLinesContainer.id = 'tree-diagram-and-lines-container' + personId;

    const diagramContainer = document.createElement('div');
    diagramContainer.setAttribute('class', 'tree-diagram-container');

    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    linesContainer.setAttribute('class', 'tree-lines-container');

    diagramAndLinesContainer.appendChild(diagramContainer);
    diagramAndLinesContainer.appendChild(linesContainer);

    treesContainer.appendChild(diagramAndLinesContainer);

    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let levelIndexesToRowsDictionary = {};
    let baseLevelIndex = 0;
    await createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, baseLevelIndex);

    let maxChildrenWithParentsOnRows = 0;
    Object.values(levelIndexesToRowsDictionary).forEach(row => {
        maxChildrenWithParentsOnRows = Math.max(maxChildrenWithParentsOnRows, getNumberOfChildrenWithParents(row));
    });

    const descSortedLevelIndexes = Object.keys(levelIndexesToRowsDictionary)
        .map(Number)
        .sort((a, b) => b - a);

    const rootLevelIndex = descSortedLevelIndexes[0]
    let parentsRow = levelIndexesToRowsDictionary[rootLevelIndex];
    diagramContainer.appendChild(parentsRow);
    await sleep(sleepInterval);

    // sort children
    for (let i = 1; i < descSortedLevelIndexes.length; i++) {
        const childrenLevelIndex = descSortedLevelIndexes[i];
        const childrenRow = levelIndexesToRowsDictionary[childrenLevelIndex];

        let sortedChildrenRow = createRow();
        diagramContainer.appendChild(sortedChildrenRow);
        parentsRow = await fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow);
    }

    // set bottom padding to each child except the last one
    const rows = diagramContainer.querySelectorAll(".tree-level-row");
    rows.forEach((row, index) => {
        if (index !== rows.length - 1) {
            row.style.padding = "0px 0px " + ((maxChildrenWithParentsOnRows + 3) * linesVerticalOffset) + "px 0px";
        }
    });

    // draw lines
    const treeDiagramContainerStyle = window.getComputedStyle(diagramContainer);
    const treeDiagramContainerWidth = diagramContainer.offsetWidth || parseFloat(treeDiagramContainerStyle.width);
    const treeDiagramContainerHeight = diagramContainer.offsetHeight || parseFloat(treeDiagramContainerStyle.height);

    linesContainer.style.width = `${treeDiagramContainerWidth}px`;
    linesContainer.style.height = `${treeDiagramContainerHeight}px`;

    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = rows[i - 1];
        const childrenRowInner = rows[i];

        await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxChildrenWithParentsOnRows);
    }

    scrollToMiddle(diagramAndLinesContainer, diagramContainer);

    fadeOutElement(loadingTextContainer);
    fadeInElement(diagramAndLinesContainer);
}

function getNumberOfChildrenWithParents(row) {
    return Array
        .from(row.querySelectorAll('.tree-node-male, .tree-node-female'))
        .filter(p =>
            p.biologicalFatherId !== null ||
            p.biologicalMotherId !== null ||
            p.adoptiveFatherId !== null ||
            p.adoptiveMotherId !== null).length;
}

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}

async function createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();
    const nodesGroupContainer = createNodesGroupContainer();
    const nodesGroup = createNodesGroup();

    if (person.isMale) {

        if (person.secondSpouse != null) {
            const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
            nodesGroupContainer.appendChild(createNodeMarriage(person, firstSpouse, false));
            nodesGroupContainer.style.paddingLeft = "0px";
            nodesGroup.appendChild(createNode(person));
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();
            nodesGroup.appendChild(createNode(secondSpouse));

            nodesGroup.appendChild(createLineBreak());
            nodesGroup.appendChild(createNodeMarriage(person, secondSpouse, true));

            processedPersonIds.add(person.secondSpouseId);
        }
        else {
            if (person.firstSpouse != null) {
                nodesGroup.appendChild(createNode(person));

                const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
                nodesGroup.appendChild(createNode(firstSpouse));

                nodesGroup.appendChild(createLineBreak());
                nodesGroup.appendChild(createNodeMarriage(person, firstSpouse, true));

                processedPersonIds.add(person.firstSpouseId);
            }
            else {
                nodesGroup.appendChild(createNode(person));
            }
        }
    }
    else {
        if (person.secondSpouse != null) {
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();
            nodesGroup.appendChild(createNode(secondSpouse));
            nodesGroup.appendChild(createNode(person));

            nodesGroup.appendChild(createLineBreak());
            nodesGroup.appendChild(createNodeMarriage(person, secondSpouse, true));

            processedPersonIds.add(person.secondSpouseId);

            nodesGroupContainer.style.paddingRight = "0px";
        }
        else {
            if (person.firstSpouse != null) {
                const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
                nodesGroup.appendChild(createNode(firstSpouse));
                nodesGroup.appendChild(createNode(person));

                nodesGroup.appendChild(createLineBreak());
                nodesGroup.appendChild(createNodeMarriage(person, firstSpouse, true));

                processedPersonIds.add(person.firstSpouseId);
            }
            else {
                nodesGroup.appendChild(createNode(person));
            }
        }
    }

    nodesGroupContainer.appendChild(nodesGroup);

    processedPersonIds.add(personId);

    if (levelIndexesToRowsDictionary[level] == null)
        levelIndexesToRowsDictionary[level] = createRow();

    levelIndexesToRowsDictionary[level].appendChild(nodesGroupContainer);

    await createRowsFrom(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
    await createRowsFrom(person.adoptiveFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);

    if (person.firstSpouse != null) {
        await createRowsFrom(person.firstSpouse.id, processedPersonIds, levelIndexesToRowsDictionary, level);
        await createRowsFrom(person.firstSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
        await createRowsFrom(person.firstSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
    }

    if (person.secondSpouse != null) {
        await createRowsFrom(person.secondSpouse.id, processedPersonIds, levelIndexesToRowsDictionary, level);
        await createRowsFrom(person.secondSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
        await createRowsFrom(person.secondSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);
}

function getCommonBiologicalChildren(person, spouse) {
    if (person.isMale) {
        return person.inverseBiologicalFather
            .filter(child => spouse.inverseBiologicalMother.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    } else {
        return person.inverseBiologicalMother
            .filter(child => spouse.inverseBiologicalFather.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    }
}

function getCommonAdoptiveChildren(person, spouse) {
    if (person.isMale) {
        return person.inverseAdoptiveFather
            .filter(child => spouse.inverseAdoptiveMother.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    } else {
        return person.inverseAdoptiveMother
            .filter(child => spouse.inverseAdoptiveFather.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    }
}

async function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    const parentsNodeGroupContainers = parentsRow.querySelectorAll('.tree-nodes-group-container');
    const orphans = [];

    for (let parentsNodeGroupContainer of parentsNodeGroupContainers) {

        let mainMarriageNode;
        let leftMarriageNode;

        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;
        let leftMarriageBiologicalChildrenIds;
        let leftMarriageAdoptiveChildrenIds;

        let marriageNodes = parentsNodeGroupContainer.querySelectorAll('.tree-node-marriage');

        if (marriageNodes.length == 2) {

            leftMarriageNode = marriageNodes[0];
            mainMarriageNode = marriageNodes[1];

            leftMarriageBiologicalChildrenIds = leftMarriageNode.inverseBiologicalParents;
            leftMarriageAdoptiveChildrenIds = leftMarriageNode.inverseAdoptiveParents;
            mainMarriageBiologicalChildrenIds = mainMarriageNode.inverseBiologicalParents;
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.inverseAdoptiveParents;
        }

        if (marriageNodes.length == 1) {
            mainMarriageNode = marriageNodes[0];

            mainMarriageBiologicalChildrenIds = mainMarriageNode.inverseBiologicalParents;
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.inverseAdoptiveParents;
        }

        let childrenNodeGroupContainers = childrenRow.querySelectorAll('.tree-nodes-group-container');
        for (let childrenNodeGroupContainer of childrenNodeGroupContainers) {

            let childMaleNode = childrenNodeGroupContainer.querySelector('.tree-node-male');
            let childFemaleNode = childrenNodeGroupContainer.querySelector('.tree-node-female');

            let childMaleId = Number(childMaleNode?.id);
            let childFemaleId = Number(childFemaleNode?.id);

            let added = false;

            if (leftMarriageBiologicalChildrenIds != null &&
                (leftMarriageBiologicalChildrenIds.includes(childMaleId) || leftMarriageBiologicalChildrenIds.includes(childFemaleId))) {
                sortedChildrenRow.appendChild(childrenNodeGroupContainer);
                added = true;
                continue;
            }

            if (leftMarriageAdoptiveChildrenIds != null &&
                (leftMarriageAdoptiveChildrenIds.includes(childMaleId) || leftMarriageAdoptiveChildrenIds.includes(childFemaleId))) {
                sortedChildrenRow.appendChild(childrenNodeGroupContainer);
                added = true;
                continue;
            }

            if (mainMarriageBiologicalChildrenIds != null &&
                (mainMarriageBiologicalChildrenIds.includes(childMaleId) || mainMarriageBiologicalChildrenIds.includes(childFemaleId))) {
                sortedChildrenRow.appendChild(childrenNodeGroupContainer);
                added = true;
                continue;
            }

            if (mainMarriageAdoptiveChildrenIds != null &&
                (mainMarriageAdoptiveChildrenIds.includes(childMaleId) || mainMarriageAdoptiveChildrenIds.includes(childFemaleId))) {
                sortedChildrenRow.appendChild(childrenNodeGroupContainer);
                added = true;
                continue;
            }

            orphans.push(childrenNodeGroupContainer);
        }
    }

    orphans.forEach(o => {
        sortedChildrenRow.appendChild(o);
    });

    return sortedChildrenRow;
}

function createRow() {
    const row = document.createElement('div');
    row.className = 'tree-level-row';
    return row;
}

function createNodesGroupContainer() {
    const nodesGroupContainer = document.createElement('div');
    nodesGroupContainer.className = 'tree-nodes-group-container';
    return nodesGroupContainer;
}

function createNodesGroup() {
    const nodesGroup = document.createElement('div');
    nodesGroup.className = 'tree-nodes-group';
    return nodesGroup;
}

function createNode(person) {
    const node = document.createElement('div');
    node.id = person.id;
    node.biologicalMotherId = person.biologicalMotherId;
    node.biologicalFatherId = person.biologicalFatherId;
    node.adoptiveMotherId = person.adoptiveMotherId;
    node.adoptiveFatherId = person.adoptiveFatherId;
    node.firstSpouseId = person.firstSpouseId;
    node.secondSpouseId = person.secondSpouseId;

    node.className = person.isMale ? 'tree-node-male' : 'tree-node-female';

    const imgPerson = document.createElement('img');
    imgPerson.src = 'https://localhost:7241/api/Image/get/' + (person.imageUrl ?? "missingImage.png");
    imgPerson.className = 'tree-node-image';

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanPersonName = document.createElement('span');
    const personNameNodeText = personToPersonNameNodeText(person);
    spanPersonName.innerText = personNameNodeText;
    spanPersonName.className = 'tree-node-main-name-text';

    const spanPersonLived = document.createElement('span');
    const personLivedNodeText = personToPersonLivedNodeText(person);
    spanPersonLived.innerText = personLivedNodeText;
    spanPersonLived.className = 'tree-node-main-lived-text';

    textsContainer.appendChild(spanPersonName);
    textsContainer.appendChild(spanPersonLived);

    const svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svgElement.setAttribute('class', 'tree-action-img');
    svgElement.setAttribute('width', '20');
    svgElement.setAttribute('height', '20');

    const useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    useElement.setAttribute('href', '/icons/icons.svg#edit');
    svgElement.appendChild(useElement);

    const buttonEditPerson = document.createElement('button');
    buttonEditPerson.appendChild(svgElement);
    buttonEditPerson.className = "action-button-on-image";
    buttonEditPerson.style.visibility = 'hidden';

    buttonEditPerson.addEventListener('click', function () {
        const personId = person.id;
        const url = `/Person/EditPerson?id=${personId}`;
        window.location.href = url;
    });

    node.appendChild(imgPerson);
    node.appendChild(textsContainer);
    node.appendChild(buttonEditPerson);
    node.title = `${personNameNodeText}\n${personLivedNodeText}`

    node.addEventListener("mouseenter", () => {
        buttonEditPerson.style.visibility = 'visible';
    });

    node.addEventListener("mouseleave", () => {
        buttonEditPerson.style.visibility = 'hidden';
    });

    return node;
}

function personToPersonNameNodeText(person) {
    let details = [];

    if (person.nobleTitle)
        details.push(person.nobleTitle);

    if (person.lastName)
        details.push(person.lastName);

    if (person.maidenName)
        details.push(`(${person.maidenName})`);

    if (person.firstName)
        details.push(person.firstName);

    if (person.otherNames)
        details.push(person.otherNames);

    return details.filter(Boolean).join(' ');
}

function personToPersonLivedNodeText(person) {
    return `(${dateToString(person.birthDate)} - ${dateToString(person.deathDate)})`;
}

function dateToString(date) {
    if (date == null)
        return "";

    if (date === UnknownServerDate)
        return HumanReadableDateUnknownDate;

    return formatDateString(date);
}

function createLineBreak() {
    const lineBreak = document.createElement('br');
    return lineBreak;
}

function createNodeMarriage(person, spouse, isLastMarriage) {

    const node = document.createElement('div');
    node.className = 'tree-node-marriage';

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanMarriage = document.createElement('span');
    spanMarriage.innerText = 'marriage';
    spanMarriage.className = 'tree-node-marriage-text';

    const spanMarriageDate = document.createElement('span');
    spanMarriageDate.innerText = personToPersonMarriageDateText(person);
    spanMarriageDate.className = 'tree-node-marriage-date-text';

    textsContainer.appendChild(spanMarriage);
    textsContainer.appendChild(spanMarriageDate);

    node.appendChild(textsContainer);

    node.inverseBiologicalParents = getCommonBiologicalChildren(person, spouse);
    node.inverseAdoptiveParents = getCommonAdoptiveChildren(person, spouse);

    node.isLastMarriage = isLastMarriage;

    return node;
}

function personToPersonMarriageDateText(person) {
    return `${dateToString(person.marriageDate)}`;
}

async function drawLines(linesContainer, parentsRow, childrenRow, maxChildrenWithParentsOnRows) {

    const numOfChildrensWithParentOnRow = getNumberOfChildrenWithParents(childrenRow);
    let offset = (((maxChildrenWithParentsOnRows - numOfChildrensWithParentOnRow) / 2) + 1) * linesVerticalOffset;

    let parentsNodesGroupContainers = parentsRow.querySelectorAll('.tree-nodes-group-container');
    for (let parentsNodeGroupContainer of parentsNodesGroupContainers) {

        let mainMarriageNode;
        let leftMarriageNode;

        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;
        let leftMarriageBiologicalChildrenIds;
        let leftMarriageAdoptiveChildrenIds;

        let marriageNodes = parentsNodeGroupContainer.querySelectorAll('.tree-node-marriage');

        if (marriageNodes.length == 2) {
            leftMarriageNode = marriageNodes[0];
            mainMarriageNode = marriageNodes[1];

            leftMarriageBiologicalChildrenIds = leftMarriageNode.inverseBiologicalParents;
            leftMarriageAdoptiveChildrenIds = leftMarriageNode.inverseAdoptiveParents;
            mainMarriageBiologicalChildrenIds = mainMarriageNode.inverseBiologicalParents;
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.inverseAdoptiveParents;
        }

        if (marriageNodes.length == 1) {
            mainMarriageNode = marriageNodes[0];

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
            drawChildLine(linesContainer, mainMarriageNode, child, offset += linesVerticalOffset, true);
        });

        mainMarriageBiologicalChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offset += linesVerticalOffset, true);
        });

        mainMarriageAdoptiveChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offset += linesVerticalOffset, false);
        });

        mainMarriageAdoptiveChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, mainMarriageNode, child, offset += linesVerticalOffset, false);
        });

        let leftMarriageExtraOffset;
        if (leftMarriageRect) {
            leftMarriageExtraOffset = mainMarriageRect.top - leftMarriageRect.top;
        }

        leftMarriageBiologicalChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offset += linesVerticalOffset), true);
        });

        leftMarriageBiologicalChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offset += linesVerticalOffset), true);
        });

        leftMarriageAdoptiveChildrenOnLeft.forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offset += linesVerticalOffset), false);
        });

        leftMarriageAdoptiveChildrenOnRight.reverse().forEach(child => {
            drawChildLine(linesContainer, leftMarriageNode, child, leftMarriageExtraOffset + (offset += linesVerticalOffset), false);
        });


        if (leftMarriageNode)
            drawMarriageLines(linesContainer, leftMarriageNode);
    }
}

function drawMarriageLines(linesContainer, marriageNode) {
    const marriageRect = marriageNode.getBoundingClientRect();
    const linesContainerClientRect = linesContainer.getBoundingClientRect();

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

    linesContainer.appendChild(path);
}

function drawChildLine(linesContainer, marriageNode, child, verticalOffset, isBiological) {
    const marriageRect = marriageNode.getBoundingClientRect();
    const childRect = child.getBoundingClientRect();

    const linesContainerClientRect = linesContainer.getBoundingClientRect();

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

    linesContainer.appendChild(path);
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}