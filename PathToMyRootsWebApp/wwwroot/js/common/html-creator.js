﻿function createPersonImageWithFallbackSvg(imageUrl, className) {
    return $('<img>')
        .attr('class', className)
        .attr('src', apiUrl + '/image/get/' + imageUrl)
        .on('error', function () {
            onGetImageError(this, className);
        });
}

function onGetImageError(image, className) {

    const imageDiv = $('<div>')
        .attr('class', 'phantom-image-div ' + className);

    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('class', 'phantom-svg');

    const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);
    use.setAttribute('class', 'phantom-use');

    svg.appendChild(use);
    imageDiv.append(svg);
    image.replaceWith(imageDiv[0]);
}