function groupByParents(generations) {
    generations.forEach((generation, index) => {
        let siblingsGroups = [];
        let flatAddedMarriageGroups = [];
        // persons on first level are non siblings
        if (index == 0) {
            generation.extendedMarriageGroupsByMarriages.forEach(marriageGroup => {
                siblingsGroups.push([marriageGroup]);
                flatAddedMarriageGroups.push(marriageGroup);
            });
        }
        else {
            generations[index - 1].extendedMarriageGroupsByMarriages.forEach(extendedMarriageGroup => {
                extendedMarriageGroup.forEach(extendedMarriage => {

                    const childrenIds = getChildrenIds(extendedMarriage)
                    const siblings = getChildrenOf(childrenIds, generations[index], flatAddedMarriageGroups);
                    if (siblings.length > 0) {
                        siblingsGroups.push(siblings);
                    }
                });
            });
        }

        generation.siblingsGroups = siblingsGroups;
    });
}


function getChildrenIds(extendedMarriage) {
    return (extendedMarriage.secondaryMarriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.secondaryMarriage?.inverseAdoptiveParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseBiologicalParentIds ?? [])
        .concat(extendedMarriage.mainMarriage?.marriage?.inverseAdoptiveParentIds ?? []);
}


function getChildrenOf(childrenIds, generation, flatAddedMarriageGroups) {
    const siblings = [];
    generation.extendedMarriageGroupsByMarriages.forEach(extendedMarriagesGroupInner => {
        if (flatAddedMarriageGroups.includes(extendedMarriagesGroupInner)) {
            return;
        }

        if (myContains(childrenIds, extendedMarriagesGroupInner)) {
            siblings.push(extendedMarriagesGroupInner);
            flatAddedMarriageGroups.push(extendedMarriagesGroupInner);
        }
    });

    return siblings;
}

function myContains(childrenIds, extendedMarriagesGroup) {
    return extendedMarriagesGroup.some(extendedMarriageInner => {
        const maleId = extendedMarriageInner.mainMarriage?.male?.id;
        const femaleId = extendedMarriageInner.mainMarriage?.female?.id;

        if (childrenIds.includes(maleId) || childrenIds.includes(femaleId)) {
            extendedMarriageInner.isMainSibling = true;
            return true;
        }

        return false;
    });
}