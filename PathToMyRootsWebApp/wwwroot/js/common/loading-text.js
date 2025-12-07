const loadingTextManager = {

    animatedLoadingTextDivsToAnimations: new WeakMap(),

    getOrCreateHiddenLoadingTextContainer(parent) {
        let loadingTextContainer = parent.find('.loading-text-container').get(0);
        if (loadingTextContainer) {
            return loadingTextContainer;
        }

        const animatedLoadingTextDiv =
            $('<div>')
                .attr('class', 'animated-loading-text-div');

        const customLoadingTextLabel =
            $('<label>')
                .attr('class', 'custom-loading-text-label');

        const loadingTextDisableMask =
            $('<div>')
                .attr('class', 'loading-text-disable-mask');

        loadingTextContainer =
            $('<div>')
                .attr('class', 'loading-text-container')
                .append(animatedLoadingTextDiv)
                .append(customLoadingTextLabel);

        loadingTextContainer.loadingTextDisableMask = loadingTextDisableMask;

        parent.append(loadingTextDisableMask);
        parent.append(loadingTextContainer);

        const grandParent = parent.parent();

        if (window.MutationObserver) {
            const observer = new MutationObserver(() => this.centerLoadingTextContainer(loadingTextContainer));
            observer.observe(grandParent[0], { childList: true, subtree: true, characterData: true });
        }

        hideElement(loadingTextContainer);

        return loadingTextContainer;
    },

    centerLoadingTextContainer(loadingTextContainer) {
        const parentRect = loadingTextContainer.parent()[0].getBoundingClientRect();
        const grandParentRect = loadingTextContainer.parent().parent()[0].getBoundingClientRect();

        // Intersection between parent and grandParent
        const visibleLeft = Math.max(parentRect.left, grandParentRect.left);
        const visibleRight = Math.min(parentRect.right, grandParentRect.right);
        const visibleTop = Math.max(parentRect.top, grandParentRect.top);
        const visibleBottom = Math.min(parentRect.bottom, grandParentRect.bottom);

        // the relatives column has a padding of thickness-large
        // so it shown a horizontal scrollbar if the loadingTextContainer is larger than the inner content
        const thicknessLargeValue = getThicknessLargeValue();

        const visibleWidth = visibleRight - visibleLeft - (2 * thicknessLargeValue);
        const visibleHeight = visibleBottom - visibleTop - (2 * thicknessLargeValue);

        const parentLeft = visibleLeft - parentRect.left + thicknessLargeValue;
        const parentTop = visibleTop - parentRect.top + thicknessLargeValue;

        loadingTextContainer.css({
            left: parentLeft + 'px',
            top: parentTop + 'px',
            width: visibleWidth + 'px',
            height: visibleHeight + 'px'
        });
    },

    async fadeIn(loadingTextContainer, text) {
        // set the custom text to empty, so when
        // the control below it fades in the old text is not shown
        this.setLoadingProgressText(loadingTextContainer.parent(), text);
        fadeInElement(loadingTextContainer.loadingTextDisableMask);

        this.startAnimating(loadingTextContainer);
        await fadeInElement(loadingTextContainer);
    },

    async fadeOut(loadingTextContainer) {
        fadeOutElement(loadingTextContainer.loadingTextDisableMask);
        await fadeOutElement(loadingTextContainer);
        this.stopAnimating(loadingTextContainer);
    },

    startAnimating(loadingTextContainer) {
        const animatedLoadingTextDiv = loadingTextContainer.find('.animated-loading-text-div')
        animatedLoadingTextDiv.empty();

        const loadingText = "Loading...";
        loadingText.split('').forEach(letter => {
            animatedLoadingTextDiv.append($('<span>').text(letter));
        });

        const spans = animatedLoadingTextDiv.find('span');
        const colorTransitionIntervalInSeconds = getColorTransitionIntervalInSeconds();
        let i = -1;

        const animation = setInterval(() => {
            spans[i]?.classList.remove('highlighted');
            i = (i + 1) % spans.length;
            spans[i].classList.add('highlighted');
        }, colorTransitionIntervalInSeconds * 1000);

        this.animatedLoadingTextDivsToAnimations.set(animatedLoadingTextDiv[0], animation);
    },

    stopAnimating(loadingTextContainer) {
        const animatedLoadingTextDiv = loadingTextContainer.find('.animated-loading-text-div')
        const animation = this.animatedLoadingTextDivsToAnimations.get(animatedLoadingTextDiv[0]);
        if (animation) {
            clearInterval(animation);
            this.animatedLoadingTextDivsToAnimations.delete(animatedLoadingTextDiv[0]);
        }
    },

    setLoadingProgressText(loadingTextContainerParent, text) {
        const customLoadingTextLabel = $(loadingTextContainerParent).find('.loading-text-container').find('.custom-loading-text-label');
        customLoadingTextLabel.html(text);
    }
}