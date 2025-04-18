function sortRowItemsByBirthDates(generations) {
    generations.forEach(g => {
        g.extendedMarriages.sort((g1, g2) => {
            const parsedBirthDate1 = parseDateToNumber(g1.mainMarriage.person.birthDate);
            const parsedBirthDate2 = parseDateToNumber(g2.mainMarriage.person.birthDate);

            return parsedBirthDate1 - parsedBirthDate2;
        });
    });
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