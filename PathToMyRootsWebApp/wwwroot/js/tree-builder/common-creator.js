function createNodesAndLinesContainer() {
    return $('<div>', {
        class: 'tree-diagram-and-lines-container'
    });
}

function createNodesContainer() {
    return $('<div>', {
        class: 'tree-diagram-container'
    });
}

function createLinesContainer() {
    // no jquery creational method for this
    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    return $(linesContainer).addClass('tree-lines-container');
}