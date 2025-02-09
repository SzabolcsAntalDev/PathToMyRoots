function isMaleSelectChanged() {
    firstSpouseIdChanged();
    secondSpouseIdChanged();
}

function firstSpouseIdChanged() {
    updateSpouseSelects('second', 'first');
}

function secondSpouseIdChanged() {
    updateSpouseSelects('first', 'second');
}

function updateSpouseSelects(idleSelectName, changedSelectName) {
    const isMale = document.getElementById('is-male-select').value.toLowerCase();
    const changedSelect = document.getElementById(changedSelectName + '-spouse-select');
    const changedSelectValue = changedSelect.value;

    document.querySelectorAll('#' + idleSelectName + '-spouse-select option').forEach(option => {
        option.style.display =
            (option.value !== "" && (option.dataset.isMale.toLowerCase() === isMale || option.value == changedSelectValue))
                ? 'none'
                : '';
    });

    const changedSpouseMarriageDatesContainer = document.getElementById(changedSelectName + '-spouse-marriage-dates-container');
    changedSpouseMarriageDatesContainer.style.display =
        changedSelect.value
            ? 'flex'
            : 'none';
}