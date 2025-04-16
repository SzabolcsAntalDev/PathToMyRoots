async function createLevelsToRows(personId) {
    const levelsToRows = new Map();
    await createLevelsToRowsRecursive(personId, new Set([null]), levelsToRows, 0);
    return levelsToRows;
}

async function createLevelsToRowsRecursive(personId, processedPersonIds, levelIndexesToRowsMap, level) {
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

            nodesGroupContainer.append(createNodeMarriage(person, firstSpouse, false));
            //// Szabi: add this back
            //nodesGroupContainer.style.paddingLeft = "0px";
            //nodesGroupContainer.style.marginLeft = "0px";
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

                    //// Szabi: add this back
                    //nodesGroupContainer.style.paddingRight = "0px";
                    //nodesGroupContainer.style.marginRight = "0px";

                    processedPersonIds.add(spouseId);
                }
                else {
                    nodesGroupContainer.append(createNodeMarriage(person, spouse, false));

                    //// Szabi: add this back
                    //nodesGroupContainer.style.paddingLeft = "0px";
                    //nodesGroupContainer.style.marginLeft = "0px";
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
                //// Szabi: add this back
                //nodesGroupContainer.style.paddingRight = "0px";
                //nodesGroupContainer.style.marginRight = "0px";
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

    setLoadingProgressText(`Number of persons found:<br>${processedPersonIds.size}`);

    await createLevelsToRowsRecursive(person.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    await createLevelsToRowsRecursive(person.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);

    if (person.firstSpouse != null) {
        await createLevelsToRowsRecursive(person.firstSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createLevelsToRowsRecursive(person.firstSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createLevelsToRowsRecursive(person.firstSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.secondSpouse != null) {
        await createLevelsToRowsRecursive(person.secondSpouse.id, processedPersonIds, levelIndexesToRowsMap, level);
        await createLevelsToRowsRecursive(person.secondSpouse.biologicalFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
        await createLevelsToRowsRecursive(person.secondSpouse.adoptiveFatherId, processedPersonIds, levelIndexesToRowsMap, level + 1);
    }

    if (person.inverseBiologicalMother != null)
        for (let child of person.inverseBiologicalMother)
            await createLevelsToRowsRecursive(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseBiologicalFather != null)
        for (let child of person.inverseBiologicalFather)
            await createLevelsToRowsRecursive(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveMother != null)
        for (let child of person.inverseAdoptiveMother)
            await createLevelsToRowsRecursive(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);

    if (person.inverseAdoptiveFather != null)
        for (let child of person.inverseAdoptiveFather)
            await createLevelsToRowsRecursive(child.id, processedPersonIds, levelIndexesToRowsMap, level - 1);
}