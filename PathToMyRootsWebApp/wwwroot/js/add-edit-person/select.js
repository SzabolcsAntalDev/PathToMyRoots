function isMaleSelectChanged() {
    const isMaleSelect = document.getElementById('is-male-select');
    const isMale = isMaleSelect.value.toLowerCase();

    updateSpouseSelects('first', isMale);
    updateSpouseSelects('second', isMale);
}

function updateSpouseSelects(name, isMale) {
    const spouseSelect = document.getElementById(name + '-spouse-select');

    spouseSelect.value = "";
    document.querySelectorAll('#' + name + '-spouse-select option').forEach(option => {
        if (option.value === "")
            return;

        option.style.display = option.dataset.isMale.toLowerCase() !== isMale ? '' : 'none';
    });
}

function firstSpouseIdChanged() {
    spouseIdChanged('first');
}

function secondSpouseIdChanged() {
    spouseIdChanged('second');
}

function spouseIdChanged(name) {
    const spouseMarriageDatesContainer = document.getElementById(name + '-spouse-marriage-dates-container');
    const spouseSelect = document.getElementById(name + '-spouse-select');

    spouseMarriageDatesContainer.style.display =
        spouseSelect.value
            ? 'flex'
            : 'none';
}