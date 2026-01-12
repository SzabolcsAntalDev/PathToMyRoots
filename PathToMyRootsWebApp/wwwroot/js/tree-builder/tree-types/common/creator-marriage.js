function createMarriage(male, female, includeAdoptive) {
    const marriage = {};

    // if it's a real marriage and not a placeholder one
    if (male && female) {
        marriage.startDate = male.firstSpouseId == female.id ? male.firstMarriageStartDate : male.secondMarriageStartDate;
        marriage.endDate = male.firstSpouseId == female.id ? male.firstMarriageEndDate : male.secondMarriageEndDate;

        // spouse numbers are displayed only for the persons who have multiple spouses
        marriage.leftSpouseNumber =
            !male.secondSpouseId
                ? null
                : male.firstSpouseId == female.id
                    ? 1
                    : 2;

        marriage.rightSpouseNumber =
            !female.secondSpouseId
                ? null
                : female.firstSpouseId == male.id
                    ? 1
                    : 2;
    }

    marriage.maleId = male?.id;
    marriage.femaleId = female?.id;

    marriage.inverseBiologicalParentIds = getCommonBiologicalChildren(male, female);
    marriage.inverseAdoptiveParentIds = includeAdoptive ? getCommonAdoptiveChildren(male, female) : [];
    marriage.inverseParentIds = marriage.inverseBiologicalParentIds.concat(marriage.inverseAdoptiveParentIds);

    return marriage;
}

function getCommonBiologicalChildren(male, female) {
    if (!male || !female) {
        return [];
    }

    return male.inverseBiologicalFather
        .filter(maleChild => female.inverseBiologicalMother.some(femaleChild => maleChild.id == femaleChild.id))
        .map(child => child.id);
}

function getCommonAdoptiveChildren(male, female) {
    if (!male || !female) {
        return [];
    }

    return male.inverseAdoptiveFather
        .filter(maleChild => female.inverseAdoptiveMother.some(femaleChild => maleChild.id == femaleChild.id))
        .map(child => child.id);
}