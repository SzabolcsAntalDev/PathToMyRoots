function createExtendedMarriagesChains(generations) {
    generations.forEach(generation => {
        let extendedMarriagesChains = [];
        let currentExtendedMarriages = [];

        generation.extendedMarriages.forEach(extendedMarriage => {
            if (currentExtendedMarriages.length == 0) {
                currentExtendedMarriages.push(extendedMarriage);
                extendedMarriagesChains.push(currentExtendedMarriages);
                return;
            }

            const previousExtendedMarriage = currentExtendedMarriages[currentExtendedMarriages.length - 1];
            const femaleIdFromPreviousMarriage = previousExtendedMarriage.mainMarriage?.female?.id;
            const femaleIdFromCurrentMarriage = extendedMarriage.secondaryMarriage?.femaleId;

            if (femaleIdFromPreviousMarriage && femaleIdFromCurrentMarriage && femaleIdFromPreviousMarriage === femaleIdFromCurrentMarriage) {
                currentExtendedMarriages.push(extendedMarriage);
            } else {
                currentExtendedMarriages = [extendedMarriage];
                extendedMarriagesChains.push(currentExtendedMarriages);
            }
        });

        generation.extendedMarriagesChains = extendedMarriagesChains;
    });
}