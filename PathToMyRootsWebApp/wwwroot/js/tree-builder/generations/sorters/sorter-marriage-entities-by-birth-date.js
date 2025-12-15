// sorts the marriage entities by the male's then by the female's birthday
function sortMarriageEntitiesByBirthDate(generations) {
    generations.forEach(generation => {
        generation.marriageEntities.sort((marriageEntity1, marriageEntity2) => {
            const birthDate1 = getValidOrNullBirthDate(marriageEntity1);
            const birthDate2 = getValidOrNullBirthDate(marriageEntity2);

            return sortDates(birthDate1, birthDate2);
        });
    });
}

function getValidOrNullBirthDate(marriageEntity) {
    const maleBirthDate = marriageEntity.male?.birthDate;
    const femaleBirthDate = marriageEntity.female?.birthDate;

    // will be null only of male is null
    if (maleBirthDate == null) {
        return femaleBirthDate;
    }

    if (maleBirthDate == DatabaseDateUnknown &&
        femaleBirthDate != null &&
        femaleBirthDate != DatabaseDateUnknown) {
        return femaleBirthDate;
    }

    return maleBirthDate;
}

function sortDates(date1, date2) {
    const parsedDate1 = parseDateToNumber(date1);
    const parsedDate2 = parseDateToNumber(date2);

    return parsedDate1 - parsedDate2;
}

function parseDateToNumber(date) {
    if (!date)
        return Infinity;

    if (date === DatabaseDateUnknown)
        return 99999999;

    const dateNumberString =
        date
            .slice(1)
            .replace("mm", "00")
            .replace("dd", "00");

    return parseInt(dateNumberString, 10);
};