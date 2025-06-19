function hideElement(element) {
    $(element).css('opacity', '0');
    $(element).css('visibility', 'hidden');
}

async function fadeInElement(element) {
    await new Promise(resolve => {
        setTimeout(() => {
            $(element).css('visibility', 'visible');
            resolve();
        }, getTransitionBufferIntervalInSeconds() * 1000);
    });

    await new Promise(resolve => {
        setTimeout(() => {
            $(element).css('opacity', '1');
            resolve();
        }, getTransitionBufferIntervalInSeconds() * 1000);
    });

    await new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, getFadeTransitionIntervalInSeconds(element) * 1000);
    });
}

async function fadeOutElement(element) {
    await new Promise(resolve => {
        setTimeout(() => {
            $(element).css('opacity', '0');
            resolve();
        }, getTransitionBufferIntervalInSeconds() * 1000);
    });

    await new Promise(resolve => {
        setTimeout(() => {
            $(element).css('visibility', 'hidden');
            resolve();
        }, getFadeTransitionIntervalInSeconds(element) * 1000);
    });
}

function isVisibleElement(element) {
    return $(element).css('visibility') == 'visible';
}