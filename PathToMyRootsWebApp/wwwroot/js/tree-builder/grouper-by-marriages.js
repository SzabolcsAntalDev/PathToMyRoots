function groupByMarriages(generations) {
    generations.forEach(generation => {
        let groups = [];
        let currentGroup = [];

        generation.extendedMarriagesSortedByMarriages.forEach(extendedMarriage => {
            if (currentGroup.length === 0) {
                currentGroup.push(extendedMarriage);
                groups.push(currentGroup);
                return;
            }

            const previous = currentGroup[currentGroup.length - 1];
            const prevFemaleId = previous.mainMarriage?.female?.id;
            const currSecondaryId = extendedMarriage.secondaryMarriage?.femaleId;

            if (prevFemaleId && currSecondaryId && prevFemaleId === currSecondaryId) {
                currentGroup.push(extendedMarriage);
            } else {
                currentGroup = [extendedMarriage];
                groups.push(currentGroup);
            }
        });

        generation.extendedMarriageGroupsByMarriages = groups;
    });
}