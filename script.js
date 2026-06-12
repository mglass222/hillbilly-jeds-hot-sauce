document.getElementById('year').textContent = new Date().getFullYear();

// Mobile nav toggle
const navToggle = document.querySelector('.nav-toggle');

function closeNav() {
  document.body.classList.remove('nav-open');
  navToggle.setAttribute('aria-expanded', 'false');
}

navToggle.addEventListener('click', () => {
  const open = document.body.classList.toggle('nav-open');
  navToggle.setAttribute('aria-expanded', open);
});
document.querySelectorAll('.nav-links a').forEach(link => {
  link.addEventListener('click', closeNav);
});
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape' && document.body.classList.contains('nav-open')) {
    closeNav();
    navToggle.focus();
  }
});
document.addEventListener('click', (e) => {
  if (document.body.classList.contains('nav-open') && !e.target.closest('.site-header')) {
    closeNav();
  }
});

// Gentle reveal on scroll (progressive enhancement — content is visible without JS)
const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
if (!prefersReduced && 'IntersectionObserver' in window) {
  document.body.classList.add('js-anim');
  const revealTargets = document.querySelectorAll('.product-card, .review, .story-inner, .feature, .bundle');
  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } });
  }, { threshold: 0.12, rootMargin: '0px 0px -5% 0px' });
  revealTargets.forEach(t => io.observe(t));
}

document.querySelectorAll('[data-checkout-url]').forEach(button => {
  const checkoutUrl = button.dataset.checkoutUrl;
  if (checkoutUrl && checkoutUrl.startsWith('https://')) {
    button.href = checkoutUrl;
    button.target = '_blank';
    button.rel = 'noopener';
    return;
  }

  // No preventDefault: after the alert, the href="#contact" fallback
  // still navigates so the click isn't a dead end.
  button.addEventListener('click', () => {
    alert("Checkout isn't live yet. This prototype is ready for Square Checkout Links when the store is ready.");
  });
});
