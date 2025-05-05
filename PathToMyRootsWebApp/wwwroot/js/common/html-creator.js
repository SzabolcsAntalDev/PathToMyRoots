function createPersonImageWithFallbackSvg(className, imageUrl) {
    return $('<img>')
        .attr('class', className)
        .attr('src', apiUrl + '/image/get/' + imageUrl)
        .on('error', function () {
            onGetImageError(className, this);
        });
}

function onGetImageError(className, image) {
    const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('class', className);

    const imageDiv = $('<div>')
        .attr('class', 'image-div');

    svg.appendChild(use);
    imageDiv.append(svg);
    image.replaceWith(imageDiv[0]);
}

function createHiddenH2(text) {
    const hiddenH2 = $('<h2>')
        .text(text);

    hideElement(hiddenH2);

    return hiddenH2;
}