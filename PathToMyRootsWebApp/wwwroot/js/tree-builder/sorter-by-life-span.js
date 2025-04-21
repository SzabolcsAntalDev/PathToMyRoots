// sort by birthDates, if not available then by deathDates
//function sortByLifeSpan(generations) {
//    generations.forEach(generation => {
//        generation.siblings.sort((extendedMarriage1, extendedMarriage2) => {
//            const date1 =
//                extendedMarriage1.mainMarriage.male?.birthDate ??
//                extendedMarriage1.mainMarriage.female?.birthDate;

//            const date2 =
//                extendedMarriage2.mainMarriage.male?.birthDate ??
//                extendedMarriage2.mainMarriage.female?.birthDate;

//            return sortByDates(date1, date2);
//        });
//    });
//}

function sortFirstGenerationByLifeSpan(generation) {
    generation.extendedMarriages.sort((extendedMarriage1, extendedMarriage2) => {
        const date1 =
            extendedMarriage1.mainMarriage?.male?.birthDate ??
            extendedMarriage1.mainMarriage?.female?.birthDate;

        const date2 =
            extendedMarriage2.mainMarriage?.male?.birthDate ??
            extendedMarriage2.mainMarriage?.female?.birthDate;

        return sortByDates(date1, date2);
    });
}

function sortSiblings(generations) {
    generations.forEach(generation => {
        generation.siblingsGroups.forEach(siblingsGroup => {
            siblingsGroup.sort((extendedMarriageGroup1, extendedMarriageGroup2) => {
                const date1 = getSortDate(extendedMarriageGroup1);
                const date2 = getSortDate(extendedMarriageGroup2);

                return sortByDates(date1, date2);
            });
        });
    });
}

function getSortDate(extendedMarriageGroup) {

    let mainMarriageSibling = getMainSiblingMarriage(extendedMarriageGroup);

    if (!mainMarriageSibling) {
        mainMarriageSibling = getFirstSibling(extendedMarriageGroup);
    }

    return mainMarriageSibling?.mainMarriage?.male?.birthDate ??
        mainMarriageSibling?.mainMarriage?.female?.birthDate;
}

function getMainSiblingMarriage(extendedMarriageGroup) {
    for (const extendedMarriage of extendedMarriageGroup) {
        if (extendedMarriage.isMainSibling) {
            return extendedMarriage;
        }
    }
    return null;
}




function getFirstSibling(extendedMarriageGroup) {
    for (const extendedMarriage of extendedMarriageGroup) {
        if (extendedMarriage.mainMarriage?.male?.birthDate || extendedMarriage.mainMarriage?.female?.birthDate) {
            return extendedMarriage;
        }
    }
    return null;
}

function sortByDates(date1, date2) {
    const parsedDate1 = parseDateToNumber(date1);
    const parsedDate2 = parseDateToNumber(date2);

    return parsedDate1 - parsedDate2;
}

function parseDateToNumber(date) {
    if (!date)
        return Infinity;

    if (date === "+yyyymmdd")
        return 99999999;

    const dateNumberString =
        date
            .slice(1)
            .replace("mm", "00")
            .replace("dd", "00");

    return parseInt(dateNumberString, 10);
};