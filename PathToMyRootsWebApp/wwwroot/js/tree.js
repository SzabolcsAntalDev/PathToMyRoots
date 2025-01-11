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

    const treeDiagram1 = document.getElementById('tree-diagram1');
    const sortedKeys = Object.keys(divsOnLevels)
        .map(Number)
        .sort((a, b) => b - a);

    //for (let level of sortedKeys)
    //    treeDiagram1.appendChild(divsOnLevels[level]);

    const treeDiagram2 = document.getElementById('tree-diagram2');
    const rootParentsLevel = sortedKeys[0]
    let parentsLevelDivsCollection = [];
    let parentsLevelDiv = divsOnLevels[rootParentsLevel];
    parentsLevelDivsCollection.push(parentsLevelDiv);
    treeDiagram2.appendChild(parentsLevelDiv);

    // sort children
    for (let i = 1; i < sortedKeys.length; i++) {
        const childrenLevel = sortedKeys[i];
        const childrenLevelDiv = divsOnLevels[childrenLevel];

        parentsLevelDiv = sortChildrenLevelDiv(treeDiagram2, parentsLevelDiv, childrenLevelDiv);
        parentsLevelDivsCollection.push(parentsLevelDiv);
    }

    // draw lines
    for (let i = 1; i < parentsLevelDivsCollection.length; i++) {
        const parentsLevelDiv1 = parentsLevelDivsCollection[i - 1];
        const childrenLevelDiv = parentsLevelDivsCollection[i];

        drawLines(parentsLevelDiv1, childrenLevelDiv);
    }
}

function sortChildrenLevelDiv(treeDiagram2, parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');
    let sortedChildrenLevelDiv = createTreeLevelDiv();
    treeDiagram2.appendChild(sortedChildrenLevelDiv);

    parentsDivs.forEach(parentsDiv => {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let pairDivs = childrenLevelDiv.querySelectorAll('.tree-div');
        pairDivs.forEach(pairDiv => {
            let malesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-male')?.biologicalMotherId;
            let malesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-male')?.biologicalFatherId;
            let femalesChildBiologicalMotherId = pairDiv.querySelector('.tree-node-female')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = pairDiv.querySelector('.tree-node-female')?.biologicalFatherId;

            if (fatherId == malesChildBiologicalFatherId || fatherId == femalesChildBiologicalFatherId ||
                motherId == malesChildBiologicalMotherId || motherId == femalesChildBiologicalMotherId) {
                sortedChildrenLevelDiv.appendChild(pairDiv);
            }
        });
    });

    return sortedChildrenLevelDiv;
}

function drawLines(parentsLevelDiv, childrenLevelDiv) {
    svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.id = 'tree-lines-svg';
    svg.style.position = 'absolute';
    svg.style.top = '0';
    svg.style.left = '0';
    svg.style.width = '100%';
    svg.style.height = '100%';
    svg.style.pointerEvents = 'none';
    svg.style.border = "2px solid red";
    document.body.appendChild(svg);

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
                drawLine(parentsDiv, pairMaleNode, svg, i += linesVerticalOffset);
            }

            if (pairFemaleNode != null && (fatherId == femalesBiologicalFatherId || motherId == femalesBiologicalMotherId)) {
                drawLine(parentsDiv, pairFemaleNode, svg, i += linesVerticalOffset);
            }
        });
    });
}

function drawLine(parentElement, childElement, svg, verticalOffset) {
    const parentRect = parentElement.getBoundingClientRect();
    const childRect = childElement.getBoundingClientRect();

    const parentX = parentRect.left + parentRect.width / 2;
    const parentY = parentRect.top + parentRect.height;
    const childX = childRect.left + childRect.width / 2;
    const childY = childRect.top;

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

