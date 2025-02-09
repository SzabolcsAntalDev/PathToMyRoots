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
    const idleSelect = document.getElementById(idleSelectName + '-spouse-select');
    const changedSelect = document.getElementById(changedSelectName + '-spouse-select');

    const changedSelectValue = changedSelect.value;

    document.querySelectorAll('#' + idleSelectName + '-spouse-select option').forEach(option => {

        if (option.value == "") {
            option.style.display = '';
            return;
        }

        if (option.dataset.isMale.toLowerCase() === isMale) {
            option.style.display = 'none';
            return;
        }

        if (option.value == changedSelectValue) {
            option.style.display = 'none';
            return;
        }

        if (option.dataset.firstSpouseId &&
            option.dataset.secondSpouseId &&
            option.dataset.firstSpouseId != idleSelect.dataset.personId &&
            option.dataset.secondSpouseId != idleSelect.dataset.personId) {
            option.style.display = 'none';
            return;
        }

        option.style.display = '';
    });

    const changedSpouseMarriageDatesContainer = document.getElementById(changedSelectName + '-spouse-marriage-dates-container');
    changedSpouseMarriageDatesContainer.style.display =
        changedSelect.value
            ? 'flex'
            : 'none';
}