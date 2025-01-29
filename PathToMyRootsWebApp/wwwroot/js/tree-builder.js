const linesVerticalOffset = 4;
const sleepInterval = 0;

const apiUrl = "https://localhost:7241/api/person/getfamily/";
const imageApiUrl = "https://localhost:7241/";

function getFadeIntervalInSeconds() {
    const fadeSeconds = getComputedStyle(document.documentElement).getPropertyValue('--fade-interval-in-seconds');
    const fadeDuration = parseFloat(fadeSeconds);

    return fadeDuration;
}

function createLoadingText() {
    const treesContainer = document.getElementById("trees-container");

    const loadingTextContainer = document.createElement("div");
    loadingTextContainer.id = "loading-text-container";
    loadingTextContainer.className = "loading-text-container";
    hideElement(loadingTextContainer);

    const loadingText = document.createElement("label");
    loadingText.textContent = "Loading...";

    loadingTextContainer.appendChild(loadingText);
    treesContainer.appendChild(loadingTextContainer);

    setTimeout(() => {
        fadeInElement(loadingTextContainer);
    }, getFadeIntervalInSeconds());

    return loadingTextContainer;
}

async function removeTreeDiagram(personId) {
    const loadingTextContainer = document.getElementById("loading-text-container");
    if (loadingTextContainer)
        fadeInElement(loadingTextContainer);

    const diagramAndLinesContainer = document.getElementById('tree-diagram-and-lines-container' + personId);
    if (diagramAndLinesContainer) {
        fadeOutElement(diagramAndLinesContainer)

        await new Promise(resolve => {
            setTimeout(() => {
                diagramAndLinesContainer.remove();
                resolve();
            }, getFadeIntervalInSeconds() * 1000);
        });
    }
}

async function createTreeDiagram(personId) {
    const treesContainer = document.getElementById("trees-container");

    const loadingTextContainer = document.getElementById("loading-text-container") ?? createLoadingText();
    fadeInElement(loadingTextContainer);

    const diagramAndLinesContainer = document.createElement('div');
    diagramAndLinesContainer.className = 'tree-diagram-and-lines-container';
    hideElement(diagramAndLinesContainer);
    diagramAndLinesContainer.id = 'tree-diagram-and-lines-container' + personId;

    const diagramContainer = document.createElement('div');
    diagramContainer.setAttribute('class', 'tree-diagram-container');

    const linesContainer = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    linesContainer.setAttribute('class', 'tree-lines-container');

    diagramAndLinesContainer.appendChild(diagramContainer);
    diagramAndLinesContainer.appendChild(linesContainer);

    treesContainer.appendChild(diagramAndLinesContainer);

    const processedPersonIds = new Set();
    processedPersonIds.add(null);

    let levelIndexesToRowsDictionary = {};
    let baseLevelIndex = 0;
    await createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, baseLevelIndex);

    const descSortedLevelIndexes = Object.keys(levelIndexesToRowsDictionary)
        .map(Number)
        .sort((a, b) => b - a);

    const rootLevelIndex = descSortedLevelIndexes[0]

    let parentsRow = levelIndexesToRowsDictionary[rootLevelIndex];
    diagramContainer.appendChild(parentsRow);
    await sleep(sleepInterval);

    // sort children
    for (let i = 1; i < descSortedLevelIndexes.length; i++) {
        const childrenLevelIndex = descSortedLevelIndexes[i];
        const childrenRow = levelIndexesToRowsDictionary[childrenLevelIndex];

        let sortedChildrenRow = createRow();
        diagramContainer.appendChild(sortedChildrenRow);
        parentsRow = await fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow);
    }

    // draw lines
    const treeDiagramContainerStyle = window.getComputedStyle(diagramContainer);
    const treeDiagramContainerWidth = diagramContainer.offsetWidth || parseFloat(treeDiagramContainerStyle.width);
    const treeDiagramContainerHeight = diagramContainer.offsetHeight || parseFloat(treeDiagramContainerStyle.height);

    linesContainer.style.width = `${treeDiagramContainerWidth}px`;
    linesContainer.style.height = `${treeDiagramContainerHeight}px`;

    const rows = diagramContainer.querySelectorAll(".tree-level-row");
    for (let i = 1; i < rows.length; i++) {
        const parentsRowInner = rows[i - 1];
        const childrenRowInner = rows[i];

        await drawLines(linesContainer, parentsRowInner, childrenRowInner);
    }

    scrollToMiddle(diagramAndLinesContainer, diagramContainer);

    fadeOutElement(loadingTextContainer);
    fadeInElement(diagramAndLinesContainer);
}

function scrollToMiddle(container, element) {
    const containerRect = container.getBoundingClientRect();
    const elementRect = element.getBoundingClientRect();

    const verticalOffset = elementRect.top - containerRect.top - (container.clientHeight / 2) + (element.clientHeight / 2);
    const horizontalOffset = elementRect.left - containerRect.left - (container.clientWidth / 2) + (element.clientWidth / 2);

    container.scrollTop += verticalOffset;
    container.scrollLeft += horizontalOffset;
}

async function createRowsFrom(personId, processedPersonIds, levelIndexesToRowsDictionary, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();

    const nodesGroup = createNodesGroup();

    if (person.isMale) {
        nodesGroup.appendChild(createNode(person));

        if (person.spouse != null) {
            const spouse = await (await fetch(`${apiUrl}${person.spouseId}`)).json();
            nodesGroup.appendChild(createNode(spouse));
        }
    }
    else {
        if (person.spouse != null) {
            const spouse = await (await fetch(`${apiUrl}${person.spouseId}`)).json();
            nodesGroup.appendChild(createNode(spouse));
        }
        nodesGroup.appendChild(createNode(person));
    }

    if (person.spouse != null) {
        nodesGroup.appendChild(createLineBreak());
        nodesGroup.appendChild(createNodeMarried());
    }

    if (levelIndexesToRowsDictionary[level] == null)
        levelIndexesToRowsDictionary[level] = createRow();

    levelIndexesToRowsDictionary[level].appendChild(nodesGroup);

    processedPersonIds.add(personId);
    processedPersonIds.add(person.spouseId);

    await createRowsFrom(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);
    if (person.spouse != null)
        await createRowsFrom(person.spouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsDictionary, level + 1);

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsDictionary, level - 1);
}

async function fillRowWithSortedChildren(sortedChildrenRow, parentsRow, childrenRow) {
    let parentsNodeGroups = parentsRow.querySelectorAll('.tree-nodes-group');

    for (let parentNodeGroup of parentsNodeGroups) {
        let fatherId = parentNodeGroup.querySelector('.tree-node-male')?.id;
        let motherId = parentNodeGroup.querySelector('.tree-node-female')?.id;

        let childrenNodeGroups = childrenRow.querySelectorAll('.tree-nodes-group');
        for (let childrenNodeGroup of childrenNodeGroups) {
            let malesChildBiologicalFatherId = childrenNodeGroup.querySelector('.tree-node-male')?.biologicalFatherId;
            let malesChildBiologicalMotherId = childrenNodeGroup.querySelector('.tree-node-male')?.biologicalMotherId;
            let femalesChildBiologicalFatherId = childrenNodeGroup.querySelector('.tree-node-female')?.biologicalFatherId;
            let femalesChildBiologicalMotherId = childrenNodeGroup.querySelector('.tree-node-female')?.biologicalMotherId;

            if ((fatherId != null && malesChildBiologicalFatherId != null && fatherId == malesChildBiologicalFatherId) ||
                (fatherId != null && femalesChildBiologicalFatherId != null && fatherId == femalesChildBiologicalFatherId) ||
                (motherId != null && malesChildBiologicalMotherId != null && motherId == malesChildBiologicalMotherId) ||
                (motherId != null && femalesChildBiologicalMotherId != null && motherId == femalesChildBiologicalMotherId)) {
                sortedChildrenRow.appendChild(childrenNodeGroup);
                await sleep(sleepInterval);

            }
        }
    }

    return sortedChildrenRow;
}

function createRow() {
    const row = document.createElement('div');
    row.className = 'tree-level-row';
    return row;
}

function createNodesGroup() {
    const nodesGroup = document.createElement('div');
    nodesGroup.className = 'tree-nodes-group';
    return nodesGroup;
}

function createNode(person) {
    const node = document.createElement('div');
    node.id = person.id;
    node.biologicalMotherId = person.biologicalMotherId;
    node.biologicalFatherId = person.biologicalFatherId;
    node.className = person.isMale ? 'tree-node-male' : 'tree-node-female';

    const imgPerson = document.createElement('img');
    imgPerson.src = 'https://localhost:7241/api/Image/get/' + (person.imageUrl ?? "missingImage.png");
    imgPerson.className = 'tree-node-image';

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanPersonName = document.createElement('span');
    spanPersonName.innerText = personToPersonNameNodeText(person);
    spanPersonName.className = 'tree-node-name-text';

    const spanPersonLived = document.createElement('span');
    spanPersonLived.innerText = personToPersonLivedNodeText(person);
    spanPersonLived.className = 'tree-node-lived-text';

    textsContainer.appendChild(spanPersonName);
    textsContainer.appendChild(spanPersonLived);

    const svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svgElement.setAttribute('class', 'tree-action-img');
    svgElement.setAttribute('width', '20');
    svgElement.setAttribute('height', '20');

    const useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    useElement.setAttribute('href', '/icons/icons.svg#edit');
    svgElement.appendChild(useElement);

    const buttonEditPerson = document.createElement('button');
    buttonEditPerson.appendChild(svgElement);
    buttonEditPerson.className = "action-button-on-image";
    buttonEditPerson.style.visibility = 'hidden';

    buttonEditPerson.addEventListener('click', function () {
        const personId = person.id;
        const url = `/Person/EditPerson?id=${personId}`;
        window.location.href = url;
    });

    node.appendChild(imgPerson);
    node.appendChild(textsContainer);
    node.appendChild(buttonEditPerson);

    node.addEventListener("mouseenter", () => {
        buttonEditPerson.style.visibility = 'visible';
    });

    node.addEventListener("mouseleave", () => {
        buttonEditPerson.style.visibility = 'hidden';
    });

    return node;
}

function personToPersonNameNodeText(person) {
    let details = [];

    if (person.nobleTitle)
        details.push(person.nobleTitle);

    if (person.lastName)
        details.push(person.lastName);

    if (person.maidenName)
        details.push(`(${person.maidenName})`);

    if (person.firstName)
        details.push(person.firstName);

    if (person.otherNames)
        details.push(person.otherNames);

    return details.filter(Boolean).join(' ');
}

function personToPersonLivedNodeText(person) {
    return `(${dateToString(person.birthDate)} - ${dateToString(person.deathDate)})`;
}

function dateToString(date) {
    if (date == null)
        return "";

    if (date === UnknownServerDate)
        return HumanReadableDateUnknownDate;

    return formatDateString(date);
}

function createLineBreak() {
    const lineBreak = document.createElement('br');
    return lineBreak;
}

function createNodeMarried() {
    const nodeMarried = document.createElement('div');
    nodeMarried.className = 'tree-node-married';
    nodeMarried.innerText = 'married';
    return nodeMarried;
}

async function drawLines(linesContainer, parentsRow, childrenRow) {
    let parentsNodesGroups = parentsRow.querySelectorAll('.tree-nodes-group');

    let i = -5 * linesVerticalOffset;

    for (let parentsNodeGroup of parentsNodesGroups) {
        let fatherId = parentsNodeGroup.querySelector('.tree-node-male')?.id;
        let motherId = parentsNodeGroup.querySelector('.tree-node-female')?.id;

        let childrenNodesGroups = childrenRow.querySelectorAll('.tree-nodes-group');

        for (let childrenNodesGroup of childrenNodesGroups) {
            let childMaleNode = childrenNodesGroup.querySelector('.tree-node-male');
            let childFemaleNode = childrenNodesGroup.querySelector('.tree-node-female');

            let malesBiologicalFatherId = childMaleNode?.biologicalFatherId;
            let malesBiologicalMotherId = childMaleNode?.biologicalMotherId;
            let femalesBiologicalFatherId = childFemaleNode?.biologicalFatherId;
            let femalesBiologicalMotherId = childFemaleNode?.biologicalMotherId;

            if (childMaleNode != null && (fatherId == malesBiologicalFatherId || motherId == malesBiologicalMotherId)) {
                drawLine(linesContainer, parentsNodeGroup, childMaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }

            if (childFemaleNode != null && (fatherId == femalesBiologicalFatherId || motherId == femalesBiologicalMotherId)) {
                drawLine(linesContainer, parentsNodeGroup, childFemaleNode, i += linesVerticalOffset);
                await sleep(sleepInterval);
            }
        }
    }
}

function drawLine(linesContainer, parent, child, verticalOffset) {
    const parentRect = parent.getBoundingClientRect();
    const childRect = child.getBoundingClientRect();

    const linesContainerClientRect = linesContainer.getBoundingClientRect();

    const parentX = parentRect.left + parentRect.width / 2 - linesContainerClientRect.left;
    const parentY = parentRect.top + parentRect.height - linesContainerClientRect.top;
    const childX = childRect.left + childRect.width / 2 - linesContainerClientRect.left;
    const childY = childRect.top - linesContainerClientRect.top;

    const middleY = ((parentY + childY) / 2) + verticalOffset;

    const pathData = `
        M ${parentX},${parentY}
        L ${parentX},${middleY}
        L ${childX},${middleY}
        L ${childX},${childY}
    `;

    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', pathData);
    path.setAttribute('class', 'tree-line-svg');

    linesContainer.appendChild(path);
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function hideElement(element) {
    element.classList.add('fade-hidden');
}

function fadeInElement(element) {
    element.classList.remove('fade-hidden');
    element.classList.remove('fade-out');
    element.classList.add('fade-in');
}

function fadeOutElement(element) {
    element.classList.remove('fade-in');
    element.classList.add('fade-out');
}