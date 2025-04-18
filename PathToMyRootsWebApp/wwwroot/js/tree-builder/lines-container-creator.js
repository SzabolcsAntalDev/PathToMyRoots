function createLinesContainer(generationsData, size) {

    const linesContainer = createLinesContainerHtml(size);

    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = $(rows[i - 1]);
        const childrenRowInner = $(rows[i]);

        await drawLines(linesContainer, parentsRowInner, childrenRowInner, maxNumberOfChildrenWithParentsOnRows);
    }

    return linesContainer;
}