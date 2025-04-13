function sortByBirthdates(levelIndexesToRowsMap) {
    levelIndexesToRowsMap.forEach((row, _) => {
        sortGroupNodeContainers(row);
    });
}

function sortGroupNodeContainers(row) {
    const nodesGroupContainers = row.find('.tree-nodes-group-container');
    const sortedNodes = sortGroupNodesContainersByBirthDates(nodesGroupContainers);

    // row.empty() doesn't work
    row.innerHTML = '';
    sortedNodes.forEach(node => {
        row.append(node);
    });
}

function sortGroupNodesContainersByBirthDates(nodeGroupContainers) {
    return Array.from(nodeGroupContainers).sort((a, b) => {
        let maleA = a.querySelector('.tree-node-male');
        let femaleA = a.querySelector('.tree-node-female');
        let birthDateA = maleA?.birthDate || femaleA?.birthDate;

        let maleB = b.querySelector('.tree-node-male');
        let femaleB = b.querySelector('.tree-node-female');
        let birthDateB = maleB?.birthDate || femaleB?.birthDate;

        const parseDate = (date) => {
            if (!date)
                return Infinity;

            if (date === "+yyyymmdd")
                return 99999999;

            date = date.replace("mm", "00").replace("dd", "00");

            return parseInt(date.slice(1), 10) || 99999999;
        };

        let dateA = parseDate(birthDateA);
        let dateB = parseDate(birthDateB);

        return dateA - dateB;
    });
}