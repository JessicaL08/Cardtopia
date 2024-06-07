// info_button.js
document.addEventListener('DOMContentLoaded', function() {
  // Récupère le bouton et l'élément de texte d'explication
  const infoButton = document.getElementById('infoButton');
  const infoText = document.getElementById('infoText');

  // Ajoute un gestionnaire d'événement au clic sur le bouton
  infoButton.addEventListener('click', function() {
    // Vérifie si le texte d'explication est actuellement visible
    if (infoText.style.display === 'none') {
      // Affiche le texte d'explication s'il est caché
      infoText.style.display = 'block';
    } else {
      // Sinon, cache le texte d'explication s'il est visible
      infoText.style.display = 'none';
    }
  });
});
