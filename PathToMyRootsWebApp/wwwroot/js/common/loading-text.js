function getOrCreateHiddenLoadingTextContainer(parent) {
    let loadingTextContainer = parent.find('#loading-text-container').get(0);
    if (loadingTextContainer) {
        return loadingTextContainer;
    }

    const loadingTextLabel =
        $('<label>')
            .attr('id', 'loading-text-label')
            .text('Loading...');

    const loadingProgressTextLabel =
        $('<label>')
            .attr('id', 'loading-progress-text-label');

    loadingTextContainer =
        $('<div>')
            .attr('id', 'loading-text-container')
            .append(loadingTextLabel)
            .append(loadingProgressTextLabel);

    hideElement(loadingTextContainer);

    return loadingTextContainer;
}

function getLoadingProgressTextLabel(loadingTextContainerParent) {
    return $(loadingTextContainerParent).find('#loading-text-container').find('#loading-progress-text-label');
}

function setLoadingProgressText(loadingTextContainerParent, text) {
    getLoadingProgressTextLabel(loadingTextContainerParent).html(text);
}