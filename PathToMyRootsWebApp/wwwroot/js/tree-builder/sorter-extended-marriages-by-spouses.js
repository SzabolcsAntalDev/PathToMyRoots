// sorts the extended marriages so each first and second spouse follows each other
function sortExtendedMarriagesBySpouses(generations) {
    generations.forEach(generation => {
        const femaleIdToExtendedMarriage = new Map();
        generation.extendedMarriages.forEach(extendedMarriage => {
            const femaleId = extendedMarriage.mainMarriage?.female?.id;
            if (femaleId) {
                femaleIdToExtendedMarriage.set(femaleId, extendedMarriage);
            }
        });

        const secondaryToMainExtendedMarriageOfFemale = new Map();
        generation.extendedMarriages.forEach(marriage => {
            secondaryToMainExtendedMarriageOfFemale.set(marriage, new Set());
        });

        generation.extendedMarriages.forEach(secondaryExtendedMarriageOfFemale => {
            const femaleIdFromSecondaryMarriage = secondaryExtendedMarriageOfFemale.secondaryMarriage?.femaleId;
            if (femaleIdFromSecondaryMarriage) {
                const mainExtendedMarriageOfFemale = femaleIdToExtendedMarriage.get(femaleIdFromSecondaryMarriage);
                if (mainExtendedMarriageOfFemale && mainExtendedMarriageOfFemale !== secondaryExtendedMarriageOfFemale) {
                    secondaryToMainExtendedMarriageOfFemale
                        .get(secondaryExtendedMarriageOfFemale)
                        .add(mainExtendedMarriageOfFemale);
                }
            }
        });

        const sortedExtendedMarriages = [];
        const visitedExtendedMarriages = new Set();
        const tempExtendedMarriages = new Set();

        generation.extendedMarriages.forEach(extendedMarriage =>
            visitExtendedMarriage(
                extendedMarriage,
                secondaryToMainExtendedMarriageOfFemale,
                visitedExtendedMarriages,
                tempExtendedMarriages,
                sortedExtendedMarriages));

        generation.extendedMarriages = sortedExtendedMarriages;
    });
}

function visitExtendedMarriage(
    extendedMarriage,
    secondaryToMainExtendedMarriageOfFemale,
    visitedExtendedMarriages,
    tempExtendedMarriages,
    sortedExtendedMarriages) {
    if (visitedExtendedMarriages.has(extendedMarriage)) {
        return;
    }

    if (tempExtendedMarriages.has(extendedMarriage)) {
        throw new Error("Cycle detected in marriages");
    }

    tempExtendedMarriages.add(extendedMarriage);
    for (const mainExtendedMarriage of secondaryToMainExtendedMarriageOfFemale.get(extendedMarriage)) {
        visitExtendedMarriage(
            mainExtendedMarriage,
            secondaryToMainExtendedMarriageOfFemale,
            visitedExtendedMarriages,
            tempExtendedMarriages,
            sortedExtendedMarriages
        );
    }
    tempExtendedMarriages.delete(extendedMarriage);
    visitedExtendedMarriages.add(extendedMarriage);
    sortedExtendedMarriages.push(extendedMarriage);
}
