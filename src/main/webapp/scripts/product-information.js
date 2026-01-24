let MAX_QTY = 1;
function updateVariant(element, sizeName) {
    // 1. Active size button
    document.querySelectorAll('.size-btn')
        .forEach(btn => btn.classList.remove('active'));
    element.classList.add('active');

    const sizeDisplay = document.getElementById('selected-size');
    if (sizeDisplay) sizeDisplay.innerText = sizeName;
    const sizeInput = document.getElementById('selectedVariantSize');
    if (sizeInput) {
        sizeInput.value = sizeName;
    }

    const price = element.getAttribute('data-price');
    const priceDisplay = document.querySelector('.current-price');
    if (priceDisplay && price) {
        priceDisplay.innerText = parseFloat(price).toLocaleString('vi-VN') + '₫';
    }

    const priceInput = document.getElementById('selectedVariantPrice');
    if (priceInput && price) {
        priceInput.value = price;
    }

    const sku = element.getAttribute('data-sku');
    const skuDisplay = document.getElementById('sku-value');
    if (skuDisplay && sku) {
        skuDisplay.innerText = sku;
    }

    const skuInput = document.getElementById('selectedVariantSku');
    if (skuInput && sku) {
        skuInput.value = sku;
    }
    // ----------------------------------------------------------------

    // 4. Cập nhật Color
    const color = element.dataset.color;
    const colorEl = document.getElementById('selected-color');
    if (colorEl && color) colorEl.innerText = color;

    // 5. Cập nhật Stock
    MAX_QTY = parseInt(element.dataset.stock);
    if (isNaN(MAX_QTY)) MAX_QTY = 0;
    updateStockUI(MAX_QTY);

    // Reset quantity nếu vượt stock
    const qtyInput = document.getElementById('product-quantity');
    if (MAX_QTY === 0) {
        qtyInput.value = 1;
    } else if (parseInt(qtyInput.value) > MAX_QTY) {
        qtyInput.value = MAX_QTY;
    }
}

function updateStockUI(stock) {
    const addToCartBtn = document.getElementById('them-vao-gio-hang');
    const buyNowBtn = document.getElementById('mua-ngay');
    const outOfStockBtn = document.getElementById('het-hang');
    const qtyInput = document.getElementById('product-quantity');
    const quality = document.getElementById('quality');

    if (stock > 0) {
        addToCartBtn.style.display = 'inline-block';
        buyNowBtn.style.display = 'inline-block';
        outOfStockBtn.style.display = 'none';
        quality.style.display ='inline-block';
    } else {
        addToCartBtn.style.display = 'none';
        buyNowBtn.style.display = 'none';
        outOfStockBtn.style.display = 'inline-block';
        quality.style.display ='none';
        qtyInput.value = 1;
    }
}



document.addEventListener('DOMContentLoaded', function() {
    const qtyInput = document.getElementById('product-quantity');
    const btnMinus = document.querySelector('.qty-minus');
    const btnPlus = document.querySelector('.qty-plus');

    if (!qtyInput || !btnMinus || !btnPlus) return;

    const MIN_QTY = 1;

    btnPlus.addEventListener('click', () => {
        let qty = parseInt(qtyInput.value) || MIN_QTY;
        if (qty < MAX_QTY) {
            qtyInput.value = qty + 1;
        }
    });

    btnMinus.addEventListener('click', () => {
        let qty = parseInt(qtyInput.value) || MIN_QTY;
        if (qty > MIN_QTY) {
            qtyInput.value = qty - 1;
        }
    });

    const mainImage = document.getElementById('mainImg');
    const thumbnails = document.querySelectorAll('.thumbnail');
    const prevBtn = document.querySelector('.fa-chevron-left');
    const nextBtn = document.querySelector('.fa-chevron-right');
    const defaultActiveBtn = document.querySelector('.size-btn.active') || document.querySelector('.size-btn');

    if (defaultActiveBtn) {
        let stock = parseInt(defaultActiveBtn.getAttribute('data-stock'));
        if (isNaN(stock)) stock = 0;
        MAX_QTY = stock;
        updateStockUI(MAX_QTY);

        if (!document.querySelector('.size-btn.active')) {
            defaultActiveBtn.click();
        }
    }

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

    const btnAdd = document.getElementById('them-vao-gio-hang');
    const popup = document.getElementById('success-add-shopping');
    const btnClose = document.getElementById('close-success-popup');

    // if (btnAdd && popup) {
    //     btnAdd.onclick = (e) => {
    //         e.preventDefault();
    //         popup.classList.add('active');
    //     };
    // }

    if (btnClose) btnClose.onclick = () => popup.classList.remove('active');

    window.addEventListener('click', (e) => {
        if (e.target === popup) popup.classList.remove('active');
    });
});