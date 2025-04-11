async function createOrGetLoadingTextContainer(parent) {
    var loadingTextContainer = document.getElementById("loading-text-container");
    if (!loadingTextContainer) {
        loadingTextContainer = document.createElement("div");

        loadingTextContainer.id = "loading-text-container";
        loadingTextContainer.className = "loading-text-container";
        hideElement(loadingTextContainer);

        const loadingText = document.createElement("label");
        loadingText.style.margin = "0px";
        loadingText.textContent = "Loading...";

        loadingTextContainer.appendChild(loadingText);
        parent.appendChild(loadingTextContainer);
    }

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, 1);
    });

    return loadingTextContainer;
}