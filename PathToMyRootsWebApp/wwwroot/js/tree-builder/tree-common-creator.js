function createTreeDiagramHtml(personId) {
    return $('<div>')
        .attr('id', 'tree-diagram-' + personId)
        .attr('class', 'tree-diagram');
}

function createLinesContainer() {
    // no jquery creational method for this
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    return $(linesContainer)
        .attr('class', 'tree-lines-container');
}