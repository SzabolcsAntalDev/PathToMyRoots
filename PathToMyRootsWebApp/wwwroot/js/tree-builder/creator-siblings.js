// creates the individual siblings
// one sibling can be as complex as
// female - male female - male female - male
function createSiblings(generations) {
    generations.forEach(generation => {
        let siblings = [];
        let currentSibling = [];

        generation.extendedMarriages.forEach(extendedMarriage => {
            if (currentSibling.length == 0) {
                currentSibling.push(extendedMarriage);
                siblings.push(currentSibling);
                return;
            }

            const previousExtendedMarriage = currentSibling[currentSibling.length - 1];
            const femaleIdFromPreviousMarriage = previousExtendedMarriage.mainMarriage?.female?.id;
            const femaleIdFromCurrentMarriage = extendedMarriage.secondaryMarriage?.femaleId;

            if (femaleIdFromPreviousMarriage && femaleIdFromCurrentMarriage && femaleIdFromPreviousMarriage == femaleIdFromCurrentMarriage) {
                currentSibling.push(extendedMarriage);
            } else {
                currentSibling = [extendedMarriage];
                siblings.push(currentSibling);
            }
        });

        generation.siblings = siblings;
    });
}