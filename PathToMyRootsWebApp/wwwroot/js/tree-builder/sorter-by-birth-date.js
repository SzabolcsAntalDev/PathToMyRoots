function sortExtendedMarriagesByBirthDate(generations) {
    generations.forEach(generation => {
        generation.extendedMarriages.sort((extendedMarriage1, extendedMarriage2) => {
            const birthDate1 = getValidOrNullBirthDate(extendedMarriage1);
            const birthDate2 = getValidOrNullBirthDate(extendedMarriage2);

            return sortDates(birthDate1, birthDate2);
        });
    });
}

function getValidOrNullBirthDate(extendedMarriage) {
    const maleBirthDate = extendedMarriage.mainMarriage?.male?.birthDate;
    return maleBirthDate == null || maleBirthDate == "+yyyymmdd"
        ? extendedMarriage.mainMarriage?.female?.birthDate
        : maleBirthDate;
}

function sortDates(date1, date2) {
    const parsedDate1 = parseDateToNumber(date1);
    const parsedDate2 = parseDateToNumber(date2);

    return parsedDate1 - parsedDate2;
}

function parseDateToNumber(date) {
    if (!date)
        return Infinity;

    // Szabi: extract this probably into Layout.cshtml
    if (date === "+yyyymmdd")
        return 99999999;

    const dateNumberString =
        date
            .slice(1)
            .replace("mm", "00")
            .replace("dd", "00");

    return parseInt(dateNumberString, 10);
};