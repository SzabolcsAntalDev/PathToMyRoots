// treeType.BIOLOGICAL - contains:
// - the actual person, his/her spouses and biologcal siblings
// - all his/her biological ancestors from the database + fake ancestors until the last known genealogy level
// - all his/her biological descedants and their spouses, recursively

// treeType.EXTENDED - contains:
// - the actual person and his/her spouses and biological/adoptive siblings and their spouses
// - all his/her biological/adoptive ancestors and their spouses from the database, excluding parents of adoptive parents
// - all his/her biological/adoptive descedants and their spouses, recursively, excluding descedants of adoptive descedants

// treeType.COMPLETE - contains:
// - all the persons from the database that are related in any way to the actual person

const treeTypes = {
    HOURGLASS_BIOLOGICAL:
        { index: 0, id: 'HOURGLASS_BIOLOGICAL' },
    HOURGLASS_EXTENDED:
        { index: 1, id: 'HOURGLASS_EXTENDED' },
    COMPLETE:
        { index: 2, id: 'COMPLETE' },
};

function getTreeTypeByIndex(index) {
    return Object.values(treeTypes).find(type => type.index === index)
}