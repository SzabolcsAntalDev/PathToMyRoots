function downloadPerson3() {
    const diagramFrame = $('#diagram-frame-3');
    const diagram = diagramFrame.find('.diagram').first()[0];

    html2canvas(diagram).then(canvas => {
        const base64image = canvas.toDataURL("image/png");
        var anchor = document.createElement('a');
        anchor.setAttribute("href", base64image);
        anchor.setAttribute("download", "my-image.png");
        anchor.click();
        anchor.remove();
    });
};