document.addEventListener("DOMContentLoaded", () => {
    addListeners();
});

function getSearchText() {
    return document.getElementById("input-search").value;
}

function getPageSize() {
    return document.getElementById("page-size-select").value;
}
function addListeners() {
    const searchInput = document.getElementById("input-search");
    const searchButton = document.getElementById("button-search");
    const pageSizeSelect = document.getElementById("page-size-select");

    searchInput.addEventListener("keypress", event => {
        if (event.key === "Enter") {
            fetchData(getSearchText(), 0, getPageSize());
        }
    });

    searchButton.addEventListener("click", () => {
        fetchData(getSearchText(), 0, getPageSize());
    });

    pageSizeSelect.addEventListener("change", () => {
        fetchData(getSearchText(), 0, getPageSize());
    });

    document.querySelectorAll("button").forEach(button => {
        button.addEventListener("click", event => {
            event.preventDefault();

            const pageNumber = button.getAttribute("data-page");

            fetchData(getSearchText(), pageNumber, getPageSize());
        });
    });
}

function setupPaginationButtons(currentPage, totalPages) {
    const firstButton = document.getElementById("first-button");
    const prevButton = document.getElementById("prev-button");
    const paginationText = document.getElementById("pagination-text");
    const nextButton = document.getElementById("next-button");
    const lastButton = document.getElementById("last-button");

    if (currentPage > 0) {
        firstButton.removeAttribute('disabled');
        prevButton.removeAttribute('disabled');

        prevButton.setAttribute('data-page', currentPage - 1);
    }
    else {
        firstButton.disabled = true;
        prevButton.disabled = true;
    }
    paginationText.textContent = (currentPage + 1) + ' / ' + totalPages;

    if (currentPage < totalPages - 1) {
        nextButton.removeAttribute('disabled');
        lastButton.removeAttribute('disabled');

        nextButton.setAttribute('data-page', currentPage + 1);
        lastButton.setAttribute('data-page', totalPages - 1);
    }
    else {
        nextButton.disabled = true;
        lastButton.disabled = true;
    }
}

function fetchData(searchText, pageNumber, pageSize) {
    fetch(`/Person/Persons?searchText=${encodeURIComponent(searchText)}&pageNumber=${pageNumber}&pageSize=${pageSize}`, {
        method: "GET",
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        }
    })
        .then(response => {
            return response.text();
        })
        .then(data => {
            const personsContainer = document.getElementById("persons-container");
            personsContainer.innerHTML = data;

            const personsTable = document.getElementById("persons-table")

            var currentPage = parseInt(personsTable.getAttribute("data-current-page"), 10);
            var totalPages = parseInt(personsTable.getAttribute("data-total-pages"), 10);

            setupPaginationButtons(currentPage, totalPages);
        });
}