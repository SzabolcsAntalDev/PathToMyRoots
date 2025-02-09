function addDateInputChangedListener(name) {
    document.getElementById('input-' + name + '-date').addEventListener('change', function () {
        document.getElementById('input-hidden-' + name + '-date').value = this.value;
    });
}

function birthDateTypeChanged() {
    dateTypeChanged("birth");
}

function deathDateTypeChanged() {
    dateTypeChanged("death");
}

function firstMarriageStartDateTypeChanged() {
    dateTypeChanged("first-marriage-start");
}

function firstMarriageEndDateTypeChanged() {
    dateTypeChanged("first-marriage-end");
}

function secondMarriageStartDateTypeChanged() {
    dateTypeChanged("second-marriage-start");
}

function secondMarriageEndDateTypeChanged() {
    dateTypeChanged("second-marriage-end");
}

function dateTypeChanged(name) {
    var inputRadioAlive = document.getElementById("input-radio-" + name + "-date-alive");
    var inputRadioUnknown = document.getElementById("input-radio-" + name + "-date-unknown");
    var inputRadioConcreteDate = document.getElementById("input-radio-" + name + "-date-concrete-date");

    var inputDate = document.getElementById("input-" + name + "-date");
    var inputHiddenDate = document.getElementById("input-hidden-" + name + "-date");

    if (inputRadioAlive != null && inputRadioAlive.checked) {
        inputDate.style.display = "none";
        inputDate.removeAttribute("pattern");
        inputDate.removeAttribute("title");

        inputHiddenDate.value = null;
    }

    if (inputRadioUnknown.checked) {
        inputDate.style.display = "none";
        inputDate.removeAttribute("pattern");
        inputDate.removeAttribute("title");
        inputDate.removeAttribute("required");

        inputHiddenDate.value = UnknownInputDate;
    }

    if (inputRadioConcreteDate.checked) {
        inputDate.style.display = "block";
        inputDate.setAttribute("pattern", DateInputPattern);
        inputDate.setAttribute("title", "Date format should be " + DateInputFlatFormat);
        inputDate.setAttribute("required", "");

        inputHiddenDate.value = inputDate.value;
    }
}