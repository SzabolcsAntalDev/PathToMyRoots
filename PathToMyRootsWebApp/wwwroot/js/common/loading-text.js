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

        loadingTextContainer =
            $('<div>')
                .attr('class', 'loading-text-container')
                .append(animatedLoadingTextDiv)
                .append(customLoadingTextLabel);

        hideElement(loadingTextContainer);

        return loadingTextContainer;
    },

    async fadeIn(loadingTextContainer) {
        this.startAnimating(loadingTextContainer);
        await fadeInElement(loadingTextContainer);
    },

    async fadeOut(loadingTextContainer) {
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
        let i = -1;

        const q = getIntervalInSeconds('loading-text-letters-transition-interval');

        const animation = setInterval(() => {
            spans[i]?.classList.remove('highlighted');
            i = (i + 1) % spans.length;
            spans[i].classList.add('highlighted');
        }, getIntervalInSeconds('loading-text-letters-transition-interval') * 1000);

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