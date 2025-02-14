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
    let childrenWithBiologicalParents =
        Array
            .from(row.querySelectorAll('.tree-node-male, .tree-node-female'))
            .filter(p =>
                p.biologicalFatherId !== null ||
                p.biologicalMotherId !== null);

    let childrenWithAdoptiveParents =
        Array
            .from(row.querySelectorAll('.tree-node-male, .tree-node-female'))
            .filter(p =>
                p.adoptiveFatherId !== null ||
                p.adoptiveMotherId !== null);

    return childrenWithBiologicalParents.length + childrenWithAdoptiveParents.length;
}