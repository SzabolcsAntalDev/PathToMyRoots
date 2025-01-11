const nodeWidth = 100;
const nodeHeight = 50;

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
    let rootParentsLevel = sortedKeys[0]
    let parentsLevelDiv = divsOnLevels[rootParentsLevel];
    treeDiagram2.appendChild(parentsLevelDiv);

    // sort children
    for (let i = 1; i < sortedKeys.length; i++) {
        const childrenLevel = sortedKeys[i];
        let childrenLevelDiv = divsOnLevels[childrenLevel];

        parentsLevelDiv = sortChildrenLevelDiv(treeDiagram2, parentsLevelDiv, childrenLevelDiv);
    }

    // draw lines
}

function sortChildrenLevelDiv(treeDiagram2, parentsLevelDiv, childrenLevelDiv) {
    let parentsDivs = parentsLevelDiv.querySelectorAll('.tree-div');
    let sortedChildrenLevelDiv = createTreeLevelDiv();
    treeDiagram2.appendChild(sortedChildrenLevelDiv);

    parentsDivs.forEach(parentsDiv => {
        let fatherId = parentsDiv.querySelector('.tree-node-male')?.id;
        let motherId = parentsDiv.querySelector('.tree-node-female')?.id;

        let childDivs = childrenLevelDiv.querySelectorAll('.tree-div');
        childDivs.forEach(childDiv => {
            let malesChildBiologicalMotherIdId = childDiv.querySelector('.tree-node-male')?.biologicalMotherId;
            let malesChildBiologicalFatherId = childDiv.querySelector('.tree-node-male')?.biologicalFatherId;
            let femalesChildBiologicalMotherIdId = childDiv.querySelector('.tree-node-female')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = childDiv.querySelector('.tree-node-female')?.biologicalFatherId;

            if (motherId == malesChildBiologicalMotherIdId || motherId == femalesChildBiologicalMotherIdId ||
                fatherId == malesChildBiologicalFatherId || fatherId == femalesChildBiologicalFatherId) {
                sortedChildrenLevelDiv.appendChild(childDiv);
            }
        });
    });

    return sortedChildrenLevelDiv;
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
    treeNode.innerText = `${person.lastName} ${person.firstName}`;
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

