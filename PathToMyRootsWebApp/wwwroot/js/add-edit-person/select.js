function setupSpouseSelects() {
    updateSpouseSelects('first');
    updateSpouseSelects('second');

    firstSpouseIdChanged();
    secondSpouseIdChanged();
}

function isMaleSelectChanged() {
    updateSpouseSelects('first').value = "";
    updateSpouseSelects('second').value = "";

    firstSpouseIdChanged();
    secondSpouseIdChanged();
}

function updateSpouseSelects(name) {
    const isMale = document.getElementById('is-male-select').value.toLowerCase();
    const spouseSelect = document.getElementById(name + '-spouse-select');

    document.querySelectorAll('#' + name + '-spouse-select option').forEach(option => {
        if (option.value === "")
            return;

        option.style.display = option.dataset.isMale.toLowerCase() !== isMale ? '' : 'none';
    });

    return spouseSelect;
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