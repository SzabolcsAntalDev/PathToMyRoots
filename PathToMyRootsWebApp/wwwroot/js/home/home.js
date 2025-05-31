let treeDiagramsDiv;

const personIds = [1, 4];
let currentPersonIndex = -1;

$(() => {
    treeDiagramsDiv = $('#tree-diagrams-div');

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

    await removeTreeDiagram(treeDiagramsDiv, currentPersonId);
    currentPersonIndex += direction;

    if (currentPersonIndex < 0) {
        currentPersonIndex = personIds.length - 1;
    }
    else if (currentPersonIndex >= personIds.length) {
        currentPersonIndex = 0;
    }

    const nextPersonId = personIds[currentPersonIndex];
    createAndDisplayTreeDiagram(treeDiagramsDiv, nextPersonId, treeTypes.HOURGLASS_EXTENDED, 2, 2);
}