// Fonction pour supprimer l'élément en fonction de la page actuelle
function deleteItem() {
    // Récupére l'URL
    let currentUrl = window.location.pathname;

    // Action de suppression en fonction de l'URL actuelle
    if (currentUrl.includes("/albums")) {
        // Si page albums,
        let albumId = currentUrl.match(/\d+/)[0]; // Obtenir l'ID de l'album

        // si détail de l'album
        if (currentUrl.includes(`/albums/${albumId}`)) {
            // activez le mode de sélection
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
    let currentUrl = window.location.pathname;

    if (currentUrl.includes("/collections")) {
        let collectionId = currentUrl.match(/\d+/)[0];
        window.location.href = `/collections/${collectionId}/edit`;
    } else if (currentUrl.includes("/albums")) {
        let albumId = currentUrl.match(/\d+/)[0];
        window.location.href = `/albums/${albumId}/edit`;
    } else {
        console.log("Page non prise en charge pour l'édition.");
    }
}

function addItem() {
    let currentUrl = window.location.pathname;

    if (currentUrl === "/collections") {
        window.location.href = "/collections/new";
    } else if (currentUrl.includes("/collections/")) {
        let collectionId = currentUrl.match(/\d+/)[0];
        window.location.href = `/collections/${collectionId}/albums/new`;
    } else if (currentUrl.includes("/albums/")) {
        let albumId = currentUrl.match(/\d+/)[0];
        window.location.href = `/albums/${albumId}/album_pokemons/new`;
    } else {
        console.log("Page non prise en charge pour l'ajout.");
    }
}

function goBack() {
    window.history.back();
}

function showInfoPopup() {
    let currentUrl = window.location.pathname;
    let infoMessage = "";

    if (currentUrl === "/") {
        infoMessage = "Explorez notre site creez des albums dans vos collections de cartes préférées!";
    } else if (currentUrl === "/collections") {
        infoMessage = "Parcourez vos collections. Choisissez en une pour voir les albums qu'elle contient ou créez une nouvelle collection pour commencer votre aventure !";
    } else if (currentUrl.includes("/collections/")) {
        infoMessage = "Découvrez tous les albums de votre collection. Ajoutez de nouveaux albums pour compléter votre collection de cartes Pokémon.";
    } else if (currentUrl.includes("/albums/")) {
        infoMessage = "Regardez toutes les cartes Pokémon de votre album. Ajoutez de nouvelles cartes pour compléter votre collection !";
    } else if (currentUrl.includes("/album_pokemons/new")) {
        infoMessage = "Parcourez les saisons, les extensions et les cartes Pokémon pour ajouter une nouvelle carte à votre album.";
    } else {
        infoMessage = "Informations spécifiques à cette page non disponibles.";
    }

    alert(infoMessage);
}

document.addEventListener('DOMContentLoaded', function() {
    const pokemonImages = document.querySelectorAll('.pokemon-image');
    const checkboxes = document.querySelectorAll('[data-suppression-target="checkbox"]');
    const deleteButton = document.getElementById('deleteSelectedButton');

    function updateLinks() {
        let anyChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
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
                image.classList.add('selected-image');
            } else {
                image.classList.remove('selected-image');
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
                    image.classList.add('selected-image');
                } else {
                    image.classList.remove('selected-image');
                }
                event.preventDefault();
            }
        });
    });
});
