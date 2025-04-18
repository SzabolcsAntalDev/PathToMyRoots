function createHiddenTreeDiagramContainer(personId) {
    return $('<div>')
        .attr('id', 'tree-diagram-container-' + personId)
        .attr('class', 'tree-diagram-container fade-hidden');
}

function createLinesContainer() {
    // no jquery creational method for this
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    return $(linesContainer)
        .attr('class', 'tree-lines-container');
}