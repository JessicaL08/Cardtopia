// Fonction pour supprimer l'élément en fonction de la page actuelle
function deleteItem() {
    // Récupére l'URL
    const currentUrl = window.location.pathname;

    // Action de suppression en fonction de l'URL actuelle
    if (currentUrl.includes("/albums")) {
        // Si page albums,
        const albumId = currentUrl.match(/\d+/)[0]; // Obtenir l'ID de l'album

        // si détail de l'album
        if (currentUrl.includes(`/albums/${albumId}`)) {
            // activez le mode de sélection
            const images = document.querySelectorAll('.pokemon-image');
            images.forEach(image => {
              image.style.opacity = '0.4';
            });
            enableCheckboxes();

        } else {
            // Sinon, action de suppression normale
            window.location.href = `/albums/${albumId}`;
        }
    } else {
        console.log("Page non prise en charge pour la suppression.");
    }
}

function enableCheckboxes() {
    const checkboxes = document.querySelectorAll('[data-suppression-target="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.disabled = false;

    const deleteButton = document.getElementById('deleteSelectedButton');
    deleteButton.style.display = 'block';

    const cancelButton = document.getElementById('cancelSelectedButton');
    cancelButton.style.display = 'block';
    });
}

function editItem() {
    const currentUrl = window.location.pathname;

    if (currentUrl.includes("/collections")) {
        const collectionId = currentUrl.match(/\d+/)[0];
        window.location.href = `/collections/${collectionId}/edit`;
    } else if (currentUrl.includes("/albums")) {
        const albumId = currentUrl.match(/\d+/)[0];
        window.location.href = `/albums/${albumId}/edit`;
    } else {
        console.log("Page non prise en charge pour l'édition.");
    }
}

function addItem() {
    const currentUrl = window.location.pathname;

    if (currentUrl.includes("/collections.") || currentUrl === "/collections") {
        window.location.href = "/collections/new";
    } else if (currentUrl.includes("/collections/")) {
        const collectionId = currentUrl.match(/\d+/)[0];
        window.location.href = `/collections/${collectionId}/albums/new`;
    } else if (currentUrl.includes("/albums/")) {
        const albumId = currentUrl.match(/\d+/)[0];
        window.location.href = `/albums/${albumId}/album_pokemons/new`;
    } else {
        console.log("Page non prise en charge pour l'ajout.");
    }
}

function goBack() {
    window.history.back();
}

function showInfoPopup() {
    const currentUrl = window.location.pathname;
    let infoMessage = "";

    if (currentUrl === "/") {
        infoMessage = "Explore notre site crée des albums dans ta collections de cartes préférées!";
    } else if (currentUrl === "/collections") {
        infoMessage = 'Parcoure tes collections. Choisis en une pour voir tes albums ou crée une nouvelle collection pour commencer ton aventure en cliquant sur <span id="add-icon" class="clickable-icon"><i class="fa-solid fa-plus"></i></span>';
    } else if (currentUrl.includes("/album_pokemons/new")) {
        infoMessage = 'Parcoure les saisons, les extensions pour ajouter une nouvelle carte à ton album. Tu peux aussi taper un nom de pokemon dans la recherche et choisir la ou les cartes que tu veux ajouter. Quand tu as fini, tu peux retourner sur tes albums en cliquant sur <span id="album-icon" class="clickable-icon"><i class="fa-solid fa-images"></i></span> !';
    } else if (currentUrl.includes("/collections/")) {
        infoMessage = 'Découvre tous les albums de ta collection. Ajoute ton premier album, ou de nouveaux en cliquant sur <span id="add-icon" class="clickable-icon"><i class="fa-solid fa-plus"></i></span>. Edit ta collection avec le bouton <span id="edit-icon" class="clickable-icon"><i class="fa-solid fa-pen-to-square"></i></span>';
    } else if (currentUrl.includes("/albums/")) {
        infoMessage = 'Regarde toutes les cartes Pokémon de ton album. Ajoute de nouvelles cartes pour compléter ta collection en cliquant sur le bouton <span id="add-icon" class="clickable-icon"><i class="fa-solid fa-plus"></i></span> du menu. Supprime des pokemons avec <span id="delete-icon" class="clickable-icon"><i class="fa-solid fa-trash"></i></span>, tu peux aussi les filtrer par types. Tu peux aussi éditer ton album avec le bouton <span id="edit-icon" class="clickable-icon"><i class="fa-solid fa-pen-to-square"></i></span>';
    } else {
        infoMessage = 'Informations spécifiques à cette page non disponibles.';
    }

    document.getElementById("popupMessage").innerHTML = infoMessage;
    document.getElementById("customPopup").style.display = "block";

    // Ajoutez les gestionnaires d'événements aux icônes
    if (document.getElementById("add-icon")) {
        document.getElementById("add-icon").addEventListener("click", addItem);
    }
    if (document.getElementById("edit-icon")) {
        document.getElementById("edit-icon").addEventListener("click", editItem);
    }
    if (document.getElementById("delete-icon")) {
        document.getElementById("delete-icon").addEventListener("click", deleteItem);
    }
    if (document.getElementById("album-icon")) {
        document.getElementById("album-icon").addEventListener("click", albumItem);
    }
}

function albumItem() {
    // Rediriger vers la page des albums
    const albumPath = document.getElementById('dataContainer').getAttribute('data-album-path');
    window.location.href = albumPath;
}

function closePopup() {
    document.getElementById("customPopup").style.display = "none";
}

// Pour fermer la fenêtre quand on clique en dehors
window.onclick = function(event) {
    const popup = document.getElementById("customPopup");
    if (event.target === popup) {
        popup.style.display = "none";
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const pokemonImages = document.querySelectorAll('.pokemon-image');
    const checkboxes = document.querySelectorAll('[data-suppression-target="checkbox"]');
    const deleteButton = document.getElementById('deleteSelectedButton');

    function updateLinks() {
        const anyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
        pokemonImages.forEach(function(image) {
            if (anyChecked) {
                image.classList.add('disabled-link');
            } else {
                image.classList.remove('disabled-link');
            }
        });
    }

    checkboxes.forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            updateLinks();
            const image = checkbox.closest('.card-container').querySelector('.pokemon-image');
            if (checkbox.checked) {
                // image.classList.add('selected-image');
                image.style.opacity = '0.4';

            } else {
                // image.classList.remove('selected-image');
                image.style.opacity = '1';

            }
        });
    });

    pokemonImages.forEach(function(image) {
        image.addEventListener('click', function(event) {
            const checkbox = image.closest('.card-container').querySelector('input[type="checkbox"]');
            if (!checkbox.disabled) {
                checkbox.checked = !checkbox.checked;
                updateLinks();
                const image = checkbox.closest('.card-container').querySelector('.pokemon-image');
                if (checkbox.checked) {
                   // image.classList.add('selected-image');
                  image.style.opacity = '1';
                } else {
                    // image.classList.remove('selected-image');
                  image.style.opacity = '0.4';
                }
                event.preventDefault();
            }
        });
    });
});
