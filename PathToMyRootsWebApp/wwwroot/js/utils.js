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

function getFadeIntervalInSeconds() {
    const fadeIntervalInSeconds = getComputedStyle(document.documentElement).getPropertyValue('--fade-interval-in-seconds');
    return parseFloat(fadeIntervalInSeconds);
}

function hideElement(element) {
    element.classList.add('fade-hidden');
}

function fadeInElement(element) {
    element.classList.remove('fade-hidden');
    element.classList.remove('fade-out');
    element.classList.add('fade-in');
}

async function fadeOutElement(element) {
    element.classList.remove('fade-in');
    element.classList.add('fade-out');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getFadeIntervalInSeconds() * 1000);
    });
}