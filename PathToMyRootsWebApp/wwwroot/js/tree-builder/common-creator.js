function createNodesAndLinesContainer() {
    const nodesAndLinesContainer = document.createElement('div');
    nodesAndLinesContainer.className = 'tree-diagram-and-lines-container';

    return nodesAndLinesContainer;
}

function createNodesContainer() {
    const nodesContainer = document.createElement('div');
    nodesContainer.setAttribute('class', 'tree-diagram-container');

    return nodesContainer;
}

function createLinesContainer() {
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    linesContainer.setAttribute('class', 'tree-lines-container');

    return linesContainer;
}