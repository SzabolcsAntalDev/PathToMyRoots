document.addEventListener("DOMContentLoaded", async () => {
    await addListeners();

    document.querySelectorAll("td, th").forEach(cell => {
        cell.setAttribute("title", cell.textContent.trim());
    });
});

function getFilterText() {
    return document.getElementById("filter-input").value;
}

function getPageSize() {
    return document.getElementById("page-size-select").value;
}
async function addListeners() {
    const filterInput = document.getElementById("filter-input");
    const filterButton = document.getElementById("filter-button");
    const pageSizeSelect = document.getElementById("page-size-select");
    const paginationContainer = document.querySelector('.pagination-container');

    filterInput.addEventListener("keypress", async event => {
        if (event.key === "Enter") {
            await fetchData(getFilterText(), 0, getPageSize());
        }
    });

    filterButton.addEventListener("click", async () => {
        await fetchData(getFilterText(), 0, getPageSize());
    });

    pageSizeSelect.addEventListener("change", async () => {
        await fetchData(getFilterText(), 0, getPageSize());
    });

    
    paginationContainer.querySelectorAll("button").forEach(button => {
        button.addEventListener("click", async event => {
            event.preventDefault();

            const currentPageNumber = button.getAttribute("data-page");

            await fetchData(getFilterText(), currentPageNumber, getPageSize());
        });
    });
}

function setupPaginationButtons(currentPageNumber, totalNumberOfPages) {
    const firstButton = document.getElementById("first-button");
    const prevButton = document.getElementById("prev-button");
    const paginationText = document.getElementById("pagination-text");
    const nextButton = document.getElementById("next-button");
    const lastButton = document.getElementById("last-button");

    if (currentPageNumber > 0) {
        firstButton.removeAttribute('disabled');
        prevButton.removeAttribute('disabled');

        prevButton.setAttribute('data-page', currentPageNumber - 1);
    }
    else {
        firstButton.disabled = true;
        prevButton.disabled = true;
    }
    paginationText.textContent = (currentPageNumber + 1) + ' / ' + totalNumberOfPages;

    if (currentPageNumber < totalNumberOfPages - 1) {
        nextButton.removeAttribute('disabled');
        lastButton.removeAttribute('disabled');

        nextButton.setAttribute('data-page', currentPageNumber + 1);
        lastButton.setAttribute('data-page', totalNumberOfPages - 1);
    }
    else {
        nextButton.disabled = true;
        lastButton.disabled = true;
    }
}

async function fetchData(filterText, currenPageNumber, pageSize) {
    const personsContainer = document.getElementById("persons-container");

    const loadingTextContainer = await createOrGetLoadingTextContainer(personsContainer.parentElement);
    fadeInElement(loadingTextContainer);

    await fadeOutElement(personsContainer);

    fetch(`/Person/Persons?filterText=${encodeURIComponent(filterText)}&currentPageNumber=${currenPageNumber}&pageSize=${pageSize}`, {
        method: "GET",
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        }
    })
        .then(response => {
            return response.text();
        })
        .then(data => {
            personsContainer.innerHTML = data;

            const personsTable = document.getElementById("persons-table")

            var currentPageNumber = parseInt(personsTable.getAttribute("data-current-page-number"), 10);
            var totalNumberOfPages = parseInt(personsTable.getAttribute("data-total-number-of-pages"), 10);

            setupPaginationButtons(currentPageNumber, totalNumberOfPages);

            fadeOutElement(loadingTextContainer);
            fadeInElement(personsContainer);
        });
}