﻿// Szabi: move this to its own class
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

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}

function getSize(element) {
    const domElement = $(element).get(0);

    const elementStyle = window.getComputedStyle(domElement);
    const elementWidth = domElement.offsetWidth || parseFloat(elementStyle.width);
    const elementHeight = domElement.offsetHeight || parseFloat(elementStyle.height);

    return { width: elementWidth, height: elementHeight };
}

function setSize(fromElement, toElement) {
    const fromElementSize = getSize(fromElement);

    toElement.css({
        width: fromElementSize.width,
        height: fromElementSize.height
    });
}

function arrayRemoveDuplicatesWithSameId(array) {
    return Array.from(new Map(array.map(obj => [obj.id, obj])).values());
}