// creates the spouse groups
// one spouse group can be as complex as
// female - male female - male female - male
function createSpousesGroups(generations) {
    generations.forEach(generation => {
        let spousesGroups = [];
        let currentSpousesGroup = [];

        generation.extendedMarriages.forEach(extendedMarriage => {
            if (currentSpousesGroup.length == 0) {
                currentSpousesGroup.push(extendedMarriage);
                spousesGroups.push(currentSpousesGroup);
                return;
            }

            const previousExtendedMarriage = currentSpousesGroup[currentSpousesGroup.length - 1];
            const femaleIdFromPreviousMarriage = previousExtendedMarriage.mainMarriage?.female?.id;
            const femaleIdFromCurrentMarriage = extendedMarriage.secondaryMarriage?.femaleId;

            if (femaleIdFromPreviousMarriage && femaleIdFromCurrentMarriage && femaleIdFromPreviousMarriage == femaleIdFromCurrentMarriage) {
                currentSpousesGroup.push(extendedMarriage);
            }
            else {
                currentSpousesGroup = [extendedMarriage];
                spousesGroups.push(currentSpousesGroup);
            }
        });

        generation.spousesGroups = spousesGroups;
    });
}