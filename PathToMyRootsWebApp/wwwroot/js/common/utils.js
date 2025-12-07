// Szabi: move this to its own class
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

    // Szabi: set timeout is needed?
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
            popupLoadingBar.style.transition = 'width ' + remainingSeconds + 's ' + getPropertyValue('default-transition-function');
            popupLoadingBar.style.width = '0%';

            popupAutoClosingTimeout = setTimeout(() => {
                fadeOutElement(popupContainer);
            }, remainingSeconds * 1000);
        });

        popupCloseButton.onclick = function () {
            fadeOutElement(popupContainer);
        };

        popupLoadingBar.style.width = "0%";
    }, getFadeTransitionIntervalInSeconds() * 1000);
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

// Szabi: maybe these are not needed with the new tooltips
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

function setSize(fromElement, toElement) {
    const fromElementSize = getSize(fromElement);

    toElement.css({
        width: fromElementSize.width,
        height: fromElementSize.height
    });
}

function getSize(element) {
    const domElement = $(element).get(0);

    const elementStyle = window.getComputedStyle(domElement);
    const elementWidth = domElement.offsetWidth || parseFloat(elementStyle.width);
    const elementHeight = domElement.offsetHeight || parseFloat(elementStyle.height);

    return { width: elementWidth, height: elementHeight };
}

function arrayRemoveDuplicatesWithSameId(array) {
    return Array.from(new Map(array.map(obj => [obj.id, obj])).values());
}

function writeCurrentTimeOnConsole(additionalText) {
    const now = new Date();

    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    const milliseconds = String(now.getMilliseconds()).padStart(3, '0');

    console.log(`${hours}:${minutes}:${seconds}.${milliseconds}` + additionalText ? ` - ${additionalText}` : '');
}