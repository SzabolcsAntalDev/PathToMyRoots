function initDropdowns() {

    addGenderAndSpouseSpecificListeners();
    addCommonDropdownsListeners();
}

// open and close menu
// filtering by filter input
// selecting option
// setting default values
function addCommonDropdownsListeners() {
    const dropdowns = document.querySelectorAll('.dropdown');

    dropdowns.forEach(dropdown => {
        // init consts
        const dropdownHeader = dropdown.querySelector('.dropdown-header');
        const dropdownHeaderSelectedOption = dropdown.querySelector('.dropdown-header-selected-option');
        const dropdownHeaderExpandButton = dropdown.querySelector('.dropdown-header-expand-button');
        const dropdownMenu = dropdown.querySelector('.dropdown-menu');
        const dropdownMenuFilterInput = dropdown.querySelector('.dropdown-menu-filter-input');
        const dropdownMenuOptions = dropdown.querySelectorAll('.dropdown-menu li');
        const dropdownMenuHiddenInput = dropdown.querySelector('input[type="hidden"]');

        // open menu on header click
        dropdownHeader.addEventListener('click', () => {
            dropdownMenuFilterInput.value = '';
            dropdownMenuFilterInput.dispatchEvent(new Event('input'));
            dropdownHeader.classList.toggle('dropdown-header-opened');
            dropdownHeaderExpandButton.classList.toggle('dropdown-header-expand-button-opened');
            dropdownMenu.classList.toggle('dropdown-menu-opened');
        });

        // close menu when user clicks out from dropdown
        document.addEventListener('click', (event) => {
            if (!dropdown.contains(event.target) && dropdownMenu.classList.contains('dropdown-menu-opened')) {
                dropdownHeader.classList.remove('dropdown-header-opened');
                dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
                dropdownMenu.classList.remove('dropdown-menu-opened');
            }
        });

        // filter items on filter input and gender in case of spouses
        dropdownMenuFilterInput.addEventListener('input', () => {
            const filterString = dropdownMenuFilterInput.value.toLowerCase()
            dropdownMenuOptions.forEach(option => {
                option.classList.remove('collapsed');

                const optionValue = option.getAttribute('data-value');

                // skip default options
                if (!optionValue) {
                    return;
                }

                const optionPersonName = option.querySelector('.person-name-span')?.textContent?.toLowerCase();

                // skip gender options
                if (!optionPersonName) {
                    return;
                }

                const currentPersonIsMale = document.querySelector('#is-male-dropdown-menu-hidden-input').value;
                const optionIsMale = option.getAttribute('data-is-male')?.toLowerCase();

                // parental dropdowns do not have isMale data, they are already filtered in the cshtml
                const isParentalDropDown = optionIsMale === undefined;
                const spouseIsOppositeGender = optionIsMale != currentPersonIsMale;
                const showOption =
                    (isParentalDropDown || spouseIsOppositeGender) &&
                    optionPersonName.includes(filterString);

                if (!showOption) {
                    option.classList.add('collapsed');
                }
            });
        });

        // when an option is selected
        dropdownMenuOptions.forEach(option => {
            option.addEventListener('click', () => {

                // unselect previous option
                const previouslySelectedOption = dropdown.querySelector('li.selected-option');
                if (previouslySelectedOption) {
                    previouslySelectedOption.classList.remove('selected-option');
                }

                // select current option
                option.classList.add('selected-option');

                // set hidden input value
                dropdownMenuHiddenInput.value = option.getAttribute('data-value');
                dropdownMenuHiddenInput.dispatchEvent(new Event('change'));

                // set header content
                dropdownHeaderSelectedOption.innerHTML = option.innerHTML;

                // close menu
                dropdownHeader.classList.remove('dropdown-header-opened');
                dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
                dropdownMenu.classList.remove('dropdown-menu-opened');
            });
        });

        // set default option and header
        let selectedOption = dropdown.querySelector('.selected-option');
        if (!selectedOption) {
            // Szabi
            selectedOption = dropdown.querySelector('li[data-value=""]');
            selectedOption.classList.add('selected-option');
        }

        dropdownHeaderSelectedOption.innerHTML = selectedOption.innerHTML;
        dropdownMenuHiddenInput.value = selectedOption.getAttribute('data-value');
        dropdownMenuHiddenInput.dispatchEvent(new Event('change'));
    });
}

function addGenderAndSpouseSpecificListeners() {
    // if gender changed reset spouse dropdowns
    const isMaleDropdownMenuHiddenInput = document.querySelector('#is-male-dropdown-menu-hidden-input');
    isMaleDropdownMenuHiddenInput.addEventListener('change', () => {
        setDefaultSpouse('first');
        setDefaultSpouse('second');
    });

    // if spouse changed to default then reset marriage date inputs
    const firstSpouseDropdown = document.querySelector('#first-spouse-dropdown');
    const firstSpouseDropdownMenuHiddenInput = firstSpouseDropdown.querySelector('input[type="hidden"]');
    firstSpouseDropdownMenuHiddenInput.addEventListener('change', () => {
        toggleMarriageDatesContainer('first');
    });

    const secondSpouseDropdown = document.querySelector('#second-spouse-dropdown');
    const secondSpouseDropdownMenuHiddenInput = secondSpouseDropdown.querySelector('input[type="hidden"]');
    secondSpouseDropdownMenuHiddenInput.addEventListener('change', () => {
        toggleMarriageDatesContainer('second');
    });
}

function setDefaultSpouse(spousePrefix) {
    const spouseDropdown = document.querySelector(`#${spousePrefix}-spouse-dropdown`);
    const dropdownMenuOptions = spouseDropdown.querySelectorAll('.dropdown-menu li');
    dropdownMenuOptions[0].click();
}

function toggleMarriageDatesContainer(spousePrefix) {
    const spouseHiddenInput = document.querySelector(`#${spousePrefix}-spouse-dropdown input[type='hidden']`);
    const spouseMarriageDatesContainer = document.querySelector(`#${spousePrefix}-spouse-marriage-dates-container`);

    var personIsSelected = spouseHiddenInput.value != '';

    if (personIsSelected) {
        spouseMarriageDatesContainer.classList.add('toggleable-container-open');
    } else {
        spouseMarriageDatesContainer.classList.remove('toggleable-container-open');
        const fieldSets = spouseMarriageDatesContainer.querySelectorAll('.input-date-fieldset');
        fieldSets.forEach(fs => {
            const defaultRadio = fs.querySelector('input[type="radio"]');
            defaultRadio.checked = true;
            defaultRadio.dispatchEvent(new Event('change'));
        });
    }
}