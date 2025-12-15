function createMarriage(male, female, includeAdoptive, isFake) {
    const marriage = {};

    marriage.isFake = isFake;
    marriage.startDate = male.firstSpouseId == female.id ? male.firstMarriageStartDate : male.secondMarriageStartDate;
    marriage.endDate = male.firstSpouseId == female.id ? male.firstMarriageEndDate : male.secondMarriageEndDate;
    marriage.maleId = male?.id;
    marriage.femaleId = female?.id;
    marriage.inverseBiologicalParentIds = getCommonBiologicalChildren(male, female);
    marriage.inverseAdoptiveParentIds = includeAdoptive ? getCommonAdoptiveChildren(male, female) : [];
    marriage.inverseParentIds = marriage.inverseBiologicalParentIds.concat(marriage.inverseAdoptiveParentIds);

    return marriage;
}

function getCommonBiologicalChildren(male, female) {
    return male.inverseBiologicalFather
        .filter(maleChild => female.inverseBiologicalMother.some(femaleChild => maleChild.id == femaleChild.id))
        .map(child => child.id);
}

function getCommonAdoptiveChildren(male, female) {
    return male.inverseAdoptiveFather
        .filter(maleChild => female.inverseAdoptiveMother.some(femaleChild => maleChild.id == femaleChild.id))
        .map(child => child.id);
}