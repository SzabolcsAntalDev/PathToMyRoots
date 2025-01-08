// JavaScript code for Family Tree

const familyData = JSON.parse(document.getElementById('familyData').textContent);

function createTree(data) {
    const container = document.getElementById('tree-container');
    const positions = {};

    data.forEach(member => {
        const node = document.createElement('div');
        node.className = 'node';
        node.innerText = member.FirstName;
        node.id = `node-${member.Id}`;
        container.appendChild(node);

        const level = 2;
        // getLevel(data, member.Id);
        node.style.top = `${level * 100}px`;
        node.style.left = `${(member.Id - 10) * 120}px`;
        positions[member.Id] = node;
    });

    data.forEach(member => {
        if (member.BiologicalMotherId) {
            const parent = positions[member.BiologicalMotherId];
            const child = positions[member.Id];
            drawLine(container, parent, child);
        }
    });
}

function drawLine(container, parent, child) {
    const parentRect = parent.getBoundingClientRect();
    const childRect = child.getBoundingClientRect();

    const line = document.createElement('div');
    line.className = 'line';

    const x1 = parentRect.left + parentRect.width / 2;
    const y1 = parentRect.top + parentRect.height;
    const x2 = childRect.left + childRect.width / 2;
    const y2 = childRect.top;

    line.style.left = `${x1}px`;
    line.style.top = `${y1}px`;
    line.style.width = `${Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2))}px`;
    line.style.transform = `rotate(${Math.atan2(y2 - y1, x2 - x1) * 180 / Math.PI}deg)`;
    container.appendChild(line);
}

createTree(familyData);