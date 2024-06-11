import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];
  static values = {
    pokemonCount: Number
  }
  connect() {
    this.cardCount = this.pokemonCountValue;
  }

  end(event) {
    const scroll = event.target.scrollLeft;
    const width = event.target.scrollWidth;

    const index = scroll / (width / this.cardCount);
    const currentCard = document.querySelector([`[data-index="${index}"]`]);

    const url = `/pokemons/${currentCard.id}/render_content`;
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        this.contentTarget.outerHTML = data.partial;
      });
  }
}
