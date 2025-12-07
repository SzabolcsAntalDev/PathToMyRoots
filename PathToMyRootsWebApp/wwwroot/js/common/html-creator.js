function createPersonImageWithFallbackSvg(imageUrl, className) {

    if (imageUrl) {
        return $('<img>')
            .attr('class', className)
            .attr('src', apiUrl + '/image/get/' + imageUrl)
            // needed for the downloaded diagram to display the images
            .attr('crossorigin', 'anonymous')
            .on('error', function () {
                onGetImageError(this, className);
            });
    }

    return getPhantomImageDiv(className);
}

function onGetImageError(image, className) {
    image.replaceWith(getPhantomImageDiv(className));
}

function getPhantomImageDiv(className) {
    const imageDiv = $('<div>')
        .attr('class', className);

    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

    svg.appendChild(use);
    imageDiv.append(svg);
    return imageDiv[0];
}