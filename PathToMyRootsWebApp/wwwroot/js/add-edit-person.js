const apiUrl = "https://localhost:7241/";

function toggleDate(name) {
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
const buttonUploadImage = document.getElementById("button-upload-image");
const previewImageContainer = document.getElementById("person-preview-image-container");
const imgPreviewImage = document.getElementById("img-preview-image");
const buttonRemoveImage = document.getElementById("button-remove-image");
const inputHiddenImageUrl = document.getElementById("input-hidden-image-url");

let cropper;
const cropperBackgroundContainer = document.getElementById("person-cropper-background-container");
const confirmCropButton = document.getElementById("confirm-crop-button");
const imgImageToCrop = document.getElementById("person-image-to-crop");

document.addEventListener("DOMContentLoaded", function () {

    addDateInputChangedListener("birth");
    addDateInputChangedListener("death");

    toggleBirthDate();
    toggleDeathDate();

    updatePreviewImageContainer();
});

buttonUploadImage.addEventListener("click", (event) => {
    event.preventDefault();
    inputImageUrl.click();
});

function updatePreviewImageContainer() {
    const imageUrl = inputHiddenImageUrl.value;
    if (!imageUrl) {
        imgPreviewImage.src = "";
        previewImageContainer.style.display = 'none';
        return;
    }

    imgPreviewImage.src = "https://localhost:7241/api/Image/get/" + imageUrl;
    previewImageContainer.style.display = 'inline-block';
}

inputImageUrl.addEventListener("change", (event) => {
    const imageFile = event.target.files[0];
    const fileReader = new FileReader();

    fileReader.onload = (e) => {
        imgImageToCrop.src = e.target.result;
        cropperBackgroundContainer.style.display = 'flex';

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

confirmCropButton.addEventListener("click", async (event) => {
    event.preventDefault();

    const croppedCanvas = cropper.getCroppedCanvas();

    croppedCanvas.toBlob(async (blob) => {
        const formData = new FormData();
        formData.append("image", blob, "cropped-image.png");

        await deleteImage(inputHiddenImageUrl.value);

        const response = await fetch(apiUrl + "api/image/upload/", {
            method: 'POST',
            body: formData,
        });

        const responseJson = await response.json();

        inputHiddenImageUrl.value = responseJson.url;
        updatePreviewImageContainer();

        cropperBackgroundContainer.style.display = 'none';
        inputImageUrl.value = "";
    }, "image/png");
});

buttonRemoveImage.addEventListener("click", async (event) => {
    event.preventDefault();

    await deleteImage(inputHiddenImageUrl.value);

    inputHiddenImageUrl.value = "";
    updatePreviewImageContainer();
});

async function deleteImage(imageName) {
    if (!imageName)
        return;

    var url = apiUrl + `api/image/delete/${imageName}`;
    await fetch(url, {
        method: "DELETE",
    });
}