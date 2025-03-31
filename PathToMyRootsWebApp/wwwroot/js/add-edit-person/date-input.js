function initDateInputs() {
    initCommonDateInputsListeners();
}

function initCommonDateInputsListeners() {
    const inputDateFieldSets = document.querySelectorAll('.input-date-fieldset');

    // setup elements on radio buttons changed
    inputDateFieldSets.forEach(fieldSet => {
        var toggleableContainer = fieldSet.querySelector(".toggleable-container");

        var inputRadioOngoing = fieldSet.querySelector(".input-radio-date-ongoing");
        var inputRadioUnknown = fieldSet.querySelector(".input-radio-date-unknown");
        var inputRadioConcreteDate = fieldSet.querySelector(".input-radio-date-concrete-date");

        var inputConcreteDate = fieldSet.querySelector(".input-date-concrete-date");
        var inputHiddenDate = fieldSet.querySelector(".input-hidden-date");

        [inputRadioOngoing, inputRadioUnknown, inputRadioConcreteDate].forEach((radio) => {
            radio?.addEventListener('change', () => {
                setupDateInputElements(
                    toggleableContainer,
                    inputRadioOngoing,
                    inputRadioUnknown,
                    inputRadioConcreteDate,
                    inputConcreteDate,
                    inputHiddenDate);
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
            inputHiddenDate);
    });
}
function setupDateInputElements(
    toggleableContainer,
    inputRadioOngoing,
    inputRadioUnknown,
    inputRadioConcreteDate,
    inputConcreteDate,
    inputHiddenDate) {

    // needed for simple toggleable fieldsets
    const toggleableTooltipContainerChild = toggleableContainer.querySelector('.tooltip-container');

    // needed for toggleable fieldsets that have toggleable parent - spouses section
    const toggleableTooltipContainerParent = toggleableContainer.parentElement?.closest('.tooltip-container');

    if (inputRadioOngoing?.checked) {
        setupForNonConcreteDate(toggleableContainer, toggleableTooltipContainerChild, toggleableTooltipContainerParent, inputConcreteDate);
        inputHiddenDate.value = null;
    }

    if (inputRadioUnknown.checked) {
        setupForNonConcreteDate(toggleableContainer, toggleableTooltipContainerChild, toggleableTooltipContainerParent, inputConcreteDate);
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
    inputConcreteDate) {

    toggleableContainer.classList.remove('toggleable-container-open');

    removeClass(toggleableTooltipContainerChild, 'overflowvisible');

    if (toggleableTooltipContainerParent) {
        removeClass(toggleableTooltipContainerParent, 'overflowvisible');
    }

    inputConcreteDate.removeAttribute("pattern");
    inputConcreteDate.removeAttribute("title");
    inputConcreteDate.removeAttribute("required");
}

function setupForConcreteDate(
    toggleableContainer,
    toggleableTooltipContainerChild,
    toggleableTooltipContainerParent,
    inputConcreteDate) {

    toggleableContainer.classList.add('toggleable-container-open');

    setTimeout(() => { addClass(toggleableTooltipContainerChild, 'overflowvisible'); }, 300);

    if (toggleableTooltipContainerParent) {
        addClass(toggleableTooltipContainerParent, 'overflowvisible');
    }

    inputConcreteDate.setAttribute("pattern", ServerDateInputValidationPattern);
    inputConcreteDate.setAttribute("title", "Date format should be " + ServerDateUnknown);
    inputConcreteDate.setAttribute("required", "");
}

function addClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;
    element.dataset[className] = count + 1;

    element.classList.add(className);
}

function removeClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;

    if (count > 1) {
        element.dataset[className] = count - 1;
    } else {
        element.classList.remove(className);
        delete element.dataset[className];
    }
}