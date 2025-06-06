// generated with chat gpt
// is sorts the extended marriages, so if there are two extended marriages:
// 1. an extended marriage that has a main marriage referencing a female
// 2. an extended marriage that has secondary marriage referencing the female from the first one
// the 1. extended marriage will come before the 2., and no other extended marriage will be placed between them

function sortExtendedMarriagesBySpouses(generations) {
    generations.forEach(generation => {
        const femaleIdToExtendedMarriage = new Map();
        const marriageToNext = new Map(); // A → B
        const marriageToPrev = new Map(); // B → A

        // Step 1: Map female IDs to their main extended marriage
        generation.extendedMarriages.forEach(extendedMarriage => {
            const femaleId = extendedMarriage.mainMarriage?.female?.id;
            if (femaleId) {
                femaleIdToExtendedMarriage.set(femaleId, extendedMarriage);
            }
        });

        // Step 2: Identify dependencies (A → B)
        generation.extendedMarriages.forEach(extendedMarriage => {
            const secondary = extendedMarriage.secondaryMarriage;
            const maleId = extendedMarriage.mainMarriage?.male?.id;
            const hasOnlyMale = !!maleId && !extendedMarriage.mainMarriage?.female;

            if (secondary?.femaleId) {
                const femaleSourceExtendedMarriage = femaleIdToExtendedMarriage.get(secondary.femaleId);

                if (femaleSourceExtendedMarriage && femaleSourceExtendedMarriage !== extendedMarriage) {
                    // Even if only male is present in mainMarriage, treat as dependency
                    marriageToNext.set(femaleSourceExtendedMarriage, extendedMarriage);
                    marriageToPrev.set(extendedMarriage, femaleSourceExtendedMarriage);
                }
            }
        });

        // Step 3: Build chains of directly dependent extended marriages
        const chains = [];
        const visited = new Set();

        for (const extendedMarriage of generation.extendedMarriages) {
            if (visited.has(extendedMarriage)) {
                continue;
            }

            // Walk backward to the root of the chain
            let currentExtendedMarriage = extendedMarriage;
            while (marriageToPrev.has(currentExtendedMarriage)) {
                currentExtendedMarriage = marriageToPrev.get(currentExtendedMarriage);
            }

            // Walk forward through the chain
            const chain = [];
            while (currentExtendedMarriage && !visited.has(currentExtendedMarriage)) {
                chain.push(currentExtendedMarriage);
                visited.add(currentExtendedMarriage);
                currentExtendedMarriage = marriageToNext.get(currentExtendedMarriage);
            }

            chains.push(chain);
        }

        // Step 4: Topologically sort chains
        const chainDeps = new Map();
        const chainMap = new Map();

        chains.forEach(chain => {
            chainDeps.set(chain, new Set());
            chainMap.set(chain[0], chain);
        });

        for (const [from, to] of marriageToNext.entries()) {
            const chainFrom = chainMap.get(from);
            const chainTo = chainMap.get(to);
            if (chainFrom && chainTo && chainFrom !== chainTo) {
                chainDeps.get(chainTo).add(chainFrom);
            }
        }

        const sortedChains = [];
        const chainVisited = new Set();

        for (const chain of chains) {
            visitChain(chain, chainDeps, chainVisited, sortedChains);
        }

        // Step 5: Flatten chains into the final sorted list
        generation.extendedMarriages = sortedChains.flat();
    });
}

function visitChain(chain, chainDeps, visited, result) {
    if (visited.has(chain)) return;
    visited.add(chain);
    for (const dep of chainDeps.get(chain)) {
        visitChain(dep, chainDeps, visited, result);
    }
    result.push(chain);
}
