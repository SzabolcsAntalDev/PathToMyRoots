function getOrCreateHiddenLoadingTextContainer(parent) {
    let loadingTextContainer = parent.find('#loading-text-container').get(0);
    if (loadingTextContainer) {
        return loadingTextContainer;
    }

    const loadingText =
        $('<label>')
            .css('margin', '0px')
            .text('Loading...');

    loadingTextContainer =
        $('<div>')
            .attr('id', 'loading-text-container')
            .append(loadingText);

    hideElement(loadingTextContainer);

    return loadingTextContainer;
}