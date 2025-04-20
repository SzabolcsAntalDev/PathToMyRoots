function sortRowItemsByBirthDates(generations) {
    generations.forEach(generation => {
        generation.extendedMarriages.sort((generation1, generation2) => {
            const parsedBirthDate1 = parseDateToNumber(generation1.mainMarriage.person.birthDate);
            const parsedBirthDate2 = parseDateToNumber(generation2.mainMarriage.person.birthDate);

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