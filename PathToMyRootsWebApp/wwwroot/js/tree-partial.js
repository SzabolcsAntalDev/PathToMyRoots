const linesVerticalOffset = 4;
const sleepInterval = 0;

const apiUrl = "https://localhost:7241/api/person/getfamily/";
const imageApiUrl = "https://localhost:7241/";

async function createTreeDiagram(personId) {
    const treeDiagramContainer = document.getElementById('tree-diagram-container');
    const treeLinesContainer = document.getElementById('tree-lines-container');

    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let levelIndexesToRowsDictionary = {};
    let baseLevelIndex = 0;
    await createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, baseLevelIndex);

    const descSortedLevelIndexes = Object.keys(levelIndexesToRowsDictionary)
        .map(Number)
        .sort((a, b) => b - a);

    const rootLevelIndex = descSortedLevelIndexes[0]

    let parentsRow = levelIndexesToRowsDictionary[rootLevelIndex];
    treeDiagramContainer.appendChild(parentsRow);
    await sleep(sleepInterval);

    // sort children
    for (let i = 1; i < descSortedLevelIndexes.length; i++) {
        const childrenLevelIndex = descSortedLevelIndexes[i];
        const childrenRow = levelIndexesToRowsDictionary[childrenLevelIndex];

        let sortedChildrenRow = createRow();
        treeDiagramContainer.appendChild(sortedChildrenRow);
        parentsRow = await fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow);
    }

    // draw lines
    const treeDiagramContainerStyle = window.getComputedStyle(treeDiagramContainer);
    const treeDiagramContainerWidth = treeDiagramContainer.offsetWidth || parseFloat(treeDiagramContainerStyle.width);
    const treeDiagramContainerHeight = treeDiagramContainer.offsetHeight || parseFloat(treeDiagramContainerStyle.height);

    treeLinesContainer.style.width = `${treeDiagramContainerWidth}px`;
    treeLinesContainer.style.height = `${treeDiagramContainerHeight}px`;

    const rows = treeDiagramContainer.querySelectorAll(".tree-level-row");
    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = rows[i - 1];
        const childrenRowInner = rows[i];

        await drawLines(parentsRowInner, childrenRowInner);
    }
}

async function createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();

    const nodesGroup = createNodesGroup();

    if (person.isMale) {
        nodesGroup.appendChild(createNode(person));

        if (person.spouse != null) {
            const spouse = await (await fetch(`${apiUrl}${person.spouseId}`)).json();
            nodesGroup.appendChild(createNode(spouse));
        }
    }
    else {
        if (person.spouse != null) {
            const spouse = await (await fetch(`${apiUrl}${person.spouseId}`)).json();
            nodesGroup.appendChild(createNode(spouse));
        }
        nodesGroup.appendChild(createNode(person));
    }

    if (person.spouse != null) {
        nodesGroup.appendChild(createLineBreak());
        nodesGroup.appendChild(createNodeMarried());
    }

    if (levelIndexesToRowsDictionary[level] == null)
        levelIndexesToRowsDictionary[level] = createRow();

    levelIndexesToRowsDictionary[level].appendChild(nodesGroup);

    processedPersonIds.add(personId);
    processedPersonIds.add(person.spouseId);

    await createRowsFrom(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
    if (person.spouse != null)
        await createRowsFrom(person.spouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);
}

async function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    let parentsNodeGroups = parentsRow.querySelectorAll('.tree-nodes-group');

    for (let parentNodeGroup of parentsNodeGroups) {
        let fatherId = parentNodeGroup.querySelector('.tree-node-male')?.id;
        let motherId = parentNodeGroup.querySelector('.tree-node-female')?.id;

        let childrenNodeGroups = childrenRow.querySelectorAll('.tree-nodes-group');
        for (let childrenNodeGroup of childrenNodeGroups) {
            let malesChildBiologicalFatherId = childrenNodeGroup.querySelector('.tree-node-male')?.biologicalFatherId;
            let malesChildBiologicalMotherId = childrenNodeGroup.querySelector('.tree-node-male')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = childrenNodeGroup.querySelector('.tree-node-female')?.biologicalFatherId;
            let femalesChildBiologicalMotherId = childrenNodeGroup.querySelector('.tree-node-female')?.biologicalMotherId;

            if ((fatherId != null && malesChildBiologicalFatherId != null && fatherId == malesChildBiologicalFatherId) ||
                (fatherId != null && femalesChildBiologicalFatherId != null && fatherId == femalesChildBiologicalFatherId) ||
                (motherId != null && malesChildBiologicalMotherId != null && motherId == malesChildBiologicalMotherId) ||
                (motherId != null && femalesChildBiologicalMotherId != null && motherId == femalesChildBiologicalMotherId)) {
                sortedChildrenRow.appendChild(childrenNodeGroup);
                await sleep(sleepInterval);

            }
        }
    }

    return sortedChildrenRow;
}

function createRow() {
    const row = document.createElement('div');
    row.className = 'tree-level-row';
    return row;
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
    node.className = person.isMale ? 'tree-node-male' : 'tree-node-female';

    const imgPerson = document.createElement('img');
    if (person.imageUrl)
        imgPerson.src = "https://localhost:7241/uploads/" + person.imageUrl;

    imgPerson.className = 'tree-node-image';

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanPersonName = document.createElement('span');
    spanPersonName.innerText = personToPersonNameNodeText(person);
    spanPersonName.className = 'tree-node-name-text';

    const spanPersonLived = document.createElement('span');
    spanPersonLived.innerText = personToPersonLivedNodeText(person);
    spanPersonLived.className = 'tree-node-lived-text';

    textsContainer.appendChild(spanPersonName);
    textsContainer.appendChild(spanPersonLived);

    const imgEditPerson = document.createElement('img');
    imgEditPerson.className = "action-img";
    imgEditPerson.src = "../../icons/edit.svg";
    imgEditPerson.title = "Edit";

    const buttonEditPerson = document.createElement('button');
    buttonEditPerson.appendChild(imgEditPerson);
    buttonEditPerson.className = "action-button-on-image";

    buttonEditPerson.addEventListener('click', function () {
        const personId = person.id;
        const url = `/Person/EditPerson?id=${personId}`;
        window.location.href = url;
    });

    node.appendChild(imgPerson);
    node.appendChild(textsContainer);
    node.appendChild(buttonEditPerson);

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

function createNodeMarried() {
    const nodeMarried = document.createElement('div');
    nodeMarried.className = 'tree-node-married';
    nodeMarried.innerText = 'married';
    return nodeMarried;
}

async function drawLines(parentsRow, childrenRow) {
    let parentsNodesGroups = parentsRow.querySelectorAll('.tree-nodes-group');

    let i = -5 * linesVerticalOffset;

    for (let parentsNodeGroup of parentsNodesGroups) {
        let fatherId = parentsNodeGroup.querySelector('.tree-node-male')?.id;
        let motherId = parentsNodeGroup.querySelector('.tree-node-female')?.id;

        let childrenNodesGroups = childrenRow.querySelectorAll('.tree-nodes-group');

        for (let childrenNodesGroup of childrenNodesGroups) {
            let childMaleNode = childrenNodesGroup.querySelector('.tree-node-male');
            let childFemaleNode = childrenNodesGroup.querySelector('.tree-node-female');

            let malesBiologicalFatherId = childMaleNode?.biologicalFatherId;
            let malesBiologicalMotherId = childMaleNode?.biologicalMotherId;
            let femalesBiologicalFatherId = childFemaleNode?.biologicalFatherId;
            let femalesBiologicalMotherId = childFemaleNode?.biologicalMotherId;

            if (childMaleNode != null && (fatherId == malesBiologicalFatherId || motherId == malesBiologicalMotherId)) {
                drawLine(parentsNodeGroup, childMaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }

            if (childFemaleNode != null && (fatherId == femalesBiologicalFatherId || motherId == femalesBiologicalMotherId)) {
                drawLine(parentsNodeGroup, childFemaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }
        }
    }
}

function drawLine(parent, child, verticalOffset) {
    const parentRect = parent.getBoundingClientRect();
    const childRect = child.getBoundingClientRect();

    const linesContainer = document.getElementById("tree-lines-container");
    const linesContainerClientRect = linesContainer.getBoundingClientRect();

    const parentX = parentRect.left + parentRect.width / 2 - linesContainerClientRect.left;
    const parentY = parentRect.top + parentRect.height - linesContainerClientRect.top;
    const childX = childRect.left + childRect.width / 2 - linesContainerClientRect.left;
    const childY = childRect.top - linesContainerClientRect.top;

    const middleY = ((parentY + childY) / 2) + verticalOffset;

    const pathData = `
        M ${parentX},${parentY}
        L ${parentX},${middleY}
        L ${childX},${middleY}
        L ${childX},${childY}
    `;

    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', 'tree-line-svg');

    linesContainer.appendChild(path);
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}