function initValidationErrorMessages() {
    collapseEmptyValidationErrorMessages();
}

function collapseEmptyValidationErrorMessages() {
    const validationErrorMessageSpans = document.querySelectorAll(".error-span-with-bottom-margin, .error-span-with-top-margin");

    validationErrorMessageSpans.forEach(span => {
        if (span.textContent == "") {
            span.style.height = '0px';
            span.style.margin = '0px';
        }
    });
}