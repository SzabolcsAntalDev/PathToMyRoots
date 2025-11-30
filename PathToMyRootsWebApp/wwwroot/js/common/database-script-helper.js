const databaseScriptHelper = {

    generatePersonsInsertionScriptSetting: false,
    genericPlaceholder: '_',
    emptyNamePlaceholder: 'X',
    idPlaceholder: 'I',
    levelPlaceholder: 'L',
    countPlaceholder: 'C',

    formatPersonName(person) {
        let nameParts = [];

        nameParts.push(person.nobleTitle ?? this.emptyNamePlaceholder);
        nameParts.push(person.lastName ?? this.emptyNamePlaceholder);
        nameParts.push(person.maidenName ?? this.emptyNamePlaceholder);
        nameParts.push(person.firstName ?? this.emptyNamePlaceholder);
        nameParts.push(person.otherNames ?? this.emptyNamePlaceholder);

        const name =
            nameParts
                .map(namePart => namePart == this.emptyNamePlaceholder ? this.emptyNamePlaceholder : this.normalizeNamePart(namePart))
                .join(this.genericPlaceholder);

        // NobleTitle_LastName_MaidenName_FirstName_OtherNames_Iid
        // X_Antal_X_Szabolcs_X_I2
        return `${name}${this.genericPlaceholder}${this.idPlaceholder}${person.id}`
    },

    // removes
    //  - accents from special characters (é, ț, ç, etc)
    //  - commas (,)
    //  - hypehns (-)
    //  - spaces
    // replaces ? with emptyNamePlaceholder
    normalizeNamePart(namePart) {
        return namePart
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/,/g, '')
            .replace(/[-\s]/g, '')
            .replace(/\?/g, this.emptyNamePlaceholder);
    },

    // generates the sql declarations of the persons available in the given nodes container
    // used in case there is an existing script for building a tree but we want
    // to rename the person declarations in the script
    // in that case we can set new names to be displayed in the trees, and then to create
    // the new declarations using this method
    generatePersonsInsertionScript(nodesContainer) {
        let insertionScript = '';
        const personNamesToCount = {};
        const generationsStartIndex = 20000;
        const generationsStepIndex = 1000;
        const numberOfPersonsOnSameLine = 1;

        const self = this;
        nodesContainer.find('.generation').each(function (generationIndex, generationDiv) {
            const personNodes = $(generationDiv).find('.person-node').toArray();

            // array of the person names in the current generation
            const personNames = personNodes.map(personNode => {
                const nameSpan = $(personNode).find('> .texts-div > .name-text');
                let personNameAndId = nameSpan.text();

                if (!personNamesToCount[personNameAndId]) {
                    personNamesToCount[personNameAndId] = 1;
                } else {
                    personNamesToCount[personNameAndId]++;
                }

                // add level and counter
                // NobleTitle_LastName_MaidenName_FirstName_OtherNames_Iid_L1_Ccount
                // X_Antal_X_Szabolcs_X_I2_L1_C1
                let personNameWithSuffixes = `${personNameAndId}${self.genericPlaceholder}${self.levelPlaceholder}${generationIndex}${self.genericPlaceholder}${self.countPlaceholder}${personNamesToCount[personNameAndId]}`;
                nameSpan.text(personNameWithSuffixes)

                return personNameWithSuffixes;
            });

            // array of the person declarations in the current generation
            const personsDeclarations = [];
            for (let i = 0; i < personNames.length; i++) {

                // this person is duplicated on 2 levels: X_Marton_Mihaly_Ilona_Bori
                // keep only the second occurrence as the person appears extendedly in the lower generation of Szabolcs Antal's genealogy tree
                // @X_Marton_Mihaly_Ilona_Bori_I23036_L2_C1
                // @X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2 - keep only this one

                if (personNames[i] == 'X_Marton_Mihaly_Ilona_Bori_I23036_L2_C1') {
                    continue;
                }

                // no other person than the exception below should be duplicated
                if (personNames[i].endsWith('C2')) {

                    if (personNames[i] != 'X_Marton_Mihaly_Ilona_Bori_I23036_L3_C2') {
                        throw new Error(`Duplicated person name: ${personNames[i]}`);
                    }
                }

                personsDeclarations.push(`DECLARE @${personNames[i]} INT = ${generationsStartIndex + generationIndex * generationsStepIndex + i};`)
            }

            const personsDeclarationsOnSameLine = [];
            for (let i = 0; i < personsDeclarations.length; i += numberOfPersonsOnSameLine) {
                personsDeclarationsOnSameLine.push(personsDeclarations.slice(i, i + numberOfPersonsOnSameLine).join('\t'));
            }

            insertionScript +=
                personsDeclarationsOnSameLine.join('\r\n') +
                '\r\n\r\n';
        });

        return insertionScript;
    },

    // given the old and new names it replaces each old name to the corresponding new one
    // based on their array indexes in the given relations sql script
    // this method is nowhere called, it is for local/static use when rarely needed
    replaceNamesInRelationsScript() {
        const namesDeclarations1 =
            `
DECLARE @Lastname1Firstname1 INT = 0;
DECLARE @Lastname2Firstname2 INT = 1;

DECLARE @Lastname2Firstname3 INT = 2;
        `;

        const namesDeclarations2 =
            `
DECLARE @Lastname1Firstname1New INT = 0;
DECLARE @Lastname2Firstname2New INT = 1;

DECLARE @Lastname2Firstname3New INT = 2;
        `;

        const relationsScript =
            `
            INSERT INTO Persons (
	            ID,
	            VALUES
	            (@Lastname1Firstname1, ...),
	            (@Lastname2Firstname2, .. )
        `;

        const relationsWithReplacedNames = this.replaceNamesInRelationsScriptInner(this.splitIntoLinesArray(namesDeclarations1), this.splitIntoLinesArray(namesDeclarations2), relationsScript);
        return relationsWithReplacedNames;
    },

    splitIntoLinesArray(text) {
        return text.split(/\r?\n/).filter(line => line.trim() !== "");
    },

    replaceNamesInRelationsScriptInner(oldNamesDeclarationsArray, newNamesDeclarationsArray, relationsScript) {
        for (let i = 0; i < oldNamesDeclarationsArray.length; i++) {
            const name1 = oldNamesDeclarationsArray[i].split(' ')[1];
            const name2 = newNamesDeclarationsArray[i].split(' ')[1];

            const regex = new RegExp(name1, 'g');
            relationsScript = relationsScript.replace(regex, name2);
        }

        return relationsScript;
    }
};