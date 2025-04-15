function hideElement(element) {
    $(element).addClass('fade-hidden');
}

function fadeInElement(element) {
    $(element).removeClass('fade-hidden');
    $(element).removeClass('fade-out');
    $(element).addClass('fade-in');
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