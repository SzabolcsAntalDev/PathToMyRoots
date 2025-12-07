const genericPlaceholder = '_';
const emptyNamePlaceholder = 'X';

function formatPersonName(person) {
    return databaseScriptHelper.executeSqlScriptHelpersSetting
        ? databaseScriptHelper.formatPersonName(person)
        : formatPersonNameInternal(person);
}

function formatPersonNameInternal(person) {
    let nameParts = [];

    if (person.nobleTitle)
        nameParts.push(person.nobleTitle);

    if (person.lastName)
        nameParts.push(person.lastName);

    if (person.maidenName)
        nameParts.push(`(${person.maidenName})`);

    if (person.firstName)
        nameParts.push(person.firstName);

    if (person.otherNames)
        nameParts.push(person.otherNames);

    return nameParts.filter(Boolean).join(' ');
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

function formatPersonNameTechnical(person) {
    let nameParts = [];

    nameParts.push(person.nobleTitle ?? emptyNamePlaceholder);
    nameParts.push(person.lastName ?? emptyNamePlaceholder);
    nameParts.push(person.maidenName ?? emptyNamePlaceholder);
    nameParts.push(person.firstName ?? emptyNamePlaceholder);
    nameParts.push(person.otherNames ?? emptyNamePlaceholder);

    // X_Antal_X_SzabolcsCsongor_X
    return nameParts
        .map(namePart => namePart == emptyNamePlaceholder ? emptyNamePlaceholder : normalizeNamePart(namePart))
        .join(genericPlaceholder);
}

function normalizeNamePart(namePart) {
    // removes
    //  - accents from special characters (é, ț, ç, etc)
    //  - commas (,)
    //  - hypehns (-)
    //  - spaces
    // replaces ? with emptyNamePlaceholder

    return namePart
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/,/g, '')
        .replace(/[-\s]/g, '')
        .replace(/\?/g, emptyNamePlaceholder);
}

function formatDiagramImageNameSuffix(treeType, ancestorsDepth, descendantsDepth, viewMode) {
    let infoParts = [];

    infoParts.push(treeType.technicalName);
    infoParts.push(`A${ancestorsDepth}`);
    infoParts.push(`D${descendantsDepth}`);
    infoParts.push(viewMode.id);

    return genericPlaceholder + infoParts.join(genericPlaceholder);
}