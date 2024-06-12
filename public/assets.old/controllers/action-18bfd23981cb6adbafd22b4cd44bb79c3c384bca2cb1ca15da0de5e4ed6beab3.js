// Fonction pour supprimer une carte
function supprimerCarte() {
  const cartes = document.querySelectorAll('.carte');
  cartes.forEach(carte => {
    carte.addEventListener('click', function() {
      this.remove();
    });
  });
}

// Fonction pour activer la suppression des cartes
function activerSuppressionDesCartes() {
  const boutonActivation = document.getElementById('activerSuppression');
  boutonActivation.addEventListener('click', function() {
    supprimerCarte();
    boutonActivation.disabled = true;
  });
}

// Événement DOMContentLoaded pour exécuter le code lorsque le DOM est prêt
document.addEventListener('DOMContentLoaded', function() {
  activerSuppressionDesCartes();
});
