function sortRowItemsByBirthDates(generations) {
    generations.forEach(g => {
        g.sort((g1, g2) => {
            const parsedBirthDate1 = parseDateToNumber(g1.simpleMarriage.person.birthDate);
            const parsedBirthDate2 = parseDateToNumber(g2.simpleMarriage.person.birthDate);

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