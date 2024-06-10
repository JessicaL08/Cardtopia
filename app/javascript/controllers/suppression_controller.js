import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["card", "checkbox", "deleteButton", "cancelButton", "listeElements"];

  connect() {
    console.log('Connecté à suppression');
  }

  activer() {
    this.cardTargets.forEach((card) => {
      const checkbox = card.querySelector('[data-suppression-target="checkbox"]');
      checkbox.addEventListener('change', () => {
        if (checkbox.checked) {
          card.classList.add('selected');
        } else {
          card.classList.remove('selected');
        }
      });
    });
    console.log('Mode suppression activé');
    this.element.disabled = true;
  }

  supprimerSelection() {
    const selectedPokemonIds = this.checkboxTargets
      .filter(checkbox => checkbox.checked)
      .map(checkbox => checkbox.value);

    const url = '/album_pokemons';

    const token = document.querySelector('meta[name="csrf-token"]').content;

    // Confirmation avant la suppression
    const confirmation = confirm("Êtes-vous sûr de vouloir supprimer les cartes sélectionnées ?");
    if (confirmation) {
      fetch(url, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': token
        },
        body: JSON.stringify({ pokemon_ids: selectedPokemonIds })
      }).then(response => {
        if (response.ok) {
          console.log('Cartes supprimées avec succès');
          // Recharger uniquement la partie de la page contenant la liste des éléments
          fetch(window.location.href)
            .then(response => response.text())
            .then(data => {
              const parser = new DOMParser();
              const htmlDocument = parser.parseFromString(data, 'text/html');
              const updatedListeElements = htmlDocument.getElementById('liste-elements').innerHTML;
              this.listeElementsTarget.innerHTML = updatedListeElements;
            })
            .catch(error => console.error('Erreur lors du chargement de la partie mise à jour de la page :', error));
        } else {
          console.error('Erreur lors de la suppression des cartes');
        }
      }).catch(error => {
        console.error('Erreur lors de la suppression des cartes:', error);
      });
    }
}

  toggleSelection(event) {
    const checkbox = event.currentTarget;
    const card = checkbox.closest('[data-suppression-target="card"]');
    if (checkbox.checked) {
      card.classList.add('selected');
    } else {
      card.classList.remove('selected');
    }
  }

  activerSelection() {
    const checkboxes = this.checkboxTargets;
    const areAllDisabled = checkboxes.every(checkbox => checkbox.disabled);

    checkboxes.forEach(checkbox => {
      checkbox.disabled = !areAllDisabled;
    });
  }
}
