function createHiddenNodesAndLinesContainer(personId) {
    return $('<div>')
        .attr('id', personId)
        .attr('class', 'tree-diagram-and-lines-container fade-hidden');
}

function createNodesContainer() {
    return $('<div>')
        .attr('class', 'tree-diagram-container');
}

function createLinesContainer() {
    // no jquery creational method for this
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    return $(linesContainer)
        .attr('class', 'tree-lines-container');
}