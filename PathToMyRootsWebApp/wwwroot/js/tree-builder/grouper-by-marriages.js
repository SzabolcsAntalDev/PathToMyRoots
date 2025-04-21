function groupByMarriages(generations) {
    generations.forEach(generation => {
        const marriages = generation.extendedMarriages;

        // Map female.id → extendedMarriage
        const idToMarriage = new Map();
        marriages.forEach(marriage => {
            const id = marriage.mainMarriage?.female?.id;
            if (id) idToMarriage.set(id, marriage);
        });

        // Build graph: edges are [dependentMarriage, baseMarriage]
        const graph = new Map(); // marriage → Set of dependencies
        marriages.forEach(marriage => {
            graph.set(marriage, new Set());
        });

        marriages.forEach(marriage => {
            const secondaryId = marriage.secondaryMarriage?.femaleId;
            if (secondaryId) {
                const dependency = idToMarriage.get(secondaryId);
                if (dependency && dependency !== marriage) {
                    graph.get(marriage).add(dependency);
                }
            }
        });

        // Topological sort
        const sorted = [];
        const visited = new Set();
        const temp = new Set();

        function visit(marriage) {
            if (visited.has(marriage)) return;
            if (temp.has(marriage)) {
                throw new Error("Cycle detected in marriages");
            }

            temp.add(marriage);
            for (const dep of graph.get(marriage)) {
                visit(dep);
            }
            temp.delete(marriage);
            visited.add(marriage);
            sorted.push(marriage);
        }

        marriages.forEach(visit);

        // Replace with sorted
        generation.extendedMarriages = sorted; // reverse because we push after visiting dependencies
    });
}
