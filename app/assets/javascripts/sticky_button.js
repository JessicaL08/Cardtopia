document.addEventListener("DOMContentLoaded", function() {
    const stickyButton = document.getElementById("stickyButton");
    const subButtons = document.getElementById("subButtons");

    stickyButton.addEventListener("click", function(event) {
        event.stopPropagation(); // Empêche la propagation du clic pour éviter la fermeture immédiate du sous-menu
        subButtons.style.display = subButtons.style.display === "none" ? "block" : "none";
    });

    document.addEventListener("click", function(event) {
        if (!stickyButton.contains(event.target) && !subButtons.contains(event.target)) {
            subButtons.style.display = "none";
        }
    });
});
