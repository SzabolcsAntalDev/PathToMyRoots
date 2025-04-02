function initDateInputs() {
    initCommonDateInputsListeners();
}

function initCommonDateInputsListeners() {
    const inputDateFieldSets = document.querySelectorAll('.input-date-fieldset');

    // setup elements on radio buttons changed
    inputDateFieldSets.forEach(fieldSet => {
        const toggleableContainer = fieldSet.querySelector('.toggleable-container');

        const inputRadioOngoing = fieldSet.querySelector('.input-radio-date-ongoing');
        const inputRadioUnknown = fieldSet.querySelector('.input-radio-date-unknown');
        const inputRadioConcreteDate = fieldSet.querySelector('.input-radio-date-concrete-date');

        const inputConcreteDate = fieldSet.querySelector('.input-date-concrete-date');
        const inputHiddenDate = fieldSet.querySelector('.input-hidden-date');

        [inputRadioOngoing, inputRadioUnknown, inputRadioConcreteDate].forEach((radio) => {
            radio?.addEventListener('change', () => {
                setupDateInputElements(
                    toggleableContainer,
                    inputRadioOngoing,
                    inputRadioUnknown,
                    inputRadioConcreteDate,
                    inputConcreteDate,
                    inputHiddenDate,
                    false);
            });
        })

        inputConcreteDate.addEventListener('change', function () {
            inputHiddenDate.value = this.value;
        });

        setupDateInputElements(
            toggleableContainer,
            inputRadioOngoing,
            inputRadioUnknown,
            inputRadioConcreteDate,
            inputConcreteDate,
            inputHiddenDate,
            true);
    });
}

function setupDateInputElements(
    toggleableContainer,
    inputRadioOngoing,
    inputRadioUnknown,
    inputRadioConcreteDate,
    inputConcreteDate,
    inputHiddenDate,
    isInitialSetup) {

    // needed for simple toggleable fieldsets
    const toggleableTooltipContainerChild = toggleableContainer.querySelector('.tooltip-container');

    // needed for toggleable fieldsets that have toggleable parent - spouses section
    const toggleableTooltipContainerParent = toggleableContainer.parentElement?.closest('.tooltip-container');

    if (inputRadioOngoing?.checked) {
        setupForNonConcreteDate(toggleableContainer, toggleableTooltipContainerChild, toggleableTooltipContainerParent, inputConcreteDate, isInitialSetup);
        inputHiddenDate.value = null;
    }

    if (inputRadioUnknown.checked) {
        setupForNonConcreteDate(toggleableContainer, toggleableTooltipContainerChild, toggleableTooltipContainerParent, inputConcreteDate, isInitialSetup);
        inputHiddenDate.value = ServerDateUnknown;
    }

    if (inputRadioConcreteDate.checked) {
        setupForConcreteDate(toggleableContainer, toggleableTooltipContainerChild, toggleableTooltipContainerParent, inputConcreteDate);
        inputHiddenDate.value = inputConcreteDate.value;
    }
}

function setupForNonConcreteDate(
    toggleableContainer,
    toggleableTooltipContainerChild,
    toggleableTooltipContainerParent,
    inputConcreteDate,
    isInitialSetup) {

    toggleableContainer.classList.remove('toggleable-container-open');

    // in the initial setup in case of a spouse if the start date is a concrete date
    // and the end date is not a concrete date then removing the class in the case of
    // the end date would remove the class that was added by the start date thus the
    // tool tip becoming not entirely visible
    if (!isInitialSetup) {
        removeAndTrackClass(toggleableTooltipContainerChild, 'overflowvisible');

        if (toggleableTooltipContainerParent) {
            removeAndTrackClass(toggleableTooltipContainerParent, 'overflowvisible');
        }
    }

    inputConcreteDate.removeAttribute('pattern');
    inputConcreteDate.removeAttribute('title');
    inputConcreteDate.removeAttribute('required');
}

function setupForConcreteDate(
    toggleableContainer,
    toggleableTooltipContainerChild,
    toggleableTooltipContainerParent,
    inputConcreteDate) {

    toggleableContainer.classList.add('toggleable-container-open');

    setTimeout(() => { addAndTrackClass(toggleableTooltipContainerChild, 'overflowvisible'); }, getFadeIntervalInSeconds() * 1000);

    if (toggleableTooltipContainerParent) {
        addAndTrackClass(toggleableTooltipContainerParent, 'overflowvisible');
    }

    inputConcreteDate.setAttribute('pattern', ServerDateInputValidationPattern);
    inputConcreteDate.setAttribute('title', 'Date format should be ' + ServerDateUnknown);
    inputConcreteDate.setAttribute('required', '');
}