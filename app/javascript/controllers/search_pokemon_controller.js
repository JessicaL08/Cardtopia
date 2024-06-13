import { Controller } from "@hotwired/stimulus";

// controller called into the file _searchbar.html.erb and _pokemon_names.html.erb

// Connects to data-controller="search-pokemon"
export default class extends Controller {
  static targets = ["search", "results"];
  connect() {}

  fire() {
    // to post the real searchbar
    this.searchTarget.classList.toggle("d-none");
  }

  search(event) {
    const url = `/pokemons/search?name=${event.currentTarget.value}`;  // get the route of the pokemon
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = data.partial;  // send the pokemon_name autocomplete
      });
  }

  filterByName(event) {
    // create a new url like http://cardtopia.xyz/albums/1?name=Evoli
    // window.location.href get the current url of the page : http://cardtopia.xyz/albums/1
    const url = new URL(window.location.href);
    // add the params name and the pokemon name to the end of the url : ?name=Evoli
    url.searchParams.set("name", event.currentTarget.innerText);
    // send the new url to the window
    window.location.href = url;
  }
}
