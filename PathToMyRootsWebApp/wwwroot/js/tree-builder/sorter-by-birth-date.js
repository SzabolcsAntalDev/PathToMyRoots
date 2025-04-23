function sortGenerationExtendedMarriagesByBirthDate(generation) {
    generation.extendedMarriages.sort((extendedMarriage1, extendedMarriage2) => {
        const birthDate1 =
            extendedMarriage1.mainMarriage?.male?.birthDate ??
            extendedMarriage1.mainMarriage?.female?.birthDate;

        const birthDate2 =
            extendedMarriage2.mainMarriage?.male?.birthDate ??
            extendedMarriage2.mainMarriage?.female?.birthDate;

        return sortByDates(birthDate1, birthDate2);
    });
}

function sortSiblingsByBirthDate(generations) {
    generations.forEach(generation => {
        generation.siblingsChains.forEach(siblings => {
            siblings.sort((extendedMarriages1, extendedMarriages2) => {
                const birthDate1 = getBirthDate(extendedMarriages1);
                const birthDate2 = getBirthDate(extendedMarriages2);

                return sortByDates(birthDate1, birthDate2);
            });
        });
    });
}

function getBirthDate(extendedMarriages) {
    let mainExtendedMarriageSibling = getMainExtendedMarriageSibling(extendedMarriages);
    if (!mainExtendedMarriageSibling) {
        mainExtendedMarriageSibling = getFirstExtendedMarriageSiblingWithBirthDate(extendedMarriages);
    }

    return mainExtendedMarriageSibling?.mainMarriage?.male?.birthDate ??
        mainExtendedMarriageSibling?.mainMarriage?.female?.birthDate;
}

function getMainExtendedMarriageSibling(extendedMarriages) {
    for (const extendedMarriage of extendedMarriages) {
        if (extendedMarriage.isMainSibling) {
            return extendedMarriage;
        }
    }
    return null;
}

// Szabi: birthDate that is not null and not default
function getFirstExtendedMarriageSiblingWithBirthDate(extendedMarriages) {
    for (const extendedMarriage of extendedMarriages) {
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