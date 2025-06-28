function createPersonImageWithFallbackSvg(imageUrl, className) {
    return $('<img>')
        .attr('class', className)
        .attr('src', apiUrl + '/image/get/' + imageUrl)
        .on('error', function () {
            onGetImageError(this, className);
        });
}

function onGetImageError(image, className) {
    const imageDiv = $('<div>')
        .attr('class', className);

    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

    svg.appendChild(use);
    imageDiv.append(svg);
    image.replaceWith(imageDiv[0]);
}