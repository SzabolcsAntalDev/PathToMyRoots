function addSettingsListeners() {
    const settingsDivs = $('.settings-div');

    settingsDivs.each((_, settingsDiv) => {
        const expandButtonDiv = $(settingsDiv).find('.expand-button-div');
        const horizontalToggleableContainer = $(settingsDiv).find('.horizontal-toggleable-container');

        expandButtonDiv.on('click', () => {
            expandButtonDiv.toggleClass('expand-button-div-opened');
            horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
        });
    });

    //[inputRadioOngoing, inputRadioUnknown, inputRadioConcreteDate].forEach((radio) => {
    //    radio?.addEventListener('change', () => {
    //        setupDateInputElements(
    //            toggleableContainer,
    //            inputRadioOngoing,
    //            inputRadioUnknown,
    //            inputRadioConcreteDate,
    //            inputConcreteDate,
    //            inputHiddenDate,
    //            false);
    //    });
    //})


    //treeTypesRadioButtons.forEach(radioButton => {
    //    radioButton.addEventListener('change', () => {

    //    });
    //});

    //dropdownHeader.classList.toggle('dropdown-header-opened');
    //dropdownMenuFilterInput.value = '';
    //dropdownMenuFilterInput.dispatchEvent(new Event('input'));
    //dropdownHeader.classList.toggle('dropdown-header-opened');
    //dropdownHeaderExpandButton.classList.toggle('dropdown-header-expand-button-opened');
    //dropdownMenu.classList.toggle('dropdown-menu-opened');

    //// close menu when user clicks out from dropdown
    //document.addEventListener('click', (event) => {
    //    if (!dropdown.contains(event.target) && dropdownMenu.classList.contains('dropdown-menu-opened')) {
    //        dropdownHeader.classList.remove('dropdown-header-opened');
    //        dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
    //        dropdownMenu.classList.remove('dropdown-menu-opened');
    //    }
    //});

    //// filter items on filter input and gender in case of spouses
    //dropdownMenuFilterInput.addEventListener('input', () => {
    //    const filterString = dropdownMenuFilterInput.value.toLowerCase()
    //    dropdownMenuOptions.forEach(option => {
    //        option.classList.remove('collapsed');

    //        const optionValue = option.getAttribute('data-value');

    //        // skip default options
    //        if (!optionValue) {
    //            return;
    //        }

    //        const optionPersonName = option.querySelector('.person-name-span')?.textContent?.toLowerCase();

    //        // skip gender options
    //        if (!optionPersonName) {
    //            return;
    //        }

    //        const currentPersonIsMale = document.querySelector('#is-male-dropdown-menu-hidden-input').value;
    //        const optionIsMale = option.getAttribute('data-is-male')?.toLowerCase();

    //        // parental dropdowns do not have isMale data, they are already filtered in the cshtml
    //        const isParentalDropDown = optionIsMale === undefined;
    //        const spouseIsOppositeGender = optionIsMale != currentPersonIsMale;
    //        const showOption =
    //            (isParentalDropDown || spouseIsOppositeGender) &&
    //            optionPersonName.includes(filterString);

    //        if (!showOption) {
    //            option.classList.add('collapsed');
    //        }
    //    });
    //});

    //// when an option is selected
    //dropdownMenuOptions.forEach(option => {
    //    option.addEventListener('click', () => {

    //        // unselect previous option
    //        const previouslySelectedOption = dropdown.querySelector('li.selected-option');
    //        if (previouslySelectedOption) {
    //            previouslySelectedOption.classList.remove('selected-option');
    //        }

    //        // select current option
    //        option.classList.add('selected-option');

    //        // set hidden input value
    //        dropdownMenuHiddenInput.value = option.getAttribute('data-value');
    //        dropdownMenuHiddenInput.dispatchEvent(new Event('change'));

    //        // set header content
    //        dropdownHeaderSelectedOption.innerHTML = option.innerHTML;

    //        // close menu
    //        dropdownHeader.classList.remove('dropdown-header-opened');
    //        dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
    //        dropdownMenu.classList.remove('dropdown-menu-opened');
    //    });
    //});

    //// set default option and header
    //let selectedOption = dropdown.querySelector('.selected-option');
    //if (!selectedOption) {
    //    selectedOption = dropdown.querySelector('li[data-value=""]');
    //    selectedOption.classList.add('selected-option');
    //}

    //dropdownHeaderSelectedOption.innerHTML = selectedOption.innerHTML;
    //dropdownMenuHiddenInput.value = selectedOption.getAttribute('data-value');
    //dropdownMenuHiddenInput.dispatchEvent(new Event('change'));
}