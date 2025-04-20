// sort by birthDates, if not available then by deathDates
function sortRowItemsByLifeSpan(generations) {
    generations.forEach(generation => {
        generation.extendedMarriages.sort((extendedMarriage1, extendedMarriage2) => {
            const birthDate1 =
                extendedMarriage1.mainMarriage.person.birthDate ??
                extendedMarriage1.mainMarriage.spouse?.birthDate;

            const birthDate2 =
                extendedMarriage2.mainMarriage.person.birthDate ??
                extendedMarriage2.mainMarriage.spouse?.birthDate;

            const date1 = birthDate1 ??
                extendedMarriage1.mainMarriage.person.deathDate ??
                extendedMarriage1.mainMarriage.spouse?.deathDate;

            const date2 = birthDate2 ??
                extendedMarriage2.mainMarriage.person.deathDate ??
                extendedMarriage2.mainMarriage.spouse?.deathDate;

            return sortByDates(date1, date2);
        });
    });
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