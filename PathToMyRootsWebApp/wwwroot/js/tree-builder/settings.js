function addSettingsListeners() {
    const settingsDivs = $('.settings-div');

    settingsDivs.each((_, settingsDiv) => {
        const expandButtonDiv = $(settingsDiv).find('.expand-button-div');
        const horizontalToggleableContainer = $(settingsDiv).find('.horizontal-toggleable-container');

        expandButtonDiv.on('click', () => {
            expandButtonDiv.toggleClass('expand-button-div-opened');
            horizontalToggleableContainer.toggleClass('horizontal-toggleable-container-open');
        });
    });
}