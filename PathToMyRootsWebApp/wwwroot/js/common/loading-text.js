// gets the loading text container from the parent
// or creates one and adds it to the parent
// then returns it
function getOrCreateLoadingTextContainer(parent) {
    let loadingTextContainer = $('#loading-text-container');
    if (loadingTextContainer.length === 0) {
        loadingTextContainer =
            $('<div>')
                .attr('id', 'loading-text-container');

        hideElement(loadingTextContainer);

        const loadingText =
            $('<label>')
                .css('margin', '0px')
                .text('Loading...');

        loadingTextContainer.append(loadingText);
        parent.append(loadingTextContainer);
    }

    return loadingTextContainer;
}