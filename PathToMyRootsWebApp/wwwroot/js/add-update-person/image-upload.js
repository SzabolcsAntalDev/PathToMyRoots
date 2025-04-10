const apiUrl = 'https://localhost:7241/';

function initImageUpload() {
    addImageUploadListeners();
}

function addImageUploadListeners() {
    const selectImageButton = document.getElementById('select-image-button');
    const removeImageButton = document.getElementById('remove-image-button');

    const cropperBackgroundContainer = document.getElementById('cropper-background-container');
    const imageToCrop = document.getElementById('image-to-crop');
    const confirmCropButton = document.getElementById('confirm-crop-button');
    const cancelCropButton = document.getElementById('cancel-crop-button');

    const hiddenImageInputUrl = document.getElementById('hidden-image-input-url');
    const hiddenImageInput = document.getElementById('hidden-image-input');

    let cropper;

    // open cropper when click on select image button
    selectImageButton.addEventListener('click', (event) => {
        event.preventDefault();
        hiddenImageInput.click();
    });

    hiddenImageInput.addEventListener('change', (event) => {
        const imageFile = event.target.files[0];
        const fileReader = new FileReader();

        // load selected image into cropper
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

    // on crop image
    confirmCropButton.addEventListener('click', async (event) => {
        event.preventDefault();

        const croppedCanvas = cropper.getCroppedCanvas();

        croppedCanvas.toBlob(async (blob) => {
            const formData = new FormData();
            formData.append('image', blob, 'cropped-image.png');

            // delete previous image if any
            if (hiddenImageInputUrl.value) {
                await deleteImage(hiddenImageInputUrl.value);
            }

            // upload the new image
            const response = await fetch(apiUrl + 'api/image/upload/', {
                method: 'POST',
                body: formData,
            });

            const responseJson = await response.json();

            // set image url into hidden input
            hiddenImageInputUrl.value = responseJson.url;
            updatePreviewImage();

            cropperBackgroundContainer.style.display = 'none';
            hiddenImageInput.value = '';
        }, 'image/png');
    });

    cancelCropButton.addEventListener('click', async (event) => {
        event.preventDefault();
        hiddenImageInput.value = '';
        cropperBackgroundContainer.style.display = 'none';
    });

    removeImageButton.addEventListener('click', async (event) => {
        event.preventDefault();

        await deleteImage(hiddenImageInputUrl.value);

        hiddenImageInputUrl.value = '';
        updatePreviewImage();
    });
}

function updatePreviewImage() {

    const toggleablePreviewImageContainer = document.getElementById('toggleable-preview-image-container');
    const previewImage = document.getElementById('preview-image');
    const removeImageButton = document.getElementById('remove-image-button');
    const hiddenImageInputUrl = document.getElementById('hidden-image-input-url');

    const imageUrl = hiddenImageInputUrl.value;

    // if image was removed
    if (!imageUrl) {
        toggleablePreviewImageContainer.classList.remove('toggleable-container-open');
        removeImageButton.disabled = true;
        return;
    }

    // set image from hidden input into the preview
    toggleablePreviewImageContainer.classList.add('toggleable-container-open');
    previewImage.src = 'https://localhost:7241/api/Image/get/' + imageUrl;
    removeImageButton.removeAttribute('disabled');
}

async function deleteImage(imageName) {
    if (!imageName)
        return;

    var url = apiUrl + `api/image/delete/${imageName}`;
    await fetch(url, {
        method: 'DELETE',
    });
}