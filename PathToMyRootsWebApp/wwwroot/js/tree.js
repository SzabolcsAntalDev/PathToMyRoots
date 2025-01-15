function exportToPNG() {
    const container = document.getElementById('tree-diagram-container-div');
    const originalOverflow = container.style.overflow;
    container.style.overflow = 'visible';

    const fullWidth = container.scrollWidth;
    const fullHeight = container.scrollHeight;

    html2canvas(container, {
        useCORS: true,
        allowTaint: false,
        scale: 2,
        width: fullWidth,
        height: fullHeight,
        scrollX: 0,
        scrollY: 0,
    }).then(canvas => {
        const base64image = canvas.toDataURL("image/png");

        const anchor = document.createElement('a');
        anchor.setAttribute("href", base64image);
        anchor.setAttribute("download", "tree-diagram.png");
        document.body.appendChild(anchor);
        anchor.click();
        document.body.removeChild(anchor);
    }).catch(error => {
        console.error("Error exporting to PNG:", error);
    }).finally(() => {
        container.style.overflow = originalOverflow;
    });
}