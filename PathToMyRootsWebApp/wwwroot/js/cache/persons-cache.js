const personsCache = {
    personsCache: new Map(),

    async getPersonJson(personId) {
        if (personId == null) {
            return null;
        }

        if (this.personsCache.has(personId)) {
            return this.personsCache.get(personId);
        }

        const response = await fetch(`${apiUrl}/person/${personId}`);

        if (!response.ok) {
            return { isPlaceholder: true };
        }

        const person = await response.json();

        this.personsCache.set(person.id, person);

        return person;
    },

    removePersonsWithClientSideData() {
        const personsToClear = [];

        for (const [personId, person] of this.personsCache.entries()) {

            const hasClientSideData =
                person.inverseBiologicalFather?.some(child => child.id < 0) ||
                person.inverseBiologicalMother?.some(child => child.id < 0) ||
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