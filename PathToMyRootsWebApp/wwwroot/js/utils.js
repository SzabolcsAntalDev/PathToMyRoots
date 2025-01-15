const humanReadableDateFormat = "{0}. {1}. {2}.";

function formatDateString(dateStr) {
    const year = dateStr.slice(1, 5);
    const month = dateStr.slice(5, 7);
    const day = dateStr.slice(7, 9);

    return humanReadableDateFormat
        .replace("{0}", year)
        .replace("{1}", month)
        .replace("{2}", day);
}