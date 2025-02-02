const treeIds = [13, 71];
let currentIndex = 1;

document.getElementById('prevTree').addEventListener('click', function () {
    showTree(-1);
});

document.getElementById('nextTree').addEventListener('click', function () {
    showTree(1);
});

async function showTree(direction) {
    const currentTreeNumber = treeIds[currentIndex];

    await removeTreeDiagram(currentTreeNumber);
    currentIndex += direction;

    if (currentIndex < 0) {
        currentIndex = treeIds.length - 1;
    }
    else if (currentIndex >= treeIds.length) {
        currentIndex = 0;
    }

    const nextTreeNumber = treeIds[currentIndex];
    createTreeDiagram(nextTreeNumber);
}