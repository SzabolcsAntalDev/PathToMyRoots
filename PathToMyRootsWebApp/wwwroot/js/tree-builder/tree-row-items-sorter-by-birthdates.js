function sortRowItemsByBirthDates(rows) {
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
            let birthDate1 = getBirthDateNumberFromNodeGroup(nodesGroupContainer1)
            let birthDate2 = getBirthDateNumberFromNodeGroup(nodesGroupContainer2);

            return birthDate1 - birthDate2;
        });
}

function getBirthDateNumberFromNodeGroup(nodeGroupContainer) {
    let maleA = $(nodeGroupContainer).find('.tree-node-male');
    let femaleA = $(nodeGroupContainer).find('.tree-node-female');
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