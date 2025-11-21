document.addEventListener('DOMContentLoaded', function() {
    const mainImage = document.querySelector('.main-image');
    const thumbnails = document.querySelectorAll('.thumbnail');
    const prevButton = document.querySelector('.fa-chevron-left');
    const nextButton = document.querySelector('.fa-chevron-right');

    const imagePaths = Array.from(thumbnails).map(thumb => thumb.getAttribute('src'));
    let currentImageIndex = 0;

    thumbnails.forEach((thumbnail, index) => {
        thumbnail.addEventListener('click', function() {
            currentImageIndex = index;
            updateMainImage();
        });
    });

    // --- CHỨC NĂNG 2: Xử lý khi nhấn nút Điều hướng (Trái/Phải) ---
    if (prevButton) {
        prevButton.addEventListener('click', function(e) {
            e.preventDefault();
            currentImageIndex = (currentImageIndex - 1 + imagePaths.length) % imagePaths.length;
            updateMainImage();
        });
    }

    if (nextButton) {
        nextButton.addEventListener('click', function(e) {
            e.preventDefault();
            currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
            updateMainImage();
        });
    }

    // --- CHỨC NĂNG CHUNG: Hàm cập nhật ảnh chính và trạng thái thumbnail ---
    function updateMainImage() {
        mainImage.src = imagePaths[currentImageIndex];

        thumbnails.forEach((thumb, index) => {
            if (index === currentImageIndex) {
                thumb.classList.add('active');
            } else {
                thumb.classList.remove('active');
            }
        });
    }
    updateMainImage();
});
document.addEventListener('DOMContentLoaded', () => {

    const btnAdd  =document.getElementById('them-vao-gio-hang');
    const popup = document.getElementById('success-add-shopping');
    const btnClose = document.getElementById('close-success-popup');
    if (btnAdd && popup) {
        btnAdd.onclick = (e) => {
            e.preventDefault();
            popup.classList.add('active');
        };
    }
    if (btnClose) {
        btnClose.onclick = () => {
            popup.classList.remove('active');
        };
    }
    if (popup) {
        popup.onclick = (e) => {
            if (e.target === popup) {
                popup.classList.remove('active');
            }
        };
    }
});
document.addEventListener('DOMContentLoaded', () => {
    const buttuonSize = document.querySelectorAll(".size-btn")
    buttuonSize.forEach(button => {
        button.addEventListener('click', function() {
            const buttonActive = document.querySelector('.size-btn.active');
            if (buttonActive) {
                buttonActive.classList.remove('active');
            }
            this.classList.add('active');
        });
    });
});