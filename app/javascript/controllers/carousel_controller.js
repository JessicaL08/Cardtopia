import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["content"];
  connect() {
    this.cardCount = 4;
  }

  end(event) {
    const scroll = event.target.scrollLeft;
    const width = event.target.scrollWidth;

    const index = scroll / (width / this.cardCount);
    const currentCard = document.querySelector([`[data-index="${index}"]`]);
    console.log(currentCard.id);

    const url = `/pokemons/${currentCard.id}/render_content`;
    console.log(url);
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        this.contentTarget.outerHTML = data.partial;
      });
  }
}
