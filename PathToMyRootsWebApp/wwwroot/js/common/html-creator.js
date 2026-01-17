let phantomPersonSymbolShape = null;
let phantomPersonSymbolViewBox = null;

function createPersonImageWithFallbackSvg(imageUrl, className) {

    if (imageUrl) {
        return $('<img>')
            .attr('class', className)
            .attr('src', apiUrl + '/image/get/' + imageUrl)
            // needed for the downloaded diagram to display the images
            .attr('crossorigin', 'anonymous')
            .on('error', function () {
                this.replaceWith(getPhantomPersonImageDiv(className));
            });
    }

    return getPhantomPersonImageDiv(className);
}

async function preloadPhantomPersonSymbol() {
    if (phantomPersonSymbolShape) {
        return;
    }

    const response = await fetch('/icons/icons.svg');
    const responseText = await response.text();

    const svgDocObject = new DOMParser().parseFromString(responseText, 'image/svg+xml');
    const phantomPersonSymbol = svgDocObject.getElementById('phantom-person');

    phantomPersonSymbolShape = phantomPersonSymbol.innerHTML.trim();
    phantomPersonSymbolViewBox = phantomPersonSymbol.getAttribute('viewBox');
}

function getPhantomPersonImageDiv(className) {
    const phantomPersonImageDiv = $('<div>').addClass(className);

    const phantomPersonSvg =
        $(document.createElementNS('http://www.w3.org/2000/svg', 'svg'))
            .attr('viewBox', phantomPersonSymbolViewBox)
            .attr('width', '100%')
            .attr('height', '100%')
            .html(phantomPersonSymbolShape);

    phantomPersonImageDiv.append(phantomPersonSvg);

    return phantomPersonImageDiv[0];
}

(async () => {
    await preloadPhantomPersonSymbol();
})();

function createSvg(symbolName) {
    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');

    use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', `/icons/icons.svg#${symbolName}`);
    svg.appendChild(use);

    return svg;
}