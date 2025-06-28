// Szabi: place all this into a treeTypes constant
const relativesMinDepth = 0;
const relativesMaxDepth = 5;
const allRelativesDepthIndex = -1;

const treeTypes = {
    HOURGLASS_BIOLOGICAL:
        { index: 0, id: 'HOURGLASS-BIOLOGICAL', displayName: 'Hourglass-biological' },
    HOURGLASS_EXTENDED:
        { index: 1, id: 'HOURGLASS-EXTENDED', displayName: 'Hourglass-extended' },
    COMPLETE:
        { index: 2, id: 'COMPLETE', displayName: 'Complete' },
};

function getTreeTypeByIndex(index) {
    return Object.values(treeTypes).find(type => type.index === index)
}

function getDepthDisplayText(depth) {
    return depth == allRelativesDepthIndex ? "All" : depth;
}