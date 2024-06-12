import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-pokemon"
export default class extends Controller {
  static targets = ["search", "results"]
  connect() {
  }

  fire() {
    this.searchTarget.classList.toggle("d-none")
  }

  search(event) {
    const url = `/pokemons/search?name=${event.currentTarget.value}`
    fetch(url).then(response => response.json()).then(data => {
      this.resultsTarget.innerHTML = data.partial
    })
  }
}
