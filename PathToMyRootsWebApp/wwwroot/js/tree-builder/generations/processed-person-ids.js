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
            // can be null if for instance male.firstSpouseId is null
            if (personId == null || this.containsOnSameLevel(personId)) {
                return;
            }

            if (!personIdsPerLevel.has(levelIndex)) {
                personIdsPerLevel.set(levelIndex, []);
            }

            const personIdsList = personIdsPerLevel.get(levelIndex);
            if (!personIdsList.includes(personId)) {
                personIdsList.push(personId);
            }
        },

        getDistinctPersonsSize() {
            const allPersonIds = Array.from(personIdsPerLevel.values()).flat();
            return new Set(allPersonIds).size;
        },

        getDuplicatedPersonIds() {
            const personIdsToCount = new Map();

            for (const personIds of personIdsPerLevel.values()) {
                for (const personId of personIds) {
                    personIdsToCount.set(personId, (personIdsToCount.get(personId) || 0) + 1);
                }
            }

            return new Set(
                Array.from(personIdsToCount.entries())
                    .filter(([_, count]) => count > 1)
                    .map(([id]) => id)
            );
        }
    };
}