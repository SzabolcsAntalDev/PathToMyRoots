function attachPaginationEventListeners() {
    document.querySelectorAll(".pagination-link").forEach(link => {
        link.addEventListener("click", event => {
            event.preventDefault();
            const page = link.getAttribute("data-page");
            fetch(`/Person/Persons?page=${page}`, {
                method: "GET",
                headers: {
                    "X-Requested-With": "XMLHttpRequest"
                }
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.text();
                })
                .then(data => {
                    const container = document.querySelector("#persons-content");
                    container.innerHTML = data;
                    attachPaginationEventListeners(); // Reattach event listeners for the new content
                })
                .catch(error => {
                    console.error("Error fetching data:", error);
                });
        });
    });
}

document.addEventListener("DOMContentLoaded", () => {
    attachPaginationEventListeners();
});