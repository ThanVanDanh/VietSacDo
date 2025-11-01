// Đợi cho toàn bộ nội dung HTML được tải xong
document.addEventListener('DOMContentLoaded', function() {
    // 1. Lấy tất cả các phần tử cần thiết
    const mainImage = document.querySelector('.main-image');
    const thumbnails = document.querySelectorAll('.thumbnail');
    const prevButton = document.querySelector('.fa-chevron-left');
    const nextButton = document.querySelector('.fa-chevron-right');

    // Tạo một mảng chứa đường dẫn ảnh lớn (từ các thumbnail)
    // Lưu ý: Cần đảm bảo tất cả các thumbnail đều có đường dẫn ảnh hợp lệ
    const imagePaths = Array.from(thumbnails).map(thumb => thumb.getAttribute('src'));
    let currentImageIndex = 0;

    // --- CHỨC NĂNG 1: Xử lý khi nhấn vào Thumbnail ---
    thumbnails.forEach((thumbnail, index) => {
        thumbnail.addEventListener('click', function() {
            // Cập nhật chỉ mục hiện tại
            currentImageIndex = index;
            // Thay đổi ảnh lớn
            updateMainImage();
        });
    });

    // --- CHỨC NĂNG 2: Xử lý khi nhấn nút Điều hướng (Trái/Phải) ---
    if (prevButton) {
        prevButton.addEventListener('click', function(e) {
            e.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ <a>
            // Quay lại ảnh trước, nếu đang ở ảnh đầu tiên thì chuyển đến ảnh cuối cùng
            currentImageIndex = (currentImageIndex - 1 + imagePaths.length) % imagePaths.length;
            updateMainImage();
        });
    }

    if (nextButton) {
        nextButton.addEventListener('click', function(e) {
            e.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ <a>
            // Chuyển đến ảnh kế tiếp, nếu đang ở ảnh cuối cùng thì chuyển về ảnh đầu tiên
            currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
            updateMainImage();
        });
    }

    // --- CHỨC NĂNG CHUNG: Hàm cập nhật ảnh chính và trạng thái thumbnail ---
    function updateMainImage() {
        // Đặt đường dẫn ảnh lớn
        mainImage.src = imagePaths[currentImageIndex];

        // Cập nhật lớp 'active' cho thumbnail
        thumbnails.forEach((thumb, index) => {
            if (index === currentImageIndex) {
                thumb.classList.add('active');
            } else {
                thumb.classList.remove('active');
            }
        });
    }

    // Khởi tạo ảnh chính khi trang tải
    // Giúp đảm bảo ảnh lớn luôn khớp với thumbnail 'active' ban đầu
    updateMainImage();
});