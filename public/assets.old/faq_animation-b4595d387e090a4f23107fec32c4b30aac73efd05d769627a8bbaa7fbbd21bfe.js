// fichier d'animation pour la FAQ de la page d'accueil du site

// app/javascript/packs/animation_observer.js
document.addEventListener("DOMContentLoaded", function() {
  const observer = new IntersectionObserver((entries) => {
    console.log("coucou faq_animation js")

    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in');
        observer.unobserve(entry.target); // Stop observing after animation starts
      }
    });
  });

  document.querySelectorAll('.hidden').forEach(element => {
    observer.observe(element);
  });
});
