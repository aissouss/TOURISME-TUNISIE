// Sélection des éléments DOM
const burger = document.querySelector('.burger');
const nav = document.querySelector('.nav-links');
const navLinks = document.querySelectorAll('.nav-links li');
const navbar = document.querySelector('.navbar');
const sections = document.querySelectorAll('section');

// Gestion du menu burger
burger.addEventListener('click', () => {
    // Toggle navigation
    nav.classList.toggle('nav-active');
    
    // Animation des liens
    navLinks.forEach((link, index) => {
        if (link.style.animation) {
            link.style.animation = '';
        } else {
            link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.3}s`;
        }
    });
    
    // Animation du burger
    burger.classList.toggle('toggle');
});

// Changement de couleur de la navbar au scroll
window.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
        navbar.style.backgroundColor = 'var(--white)';
        navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
    } else {
        navbar.style.backgroundColor = 'transparent';
        navbar.style.boxShadow = 'none';
    }
});

// Smooth scroll pour les liens d'ancrage
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
            // Fermer le menu mobile si ouvert
            if (nav.classList.contains('nav-active')) {
                nav.classList.remove('nav-active');
                burger.classList.remove('toggle');
                navLinks.forEach(link => {
                    link.style.animation = '';
                });
            }
        }
    });
});

// Animation des sections au scroll
const observerOptions = {
    threshold: 0.2
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animate');
        }
    });
}, observerOptions);

sections.forEach(section => {
    observer.observe(section);
});

// Animation des cartes de destination
const destinationCards = document.querySelectorAll('.destination-card');
const destinationObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animate');
            destinationObserver.unobserve(entry.target);
        }
    });
}, observerOptions);

destinationCards.forEach(card => {
    destinationObserver.observe(card);
});

// Animation des cartes culturelles
const cultureCards = document.querySelectorAll('.culture-card');
cultureCards.forEach(card => {
    observer.observe(card);
});

// Animation des cartes d'hébergement
const accommodationCards = document.querySelectorAll('.type-card');
accommodationCards.forEach(card => {
    observer.observe(card);
});

// Animation des cartes de sites patrimoniaux
const heritageCards = document.querySelectorAll('.site-card');
heritageCards.forEach(card => {
    observer.observe(card);
});

// Gestion du formulaire de réservation
const bookingForm = document.querySelector('.booking-form form');
if (bookingForm) {
    bookingForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const submitButton = bookingForm.querySelector('button[type="submit"]');
        submitButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Recherche en cours...';
        submitButton.disabled = true;

        // Simulation d'une requête de réservation
        setTimeout(() => {
            submitButton.innerHTML = 'Rechercher';
            submitButton.disabled = false;
            alert('Votre recherche a été effectuée avec succès !');
        }, 2000);
    });
}

// Animation des points sur la carte du patrimoine
const mapPoints = document.querySelectorAll('.map-point');
mapPoints.forEach(point => {
    point.addEventListener('mouseenter', () => {
        const info = point.querySelector('.point-info');
        info.style.opacity = '1';
        info.style.visibility = 'visible';
    });

    point.addEventListener('mouseleave', () => {
        const info = point.querySelector('.point-info');
        info.style.opacity = '0';
        info.style.visibility = 'hidden';
    });
});

// Gestion des images lazy loading
document.addEventListener('DOMContentLoaded', () => {
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                imageObserver.unobserve(img);
            }
        });
    });

    images.forEach(img => imageObserver.observe(img));
});

// Animation des icônes sociales
const socialLinks = document.querySelectorAll('.social-links a');
socialLinks.forEach(link => {
    link.addEventListener('mouseenter', () => {
        link.style.transform = 'translateY(-5px)';
    });

    link.addEventListener('mouseleave', () => {
        link.style.transform = 'translateY(0)';
    });
}); 