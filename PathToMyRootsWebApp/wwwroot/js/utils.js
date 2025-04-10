function getPropertyValue(propertyName) {
    return getComputedStyle(document.documentElement).getPropertyValue('--' + propertyName);
}

function getIntervalInSeconds(propertyName) {
    const intervalInSecondsString = getPropertyValue(propertyName);
    return parseFloat(intervalInSecondsString);
}

function getTransitionIntervalInSeconds() {
    return getIntervalInSeconds('default-transition-interval');
}

function getPopupDisplayIntervalInSeconds() {
    return getIntervalInSeconds('popup-loading-bar-transition-interval');
}

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
        }, getTransitionIntervalInSeconds() * 1000);
    });
}

function showPopup(popupPrefix, message) {
    if (!message) {
        return;
    }

    const popupContainer = document.querySelector('.' + popupPrefix + '-popup-container');
    const popupMessage = popupContainer.querySelector('.popup-message');
    const popupCloseButton = popupContainer.querySelector('.popup-close-button');
    const popupLoadingBar = popupContainer.querySelector('.popup-loading-bar');
    const popupDisplayIntervalInSeconds = getPopupDisplayIntervalInSeconds();

    popupMessage.textContent = message;

    fadeInElement(popupContainer);

    setTimeout(() => {
        let popupAutoClosingTimeout = setTimeout(() => {
            fadeOutElement(popupContainer);
        }, popupDisplayIntervalInSeconds * 1000);

        popupContainer.addEventListener('mouseenter', () => {
            const computedWidth = window.getComputedStyle(popupLoadingBar).width;
            popupLoadingBar.style.transition = 'none';
            popupLoadingBar.style.width = computedWidth;
            clearTimeout(popupAutoClosingTimeout);
        });

        popupContainer.addEventListener('mouseleave', () => {
            const remainingSeconds = popupDisplayIntervalInSeconds / (popupContainer.clientWidth / popupLoadingBar.clientWidth);
            popupLoadingBar.style.transition = 'width ' + remainingSeconds + 's ' + getPropertyValue('popup-loading-bar-transition-function');
            popupLoadingBar.style.width = '0%';

            popupAutoClosingTimeout = setTimeout(() => {
                fadeOutElement(popupContainer);
            }, remainingSeconds * 1000);
        });

        popupCloseButton.onclick = function () {
            fadeOutElement(popupContainer);
        };

        popupLoadingBar.style.width = "0%";
    }, getTransitionIntervalInSeconds() * 1000);
}

function showSuccessPopup(successCode) {
    if (!successCode)
        return;

    showPopup('success', successMessages[successCode]);
}

function showErrorPopup(errorCode) {
    if (!errorCode)
        return;

    showPopup('error', errorMessages[errorCode]);

}

function addAndTrackClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;
    element.dataset[className] = count + 1;

    element.classList.add(className);
}

function removeAndTrackClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;

    if (count > 1) {
        element.dataset[className] = count - 1;
    } else {
        element.classList.remove(className);
        delete element.dataset[className];
    }
}