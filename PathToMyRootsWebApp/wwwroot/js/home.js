document.getElementById('prevTree').addEventListener('click', function () {
    showTree(1);
});

document.getElementById('nextTree').addEventListener('click', function () {
    showTree(2);
});

function showTree(treeNumber) {
    if (treeNumber === 1) {
        createTreeDiagram(71);
    } else if (treeNumber === 2) {
        createTreeDiagram(13);
    }
}