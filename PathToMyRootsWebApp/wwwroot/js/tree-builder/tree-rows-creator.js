async function createRowsFrom(personId, processedPersonIds, levelIndexesToRowsMap, level) {
    if (personId == null || processedPersonIds.has(personId))
        return;

    const person = await (await fetch(`${apiUrl}${personId}`)).json();
    const nodesGroupContainer = createNodesGroupContainer();
    const nodesGroup = createNodesGroup();

    if (person.isMale) {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            nodesGroup.append(createNode(person));
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
            const firstSpouse = await (await fetch(`${apiUrl}${person.firstSpouseId}`)).json();
            const secondSpouse = await (await fetch(`${apiUrl}${person.secondSpouseId}`)).json();

            nodesGroupContainer.appendChild(createNodeMarriage(person, firstSpouse, false));
            nodesGroupContainer.style.paddingLeft = "0px";
            nodesGroupContainer.style.marginLeft = "0px";
            nodesGroup.append(createNode(person));
            nodesGroup.append(createNode(secondSpouse));
            nodesGroup.append(createLineBreak());
            nodesGroup.append(createNodeMarriage(person, secondSpouse, true));

            processedPersonIds.add(person.secondSpouseId);
        }
        else { // single married
            const spouseId = person.firstSpouseId ?? person.secondSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) {
                if (spouse.secondSpouseId == personId) {
                    nodesGroup.append(createNode(person));
                    nodesGroup.append(createNode(spouse));
                    nodesGroup.append(createLineBreak());
                    nodesGroup.append(createNodeMarriage(person, spouse, true));

                    nodesGroupContainer.style.paddingRight = "0px";
                    nodesGroupContainer.style.marginRight = "0px";

                    processedPersonIds.add(spouseId);
                }
                else {
                    nodesGroupContainer.appendChild(createNodeMarriage(person, spouse, false));
                    nodesGroupContainer.style.paddingLeft = "0px";
                    nodesGroupContainer.style.marginLeft = "0px";
                    nodesGroup.append(createNode(person));
                }
            }
            else {
                nodesGroup.append(createNode(person));
                nodesGroup.append(createNode(spouse));
                nodesGroup.append(createLineBreak());
                nodesGroup.append(createNodeMarriage(person, spouse, true));

                processedPersonIds.add(spouseId);
            }
        }
    }
    else {
        if (person.firstSpouseId == null && person.secondSpouseId == null) { // single
            nodesGroup.append(createNode(person));
        }
        else if (person.firstSpouseId != null && person.secondSpouseId != null) { // double married
        }
        else { // single married
            const spouseId = person.firstSpouseId ?? person.secondSpouseId;
            const spouse = await (await fetch(`${apiUrl}${spouseId}`)).json();

            if (spouse.firstSpouseId != null && spouse.secondSpouseId != null) { // double married man
                nodesGroup.append(createNode(person));
                nodesGroupContainer.style.paddingRight = "0px";
                nodesGroupContainer.style.marginRight = "0px";
            }
            else { // single married man
                nodesGroup.append(createNode(spouse));
                nodesGroup.append(createNode(person));
                nodesGroup.append(createLineBreak());
                nodesGroup.append(createNodeMarriage(person, spouse, true));

                processedPersonIds.add(spouseId);
            }
        }
    }

    // if not double married female
    if (nodesGroup.children().length > 0) {
        nodesGroupContainer.append(nodesGroup);

        if (!levelIndexesToRowsMap.has(level))
            levelIndexesToRowsMap.set(level, createRow());

        levelIndexesToRowsMap.get(level).append(nodesGroupContainer);
    }

    processedPersonIds.add(personId);

    await createRowsFrom(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    await createRowsFrom(person.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);

    if (person.firstSpouse != null) {
        await createRowsFrom(person.firstSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createRowsFrom(person.firstSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createRowsFrom(person.firstSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.secondSpouse != null) {
        await createRowsFrom(person.secondSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createRowsFrom(person.secondSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createRowsFrom(person.secondSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createRowsFrom(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);
}