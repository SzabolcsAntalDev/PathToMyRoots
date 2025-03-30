function initDropdowns() {

    addCommonDropdownsListeners();
    addGenderAndSpouseSpecificListeners();

    resetSpouseDropdowns();
}

function addCommonDropdownsListeners() {
    const dropdowns = document.querySelectorAll(".dropdown");
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
            dropdownHeader.classList.toggle('dropdown-header-opened');
            dropdownHeaderExpandButton.classList.toggle('dropdown-header-expand-button-opened');
            dropdownMenu.classList.toggle('dropdown-menu-opened');
        });

        // filtering
        dropdownMenuFilterInput.addEventListener('input', () => {
            dropdownMenuOptions.forEach(option => {
                const personNameSpan = option.querySelector('.person-name-span');
                if (personNameSpan) {
                    const personName = personNameSpan.textContent.toLowerCase();

                    if (personName.includes(dropdownMenuFilterInput.value.toLowerCase())) {
                        option.classList.remove('collapsed');
                    }
                    else {
                        option.classList.add('collapsed');
                    }
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

                // set header content
                dropdownHeaderSelectedOption.innerHTML = option.innerHTML;

                // set hidden input value
                dropdownMenuHiddenInput.value = option.getAttribute('data-value');
                dropdownMenuHiddenInput.dispatchEvent(new Event("change"));

                // close menu
                dropdownHeader.classList.remove('dropdown-header-opened');
                dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
                dropdownMenu.classList.remove('dropdown-menu-opened');
            });
        });

        // select default option if nothing is selected
        let selectedOption = dropdown.querySelector('.selected-option');
        if (!selectedOption) {
            selectedOption = dropdown.querySelector('li[data-value=""]');
            selectedOption.classList.add('selected-option');
        }

        // set selected option into header by default
        dropdownHeaderSelectedOption.innerHTML = selectedOption.innerHTML;

        dropdownMenuHiddenInput.value = selectedOption.getAttribute('data-value');
        dropdownMenuHiddenInput.dispatchEvent(new Event("change"));

        // close menu if user clicks out from dropdown
        document.addEventListener("click", (event) => {
            if (!dropdown.contains(event.target) && dropdownMenu.classList.contains('dropdown-menu-opened')) {
                dropdownMenuFilterInput.value = '';
                resetSpouseDropdowns();
                dropdownHeader.classList.remove('dropdown-header-opened');
                dropdownHeaderExpandButton.classList.remove('dropdown-header-expand-button-opened');
                dropdownMenu.classList.remove('dropdown-menu-opened');
            }
        });
    });
}

function addGenderAndSpouseSpecificListeners() {
    // add gender and spouse dropdown listeners
    const isMaleDropdownMenuHiddenInput = document.querySelector('#is-male-dropdown-menu-hidden-input');
    isMaleDropdownMenuHiddenInput.addEventListener('change', (event) => {
        resetSpouseDropdowns();
    });

    // Szabi: when spouse is set to null, reset marriage date inputs
    const firstSpouseDropdown = document.querySelector('#first-spouse-dropdown');
    const firstSpouseDropdownFilterInput = firstSpouseDropdown.querySelector('.dropdown-menu-filter-input');
    const firstSpouseDropdownMenuHiddenInput = firstSpouseDropdown.querySelector('input[type="hidden"]');
    firstSpouseDropdownFilterInput.addEventListener('input', (event) => {
        resetSpouseDropdowns();
    });
    firstSpouseDropdownMenuHiddenInput.addEventListener('change', (event) => {
        resetSpouseDropdowns();
    });

    const secondSpouseDropdown = document.querySelector('#second-spouse-dropdown');
    const secondSpouseDropdownFilterInput = secondSpouseDropdown.querySelector('.dropdown-menu-filter-input');
    const secondSpouseDropdownMenuHiddenInput = secondSpouseDropdown.querySelector('input[type="hidden"]');
    secondSpouseDropdownFilterInput.addEventListener('input', (event) => {
        resetSpouseDropdowns();
    });
    secondSpouseDropdownMenuHiddenInput.addEventListener('change', (event) => {
        resetSpouseDropdowns();
    });
}

function resetSpouseDropdowns() {

    resetSpouseDropdown('first');
    resetSpouseDropdown('second');
}

function resetSpouseDropdown(spousePrefix) {
    const isMale = document.querySelector('#is-male-dropdown-menu-hidden-input').value;

    const spouseDropdown = document.querySelector(`#${spousePrefix}-spouse-dropdown`);
    const spouseDropdownHeaderSelectedOption = spouseDropdown.querySelector('.dropdown-header-selected-option');
    const spouseDropdownMenuHiddenInput = spouseDropdown.querySelector('input[type="hidden"]');

    const spouseDropdownMenuFilterInputValue = spouseDropdown.querySelector('.dropdown-menu-filter-input').value.toLowerCase();

    // show/hide elements
    const dropdownMenuOptions = spouseDropdown.querySelectorAll('li');
    dropdownMenuOptions.forEach(option => {
        option.classList.remove('collapsed');
        option.classList.remove('selected-option');

        const optionIsMale = option.getAttribute('data-is-male')?.toLowerCase();
        const optionPersonNameSpan = option.querySelector('.person-name-span');
        const optionValue = option.getAttribute('data-value');

        const showOption =
            (optionIsMale == null) ||
            (
                optionIsMale != isMale &&
                optionPersonNameSpan.textContent.toLowerCase().includes(spouseDropdownMenuFilterInputValue)
            );

        if (!showOption) {
            option.classList.add('collapsed');
        }
    });

    // select element
    const optionToSelect =
        spouseDropdown.querySelector(`li[data-value='${spouseDropdownMenuHiddenInput.value}']:not(.collapsed)`) ??
        spouseDropdown.querySelector(`li[data-value='']`);

    optionToSelect.classList.add('selected-option');
    spouseDropdownHeaderSelectedOption.innerHTML = optionToSelect.innerHTML;

    // set hidden input value
    if (spouseDropdownMenuHiddenInput.value != optionToSelect.getAttribute('data-value')) {
        spouseDropdownMenuHiddenInput.value = optionToSelect.getAttribute('data-value');
        spouseDropdownMenuHiddenInput.dispatchEvent(new Event("change"));
    }
}