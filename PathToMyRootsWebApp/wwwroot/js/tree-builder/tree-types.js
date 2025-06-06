// treeType.BIOLOGICAL - contains:
// - the actual person, his/her spouses and biological siblings
// - all his/her biological ancestors from the database + spouses of his/her parents if they have children together + fake ancestors until the last known genealogy level
// - all his/her biological descedants and their spouses, recursively

// treeType.EXTENDED - contains:
// - the actual person and his/her spouses and biological/adoptive siblings and their spouses
// - all his/her biological/adoptive ancestors and their spouses from the database, excluding parents of adoptive parents
// - all his/her biological/adoptive descedants and their spouses, recursively, excluding descedants of adoptive descedants

// treeType.COMPLETE - contains:
// - all the persons from the database that are related in any way to the actual person

const relativesMinDepth = 0;
const relativesMaxDepth = 5;
const allRelativesDepthIndex = -1;

const treeTypes = {
    HOURGLASS_BIOLOGICAL:
        { index: 0, id: 'HOURGLASS_BIOLOGICAL', displayName: 'Hourglass-biological' },
    HOURGLASS_EXTENDED:
        { index: 1, id: 'HOURGLASS_EXTENDED', displayName: 'Hourglass-extended' },
    COMPLETE:
        { index: 2, id: 'COMPLETE', displayName: 'Complete' },
};

function getTreeTypeByIndex(index) {
    return Object.values(treeTypes).find(type => type.index === index)
}

function getDepthDisplayText(depth) {
    return depth == allRelativesDepthIndex ? "All" : depth;
}