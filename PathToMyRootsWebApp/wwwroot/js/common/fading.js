function hideElement(element) {
    $(element).addClass('fade-hidden');
}

async function fadeInElement(element) {
    // in case fade-hidden and fade-in is immediately applied
    // the browser does not fade it in, it just shows the element instantly
    // so we add this small delay to make the fade in work properly
    if ($(element).hasClass('fade-hidden')) {
        await new Promise(resolve => {
            setTimeout(() => {
                resolve();
            }, getTransitionIntervalInSeconds(element) * 50);
        });
    }

    $(element).addClass('fade-in');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getTransitionIntervalInSeconds(element) * 1000);
    });

    $(element).removeClass('fade-hidden');
    $(element).removeClass('fade-out');
}

async function fadeOutElement(element) {
    $(element).removeClass('fade-in');
    $(element).addClass('fade-out');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getTransitionIntervalInSeconds(element) * 1000);
    });
}