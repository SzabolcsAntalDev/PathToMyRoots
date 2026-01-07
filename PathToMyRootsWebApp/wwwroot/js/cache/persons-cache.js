const personsCache = {
    personsCache: new Map(),

    async getPersonJson(personId) {
        if (personId == null || personId == -1) {
            return null;
        }

        if (this.personsCache.has(personId)) {
            return this.personsCache.get(personId);
        }

        const person = await (await fetch(`${apiUrl}/person/${personId}`)).json();
        this.personsCache.set(person.id, person);

        return person;
    },

    clearPersonsWithClientSideData() {
        const personsToClear = [];

        for (const [personId, person] of this.personsCache.entries()) {

            // Szabi now: will have to check this soon
            const hasClientSideData =
                person.inverseBiologicalFather?.some(childId => childId < 0) ||
                person.inverseBiologicalMother?.some(childId => childId < 0) ||
                person.firstSpouseId < 0;

            if (hasClientSideData) {
                personsToClear.push(personId);
            }
        }

        for (const personId of personsToClear) {
            this.personsCache.delete(personId);
        }
    }
}