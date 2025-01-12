function toggleBirthDateInput() {
    var birthDateDiv = document.getElementById("birthDateDiv");
    var hiddenBirthDateInput = document.getElementById("hiddenBirthDate");
    var unknownRadio = document.getElementById("unknownBirthDate");
    var concreteDateRadio = document.getElementById("concreteBirthDate");
    var birthDateInput = document.getElementById("birthDateInput");

    if (concreteDateRadio.checked) {
        birthDateDiv.style.display = "block";
        hiddenBirthDateInput.value = birthDateInput.value || "";
    } else {
        birthDateDiv.style.display = "none";
        if (unknownRadio.checked) {
            hiddenBirthDateInput.value = UnknownDate;
        }
    }
}

function toggleDeathDateInput() {
    var deathDateDiv = document.getElementById("deathDateDiv");
    var hiddenDeathDateInput = document.getElementById("hiddenDeathDate");
    var aliveRadio = document.getElementById("alive");
    var unknownRadio = document.getElementById("unknownDeathDate");
    var concreteDateRadio = document.getElementById("concreteDeathDate");
    var deathDateInput = document.getElementById("deathDateInput");

    if (concreteDateRadio.checked) {
        deathDateDiv.style.display = "block";
        hiddenDeathDateInput.value = deathDateInput.value;
    } else {
        deathDateDiv.style.display = "none";
        if (aliveRadio.checked) {
            hiddenDeathDateInput.value = null;
        } else if (unknownRadio.checked) {
            hiddenDeathDateInput.value = UnknownDate;
        }
    }
}

function capitalizeFirstLetter(text) {
    if (text.length === 0) return text;
    return text.charAt(0).toUpperCase() + text.slice(1);
}

document.getElementById('deathDateInput').addEventListener('change', function () {
    var deathDate = this.value;
    document.getElementById('hiddenDeathDate').value = deathDate;
});

document.getElementById('birthDateInput').addEventListener('change', function () {
    var birthDate = this.value;
    document.getElementById('hiddenBirthDate').value = birthDate;
});

document.addEventListener("DOMContentLoaded", function () {
    toggleBirthDateInput();
    toggleDeathDateInput();
});