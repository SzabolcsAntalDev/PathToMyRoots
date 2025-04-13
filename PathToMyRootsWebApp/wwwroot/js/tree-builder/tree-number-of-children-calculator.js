function getMaxNumberOfChildrenWithParentsOnRows(levelIndexesToRowsMap) {
    let maxChildrenWithParentsOnRows1 = 0;
    levelIndexesToRowsMap.forEach((value, _) => {
        maxChildrenWithParentsOnRows1 = Math.max(maxChildrenWithParentsOnRows1, getNumberOfChildrenWithParents(value));
    });

    return maxChildrenWithParentsOnRows1;
}

function getNumberOfChildrenWithParents(row) {

    // biological and adoptive parents should not be merged into one filter here
    // a child with both biological and adoptive parents will have 2 lines
    // Szabi: null or undefined?
    let childrenWithBiologicalParents =
        Array
            .from(row.find('.tree-node-male, .tree-node-female'))
            .filter(p => {
                var a = $(p).data('biologicalFatherId');

                return $(p).data('biologicalFatherId') != null ||
                    $(p).data('biologicalMotherId') != null
            });

    let childrenWithAdoptiveParents =
        Array
            .from(row.find('.tree-node-male, .tree-node-female'))
            .filter(p =>
                $(p).data('adoptiveFatherId') != null ||
                $(p).data('adoptiveMotherId') != null);

    return childrenWithBiologicalParents.length + childrenWithAdoptiveParents.length;
}