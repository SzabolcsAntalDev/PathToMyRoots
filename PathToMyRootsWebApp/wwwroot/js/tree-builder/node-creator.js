function createRow() {
    const row = document.createElement('div');
    row.className = 'tree-level-row';
    return row;
}

function createNodesGroupContainer() {
    const nodesGroupContainer = document.createElement('div');
    nodesGroupContainer.className = 'tree-nodes-group-container';
    return nodesGroupContainer;
}

function createNodesGroup() {
    const nodesGroup = document.createElement('div');
    nodesGroup.className = 'tree-nodes-group';
    return nodesGroup;
}

function createNode(person) {
    const node = document.createElement('div');
    node.id = person.id;
    node.birthDate = person.birthDate;
    node.biologicalMotherId = person.biologicalMotherId;
    node.biologicalFatherId = person.biologicalFatherId;
    node.adoptiveMotherId = person.adoptiveMotherId;
    node.adoptiveFatherId = person.adoptiveFatherId;
    node.firstSpouseId = person.firstSpouseId;
    node.secondSpouseId = person.secondSpouseId;

    node.className = person.isMale ? 'tree-node-male' : 'tree-node-female';

    const imgPerson = document.createElement('img');
    imgPerson.src = 'https://localhost:7241/api/Image/get/' + person.imageUrl;
    imgPerson.className = 'tree-node-image';

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanPersonName = document.createElement('span');
    const personNameNodeText = personToPersonNameNodeText(person);
    spanPersonName.innerText = personNameNodeText;
    spanPersonName.className = 'tree-node-main-name-text';

    const spanPersonLived = document.createElement('span');
    const personLivedNodeText = datesToPeriodText(person.birthDate, person.deathDate);
    spanPersonLived.innerText = personLivedNodeText;
    spanPersonLived.className = 'tree-node-main-lived-text';

    textsContainer.appendChild(spanPersonName);
    textsContainer.appendChild(spanPersonLived);

    const svgElement = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svgElement.setAttribute('class', 'small-svg');
    svgElement.setAttribute('width', '20');
    svgElement.setAttribute('height', '20');

    const useElement = document.createElementNS('http://www.w3.org/2000/svg', 'use');
    useElement.setAttribute('href', '/icons/icons.svg#update');
    svgElement.appendChild(useElement);

    const buttonUpdatePerson = document.createElement('button');
    buttonUpdatePerson.appendChild(svgElement);
    buttonUpdatePerson.className = "tree-action-button";
    buttonUpdatePerson.style.visibility = 'hidden';

    buttonUpdatePerson.addEventListener('click', function () {
        const personId = person.id;
        const url = `/Person/UpdatePerson?id=${personId}`;
        window.location.href = url;
    });

    node.appendChild(imgPerson);
    node.appendChild(textsContainer);
    node.appendChild(buttonUpdatePerson);
    node.title = `${personNameNodeText}\n${personLivedNodeText}`

    node.addEventListener("mouseenter", () => {
        buttonUpdatePerson.style.visibility = 'visible';
    });

    node.addEventListener("mouseleave", () => {
        buttonUpdatePerson.style.visibility = 'hidden';
    });

    return node;
}

function createLineBreak() {
    return document.createElement('br');
}

function createNodeMarriage(person, spouse, isMainMarriage) {
    const startDate = person.firstSpouseId == spouse.id ? person.firstMarriageStartDate : person.secondMarriageStartDate;
    const endDate = person.firstSpouseId == spouse.id ? person.firstMarriageEndDate : person.secondMarriageEndDate;

    const node = document.createElement('div');
    node.classList.add('tree-node-marriage', isMainMarriage ? 'main-marriage' : 'left-marriage');

    const textsContainer = document.createElement('div');
    textsContainer.className = "tree-node-texts";

    const spanMarriage = document.createElement('span');
    const marriageText = 'marriage';
    spanMarriage.innerText = marriageText;
    spanMarriage.className = 'tree-node-marriage-text';

    const spanMarriageDate = document.createElement('span');
    const marriageDateText = datesToPeriodText(startDate, endDate);
    spanMarriageDate.innerText = marriageDateText;
    spanMarriageDate.className = 'tree-node-marriage-date-text';

    textsContainer.appendChild(spanMarriage);
    textsContainer.appendChild(spanMarriageDate);

    node.appendChild(textsContainer);
    node.title = `${marriageText}\n${marriageDateText}`

    node.inverseBiologicalParents = getCommonBiologicalChildren(person, spouse);
    node.inverseAdoptiveParents = getCommonAdoptiveChildren(person, spouse);
    node.maleId = person.isMale ? person.id : spouse.id;
    node.femaleId = !person.isMale ? person.id : spouse.id;

    return node;
}