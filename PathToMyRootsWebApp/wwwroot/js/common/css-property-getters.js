﻿function getPropertyValue(propertyName, element = document.documentElement) {
    return getComputedStyle($(element)[0]).getPropertyValue('--' + propertyName);
}

function getPersonNodeWidth(viewMode) {
    return getPropertyValue(`person-node-width-${viewMode.id.toLowerCase()}`);
}

function getMarriageNodeWidth(viewMode) {
    return getPropertyValue(`marriage-node-width-${viewMode.id.toLowerCase()}`);
}

function getMarriageNodeHeight(viewMode) {
    return getPropertyValue(`marriage-node-height-${viewMode.id.toLowerCase()}`);
}

function getNodeHorizontalMargin(viewMode) {
    return getPropertyValue(`node-horizontal-margin-${viewMode.id.toLowerCase()}`);
}

function getTreePersonImageWidth(viewMode) {
    return getPropertyValue(`tree-person-image-width-${viewMode.id.toLowerCase()}`);
}

function getTreePersonImageHeight(viewMode) {
    return getPropertyValue(`tree-person-image-height-${viewMode.id.toLowerCase()}`);
}

function getNodePathsVerticalOffset(viewMode) {
    const nodePathsVerticalOffset = getPropertyValue(`node-paths-vertical-offset-${viewMode.id.toLowerCase()}`);
    return parseFloat(nodePathsVerticalOffset);
}

function getIntervalInSeconds(propertyName, element) {
    const intervalInSecondsString = getPropertyValue(propertyName, element);
    return parseFloat(intervalInSecondsString);
}

function getTransitionBufferIntervalInSeconds() {
    return getIntervalInSeconds('transition-buffer-interval');
}

function getColorTransitionIntervalInSeconds() {
    return getIntervalInSeconds('color-transition-interval');
}

function getFadeTransitionIntervalInSeconds(element) {
    return getIntervalInSeconds('fade-transition-interval', element);
}

function getTreeSizeTransitionIntervalInSeconds(element) {
    return getIntervalInSeconds('tree-size-transition-interval', element);
}

function getTooltipTransitionIntervalInSeconds(element) {
    return getIntervalInSeconds('tooltip-transition-interval', element);
}

function getPopupDisplayIntervalInSeconds() {
    return getIntervalInSeconds('popup-loading-bar-transition-interval');
}

function getScrollTransitionIntervalInSeconds() {
    return getIntervalInSeconds('scroll-transition-interval');
}

function getScrollBarSize() {
    return getPropertyValue('scroll-bar-size');
}

function getTooltipOffset() {
    const tooltipOffset = getPropertyValue('tooltip-offset');
    return parseFloat(tooltipOffset);
}