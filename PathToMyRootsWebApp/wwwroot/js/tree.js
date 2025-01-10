const familyData = JSON.parse(document.getElementById('familyData').textContent);

const nodeWidth = 100;
const nodeHeight = 50;

function createTreeDiagram(family) {

    let divsOnLevels = {};
    let level = 0;

    createNodesFrom(family, divsOnLevels, level);

    const treeDiagram = document.getElementById('tree-diagram');

    let reversedDivsOnLevels = Object.keys(divsOnLevels).reverse();
    for (let level of reversedDivsOnLevels)
        treeDiagram.appendChild(divsOnLevels[level]);
}

function createNodesFrom(person, divsOnLevels, level) {
    if (person == null)
        return;

    const treeDiv = createTreeDiv();

    treeDiv.appendChild(createTreeNode(person));

    if (person.Spouse != null)
        treeDiv.appendChild(createTreeNode(person.Spouse));

    if (divsOnLevels[level] == null)
        divsOnLevels[level] = createTreeLevelDiv();

    divsOnLevels[level].appendChild(treeDiv);

    createNodesFrom(person.BiologicalFather, divsOnLevels, level + 1);
    if (person.Spouse != null)
        createNodesFrom(person.Spouse.BiologicalFather, divsOnLevels, level + 1);
}

function createTreeNode(person) {
    const treeNode = document.createElement('div');
    treeNode.className = 'tree-node';
    treeNode.innerText = `${person.LastName} ${person.FirstName}`;
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

createTreeDiagram(familyData);

