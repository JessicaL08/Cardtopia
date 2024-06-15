document.addEventListener("DOMContentLoaded", function() {
  // Vérifiez si l'utilisateur est sur la page d'accueil
  if (window.location.pathname.includes("/pokemons/")){
    // Sélectionnez les boutons que vous voulez masquer
    const buttonsToHide = [
      document.getElementById("delete-item"),
      document.getElementById("edit-item"),
      document.getElementById("add-item"),
      document.getElementById("popup")
    ];

    // Masquez les boutons non pertinents
    buttonsToHide.forEach(button => {
      if (button) {
        button.style.display = "none";
      }
    });
  }
});
