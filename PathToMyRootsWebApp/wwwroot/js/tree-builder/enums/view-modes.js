const viewModes = {
    EXTRASMALL:
    {
        index: -1,
        id: 'EXTRASMALL',
        displayName: 'Extra small'
    },
    SMALL:
    {
        index: 0,
        id: 'SMALL',
        displayName: 'Small'
    },
    MEDIUM:
    {
        index: 1,
        id: 'MEDIUM',
        displayName: 'Medium'
    },
    LARGE:
    {
        index: 2,
        id: 'LARGE',
        displayName: 'Large'
    },
};

function getViewModeByIndex(index) {
    return Object.values(viewModes).find(mode => mode.index === index)
}