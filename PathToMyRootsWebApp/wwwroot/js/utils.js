function formatDateString(dateStr) {
    const year = parseInt(dateStr.slice(1, 5), 10);
    const month = parseInt(dateStr.slice(5, 7), 10);
    const day = parseInt(dateStr.slice(7, 9), 10);

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

async function createOrGetLoadingTextContainer(parent) {
    var loadingTextContainer = document.getElementById("loading-text-container");
    if (!loadingTextContainer) {
        loadingTextContainer = document.createElement("div");

        loadingTextContainer.id = "loading-text-container";
        loadingTextContainer.className = "loading-text-container";
        hideElement(loadingTextContainer);

        const loadingText = document.createElement("label");
        loadingText.style.margin = "0px";
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