let treeDiagramsContainer;

const personIds = [1, 2, 3];
let currentPersonIndex = -1;

$(() => {
    treeDiagramsContainer = $('#tree-diagrams-container');

    $('#prevTree').on('click', function () {
        showTree(-1);
    })

    $('#nextTree').on('click', function () {
        showTree(1);
    })

    showTree(1)
});

async function showTree(direction) {
    const currentPersonId = personIds[currentPersonIndex];

    await removeTreeDiagram(treeDiagramsContainer, currentPersonId);
    currentPersonIndex += direction;

    if (currentPersonIndex < 0) {
        currentPersonIndex = personIds.length - 1;
    }
    else if (currentPersonIndex >= personIds.length) {
        currentPersonIndex = 0;
    }

    const nextPersonId = personIds[currentPersonIndex];
    createAndDisplayTreeDiagram(treeDiagramsContainer, nextPersonId);
}