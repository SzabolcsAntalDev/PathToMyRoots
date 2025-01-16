function toggleDate(name) {
    var inputRadioAlive = document.getElementById("input-radio-" + name + "-date-alive");
    var inputRadioUnknown = document.getElementById("input-radio-" + name + "-date-unknown");
    var inputRadioConcrete = document.getElementById("input-radio-" + name + "-date-concrete");

    var dateInput = document.getElementById("input-" + name + "-date");
    var hiddenDateInput = document.getElementById("input-hidden-" + name + "-date");

    if (inputRadioAlive != null && inputRadioAlive.checked) {
        dateInput.style.display = "none";
        dateInput.removeAttribute("pattern");
        dateInput.removeAttribute("title");

        hiddenDateInput.value = null;
    }

    if (inputRadioUnknown.checked) {
        dateInput.style.display = "none";
        dateInput.removeAttribute("pattern");
        dateInput.removeAttribute("title");
        dateInput.removeAttribute("required");

        hiddenDateInput.value = UnknownInputDate;
    }

    if (inputRadioConcrete.checked) {
        dateInput.style.display = "block";
        dateInput.setAttribute("pattern", DateInputPattern);
        dateInput.setAttribute("title", "Date format should be " + DateInputFlatFormat);
        dateInput.setAttribute("required", "");

        hiddenDateInput.value = dateInput.value;
    }
}

function addDateInputChangedListener(name) {
    document.getElementById("input-" + name + "-date").addEventListener('change', function () {
        document.getElementById("input-hidden-" + name + "-date").value = this.value;
    });
}

function toggleBirthDate() {
    toggleDate("birth");
}

function toggleDeathDate() {
    toggleDate("death");
}

document.addEventListener("DOMContentLoaded", function () {

    addDateInputChangedListener("birth");
    addDateInputChangedListener("death");

    toggleBirthDate();
    toggleDeathDate();
});