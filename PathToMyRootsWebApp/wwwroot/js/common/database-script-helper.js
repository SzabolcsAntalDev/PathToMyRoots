const databaseScriptHelper = {

    executeSqlScriptHelpersSetting: false,
    firstDigitOfNewPersonsId: '4',

    formatPersonName(person) {
        const name = formatPersonNameTechnical(person);

        // _X_Antal_X_SzabolcsCsongor_X_1_
        return this.formatNameWithId(name, person.id);
    },

    formatNameWithId(name, id) {
        // _NobleTitle_LastName_MaidenName_FirstName_OtherNames_id_
        // _X_Antal_X_SzabolcsCsongor_X_1_
        return `${genericPlaceholder}${name}${genericPlaceholder}${id}${genericPlaceholder}`;
    },

    executeSqlScriptHelpers(nodesContainer) {
        const namesWithIdsObjects = this.getNamesWithIdsObjects(nodesContainer);
        const declarationLines = this.getDeclarationLines(namesWithIdsObjects);
        const insertionsScript = ``;

        const insertionsScriptWithPersonsReplaced = this.replacePersonsInInsertionsScript(insertionsScript, namesWithIdsObjects);
        const sortedInsertionLines = this.getSortedInsertionLines(insertionsScriptWithPersonsReplaced, namesWithIdsObjects);
        const indentedInsertionLines = this.getIndentedInsertionLines(sortedInsertionLines);

        console.info(this.concatLinesIntoMultilineString(this.getIndentedInsertionLines(this.splitMulilineStringIntoLines(insertionsScript))));
        console.info(this.concatLinesIntoMultilineString(declarationLines));
        console.info(this.concatLinesIntoMultilineString(indentedInsertionLines));
    },

    // generates the declarations of the persons available in the given nodes container
    getNamesWithIdsObjects(nodesContainer) {
        const allNamesWithIdsObjects = [];
        const allNamesWithIdsSet = new Set();
        const generationsStartIndex = 20000;
        const generationsStepIndex = 1000;

        const self = this;
        nodesContainer.find('.generation').each(function (generationIndex, generationDiv) {
            const nodes = $(generationDiv).find('.person-node').toArray();
            const namesWithIdsObjectsOfGeneration = self.getNamesWithIdsObjectsOfGeneration(nodes, allNamesWithIdsSet, generationsStartIndex, generationIndex, generationsStepIndex);
            allNamesWithIdsObjects.push(...namesWithIdsObjectsOfGeneration);
        });

        return allNamesWithIdsObjects;
    },

    // array of objects contaning the name, oldId and newId of the persons in the current generation
    // omits the names already found in previous generations
    getNamesWithIdsObjectsOfGeneration(nodes, allNamesWithIdsSet, generationsStartIndex, generationIndex, generationsStepIndex) {
        return nodes
            .map((node, i) => {

                // _X_Antal_X_SzabolcsCsongor_X_1_
                const nameAndId = $(node).find('> .texts-div > .name-text').text();

                if (allNamesWithIdsSet.has(nameAndId)) {
                    console.warn(`Duplicated name: ${nameAndId}, its id would have been ${generationsStartIndex + generationIndex * generationsStepIndex + i}`);
                    return null;
                }
                else {
                    allNamesWithIdsSet.add(nameAndId);
                }

                // in _X_Antal_X_SzabolcsCsongor_X_1_
                // finds X_Antal_X_SzabolcsCsongor_X
                const nameRegex = new RegExp(`^${genericPlaceholder}((?:[^${genericPlaceholder}]*${genericPlaceholder}){4}[^${genericPlaceholder}]*?)${genericPlaceholder}`);

                return {
                    name: nameAndId.match(nameRegex)[1],
                    oldId: nameAndId.split('_')[6],
                    newId: generationsStartIndex + generationIndex * generationsStepIndex + i
                };
            })
            .filter(nameWithIdObject => nameWithIdObject != null);
    },

    getDeclarationLines(namesWithIdsObjects) {
        return namesWithIdsObjects
            .map(nameWithIdObject => {
                // DECLARE @_X_Antal_X_SzabolcsCsongor_X_1_ INT = 1;
                return `DECLARE @${this.formatNameWithId(nameWithIdObject.name, nameWithIdObject.newId)} INT = ${nameWithIdObject.newId};`
            });
    },

    replacePersonsInInsertionsScript(insertionsScript, namesWithIdsObjects) {
        const scriptWithNormalOrderReplacements = this.replacePersonsInInsertionsScriptInNormalOrder(insertionsScript, namesWithIdsObjects);
        if (scriptWithNormalOrderReplacements) {
            return scriptWithNormalOrderReplacements;
        }
        else {
            console.warn('Replacement of persons in normal replace order failed. Trying in reversed order.');
            return this.replacePersonsInInsertionsScriptInReverseOrder(insertionsScript, namesWithIdsObjects);
        }
    },

    replacePersonsInInsertionsScriptInNormalOrder(insertionsScript, namesWithIdsObjects) {
        for (const nameWithIdObject of namesWithIdsObjects) {
            insertionsScript = this.replacePersonInInsertionsScript(insertionsScript, nameWithIdObject, true);

            if (!insertionsScript) {
                return false;
            }
        };

        return insertionsScript;
    },

    replacePersonsInInsertionsScriptInReverseOrder(insertionsScript, namesWithIdsObjects) {
        namesWithIdsObjects.reverse().forEach(nameWithIdObject => {
            insertionsScript = this.replacePersonInInsertionsScript(insertionsScript, nameWithIdObject, false);
        });

        return insertionsScript;
    },

    replacePersonInInsertionsScript(insertionsScript, nameWithIdObject, returnIfDifferentNumberOfOccurencesFound) {
        const newNameWithId = this.formatNameWithId(nameWithIdObject.name, nameWithIdObject.newId);
        let previousNumberOfOccurrences;
        let afterNumberOfOccurrences;

        // person was newly inserted
        if (nameWithIdObject.oldId.startsWith(this.firstDigitOfNewPersonsId)) {
            const newNameWithIdSql = `@${newNameWithId}`;
            previousNumberOfOccurrences = this.getNumberOfOccurences(insertionsScript, nameWithIdObject.oldId);
            insertionsScript = insertionsScript.replaceAll(nameWithIdObject.oldId, newNameWithIdSql);
            afterNumberOfOccurrences = this.getNumberOfOccurences(insertionsScript, newNameWithIdSql);
        }
        // person already existed
        else {
            const oldNameWithId = this.formatNameWithId(nameWithIdObject.name, nameWithIdObject.oldId);
            previousNumberOfOccurrences = this.getNumberOfOccurences(insertionsScript, oldNameWithId);
            insertionsScript = insertionsScript.replaceAll(oldNameWithId, newNameWithId);
            afterNumberOfOccurrences = this.getNumberOfOccurences(insertionsScript, newNameWithId);
        }

        if (previousNumberOfOccurrences != afterNumberOfOccurrences) {
            console.warn(`Number of occurences of person differs after replace: ${nameWithIdObject.name}, ${nameWithIdObject.oldId}, ${nameWithIdObject.newId}`);

            if (returnIfDifferentNumberOfOccurencesFound) {
                return false;
            }
        }

        return insertionsScript;
    },

    getNumberOfOccurences(text, subtext) {
        return text.split(subtext).length - 1;
    },

    getSortedInsertionLines(insertionsScript, namesWithIdsObjects) {
        // @_X_Antal_X_SzabolcsCsongor_X_1_
        const declarationLines =
            namesWithIdsObjects
                .map(nameWithIdObject => `@${this.formatNameWithId(nameWithIdObject.name, nameWithIdObject.newId)}`);

        const insertionObjects =
            this.splitMulilineStringIntoLines(insertionsScript)
                .map(insertionLine => ({
                    originalInsertionLine: insertionLine,
                    // in (@_X_Antal_X_SzabolcsCsongor_X_1_, 'Antal', NULL, ...
                    // finds @_X_Antal_X_SzabolcsCsongor_X_1_
                    // use coalescing operator for the case the methods are not running on the whole complete tree of Szabolcs Antal
                    insertedPersonName: insertionLine.match(/\(@([^,]+),/)?.[1] ?? null
                }));

        return insertionObjects
            .sort((a, b) => { return declarationLines.indexOf(a.insertedPersonName) - declarationLines.indexOf(b.insertedPersonName); })
            .map(insertionObject => insertionObject.originalInsertionLine);
    },

    getIndentedInsertionLines(insertionLines) {
        const insertionsMatrix = [];
        const self = this;

        insertionLines.forEach(function (insertionLine, _) {
            insertionsMatrix.push(self.splitInsertionLineIntoColumns(insertionLine));
        });

        const columnsMaxLengthsInTabs = [];
        insertionsMatrix[0].forEach(function (_, columnIndex) {
            let columnMaxLength = 0;

            insertionsMatrix.forEach(function (_, rowIndex) {
                columnMaxLength = (insertionsMatrix[rowIndex][columnIndex].length > columnMaxLength) ? insertionsMatrix[rowIndex][columnIndex].length : columnMaxLength;
            });

			columnsMaxLengthsInTabs[columnIndex] = Math.trunc((columnMaxLength + 4) / 4);
        });

        const indentedInsertionLines = [];

        insertionsMatrix.forEach(function (row, _) {
            let indentedInsertionLine = '\t';

            row.forEach(function (column, columnIndex) {
				const numberOfTabs = columnsMaxLengthsInTabs[columnIndex] - Math.trunc((column.length + 4) / 4);
				indentedInsertionLine += column + '\t'.repeat(numberOfTabs + 1);
            });

			indentedInsertionLines.push(indentedInsertionLine);
        });

		return indentedInsertionLines;
    },

	splitInsertionLineIntoColumns(insertionLine) {
		insertionLine = insertionLine.trim();

		// splits by whitespace, but takes string between quotes together
        const regex = /'[^']*',?|[^,\s][^,]*,?/g;
        const columns = [];

        let match;
		while ((match = regex.exec(insertionLine)) !== null) {
			columns.push(match[0].trim());
        }

		return columns;
    },

    splitMulilineStringIntoLines(text) {
        return text.split(/\r?\n/).filter(line => line.trim() !== "");
    },

    concatLinesIntoMultilineString(lines) {
        return lines.join('\r\n');
    },
};