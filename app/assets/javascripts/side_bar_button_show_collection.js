  document.addEventListener("DOMContentLoaded", function() {
    // check user sur la page la page show collection
    if (window.location.pathname.includes("/collections") || window.location.pathname === "/collections"){
      const buttonsToHide = [
        document.getElementById("delete-item"),
        document.getElementById("home-button"),
      ];

      // Masquez les boutons non pertinents
      buttonsToHide.forEach(button => {
        if (button) {
          button.style.display = "none";
        }
      });
    }
  });
