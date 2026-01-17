const creatorImages = {
    phantomPersonSymbolSymbol: null,
    phantomPersonSymbolViewBox: null,

    async preloadPhantomPersonSymbol() {
        const response = await fetch('/icons/icons.svg');
        const responseText = await response.text();

        const svgDocObject = new DOMParser().parseFromString(responseText, 'image/svg+xml');
        const phantomPersonSymbol = svgDocObject.getElementById('phantom-person');

        this.phantomPersonSymbolSymbol = phantomPersonSymbol.innerHTML.trim();
        this.phantomPersonSymbolViewBox = phantomPersonSymbol.getAttribute('viewBox');
    },

    createPersonImageWithFallbackSvg(imageUrl, className) {
        const self = this;

        return $('<img>')
            .attr('class', className)
            .attr('src', apiUrl + '/image/get/' + imageUrl)
            // needed for the downloaded diagram to display the images
            .attr('crossorigin', 'anonymous')
            .on('error', function () {
                this.replaceWith(self.getPhantomPersonImageDiv(className));
            });
    },

    getPhantomPersonImageDiv(className) {
        const phantomPersonImageDiv = $('<div>').addClass(className);

        const self = this;
        // is svg not loaded yet, retry later
        if (!this.phantomPersonSymbolSymbol || !this.phantomPersonSymbolViewBox) {
            setTimeout(() => {
                phantomPersonImageDiv.replaceWith(
                    self.getPhantomPersonImageDiv(className)
                );
            }, 1000);

            return phantomPersonImageDiv[0];
        }

        const phantomPersonSvg =
            $(document.createElementNS('http://www.w3.org/2000/svg', 'svg'))
                .attr('viewBox', this.phantomPersonSymbolViewBox)
                .attr('width', '100%')
                .attr('height', '100%')
                .html(this.phantomPersonSymbolSymbol);

        phantomPersonImageDiv.append(phantomPersonSvg);

        return phantomPersonImageDiv[0];
    },

    createSvg(symbolName) {
        const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');

        use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', `/icons/icons.svg#${symbolName}`);
        svg.appendChild(use);

        return svg;
    }
}

creatorImages.preloadPhantomPersonSymbol();