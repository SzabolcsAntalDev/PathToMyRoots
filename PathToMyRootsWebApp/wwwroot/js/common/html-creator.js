// Szabi: reuse this everywhere
function createPersonImageWithFallbackSvg(className, imageUrl) {
    return $('<img>')
        .attr('class', className)
        .attr('src', apiUrl + '/image/get/' + imageUrl)
        .on('error', function () {
            const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
            use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', phantomPersonSymbolPath);

            const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
            svg.setAttribute('class', className);
            svg.setAttribute('viewBox', '0 0 3 4');
            svg.setAttribute('preserveAspectRatio', 'xMidYMid meet');

            svg.appendChild(use);
            $(this).replaceWith(svg);
        });
}