// Szabi: change all document loaded functions to this type
//$(function () {
//});

// tooltips work the following way:
//
// to the tooltip source element assign:
// - the id for the data-tooltip-id attribute (data-tooltip-id="hourglass-biological")
// - the class tooltip-source
//
// to the tooltip element assign:
// - the id for the data-tooltip-id attribute (data-tooltip-id="hourglass-biological")
// - the class tooltip
//
// the tooltip will automatically become invisible by having opacity 0
// finally call the registerTooltips method
// each tooltip is moved to the body - needed to overflow its original container
// and an event handler is added the tooltip to be shown in the middle below the source element
// registerTooltips can be called multiple times, it will assign the tooltips only to the uninitialized sources
// duplicated tooltips (tests page for instance) will be omitted
function registerTooltips() {
    const tooltipContentIdsInBody = new Set();

    // get all tooltip ids that are already in the body
    $('.tooltip').each(function () {
        const tooltip = $(this);
        if (tooltip.parent()[0] === document.body) {
            const id = tooltip.data('tooltip-id');
            tooltipContentIdsInBody.add(id);
        }
    });

    // ove tooltips to body or remove if because it's a duplicate
    $('.tooltip').each(function () {
        const tooltip = $(this);
        const tooltipId = tooltip.data('tooltip-id');

        // remove duplicate tooltip
        if (tooltip.parent()[0] !== document.body && tooltipContentIdsInBody.has(tooltipId)) {
            tooltip.remove();
        } else if (!tooltipContentIdsInBody.has(tooltipId)) {
            // move it to the body if it's the first tooltip-content with its id
            tooltip.prependTo(document.body);
            tooltipContentIdsInBody.add(tooltipId);
        }
    });

    const tooltipSourceToTooltip = new Map();
    const tooltipSources = $('.tooltip-source');

    // add event listeners only
    tooltipSources.each(function () {
        const tooltipSource = $(this);
        if (tooltipSource.data('tooltip-source-initialized')) {
            return;
        }

        const tooltipId = tooltipSource.data('tooltip-id');

        // find matching tooltip
        const tooltip = $('.tooltip').filter(function () {
            return $(this).data('tooltip-id') == tooltipId;
        }).first();

        tooltipSourceToTooltip.set(tooltipSource[0], tooltip.get(0));

        tooltipSource.on('mouseenter', function () {
            const tooltipSourceInner = this;
            const tooltipInner = tooltipSourceToTooltip.get(tooltipSourceInner);

            const tooltipSourceClientRect = tooltipSourceInner.getBoundingClientRect();
            const windowScrollX = window.scrollX;
            const windowScrollY = window.scrollY;

            const tooltipHeight = tooltipInner.offsetHeight;
            const spaceBelow = window.innerHeight - tooltipSourceClientRect.bottom;

            tooltipInner.style.left = `${(tooltipSourceClientRect.left + (tooltipSourceClientRect.width / 2)) + windowScrollX}px`;

            const tooltipOffset = getTooltipOffset();

            // position tooltip below target below if possibe
            const top = (spaceBelow >= tooltipHeight + tooltipOffset)
                ? tooltipInner.style.top = `${tooltipSourceClientRect.bottom + windowScrollY + tooltipOffset}px`
                : tooltipInner.style.top = `${tooltipSourceClientRect.top + windowScrollY - tooltipHeight - tooltipOffset}px`;

            tooltipInner.style.top = top;

            $(tooltipInner).addClass('tooltip-open');
        });

        tooltipSource.on('mouseleave', function () {
            const tooltipSourceInner = this;
            const tooltipInner = tooltipSourceToTooltip.get(tooltipSourceInner);

            $(tooltipInner).removeClass('tooltip-open');
        });

        tooltipSource.data('tooltip-source-initialized', true);
    });
}