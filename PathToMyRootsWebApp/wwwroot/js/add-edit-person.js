const apiUrl = "https://localhost:7241/";

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

const inputImageUrl = document.getElementById("input-image-url");
const inputHiddenImageUrl = document.getElementById("input-hidden-image-url");
const imgPreviewImage = document.getElementById("img-preview-image");

const divCropperOverlay = document.getElementById("div-cropper-overlay");
const buttonCropConfirm = document.getElementById("button-crop-confirm");
const imgImageToCrop = document.getElementById("img-image-to-crop");

document.addEventListener("DOMContentLoaded", function () {

    addDateInputChangedListener("birth");
    addDateInputChangedListener("death");

    toggleBirthDate();
    toggleDeathDate();

    updatePreviewImage();
});

let cropper;

function updatePreviewImage() {
    const imageUrl = inputHiddenImageUrl.value;
    if (!imageUrl)
        return;

    imgPreviewImage.src = "https://localhost:7241/uploads/" + imageUrl;
    imgPreviewImage.style.display = 'block';
}

inputImageUrl.addEventListener("change", (event) => {
    const imageFile = event.target.files[0];
    const fileReader = new FileReader();

    fileReader.onload = (e) => {
        imgImageToCrop.src = e.target.result;
        divCropperOverlay.style.display = 'flex';

        if (cropper)
            cropper.destroy();

        cropper = new Cropper(imgImageToCrop, {
            aspectRatio: 3 / 4,
            viewMode: 1,
            autoCropArea: 0.8,
            responsive: true,
        });
    };

    fileReader.readAsDataURL(imageFile);
});

buttonCropConfirm.addEventListener("click", async (event) => {
    event.preventDefault();

    const croppedCanvas = cropper.getCroppedCanvas();

    croppedCanvas.toBlob(async (blob) => {
        const formData = new FormData();
        formData.append("image", blob, "cropped-image.png");
        try {
            const response = await fetch(apiUrl + "api/image/upload/", {
                method: 'POST',
                body: formData,
            });

            if (!response.ok) {
                throw new Error(`Server error: ${response.statusText}`);
            }

            const responseJson = await response.json();

            inputHiddenImageUrl.value = responseJson.url;
            updatePreviewImage();

            divCropperOverlay.style.display = 'none';
        }
        catch (error) {
            console.error("Upload failed:", error);
        }
    }, "image/png");
});
