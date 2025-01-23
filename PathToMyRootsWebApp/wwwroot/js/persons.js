document.addEventListener("DOMContentLoaded", () => {
    addAllListeners()
});

function addAllListeners() {
    attachPaginationEventListeners();

    const inputSearch = document.getElementById("input-search");
    const buttonSearch = document.getElementById("button-search");

    buttonSearch.addEventListener("click", () => {
        fetchData(0, inputSearch.value);
    });

    inputSearch.addEventListener("keypress", event => {
        if (event.key === "Enter") {
            fetchData(0, inputSearch.value);
        }
    });
}

function attachPaginationEventListeners() {
    document.querySelectorAll("button").forEach(link => {
        link.addEventListener("click", event => {
            event.preventDefault();
            const page = link.getAttribute("data-page");
            fetchData(page, document.getElementById("input-search").value);
        });
    });
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
            const personsContainer = document.querySelector("#persons-container");
            personsContainer.innerHTML = data;
            addAllListeners();
        });
}

