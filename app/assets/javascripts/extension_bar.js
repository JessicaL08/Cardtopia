document.addEventListener("DOMContentLoaded", function() {
  document.querySelectorAll(".season-name").forEach(function(seasonName) {
    seasonName.addEventListener("click", function(event) {
      event.preventDefault();
      const seasonAndExtensions = seasonName.parentElement;
      const seasonId = seasonAndExtensions.id.split("-")[1];

      // Afficher les extensions de la saison et masquer les autres
      document.querySelectorAll(".season-and-extensions").forEach(function(seasonDiv) {
        if (seasonDiv.id === seasonAndExtensions.id) {
          seasonDiv.querySelector(".button-container").style.display = "block";
        } else {
          seasonDiv.querySelector(".button-container").style.display = "none";
          seasonDiv.style.display = "none"; // Masquer la saison
        }
      });

      document.querySelectorAll(".season-name").forEach(el => el.style.fontWeight = "normal");
      seasonName.style.fontWeight = "bold";
    });
  });
});
