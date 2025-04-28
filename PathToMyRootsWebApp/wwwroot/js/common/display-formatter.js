﻿function formatPersonName(person) {
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

function formatTimePeriod(startDate, endDate) {
    var startDateString = formatDate(startDate) ?? HumanReadableDateUnknownDate;
    var endDateString = formatDate(endDate);

    if (endDateString)
        return `${startDateString} - ${endDateString}`;

    return `${startDateString} -`;
}

function formatDate(date) {
    if (date == null)
        return null;

    if (date === DatabaseDateUnknown)
        return HumanReadableDateUnknownDate;

    const year = parseInt(date.slice(1, 5), 10);
    const month = parseInt(date.slice(5, 7), 10);
    const day = parseInt(date.slice(7, 9), 10);

    let parts = [];

    if (!isNaN(year)) {
        parts.push(year + '.');

        if (!isNaN(month)) {
            parts.push(String(month).padStart(2, '0') + '.');

            if (!isNaN(day)) {
                parts.push(String(day).padStart(2, '0') + '.');
            }
        }
    }

    return parts.join(' ');
}