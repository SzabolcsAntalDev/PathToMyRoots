document.addEventListener("DOMContentLoaded", function () {
    addDateInputChangedListener("birth");
    addDateInputChangedListener("death");
    addDateInputChangedListener("first-marriage-start");
    addDateInputChangedListener("first-marriage-end");
    addDateInputChangedListener("second-marriage-start");
    addDateInputChangedListener("second-marriage-end");

    birthDateTypeChanged();
    deathDateTypeChanged();
    firstMarriageStartDateTypeChanged();
    firstMarriageEndDateTypeChanged();
    secondMarriageStartDateTypeChanged();
    secondMarriageEndDateTypeChanged();

    isMaleSelectChanged();
    
    updatePreviewImage();
});