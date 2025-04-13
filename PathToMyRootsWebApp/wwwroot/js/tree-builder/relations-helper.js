function getCommonBiologicalChildren(person, spouse) {
    if (person.isMale) {
        return person.inverseBiologicalFather
            .filter(child => spouse.inverseBiologicalMother.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    } else {
        return person.inverseBiologicalMother
            .filter(child => spouse.inverseBiologicalFather.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    }
}

function getCommonAdoptiveChildren(person, spouse) {
    if (person.isMale) {
        return person.inverseAdoptiveFather
            .filter(child => spouse.inverseAdoptiveMother.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    } else {
        return person.inverseAdoptiveMother
            .filter(child => spouse.inverseAdoptiveFather.some(spouseChild => spouseChild.id === child.id))
            .map(child => child.id);
    }
}

function getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(firstChildrenNodeGroupContainer, childrenNodeGroupContainers, maleNode) {
    if (maleNode.secondSpouseId == null)
        return null;

    for (let childrenNodeGroupContainer of childrenNodeGroupContainers) {
        if (firstChildrenNodeGroupContainer == childrenNodeGroupContainer)
            continue;

        let childFemaleNode = childrenNodeGroupContainer.querySelector('.tree-node-female');
        let childFemaleId = Number(childFemaleNode?.id);

        if (maleNode.firstSpouseId == childFemaleId)
            return childrenNodeGroupContainer;
    }

    return null;
}

function getFirstSpouseNodeGroupContainerOtherThanActualOfMarriedFemale(firstChildrenNodeGroupContainer, childrenNodeGroupContainers, femaleNode) {
    for (let childrenNodeGroupContainer of childrenNodeGroupContainers) {
        if (firstChildrenNodeGroupContainer == childrenNodeGroupContainer)
            continue;

        let childMaleNode = childrenNodeGroupContainer.querySelector('.tree-node-male');
        let childMaleId = Number(childMaleNode?.id);

        if (femaleNode.firstSpouseId == childMaleId)
            return childrenNodeGroupContainer;
    }

    return null;
}

function getNumberOfChildrenWithParents(row) {

    // biological and adoptive parents should not be merged into one filter here
    // a child with both biological and adoptive parents will have 2 lines
    // Szabi: null or undefined?
    let childrenWithBiologicalParents =
        Array
            .from(row.find('.tree-node-male, .tree-node-female'))
            .filter(p =>
                $(p).data('biologicalFatherId') != null ||
                $(p).data('biologicalMotherId') != null);

    let childrenWithAdoptiveParents =
        Array
            .from(row.find('.tree-node-male, .tree-node-female'))
            .filter(p =>
                $(p).data('adoptiveFatherId') != null ||
                $(p).data('adoptiveMotherId') != null);

    return childrenWithBiologicalParents.length + childrenWithAdoptiveParents.length;
}