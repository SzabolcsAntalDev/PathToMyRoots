// Szabi: should do this later
function sortByParents(generations) {
    let parentGeneration = {};
    generations.forEach(g => {
        let sortedChildrenRow = createRow();
        nodesContainer.append(sortedChildrenRow);
        parentsRow = fillRowWithSortedChildren(sortedChildrenRow, parentsRow, value);
    });
}

function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    const parentsNodeGroupContainers = parentsRow.find('.tree-extended-marriage');

    parentsNodeGroupContainers.each((_, parentsNodeGroupContainer) => {
        let secondaryMarriageNode = $(parentsNodeGroupContainer).find('.left-marriage');
        let mainMarriageNode = $(parentsNodeGroupContainer).find('.main-marriage');

        let secondaryMarriageBiologicalChildrenIds;
        let secondaryMarriageAdoptiveChildrenIds;
        let mainMarriageBiologicalChildrenIds;
        let mainMarriageAdoptiveChildrenIds;

        if (secondaryMarriageNode.length) {
            secondaryMarriageBiologicalChildrenIds = secondaryMarriageNode.data('inverseBiologicalParentIds');
            secondaryMarriageAdoptiveChildrenIds = secondaryMarriageNode.data('inverseAdoptiveParentIds');
        }

        if (mainMarriageNode.length) {
            mainMarriageBiologicalChildrenIds = mainMarriageNode.data('inverseBiologicalParentIds');
            mainMarriageAdoptiveChildrenIds = mainMarriageNode.data('inverseAdoptiveParentIds');
        }

        const takenSpouseNodeGroupContainers = [];
        const childrenNodeGroupContainers = childrenRow.find('.tree-extended-marriage');
        const siblings = [];

        // Szabi: use each here
        childrenNodeGroupContainers.each((_, element) => {
            const childrenNodeGroupContainer = $(element);
            if (takenSpouseNodeGroupContainers.includes(childrenNodeGroupContainer))
                return;

            const childMaleNode = childrenNodeGroupContainer.find('.tree-node-male');
            const childFemaleNode = childrenNodeGroupContainer.find('.tree-node-female');

            let childMaleId = childMaleNode.length ? Number(childMaleNode.attr('id')) : null;
            let childFemaleId = childFemaleNode.left ? Number(childFemaleNode.attr('id')) : null;

            // Szabi: can this ever be undefined?
            if (secondaryMarriageBiologicalChildrenIds != undefined &&
                (secondaryMarriageBiologicalChildrenIds.includes(childMaleId) || secondaryMarriageBiologicalChildrenIds.includes(childFemaleId))) {

                const isMale = secondaryMarriageBiologicalChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);

                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (secondaryMarriageAdoptiveChildrenIds != null &&
                (secondaryMarriageAdoptiveChildrenIds.includes(childMaleId) || secondaryMarriageAdoptiveChildrenIds.includes(childFemaleId))) {

                const isMale = secondaryMarriageAdoptiveChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);

                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (mainMarriageBiologicalChildrenIds != null &&
                (mainMarriageBiologicalChildrenIds.includes(childMaleId) || mainMarriageBiologicalChildrenIds.includes(childFemaleId))) {

                const isMale = mainMarriageBiologicalChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }

            if (mainMarriageAdoptiveChildrenIds != null &&
                (mainMarriageAdoptiveChildrenIds.includes(childMaleId) || mainMarriageAdoptiveChildrenIds.includes(childFemaleId))) {

                const isMale = mainMarriageAdoptiveChildrenIds.includes(childMaleId);
                if (isMale) {
                    const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                        getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

                    if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                        siblings.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                        siblings.push(childrenNodeGroupContainer);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                else {
                    const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                        getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

                    if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                        siblings.push(childrenNodeGroupContainer);
                        siblings.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                        takenSpouseNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                    }
                    else
                        siblings.push(childrenNodeGroupContainer);
                }
                return;
            }
        });

        const treeSiblingsContainer =
            $('<div>')
                .attr('class', 'tree-siblings-container');

        let added = false;
        siblings.forEach(s => {
            treeSiblingsContainer.append(s);
            added = true;
        });

        if (added) {
            sortedChildrenRow.append(treeSiblingsContainer);
        }
    });

    // orphans
    const childrenNodeGroupContainers = childrenRow.find('.tree-extended-marriage');
    const firstSpousesNodeGroupContainers = [];
    childrenNodeGroupContainers.each((_, element) => {
        const childrenNodeGroupContainer = $(element);
        if (firstSpousesNodeGroupContainers.includes(childrenNodeGroupContainer))
            return;

        let childMaleNode = childrenNodeGroupContainer.find('.tree-node-male').first();
        let childFemaleNode = childrenNodeGroupContainer.find('.tree-node-female').first();

        let childMaleId = Number(childMaleNode?.id);
        let childFemaleId = Number(childFemaleNode?.id);
        let added = false;

        if (childMaleId) {
            const firstSpouseNodeGroupContainerOfDoubleMarriedMale =
                getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(childrenNodeGroupContainer, childrenNodeGroupContainers, childMaleNode);

            if (firstSpouseNodeGroupContainerOfDoubleMarriedMale != null) {
                const treeSiblingsContainer =
                    $('<div>')
                        .attr('class', 'tree-siblings-container')
                        .append(firstSpouseNodeGroupContainerOfDoubleMarriedMale)
                        .append(childrenNodeGroupContainer);

                sortedChildrenRow.append(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOfDoubleMarriedMale);
                added = true;
            }
        }

        if (childFemaleId) {
            const firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale =
                getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(childrenNodeGroupContainer, childrenNodeGroupContainers, childFemaleNode);

            if (firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale != null) {
                const treeSiblingsContainer =
                    $('<div>')
                        .attr('class', 'tree-siblings-container')
                        .append(childrenNodeGroupContainer)
                        .append(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);

                sortedChildrenRow.append(treeSiblingsContainer);

                firstSpousesNodeGroupContainers.push(firstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale);
                added = true;
            }
        }

        if (!added) {
            const treeSiblingsContainer =
                $('<div>')
                    .attr('class', 'tree-siblings-container')
                    .append(childrenNodeGroupContainer);

            sortedChildrenRow.append(treeSiblingsContainer);
        }
    });

    return sortedChildrenRow;
}