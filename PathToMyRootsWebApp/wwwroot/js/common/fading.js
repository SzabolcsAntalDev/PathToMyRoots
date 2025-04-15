function hideElement(element) {
    $(element).addClass('fade-hidden');
}

async function fadeInElement(element) {
    $(element).removeClass('fade-hidden');
    $(element).removeClass('fade-out');
    $(element).addClass('fade-in');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getTransitionIntervalInSeconds() * 1000);
    });
}

async function fadeOutElement(element) {
    $(element).removeClass('fade-in');
    $(element).addClass('fade-out');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getTransitionIntervalInSeconds() * 1000);
    });
}