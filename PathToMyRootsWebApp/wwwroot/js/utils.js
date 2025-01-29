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

async function createOrGetLoadingTextContainer(parent) {
    var loadingTextContainer = document.getElementById("loading-text-container");
    if (!loadingTextContainer) {
        loadingTextContainer = document.createElement("div");

        loadingTextContainer.id = "loading-text-container";
        loadingTextContainer.className = "loading-text-container";
        hideElement(loadingTextContainer);

        const loadingText = document.createElement("label");
        loadingText.textContent = "Loading...";

        loadingTextContainer.appendChild(loadingText);
        parent.appendChild(loadingTextContainer);
    }

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, 1);
    });

    return loadingTextContainer;
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