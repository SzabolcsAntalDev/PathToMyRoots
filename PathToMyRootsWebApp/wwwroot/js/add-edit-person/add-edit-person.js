document.addEventListener("DOMContentLoaded", function () {
    initValidationErrorMessages();
    addSpousesDropDownValueToDatesContainerCollapseListener();
    initDateInputs();
    initDropdowns();
    updatePreviewImage();
});

function addSpousesDropDownValueToDatesContainerCollapseListener() {
    addSpouseDropDownValueToDatesContainerCollapseListener('first');
    addSpouseDropDownValueToDatesContainerCollapseListener('second');
}

function addSpouseDropDownValueToDatesContainerCollapseListener(spousePrefix) {
    const spouseHiddenInput = document.querySelector(`#${spousePrefix}-spouse-dropdown input[type="hidden"]`);
    const spouseMarriageDatesContainer = document.querySelector(`#${spousePrefix}-spouse-marriage-dates-container`);

    spouseHiddenInput.addEventListener('change', (event) => {
        var personIsSelected = event.target.value;

        if (personIsSelected) {
            spouseMarriageDatesContainer.classList.add('toggleable-container-open');
        } else {
            spouseMarriageDatesContainer.classList.remove('toggleable-container-open');
        }
    });
}