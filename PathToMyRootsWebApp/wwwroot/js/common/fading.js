function hideElement(element) {
    $(element).addClass('fade-hidden');
}

async function fadeInElement(element) {
    
    $(element).addClass('fade-in');

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getTransitionIntervalInSeconds() * 1000);
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
        }, getTransitionIntervalInSeconds() * 1000);
    });
}