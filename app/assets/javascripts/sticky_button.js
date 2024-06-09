document.addEventListener("DOMContentLoaded", function() {
    const stickyButton = document.getElementById("stickyButton");
    const subButtons = document.getElementById("subButtons");

    stickyButton.addEventListener("click", function(event) {
        event.stopPropagation(); //Pas de propagation du clic
        subButtons.style.display = subButtons.style.display === "none" ? "block" : "none";
    });

    document.addEventListener("click", function(event) {
        if (!stickyButton.contains(event.target) && !subButtons.contains(event.target)) {
            subButtons.style.display = "none";
        }
    });
});
