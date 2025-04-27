function personToPersonNameNodeText(person) {
    let details = [];

    if (person.nobleTitle)
        details.push(person.nobleTitle);

    if (person.lastName)
        details.push(person.lastName);

    if (person.maidenName)
        details.push(`(${person.maidenName})`);

    if (person.firstName)
        details.push(person.firstName);

    if (person.otherNames)
        details.push(person.otherNames);

    return details.filter(Boolean).join(' ');
}

function datesToPeriodText(startDate, endDate) {

    var startDateString = dateToString(startDate) ?? HumanReadableDateUnknownDate;
    var endDateString = dateToString(endDate);

    if (endDateString)
        return `${startDateString} - ${endDateString}`;

    return startDateString;
}

function dateToString(date) {
    if (date == null)
        return null;

    if (date === UnknownServerDate)
        return HumanReadableDateUnknownDate;

    return formatDateString(date);
}