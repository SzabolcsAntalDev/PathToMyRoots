function getCommonBiologicalChildren(male, female) {
    return male.inverseBiologicalFather
        .filter(maleChild => female.inverseBiologicalMother.some(femaleChild => maleChild.id === femaleChild.id))
        .map(child => child.id);
}

function getCommonAdoptiveChildren(male, female) {
    return male.inverseAdoptiveFather
        .filter(maleChild => female.inverseAdoptiveMother.some(femaleChild => maleChild.id === femaleChild.id))
        .map(child => child.id);
}

function getFirstSpouseNodeGroupContainerOfDoubleMarriedMale(actualChildrenNodeGroupContainer, childrenNodeGroupContainers, maleNode) {
    if (maleNode.secondSpouseId == null)
        return null;

    for (let childrenNodeGroupContainer of childrenNodeGroupContainers) {
        if (actualChildrenNodeGroupContainer == childrenNodeGroupContainer)
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