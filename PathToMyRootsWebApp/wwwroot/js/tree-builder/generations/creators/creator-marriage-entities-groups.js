// generated with chat gpt
// creates groups that contain the marriage entities that share the same spouses

function createMarriageEntitiesGroups(generations) {
    generations.forEach(generation => {
        generation.marriageEntitiesGroups = createMarriageEntitiesGroupsInner(generation.marriageEntities);
    });
}

function createMarriageEntitiesGroupsInner(marriageEntities) {
    const marriagesEntitiesByPersonId = createMarriageEntitiesByPersonIdMap(marriageEntities);
    const visitedMarriageEntities = new Set();
    const marriageEntitiesGroups = [];

    for (const marriageEntity of marriageEntities) {
        if (visitedMarriageEntities.has(marriageEntity)) {
            continue;
        }

        const marriageEntitiesGroup = createMarriageEntitiesGroup(
            marriageEntity,
            marriagesEntitiesByPersonId,
            visitedMarriageEntities
        );

        marriageEntitiesGroups.push(marriageEntitiesGroup);
    }

    return marriageEntitiesGroups;
}

function createMarriageEntitiesByPersonIdMap(marriageEntities) {
    const marriageEntitiesByPersonId = new Map();

    for (const marriageEntity of marriageEntities) {
        addMarriageEntityToMap(marriageEntitiesByPersonId, marriageEntity.male?.id, marriageEntity);
        addMarriageEntityToMap(marriageEntitiesByPersonId, marriageEntity.female?.id, marriageEntity);
    }

    return marriageEntitiesByPersonId;
}

function addMarriageEntityToMap(marriageEntitiesByPersonId, personId, marriageEntity) {
    if (!personId) {
        return;
    }

    if (!marriageEntitiesByPersonId.has(personId)) {
        marriageEntitiesByPersonId.set(personId, []);
    }

    marriageEntitiesByPersonId.get(personId).push(marriageEntity);
}

function createMarriageEntitiesGroup(marriageEntity, marriagesEntitiesByPersonId, visitedMarriageEntities) {
    const marriageEntitiesGroup = [];
    const marriageEntitiesStack = [marriageEntity];

    while (marriageEntitiesStack.length > 0) {
        const currentMarriageEntity = marriageEntitiesStack.pop();

        if (visitedMarriageEntities.has(currentMarriageEntity)) {
            continue;
        }

        visitedMarriageEntities.add(currentMarriageEntity);
        marriageEntitiesGroup.push(currentMarriageEntity);

        const spouseIds = [
            currentMarriageEntity.male?.id,
            currentMarriageEntity.female?.id
        ];

        for (const spouseId of spouseIds) {
            if (!spouseId) {
                continue;
            }

            const relatedMarriageEntities = marriagesEntitiesByPersonId.get(spouseId) || [];

            for (const relatedMarriageEntity of relatedMarriageEntities) {
                if (!visitedMarriageEntities.has(relatedMarriageEntity)) {
                    marriageEntitiesStack.push(relatedMarriageEntity);
                }
            }
        }
    }

    return marriageEntitiesGroup;
}