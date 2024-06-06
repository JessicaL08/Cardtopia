import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="suppression"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    console.log('Connecté à suppression');
  }

  suppression(event) {
    event.currentTarget.closest('li').remove();
    console.log('Carte supprimée');
  }

  activer() {
    this.cardTargets.forEach((card) => {
      card.addEventListener('click', this.suppression.bind(this));
    });
    console.log('Mode suppression activé');
    this.element.disabled = true;
  }
}
