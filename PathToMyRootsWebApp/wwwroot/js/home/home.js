let diagramsDiv;

const personIds = [1, 4];
let currentPersonIndex = -1;

$(() => {
    diagramsDiv = $('#diagrams-div');

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

    await removeDiagramFrame(diagramsDiv, currentPersonId);
    currentPersonIndex += direction;

    if (currentPersonIndex < 0) {
        currentPersonIndex = personIds.length - 1;
    }
    else if (currentPersonIndex >= personIds.length) {
        currentPersonIndex = 0;
    }

    const nextPersonId = personIds[currentPersonIndex];
    createAndDisplayDiagramFrame(diagramsDiv, nextPersonId, nextPersonId, treeTypes.HOURGLASS_EXTENDED, true, 2, 2, viewModes.MEDIUM);
}