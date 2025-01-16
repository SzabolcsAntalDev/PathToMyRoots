const nodeWidth = 100;
const nodeHeight = 50;
const linesVerticalOffset = 4;
const sleepInterval = 0;

const apiUrl = "https://localhost:7241/api/person/getfamily/";

async function createTreeDiagram(personId) {
    const treeDiagram = document.getElementById('tree-diagram');
    const treeLines = document.getElementById('tree-lines');

    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let levelIndexesToDivsDictionary = {};
    let baseLevelIndex = 0;
    await createNodesFrom(personId, processedPersonIds, levelIndexesToDivsDictionary, baseLevelIndex);

    const descSortedLevelIndexes = Object.keys(levelIndexesToDivsDictionary)
        .map(Number)
        .sort((a, b) => b - a);

    const rootLevelIndex = descSortedLevelIndexes[0]

    let parentsLevelDiv = levelIndexesToDivsDictionary[rootLevelIndex];
    treeDiagram.appendChild(parentsLevelDiv);
    await sleep(sleepInterval);

    // sort children
    for (let i = 1; i < descSortedLevelIndexes.length; i++) {
        const childrenLevelIndex = descSortedLevelIndexes[i];
        const childrenLevelDiv = levelIndexesToDivsDictionary[childrenLevelIndex];

        let sortedChildrenLevelDiv = createTreeLevelDiv();
        treeDiagram.appendChild(sortedChildrenLevelDiv);
        parentsLevelDiv = await fillWithSortedChildren(sortedChildrenLevelDiv, parentsLevelDiv, childrenLevelDiv);
    }

    // draw lines
    const treeDiagramStyle = window.getComputedStyle(treeDiagram);
    const treeDiagramWidth = treeDiagram.offsetWidth || parseFloat(treeDiagramStyle.width);
    const treeDiagramHeight = treeDiagram.offsetHeight || parseFloat(treeDiagramStyle.height);

    treeLines.style.width = `${treeDiagramWidth}px`;
    treeLines.style.height = `${treeDiagramHeight}px`;

    const levelDivsCollection = treeDiagram.querySelectorAll(".tree-line-div");
    for (let i = 1; i < levelDivsCollection.length; i++) {
        const parentsLevelDiv1 = levelDivsCollection[i - 1];
        const childrenLevelDiv = levelDivsCollection[i];

        await drawLines(parentsLevelDiv1, childrenLevelDiv);
    }
}

async function fillWithSortedChildren(sortedChildrenLevelDiv, parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');

    for (let parentsDiv of parentsDivs) {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let pairDivs = childrenLevelDiv.querySelectorAll('.tree-div');
        for (let pairDiv of pairDivs) {
            let malesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-male')?.biologicalMotherId;
            let malesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-male')?.biologicalFatherId;
            let femalesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-female')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-female')?.biologicalFatherId;

            if ((fatherId != null && malesChildBiologicalFatherId != null && fatherId == malesChildBiologicalFatherId) ||
                (fatherId != null && femalesChildBiologicalFatherId != null && fatherId == femalesChildBiologicalFatherId) ||
                (motherId != null && malesChildBiologicalMotherId != null && motherId == malesChildBiologicalMotherId) ||
                (motherId != null && femalesChildBiologicalMotherId != null && motherId == femalesChildBiologicalMotherId)) {
                sortedChildrenLevelDiv.appendChild(pairDiv);
                await sleep(sleepInterval);

            }
        }
    }

    return sortedChildrenLevelDiv;
}

async function drawLines(parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');
    let childrenDivs = childrenLevelDiv.querySelectorAll('.tree-div');

    let i = -5 * linesVerticalOffset;

    for (let parentsDiv of parentsDivs) {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let pairDivs = childrenLevelDiv.querySelectorAll('.tree-div');

        for (let pairDiv of pairDivs) {
            let pairMaleNode = pairDiv.querySelector('.tree-node-male');
            let pairFemaleNode = pairDiv.querySelector('.tree-node-female');

            let malesBiologicalFatherId = pairMaleNode?.biologicalFatherId;
            let malesBiologicalMotherId = pairMaleNode?.biologicalMotherId;
            let femalesBiologicalFatherId = pairFemaleNode?.biologicalFatherId;
            let femalesBiologicalMotherId = pairFemaleNode?.biologicalMotherId;

            if (pairMaleNode != null && (fatherId == malesBiologicalFatherId || motherId == malesBiologicalMotherId)) {
                drawLine(parentsDiv, pairMaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }

            if (pairFemaleNode != null && (fatherId == femalesBiologicalFatherId || motherId == femalesBiologicalMotherId)) {
                drawLine(parentsDiv, pairFemaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }
        }
    }
}

function drawLine(parentElement, childElement, verticalOffset) {
    const parentRect = parentElement.getBoundingClientRect();
    const childRect = childElement.getBoundingClientRect();

    const svg = document.getElementById("tree-lines");

    const parentX = parentRect.left + parentRect.width / 2 - svg.getBoundingClientRect().left;
    const parentY = parentRect.top + parentRect.height - svg.getBoundingClientRect().top;
    const childX = childRect.left + childRect.width / 2 - svg.getBoundingClientRect().left;
    const childY = childRect.top - svg.getBoundingClientRect().top;

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

    svg.appendChild(path);
}

async function createNodesFrom(personId, processedPersonIds, divsOnLevels, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const response = await fetch(`${apiUrl}${personId}`);
    const person = await response.json();

    const treeDiv = createTreeDiv();

    if (person.isMale) {
        treeDiv.appendChild(createTreeNode(person));

        if (person.spouse != null) {
            const spouseResponse = await fetch(`${apiUrl}${person.spouseId}`);
            const spouse = await spouseResponse.json();
            treeDiv.appendChild(createTreeNode(spouse));
        }
    }
    else {
        if (person.spouse != null) {
            const spouseResponse = await fetch(`${apiUrl}${person.spouseId}`);
            const spouse = await spouseResponse.json();
            treeDiv.appendChild(createTreeNode(spouse));
        }
        treeDiv.appendChild(createTreeNode(person));
    }

    if (person.spouse != null) {
        treeDiv.appendChild(createLineBreak());
        treeDiv.appendChild(createTreeNodeMarried());
    }

    if (divsOnLevels[level] == null)
        divsOnLevels[level] = createTreeLevelDiv();

    divsOnLevels[level].appendChild(treeDiv);

    processedPersonIds.add(personId);
    processedPersonIds.add(person.spouseId);

    await createNodesFrom(person.biologicalFatherId, processedPersonIds, divsOnLevels, level + 1);
    if (person.spouse != null)
        await createNodesFrom(person.spouse.biologicalFatherId, processedPersonIds, divsOnLevels, level + 1);

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createNodesFrom(child.id, processedPersonIds, divsOnLevels, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createNodesFrom(child.id, processedPersonIds, divsOnLevels, level - 1);
}

function createTreeNode(person) {
    const treeNode = document.createElement('div');
    treeNode.id = person.id;
    treeNode.biologicalMotherId = person.biologicalMotherId;
    treeNode.biologicalFatherId = person.biologicalFatherId;
    treeNode.className = person.isMale ? 'tree-node-male' : 'tree-node-female';
    treeNode.innerText = `${person.id} - ${person.lastName} ${person.maidenName ? `(${person.maidenName}) ` : ''}${person.firstName}${person.otherNames ? ` ${person.otherNames}` : ''} 
                        (${dateToString(person.birthDate)} - ${dateToString(person.deathDate)})`;
    return treeNode;
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

function createTreeNodeMarried() {
    const treeNodeMarried = document.createElement('div');
    treeNodeMarried.className = 'tree-node-married';
    treeNodeMarried.innerText = 'married';
    return treeNodeMarried;
}

function createTreeDiv() {
    const treeDiv = document.createElement('div');
    treeDiv.className = 'tree-div';
    return treeDiv;
}

function createTreeLevelDiv() {
    const treeLevelDiv = document.createElement('div');
    treeLevelDiv.className = 'tree-line-div';
    return treeLevelDiv;
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}