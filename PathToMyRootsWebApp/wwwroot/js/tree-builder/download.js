async function downloadDiagramAsPng(treeContext) {
    const diagramClone = treeContext.treeDiagram.clone(true, true);

    // a clone of the diagram is needed to be created because
    // html2canvas does not support text-overflow: ellipsis
    // so we have to manually truncate the texts in the tree nodes
    // the wrapper is needed the diagram to have a parent
    const diagramWrapper = treeHtmlCreator.createDiagramWrapperForDownload();

    diagramWrapper.appendTo('body');
    diagramWrapper.append(diagramClone);

    const diagramRect = treeContext.treeDiagram[0].getBoundingClientRect();
    diagramClone.css({
        // use Math.floor to remove horizontal line on the very bottom
        // that appears sometimes because of sub-pixel rounding
        width: Math.floor(diagramRect.width) + 'px',
        height: Math.floor(diagramRect.height) + 'px',
        boxSizing: 'border-box'
    });

    // as html2canvas does not support text-overflow: ellipsis
    truncateTexts(diagramClone);

    html2canvas(diagramClone[0], {
        scale: window.devicePixelRatio,
        useCORS: true,
        imageSmoothingEnabled: true,
        imageSmoothingQuality: "high"
    }).then(canvas => {
        canvas.toBlob(blob => {
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = getDiagramImageName(treeContext);
            link.click();

            // frees up temporary object created by URL.createObjectURL(blob)
            URL.revokeObjectURL(link.href);
            diagramWrapper.remove();
        }, 'image/png');
    });
}

function truncateTexts(diagramClone) {
    // needed for text size measuring
    const canvasContext = document.createElement('canvas').getContext('2d');

    diagramClone.find('span').each(function () {
        const span = $(this);
        const text = span.text();

        const computedStyle = window.getComputedStyle(this);
        canvasContext.font = `${computedStyle.fontWeight} ${computedStyle.fontSize} ${computedStyle.fontFamily}`;

        const spanWidth = this.getBoundingClientRect().width;

        const truncatedText = truncateText(canvasContext, text, spanWidth);
        span.text(truncatedText);
    });
}

function truncateText(canvasContext, text, maxWidth) {
    const ellipsis = '…';
    const ellipsisWidth = canvasContext.measureText(ellipsis).width;
    let truncatedText = text;

    if (canvasContext.measureText(truncatedText).width <= maxWidth) {
        return truncatedText;
    }

    let textLength = truncatedText.length;
    while (canvasContext.measureText(truncatedText).width >= maxWidth - ellipsisWidth && textLength-- > 0) {
        truncatedText = truncatedText.substring(0, textLength);
    }

    return truncatedText + ellipsis;
}

function getDiagramImageName(treeContext) {
    const personName = formatPersonNameTechnical(treeContext.person);

    const imageSuffix =
        formatDiagramImageNameSuffix(
            treeContext.treeType,
            treeContext.ancestorsDepth,
            treeContext.descedantsDepth,
            treeContext.viewMode);

    return `${personName}${imageSuffix}.png`;
}