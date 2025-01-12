const nodeWidth = 100;
const nodeHeight = 50;
const linesVerticalOffset = 4;

const apiUrl = "https://localhost:7241/api/person/getfamily/";

async function createTreeDiagram(personId) {
    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let divsOnLevels = {};
    let level = 0;
    await createNodesFrom(personId, processedPersonIds, divsOnLevels, level);

    const sortedKeys = Object.keys(divsOnLevels)
        .map(Number)
        .sort((a, b) => b - a);

    const treeDiagram = document.getElementById('tree-diagram');
    const rootParentsLevel = sortedKeys[0]
    let parentsLevelDivsCollection = [];
    let parentsLevelDiv = divsOnLevels[rootParentsLevel];
    parentsLevelDivsCollection.push(parentsLevelDiv);
    treeDiagram.appendChild(parentsLevelDiv);

    // sort children
    for (let i = 1; i < sortedKeys.length; i++) {
        const childrenLevel = sortedKeys[i];
        const childrenLevelDiv = divsOnLevels[childrenLevel];

        parentsLevelDiv = sortChildrenLevelDiv(treeDiagram, parentsLevelDiv, childrenLevelDiv);
        parentsLevelDivsCollection.push(parentsLevelDiv);
    }

    const treeLines = document.getElementById('tree-lines');

    // Get the size of treeDiagram
    const treeDiagramStyles = window.getComputedStyle(treeDiagram);
    const width = treeDiagram.offsetWidth || parseFloat(treeDiagramStyles.width);
    const height = treeDiagram.offsetHeight || parseFloat(treeDiagramStyles.height);

    // Set the size of treeLines
    treeLines.style.width = `${width}px`;
    treeLines.style.height = `${height}px`;

    // draw lines
    for (let i = 1; i < parentsLevelDivsCollection.length; i++) {
        const parentsLevelDiv1 = parentsLevelDivsCollection[i - 1];
        const childrenLevelDiv = parentsLevelDivsCollection[i];

        drawLines(parentsLevelDiv1, childrenLevelDiv);
    }
}

function sortChildrenLevelDiv(treeDiagram, parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');
    let sortedChildrenLevelDiv = createTreeLevelDiv();
    treeDiagram.appendChild(sortedChildrenLevelDiv);

    parentsDivs.forEach(parentsDiv => {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let pairDivs = childrenLevelDiv.querySelectorAll('.tree-div');
        pairDivs.forEach(pairDiv => {
            let malesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-male')?.biologicalMotherId;
            let malesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-male')?.biologicalFatherId;
            let femalesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-female')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-female')?.biologicalFatherId;

            if ((fatherId != null && malesChildBiologicalFatherId   != null && fatherId == malesChildBiologicalFatherId) ||
                (fatherId != null && femalesChildBiologicalFatherId != null && fatherId == femalesChildBiologicalFatherId) ||
                (motherId != null && malesChildBiologicalMotherId   != null && motherId == malesChildBiologicalMotherId) ||
                (motherId != null && femalesChildBiologicalMotherId != null && motherId == femalesChildBiologicalMotherId)) {
                sortedChildrenLevelDiv.appendChild(pairDiv);
            }
        });
    });

    return sortedChildrenLevelDiv;
}

function drawLines(parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');
    let childrenDivs = childrenLevelDiv.querySelectorAll('.tree-div');

    let i = -5 * linesVerticalOffset;

    parentsDivs.forEach(parentsDiv => {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let pairDivs = childrenLevelDiv.querySelectorAll('.tree-div');

        pairDivs.forEach(pairDiv => {
            let pairMaleNode = pairDiv.querySelector('.tree-node-male');
            let pairFemaleNode = pairDiv.querySelector('.tree-node-female');

            let malesBiologicalFatherId = pairMaleNode?.biologicalFatherId;
            let malesBiologicalMotherId = pairMaleNode?.biologicalMotherId;
            let femalesBiologicalFatherId = pairFemaleNode?.biologicalFatherId;
            let femalesBiologicalMotherId = pairFemaleNode?.biologicalMotherId;

            if (pairMaleNode != null && (fatherId == malesBiologicalFatherId || motherId == malesBiologicalMotherId)) {
                drawLine(parentsDiv, pairMaleNode, i += linesVerticalOffset);
            }

            if (pairFemaleNode != null && (fatherId == femalesBiologicalFatherId || motherId == femalesBiologicalMotherId)) {
                drawLine(parentsDiv, pairFemaleNode, i += linesVerticalOffset);
            }
        });
    });
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

    // Draw the path
    const pathData = `
        M ${parentX},${parentY}
        L ${parentX},${middleY}
        L ${childX},${middleY}
        L ${childX},${childY}
    `;

    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('stroke', 'black');
    path.setAttribute('stroke-width', '1');
    path.setAttribute('fill', 'transparent'); // No fill for the path


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
        if (person.spouse != null)
            treeDiv.appendChild(createTreeNode(person.spouse));
    }
    else {
        if (person.spouse != null)
            treeDiv.appendChild(createTreeNode(person.spouse));
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
    treeNode.innerText = `${person.id} - ${person.lastName} ${person.firstName}`;
    return treeNode;
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

createTreeDiagram(35);

