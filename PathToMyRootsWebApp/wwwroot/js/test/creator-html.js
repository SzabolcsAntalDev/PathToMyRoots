const testsHtmlCreator = {
    createHiddenH2(text) {
        const hiddenH2 = $('<h2>')
            .text(text);

        hideElement(hiddenH2);

        return hiddenH2;
    },

    createHiddenTestCaseDiv(id) {
        const hiddenDiv = $('<div>')
            .attr('id', id)
            .attr('class', 'test-case-div');

        hideElement(hiddenDiv);

        return hiddenDiv;
    },

    createIcon(id) {
        const imageDiv = $('<div>')
            .attr('class', 'svg-div-' + id);

        const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
        use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', "/icons/icons.svg#" + id);

        svg.appendChild(use);
        imageDiv.append(svg);
        return imageDiv;
    },

    createP(text) {
        return $('<p>')
            .text(text);
    },

    createHiddenH3(text) {
        const hiddenH3 = $('<h3>')
            .text(text);

        hideElement(hiddenH3);

        return hiddenH3;
    },

    createScrollToTestButton(treeDiagramsDiv, testTitle) {
        const button = $('<button>')
            .addClass('flat-button-with-svg-small');

        hideElement(button);

        const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
        use.setAttributeNS('http://www.w3.org/1999/xlink', 'xlink:href', "/icons/icons.svg#arrow-down");

        svg.appendChild(use);
        button.append(svg);

        button.on('click', function () {
            const treeDiagramsDivTop = treeDiagramsDiv.offset().top;
            const testTitleTop = testTitle.offset().top;
            const scrollTop = treeDiagramsDiv.scrollTop();

            const offset = testTitleTop - treeDiagramsDivTop + scrollTop;

            treeDiagramsDiv.animate({
                scrollTop: offset
            }, getScrollTransitionIntervalInSeconds() * 1000);
        });

        return button;
    }
}