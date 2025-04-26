function sortExtendedMarriagesByBirthDate(generations) {
    generations.forEach(generation => {
        generation.extendedMarriages.sort((extendedMarriage1, extendedMarriage2) => {
            const birthDate1 =
                extendedMarriage1.mainMarriage?.male?.birthDate ??
                extendedMarriage1.mainMarriage?.female?.birthDate;

            const birthDate2 =
                extendedMarriage2.mainMarriage?.male?.birthDate ??
                extendedMarriage2.mainMarriage?.female?.birthDate;

            return sortDates(birthDate1, birthDate2);
        });
    });
}

function sortDates(date1, date2) {
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