function sortRowItemsByBirtDates(rows) {
    rows.forEach(r => {
        sortRowItems(r);
    });
}

function sortRowItems(row) {
    const nodesGroupContainers = row.find('.tree-nodes-group-container');
    const sortedNodesGroupContainers = sortNodesGroupContainers(nodesGroupContainers);

    // row.empty() doesn't work
    row.innerHTML = '';
    sortedNodesGroupContainers.forEach(c => {
        row.append(c);
    });
}

function sortNodesGroupContainers(nodesGroupContainers) {
    return Array
        .from(nodesGroupContainers)
        .sort((nodesGroupContainer1, nodesGroupContainer2) => {
            let birtDate1 = getBirthDateNumberFromNodeGroup(nodesGroupContainer1)
            let birtDate2 = getBirthDateNumberFromNodeGroup(nodesGroupContainer2);

            return nodeGroup1BirthDate - nodeGroup2BirthDate;
        });
}

function getBirthDateNumberFromNodeGroup(nodeGroup) {
    let maleA = nodeGroup.find('.tree-node-male').get(0);
    let femaleA = nodeGroup.find('.tree-node-female').get(0);
    const birthDate =
        maleA != undefined
            ? maleA.data('birthDate')
            : femaleA.data('birthDate');

    return parseDateToNumber(birthDate);
}

function parseDateToNumber(date) {
    if (!date)
        return Infinity;

    if (date === "+yyyymmdd")
        return 99999999;

    const dateNumberString =
        date
            .slice(1)
            .replace("mm", "00")
            .replace("dd", "00");

    return parseInt(dateNumberString, 10);
};