const apiUrl = "https://localhost:7241/";

const hiddenImageInputUrl = document.getElementById("hidden-image-input-url");
const hiddenImageInput = document.getElementById("hidden-image-input");
const selectImageButton = document.getElementById("select-image-button");

const previewImageContainer = document.getElementById("preview-image");
const previewImage = document.getElementById("preview-image");
const removeImageButton = document.getElementById("remove-image-button");

const cropperBackgroundContainer = document.getElementById("cropper-background-container");
const imageToCrop = document.getElementById("image-to-crop");
const confirmCropButton = document.getElementById("confirm-crop-button");
const cancelCropButton = document.getElementById("cancel-crop-button");

let cropper;

selectImageButton.addEventListener("click", (event) => {
    event.preventDefault();
    hiddenImageInput.click();
});

hiddenImageInput.addEventListener("change", (event) => {
    const imageFile = event.target.files[0];
    const fileReader = new FileReader();

    fileReader.onload = (e) => {
        imageToCrop.src = e.target.result;
        cropperBackgroundContainer.style.display = 'flex';

        if (cropper)
            cropper.destroy();

        cropper = new Cropper(imageToCrop, {
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

        await deleteImage(hiddenImageInputUrl.value);

        const response = await fetch(apiUrl + "api/image/upload/", {
            method: 'POST',
            body: formData,
        });

        const responseJson = await response.json();

        hiddenImageInputUrl.value = responseJson.url;
        updatePreviewImageContainer();

        cropperBackgroundContainer.style.display = 'none';
        hiddenImageInput.value = "";
    }, "image/png");
});

cancelCropButton.addEventListener("click", async (event) => {
    event.preventDefault();
    cropperBackgroundContainer.style.display = 'none';
});

function updatePreviewImageContainer() {
    const imageUrl = hiddenImageInputUrl.value;
    if (!imageUrl) {
        previewImage.src = "";
        previewImageContainer.style.display = 'none';
        return;
    }

    previewImage.src = "https://localhost:7241/api/Image/get/" + imageUrl;
    previewImageContainer.style.display = 'inline-block';
}

removeImageButton.addEventListener("click", async (event) => {
    event.preventDefault();

    await deleteImage(hiddenImageInputUrl.value);

    hiddenImageInputUrl.value = "";
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