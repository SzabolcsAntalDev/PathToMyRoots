const treeTypes = {
    HOURGLASS_BIOLOGICAL:
        { index: 0, id: 'HOURGLASS-BIOLOGICAL', displayName: 'Hourglass-biological' },
    HOURGLASS_EXTENDED:
        { index: 1, id: 'HOURGLASS-EXTENDED', displayName: 'Hourglass-extended' },
    COMPLETE:
        { index: 2, id: 'COMPLETE', displayName: 'Complete' },

    getTreeTypeByIndex(treeTypeIndex) {
        return Object.values(treeTypes).find(treeType => treeType.index == treeTypeIndex)
    }
};