document.addEventListener("DOMContentLoaded", () => {
    addListeners();
});

function addListeners() {
    const inputSearch = document.getElementById("input-search");
    const buttonSearch = document.getElementById("button-search");

    inputSearch.addEventListener("keypress", event => {
        if (event.key === "Enter") {
            fetchData(0, inputSearch.value);
        }
    });

    buttonSearch.addEventListener("click", () => {
        fetchData(0, inputSearch.value);
    });

    document.querySelectorAll("button").forEach(button => {
        button.addEventListener("click", event => {
            event.preventDefault();

            const pageNumber = button.getAttribute("data-page");
            const searchText = document.getElementById("input-search").value;

            fetchData(pageNumber, searchText);
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

function fetchData(page, searchText) {
    fetch(`/Person/Persons?page=${page}&searchText=${encodeURIComponent(searchText)}`, {
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