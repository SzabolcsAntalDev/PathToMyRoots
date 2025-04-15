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

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}