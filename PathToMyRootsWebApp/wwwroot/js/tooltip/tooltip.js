// Szabi: change all document loaded functions to this type
//$(function () {
//});

function registerTooltips() {
    const body = $('body');
    const tooltipHtmlsAlreadyInBody = new Set();

    // get all tooltip elements that are direct children of body
    $('.tooltip').filter(function () {
        const tooltip = $(this);
        return tooltip.parent()[0] === document.body;
    }).each(function () {
        tooltipHtmlsAlreadyInBody.add($(this).html());
    });

    // get all tooltips not already in body and unique by HTML content
    const uniqueTooltipsToAddToBody = $('.tooltip').filter(function () {
        const tooltip = $(this);
        return tooltip.parent()[0] !== document.body && !tooltipHtmlsAlreadyInBody.has(tooltip.html());
    });

    // move unique tooltips to body
    uniqueTooltipsToAddToBody.each(function () {
        const tooltip = $(this);
        tooltip.prependTo(body);
    });

    const tooltipSourceToTooltip = new Map();
    const tooltipSources = $('.tooltip-source');

    // add event listeners only
    tooltipSources.each(function () {
        const tooltipSource = $(this);
        if (tooltipSource.data('tooltip-initialized')) {
            return;
        }

        const tooltipId = tooltipSource.data('tooltip-id');

        // find matching tooltip
        const tooltip = $('.tooltip').filter(function () {
            return $(this).data('tooltip-id') == tooltipId;
        }).first();

        tooltipSourceToTooltip.set(tooltipSource[0], tooltip.get(0));

        tooltipSource.on('mouseenter', function () {
            const tooltipSourceInner= this;
            const tooltipInner = tooltipSourceToTooltip.get(tooltipSourceInner);

            const rect = tooltipSourceInner.getBoundingClientRect();
            tooltipInner.style.left = `${(rect.left + (rect.width / 2)) + window.scrollX}px`;
            tooltipInner.style.top = `${rect.bottom + window.scrollY + 3}px`;
            $(tooltipInner).addClass('tooltip-open');
        });

        tooltipSource.on('mouseleave', function () {
            const tooltipSourceInner = this;
            const tooltipInner = tooltipSourceToTooltip.get(tooltipSourceInner);

            $(tooltipInner).removeClass('tooltip-open');
        });

        tooltipSource.data('tooltip-initialized', true);
    });
}
