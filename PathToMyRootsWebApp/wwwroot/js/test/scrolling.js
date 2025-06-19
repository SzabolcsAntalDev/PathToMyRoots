function addScrollButtonsListeners() {
    const scrollTransitionInterval = getScrollTransitionIntervalInSeconds() * 1000;
    const scrollToTopButton = $('#scroll-to-top-button');
    const scrollToBottomButton = $('#scroll-to-bottom-button');
    const treeDiagramsDiv = $('#tree-diagrams-div');

    treeDiagramsDiv.on('scroll', function () {
        updateTopButtonVisibility(treeDiagramsDiv, scrollToTopButton);
        updateBottomButtonVisibility(treeDiagramsDiv, scrollToBottomButton);
    });

    treeDiagramsDiv.on('resize', function () {
        updateTopButtonVisibility(treeDiagramsDiv, scrollToTopButton);
        updateBottomButtonVisibility(treeDiagramsDiv, scrollToBottomButton);
    });

    new MutationObserver(() => {
        updateTopButtonVisibility(treeDiagramsDiv, scrollToTopButton);
        updateBottomButtonVisibility(treeDiagramsDiv, scrollToBottomButton);
    }).observe(treeDiagramsDiv[0], {
        childList: true,
        subtree: true
    });

    $(window).on('resize', function () {
        updateTopButtonVisibility(treeDiagramsDiv, scrollToTopButton);
        updateBottomButtonVisibility(treeDiagramsDiv, scrollToBottomButton);
    });

    $('#scroll-to-top-button').on('click', function () {
        treeDiagramsDiv.animate(
            { scrollTop: 0 },
            scrollTransitionInterval);
    });

    $('#scroll-to-bottom-button').on('click', function () {
        treeDiagramsDiv.animate(
            { scrollTop: treeDiagramsDiv[0].scrollHeight - treeDiagramsDiv[0].clientHeight },
            scrollTransitionInterval);
    });
}

function updateTopButtonVisibility(treeDiagramsDiv, scrollToTopButton) {
    const treeDiagramsDivElement = treeDiagramsDiv[0];
    const scrollBarIsVisible = treeDiagramsDivElement.scrollHeight > treeDiagramsDivElement.clientHeight;
    const isScrolledDown = treeDiagramsDivElement.scrollTop > 0;

    if (scrollBarIsVisible && isScrolledDown) {
        if (!isVisibleElement(scrollToTopButton)) {
            fadeInElement(scrollToTopButton);
        }
    }
    else {
        if (isVisibleElement(scrollToTopButton)) {
            fadeOutElement(scrollToTopButton);
        }
    }
}

function updateBottomButtonVisibility(treeDiagramsDiv, scrollToBottomButton) {
    const treeDiagramsDivElement = treeDiagramsDiv[0];
    const scrollBarIsVisible = treeDiagramsDivElement.scrollHeight > treeDiagramsDivElement.clientHeight;

    const isScrolledToBottom =
        treeDiagramsDivElement.scrollTop + treeDiagramsDivElement.clientHeight >=
        treeDiagramsDivElement.scrollHeight - 1;

    const horizontalScrollbarVisible = treeDiagramsDivElement.scrollWidth > treeDiagramsDivElement.clientWidth;
    scrollToBottomButton.css('bottom', horizontalScrollbarVisible ? getScrollBarSize() : '0px');

    if (scrollBarIsVisible && !isScrolledToBottom) {
        if (!isVisibleElement(scrollToBottomButton)) {
            fadeInElement(scrollToBottomButton);
        }
    }
    else {
        if (isVisibleElement(scrollToBottomButton)) {
            fadeOutElement(scrollToBottomButton);
        }
    }
}