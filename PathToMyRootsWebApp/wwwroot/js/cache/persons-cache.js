const personsCache = new Map();

async function getPersonJson(personId) {
    if (personId == null || personId == -1) {
        return null;
    }

    if (personsCache.has(personId)) {
        return personsCache.get(personId);
    }

    const person = await (await fetch(`${apiUrl}/person/${personId}`)).json();
    personsCache.set(person.id, person);

    return person;
}