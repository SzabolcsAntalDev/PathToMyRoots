function showPopup(popupPrefix, message) {
    if (!message) {
        return;
    }

    const popupContainer = document.querySelector('#' + popupPrefix + '-popup-container');
    const popupMessage = popupContainer.querySelector('.popup-message');
    const popupCloseButton = popupContainer.querySelector('.popup-close-button');
    const popupLoadingBar = popupContainer.querySelector('.popup-loading-bar');
    const popupDisplayIntervalInSeconds = getPopupDisplayIntervalInSeconds();

    popupMessage.textContent = message;

    fadeInElement(popupContainer);

    let popupAutoClosingTimeout = setTimeout(() => {
        fadeOutElement(popupContainer);
    }, popupDisplayIntervalInSeconds * 1000);

    popupContainer.addEventListener('mouseenter', () => {
        const computedWidth = window.getComputedStyle(popupLoadingBar).width;
        popupLoadingBar.style.width = computedWidth;
        clearTimeout(popupAutoClosingTimeout);
    });

    popupContainer.addEventListener('mouseleave', () => {
        const remainingSeconds = popupDisplayIntervalInSeconds / (popupContainer.clientWidth / popupLoadingBar.clientWidth);
        popupLoadingBar.style.transitionDuration = remainingSeconds + 's ';
        popupLoadingBar.style.width = '0%';

        popupAutoClosingTimeout = setTimeout(() => {
            fadeOutElement(popupContainer);
        }, remainingSeconds * 1000);
    });

    popupCloseButton.onclick = function () {
        fadeOutElement(popupContainer);
    };

    popupLoadingBar.style.width = "0%";
}

function showSuccessPopup(successCode) {
    if (!successCode) {
        return;
    }

    showPopup('success', successMessages[successCode]);
}

function showErrorPopup(errorCode) {
    if (!errorCode) {
        return;
    }

    showPopup('error', errorMessages[errorCode]);
}