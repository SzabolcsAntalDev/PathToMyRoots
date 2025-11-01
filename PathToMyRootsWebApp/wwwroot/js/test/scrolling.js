function addScrollButtonsListeners() {
    const scrollTransitionInterval = getScrollTransitionIntervalInSeconds() * 1000;
    const scrollToTopButton = $('#scroll-to-top-button');
    const scrollToBottomButton = $('#scroll-to-bottom-button');
    const scrollableContent = $('#scrollable-content');

    scrollableContent.on('scroll', function () {
        updateTopButtonVisibility(scrollableContent, scrollToTopButton);
        updateBottomButtonVisibility(scrollableContent, scrollToBottomButton);
    });

    scrollableContent.on('resize', function () {
        updateTopButtonVisibility(scrollableContent, scrollToTopButton);
        updateBottomButtonVisibility(scrollableContent, scrollToBottomButton);
    });

    new MutationObserver(() => {
        updateTopButtonVisibility(scrollableContent, scrollToTopButton);
        updateBottomButtonVisibility(scrollableContent, scrollToBottomButton);
    }).observe(scrollableContent[0], {
        childList: true,
        subtree: true
    });

    $(window).on('resize', function () {
        updateTopButtonVisibility(scrollableContent, scrollToTopButton);
        updateBottomButtonVisibility(scrollableContent, scrollToBottomButton);
    });

    $('#scroll-to-top-button').on('click', function () {
        scrollableContent.animate(
            { scrollTop: 0 },
            scrollTransitionInterval);
    });

    $('#scroll-to-bottom-button').on('click', function () {
        scrollableContent.animate(
            { scrollTop: scrollableContent[0].scrollHeight - scrollableContent[0].clientHeight },
            scrollTransitionInterval);
    });
}

function updateTopButtonVisibility(scrollableContent, scrollToTopButton) {
    const scrollableContentElement = scrollableContent[0];
    const scrollBarIsVisible = scrollableContentElement.scrollHeight > scrollableContentElement.clientHeight;
    const isScrolledDown = scrollableContentElement.scrollTop > 0;

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

function updateBottomButtonVisibility(scrollableContent, scrollToBottomButton) {
    const scrollableContentElement = scrollableContent[0];
    const scrollBarIsVisible = scrollableContentElement.scrollHeight > scrollableContentElement.clientHeight;

    const isScrolledToBottom =
        scrollableContentElement.scrollTop + scrollableContentElement.clientHeight >=
        scrollableContentElement.scrollHeight - 1;

    const horizontalScrollbarVisible = scrollableContentElement.scrollWidth > scrollableContentElement.clientWidth;
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