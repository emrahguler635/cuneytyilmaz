(function(){
  const pages = Array.from(document.querySelectorAll('.page'));
  const menu = document.querySelector('.menu');
  const toggle = document.querySelector('.menu__toggle');
  const navButtons = Array.from(document.querySelectorAll('[data-nav]'));

  function showPage(key){
    pages.forEach(p => p.classList.toggle('is-visible', p.id === key));
    const topBtns = Array.from(document.querySelectorAll('.menu__item'));
    topBtns.forEach(b => b.classList.toggle('is-active', b.getAttribute('data-nav') === key));
    window.scrollTo({top:0, behavior:'smooth'});
    if(menu) menu.classList.remove('is-open');
  }

  navButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const key = btn.getAttribute('data-nav');
      if(key) showPage(key);
    });
  });

  if(toggle){
    toggle.addEventListener('click', () => menu.classList.toggle('is-open'));
  }

  // Slider
  const slides = Array.from(document.querySelectorAll('.hero__slide'));
  const dots = Array.from(document.querySelectorAll('.dot'));
  let idx = 0;

  function setSlide(i){
    idx = (i + slides.length) % slides.length;
    slides.forEach((s, k) => s.classList.toggle('is-active', k === idx));
    dots.forEach((d, k) => d.classList.toggle('is-active', k === idx));
  }

  dots.forEach(d => d.addEventListener('click', () => setSlide(parseInt(d.getAttribute('data-slide'),10)||0)));
  setInterval(() => setSlide(idx+1), 5000);
})();
