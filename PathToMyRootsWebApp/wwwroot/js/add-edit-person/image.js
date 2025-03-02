const apiUrl = "https://localhost:7241/";

const hiddenInputImageUrl = document.getElementById("hidden-input-image-url");
const hiddenInputImage = document.getElementById("hidden-input-image");
const uploadImageButton = document.getElementById("upload-image-button");

const previewImageContainer = document.getElementById("preview-image");
const previewImage = document.getElementById("preview-image");
const removeImageButton = document.getElementById("remove-image-button");

const cropperBackgroundContainer = document.getElementById("cropper-background-container");
const imageToCrop = document.getElementById("image-to-crop");
const confirmCropButton = document.getElementById("confirm-crop-button");

let cropper;

uploadImageButton.addEventListener("click", (event) => {
    event.preventDefault();
    hiddenInputImage.click();
});

hiddenInputImage.addEventListener("change", (event) => {
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

        await deleteImage(hiddenInputImageUrl.value);

        const response = await fetch(apiUrl + "api/image/upload/", {
            method: 'POST',
            body: formData,
        });

        const responseJson = await response.json();

        hiddenInputImageUrl.value = responseJson.url;
        updatePreviewImageContainer();

        cropperBackgroundContainer.style.display = 'none';
        hiddenInputImage.value = "";
    }, "image/png");
});

function updatePreviewImageContainer() {
    const imageUrl = hiddenInputImageUrl.value;
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

    await deleteImage(hiddenInputImageUrl.value);

    hiddenInputImageUrl.value = "";
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