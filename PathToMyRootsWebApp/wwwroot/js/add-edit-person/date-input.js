function initDateInputs() {
    initCommonDateInputsListeners();
}

function initCommonDateInputsListeners() {
    const inputDateFieldSets = document.querySelectorAll('.input-date-fieldset');

    // when date is changed by user, update hidden input
    inputDateFieldSets.forEach(fieldSet => {
        fieldSet.querySelector('.input-date-concrete-date').addEventListener('change', function () {
            fieldSet.querySelector('.input-hidden-date').value = this.value;
        });
    });

    // setup elements on radio buttons changed
    inputDateFieldSets.forEach(fieldSet => {
        var inputRadioAlive = fieldSet.querySelector(".input-radio-date-ongoing");
        var inputRadioUnknown = fieldSet.querySelector(".input-radio-date-unknown");
        var inputRadioConcreteDate = fieldSet.querySelector(".input-radio-date-concrete-date");

        var toggleableContainer = fieldSet.querySelector(".toggleable-container");
        var inputDate = fieldSet.querySelector(".input-date-concrete-date");
        var inputHiddenDate = fieldSet.querySelector(".input-hidden-date");

        if (inputRadioAlive) {
            inputRadioAlive.addEventListener('change', () => {
                setupDateInputElements(
                    inputRadioAlive,
                    inputRadioUnknown,
                    inputRadioConcreteDate,
                    toggleableContainer,
                    inputDate,
                    inputHiddenDate);
            });
        }

        inputRadioUnknown.addEventListener('change', () => {
            setupDateInputElements(
                inputRadioAlive,
                inputRadioUnknown,
                inputRadioConcreteDate,
                toggleableContainer,
                inputDate,
                inputHiddenDate);
        });

        inputRadioConcreteDate.addEventListener('change', () => {
            setupDateInputElements(
                inputRadioAlive,
                inputRadioUnknown,
                inputRadioConcreteDate,
                toggleableContainer,
                inputDate,
                inputHiddenDate);
        });

        setupDateInputElements(
            inputRadioAlive,
            inputRadioUnknown,
            inputRadioConcreteDate,
            toggleableContainer,
            inputDate,
            inputHiddenDate);
    });
}
function setupDateInputElements(
    inputRadioAlive,
    inputRadioUnknown,
    inputRadioConcreteDate,
    toggleableContainer,
    inputDate,
    inputHiddenDate) {
    if (inputRadioAlive != null && inputRadioAlive.checked) {
        toggleableContainer.classList.remove('toggleable-container-open');
        inputDate.removeAttribute("pattern");
        inputDate.removeAttribute("title");
        inputDate.removeAttribute("required");

        inputHiddenDate.value = null;
    }

    if (inputRadioUnknown.checked) {
        toggleableContainer.classList.remove('toggleable-container-open');
        inputDate.removeAttribute("pattern");
        inputDate.removeAttribute("title");

        inputHiddenDate.value = ServerDateUnknown;
    }

    if (inputRadioConcreteDate.checked) {
        toggleableContainer.classList.add('toggleable-container-open');
        inputDate.setAttribute("pattern", ServerDateInputValidationPattern);
        inputDate.setAttribute("title", "Date format should be " + ServerDateUnknown);
        inputDate.setAttribute("required", "");

        inputHiddenDate.value = inputDate.value;
    }
}