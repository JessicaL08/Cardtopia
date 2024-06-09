document.addEventListener("DOMContentLoaded", function() {
  const cardsContainer = document.querySelector(".cards-container");
  const albumId = cardsContainer.getAttribute("data-album-id");
  const albumPokemonsPath = cardsContainer.getAttribute("data-album-pokemons-path");
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

  const cards = document.querySelectorAll(".card");
  cards.forEach(card => {
    card.addEventListener("click", function() {
      cards.forEach(c => c.classList.remove("selected"));
      card.classList.add("selected");
      const pokemonId = card.getAttribute("data-pokemon-id");

      fetch(albumPokemonsPath, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ pokemon_id: pokemonId })
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then(data => {
        if (data.success) {
          alert("Pokémon ajouté à l'album!");
        } else {
          alert("Erreur: " + data.error);
        }
      })
      .catch(error => {
        console.error("Erreur:", error);
        alert("Une erreur s'est produite. Veuillez réessayer.");
      });
    });
  });
});
