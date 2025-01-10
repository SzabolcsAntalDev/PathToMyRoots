const nodeWidth = 100;
const nodeHeight = 50;

const apiUrl = "https://localhost:7241/api/person/getfamily/";

async function createTreeDiagram(personId) {
    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let divsOnLevels = {};
    let level = 0;

    await createNodesFrom(personId, processedPersonIds, divsOnLevels, level);

    const treeDiagram = document.getElementById('tree-diagram');

    const sortedKeys = Object.keys(divsOnLevels)
        .map(Number)
        .sort((a, b) => b - a);

    for (let level of sortedKeys)
        treeDiagram.appendChild(divsOnLevels[level]);
}

async function createNodesFrom(personId, processedPersonIds, divsOnLevels, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const response = await fetch(`${apiUrl}${personId}`);
    const person = await response.json();

    const treeDiv = createTreeDiv();

    treeDiv.appendChild(createTreeNode(person));

    if (person.spouse != null)
        treeDiv.appendChild(createTreeNode(person.spouse));

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
    treeNode.className = 'tree-node';
    treeNode.innerText = `${person.lastName} ${person.firstName}`;
    return treeNode;
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

createTreeDiagram(15);

