document.addEventListener('DOMContentLoaded', function() {
  const trashButton = document.querySelector('#trashButton');

  if (trashButton) {
    trashButton.addEventListener('click', function() {
      const deleteSelectedButton = document.querySelector('#deleteSelectedButton');
      deleteSelectedButton.removeAttribute('hidden');
    });
  }
});
