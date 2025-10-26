document.addEventListener('DOMContentLoaded', function () {
    const carousel = document.querySelector('#myCarousel');
    const carouselInner = carousel.querySelector('.carousel-inner');
    const items = carousel.querySelectorAll('.item');
    const prevButton = carousel.querySelector('.left.carousel-control');
    const nextButton = carousel.querySelector('.right.carousel-control');

    if (items.length <= 1) return;

    const firstClone = items[0].cloneNode(true);
    const lastClone = items[items.length - 1].cloneNode(true);

    firstClone.classList.add('clone');
    lastClone.classList.add('clone');

    carouselInner.appendChild(firstClone);
    carouselInner.insertBefore(lastClone, items[0]);

    const allItems = carousel.querySelectorAll('.item');
    const totalItems = allItems.length;

    let currentIndex = 1;
    let isTransitioning = false;
    const autoPlayDelay = 4000;
    let autoPlayInterval = null;

    function setInitialPosition() {
        carouselInner.style.transition = 'none';
        carouselInner.style.transform = `translateX(-${currentIndex * 100}%)`;

        setTimeout(() => {
            carouselInner.style.transition = 'transform 0.5s ease-in-out';
        }, 20);
    }

    setInitialPosition();

    function moveToSlide(index) {
        if (isTransitioning) return;
        isTransitioning = true;

        currentIndex = index;
        carouselInner.style.transform = `translateX(-${currentIndex * 100}%)`;
    }

    nextButton.addEventListener('click', (event) => {
        event.preventDefault();
        moveToSlide(currentIndex + 1);
    });

    prevButton.addEventListener('click', (event) => {
        event.preventDefault();
        moveToSlide(currentIndex - 1);
    });

    carouselInner.addEventListener('transitionend', () => {
        if (allItems[currentIndex].classList.contains('clone')) {
            carouselInner.style.transition = 'none';

            if (currentIndex === 0) {
                currentIndex = totalItems - 2;
            } else if (currentIndex === totalItems - 1) {
                currentIndex = 1;
            }

            carouselInner.style.transform = `translateX(-${currentIndex * 100}%)`;

            carouselInner.offsetHeight;
            carouselInner.style.transition = 'transform 0.5s ease-in-out';
        }

        isTransitioning = false;
    });
    function startAutoPlay() {
        if (autoPlayInterval) return;
        autoPlayInterval = setInterval(() => {
            moveToSlide(currentIndex + 1);
        }, autoPlayDelay);
    }

    function stopAutoPlay() {
        clearInterval(autoPlayInterval);
        autoPlayInterval = null;
    }

    carousel.addEventListener('mouseenter', stopAutoPlay);

    carousel.addEventListener('mouseleave', startAutoPlay);
    startAutoPlay();
});