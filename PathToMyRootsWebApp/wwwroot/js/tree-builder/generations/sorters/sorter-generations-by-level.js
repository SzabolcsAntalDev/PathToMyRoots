function sortByLevelAndConvertToArray(generationsMap) {
    return Array.from(generationsMap.entries())
        .sort((a, b) => a[0] - b[0])
        .map(([_, value]) => value);
}