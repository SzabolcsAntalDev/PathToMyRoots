function createProcessedPersonIds() {
    const personIdsPerLevel = new Map();

    return {
        containsOnSameLevel(levelIndex, personId) {
            const personIdsList = personIdsPerLevel.get(levelIndex);
            return personIdsList ? personIdsList.includes(personId) : false;
        },

        containsOnAnyOtherLevel(personId) {
            for (const personIdsList of personIdsPerLevel.values()) {
                if (personIdsList.includes(personId)) {
                    return true;
                }
            }
            return false;
        },

        add(levelIndex, personId) {
            if (!personIdsPerLevel.has(levelIndex)) {
                personIdsPerLevel.set(levelIndex, []);
            }
            const personIdsList = personIdsPerLevel.get(levelIndex);
            if (!personIdsList.includes(personId)) {
                personIdsList.push(personId);
            }
        },

        getSize() {
            return Array.from(personIdsPerLevel.values())
                .reduce((sum, personIds) => sum + personIds.length, 0);
        }
    };
}