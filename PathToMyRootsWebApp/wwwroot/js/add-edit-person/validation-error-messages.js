function initValidationErrorMessages() {
    collapseEmptyValidationErrorMessages();
}

function collapseEmptyValidationErrorMessages() {
    const validationErrorMessageSpans = document.querySelectorAll('.error-span-small-with-bottom-margin, .error-span-small-with-top-margin');

    validationErrorMessageSpans.forEach(span => {
        if (span.textContent == '') {
            span.style.height = '0px';
            span.style.margin = '0px';
        }
    });
}