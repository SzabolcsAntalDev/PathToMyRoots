// Szabi: maybe these are not needed with the new tooltips
function addAndTrackClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;
    element.dataset[className] = count + 1;

    element.classList.add(className);
}

function removeAndTrackClass(element, className) {
    let count = element.dataset[className] ? parseInt(element.dataset[className]) : 0;

    if (count > 1) {
        element.dataset[className] = count - 1;
    } else {
        element.classList.remove(className);
        delete element.dataset[className];
    }
}

function setSize(fromElement, toElement, offset) {
    const fromElementSize = getSize(fromElement);

    toElement.css({
        width: fromElementSize.width + offset,
        height: fromElementSize.height + offset
    });
}

function getSize(element) {
    const domElement = $(element).get(0);

    const elementStyle = window.getComputedStyle(domElement);
    const elementWidth = domElement.offsetWidth || parseFloat(elementStyle.width);
    const elementHeight = domElement.offsetHeight || parseFloat(elementStyle.height);

    return { width: elementWidth, height: elementHeight };
}

function arrayRemoveDuplicatesWithSameId(array) {
    return Array.from(new Map(array.map(obj => [obj.id, obj])).values());
}