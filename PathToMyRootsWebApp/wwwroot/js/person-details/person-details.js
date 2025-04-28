async function createPersonDetails(personId) {
    const treeDiagramsContainer = $('#tree-diagrams-container');
    createAndDisplayTreeDiagram(treeDiagramsContainer, personId);

    const person = await (await fetch(`${apiUrl}/person/${personId}`)).json();
    const infoColumn = $('.info-column');
    const relativesColumn = $('.relatives-column');

    infoColumn
        .append(createPersonDetailsImage(person))
        .append(createPersonDetailsNameSpan(person))
        .append(createPersonDetailsLivedSpan(person));

    if (person.firstSpouseId) {
        const spousesContainer =
            createPersonDetailsRelativesContainer()
                .append(createPersonDetailsRelativesContainerTitle('Spouses'));

        const spouses = createRelatives();
        spouses.append(
            createPersonDetailsSpouse(
                person.firstSpouse,
                person.firstMarriageStartDate,
                person.firstMarriageEndDate));

        if (person.secondSpouseId) {
            spouses.append(
                createPersonDetailsSpouse(
                    person.secondSpouse,
                    person.secondMarriageStartDate,
                    person.secondMarriageEndDate));
        }

        spousesContainer.append(spouses);
        relativesColumn.append(spousesContainer);
    }

    const childrenObjects = (person.inverseBiologicalFather ?? [])
        .concat(person.inverseBiologicalMother ?? [])
        .concat(person.inverseAdoptiveFather ?? [])
        .concat(person.inverseAdoptiveMother ?? [])

    if (childrenObjects) {
        const childrenContainer =
            createPersonDetailsRelativesContainer()
                .append(createPersonDetailsRelativesContainerTitle('Children'))

        const children = createRelatives();
        childrenObjects.forEach(child => {
            children.append(createPersonDetailsChild(child));
        })

        childrenContainer.append(children);
        relativesColumn.append(childrenContainer);
    }
}