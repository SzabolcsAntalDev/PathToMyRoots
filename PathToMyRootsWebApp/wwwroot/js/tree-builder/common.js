function sortByLevelAndConvertToArray(generationsMap) {
    return Array.from(generationsMap.entries())
        .sort((a, b) => a[0] - b[0])
        .map(([_, value]) => value);
}

function createMarriage(male, female, isStaticMarriage, isFake) {
    const marriage = {};

    marriage.isStaticMarriage = isStaticMarriage;
    marriage.isFake = isFake;
    marriage.startDate = male.firstSpouseId == female.id ? male.firstMarriageStartDate : male.secondMarriageStartDate;;
    marriage.endDate = male.firstSpouseId == female.id ? male.firstMarriageEndDate : male.secondMarriageEndDate;
    marriage.maleId = male?.id;
    marriage.femaleId = female?.id;
    marriage.inverseBiologicalParentIds = getCommonBiologicalChildren(male, female);
    marriage.inverseAdoptiveParentIds = getCommonAdoptiveChildren(male, female);

    return marriage;
}

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