const relativesDepth = {
    MIN: { index: 0 },
    MAX: { index: 5 },
    ALL: { index: -1 },

    getDisplayText(depthIndex) {
        return depthIndex == this.ALL.index ? 'All' : depthIndex;
    }
}