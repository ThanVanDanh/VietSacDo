function updateVariant(element, sizeName) {
    // Active size
    document.querySelectorAll('.size-btn')
        .forEach(btn => btn.classList.remove('active'));
    element.classList.add('active');

    const sizeDisplay = document.getElementById('selected-size');
    if (sizeDisplay) sizeDisplay.innerText = sizeName;

    //price
    const price = element.getAttribute('data-price');
    const priceDisplay = document.querySelector('.current-price');
    if (priceDisplay && price) {
        priceDisplay.innerText =
            parseFloat(price).toLocaleString('vi-VN') + '₫';
    }
    // sku
    const sku = element.getAttribute('data-sku');
    const skuDisplay = document.getElementById('sku-value');
    if (skuDisplay && sku) {
        skuDisplay.innerText = sku;
    }
}


document.addEventListener('DOMContentLoaded', function() {

    const mainImage = document.getElementById('mainImg');
    const thumbnails = document.querySelectorAll('.thumbnail');
    const prevBtn = document.querySelector('.fa-chevron-left');
    const nextBtn = document.querySelector('.fa-chevron-right');

    if (mainImage && thumbnails.length > 0) {
        const imagePaths = Array.from(thumbnails).map(thumb => thumb.src);
        let currentIndex = 0;

        const changeImage = (index) => {
            currentIndex = index;
            mainImage.src = imagePaths[currentIndex];
            thumbnails.forEach((t, i) => t.classList.toggle('active', i === currentIndex));
        };

        thumbnails.forEach((thumb, i) => {
            thumb.addEventListener('click', () => changeImage(i));
        });

        prevBtn?.parentElement.addEventListener('click', (e) => {
            e.preventDefault();
            currentIndex = (currentIndex - 1 + imagePaths.length) % imagePaths.length;
            changeImage(currentIndex);
        });

        nextBtn?.parentElement.addEventListener('click', (e) => {
            e.preventDefault();
            currentIndex = (currentIndex + 1) % imagePaths.length;
            changeImage(currentIndex);
        });
    }

    // --- XỬ LÝ POPUP GIỎ HÀNG ---
    const btnAdd = document.getElementById('them-vao-gio-hang');
    const popup = document.getElementById('success-add-shopping');
    const btnClose = document.getElementById('close-success-popup');

    if (btnAdd && popup) {
        btnAdd.onclick = (e) => {
            e.preventDefault();
            popup.classList.add('active');
        };
    }

    if (btnClose) btnClose.onclick = () => popup.classList.remove('active');

    window.addEventListener('click', (e) => {
        if (e.target === popup) popup.classList.remove('active');
    });
});