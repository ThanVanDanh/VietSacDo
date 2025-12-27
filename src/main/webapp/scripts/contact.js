document.addEventListener('DOMContentLoaded', () => {

    // --- 1. CẤU HÌNH CÁC BIẾN MODAL ---
    const viewModal = document.getElementById('contact-modal');
    const deleteModal = document.getElementById('delete-modal');
    const replyModal = document.getElementById('reply-modal');

    // --- 2. XỬ LÝ NÚT: XEM CHI TIẾT ---
    const viewButtons = document.querySelectorAll('.btn-view-detail');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Lấy dữ liệu từ data-attribute trong nút bấm HTML
            const id = this.getAttribute('data-id');
            const name = this.getAttribute('data-name');
            const email = this.getAttribute('data-email');
            const date = this.getAttribute('data-date');
            const message = this.getAttribute('data-message');

            // Đổ dữ liệu vào các thẻ trong Modal
            document.getElementById('modal-id').textContent = id;
            document.getElementById('modal-name').textContent = name;
            document.getElementById('modal-email').textContent = email;
            document.getElementById('modal-date').textContent = date;
            document.getElementById('modal-message-full').textContent = message;

            // Hiển thị modal
            viewModal.style.display = 'block';
        });
    });

    // --- 3. XỬ LÝ NÚT: XÓA (quan trọng) ---
    const deleteButtons = document.querySelectorAll('.delete');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Lấy ID từ data-id
            const id = this.getAttribute('data-id');

            // Lấy tên khách hàng từ cột thứ 2 của dòng đó (để hiển thị cho chắc chắn)
            const row = this.closest('tr');
            const name = row.querySelector('td:nth-child(2)').textContent;

            // 1. Hiển thị thông tin lên màn hình xác nhận
            const displayId = document.getElementById('delete-id-display'); // (Lưu ý: Bạn cần có thẻ span id="delete-id-display" trong JSP)
            if (displayId) displayId.textContent = id;

            const displayName = document.getElementById('delete-name');
            if (displayName) displayName.textContent = name;

            // 2. QUAN TRỌNG NHẤT: Gán ID vào ô Input Ẩn của Form
            const inputHiddenId = document.getElementById('input-delete-id');
            if (inputHiddenId) {
                inputHiddenId.value = id;
            } else {
                console.error("Lỗi: Không tìm thấy thẻ input có id='input-delete-id' trong Modal Xóa!");
            }

            // Hiển thị modal
            deleteModal.style.display = 'block';
        });
    });

    // --- 4. XỬ LÝ NÚT: TRẢ LỜI EMAIL ---
    const replyButtons = document.querySelectorAll('.btn-reply-email');
    replyButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Lấy email từ data-attribute (ưu tiên) hoặc từ cột trong bảng
            let email = this.getAttribute('data-recipient-email');

            // Nếu nút không có data-email, thử tìm trong bảng
            if (!email) {
                const row = this.closest('tr');
                email = row.querySelector('td:nth-child(3)').textContent;
            }

            // Gán email vào ô nhập liệu
            document.getElementById('reply-to').value = email;

            // Hiển thị modal
            replyModal.style.display = 'block';
        });
    });

    // --- 5. XỬ LÝ ĐÓNG MODAL (Chung cho tất cả) ---

    // Hàm đóng tất cả modal
    function closeAllModals() {
        viewModal.style.display = 'none';
        deleteModal.style.display = 'none';
        replyModal.style.display = 'none';
    }

    // Gán sự kiện click cho các nút "X" (close-button)
    document.querySelectorAll('.close-button').forEach(btn => {
        btn.onclick = closeAllModals;
    });

    // Gán sự kiện cho các nút "Hủy"
    const cancelDeleteBtn = document.getElementById('cancel-delete');
    if (cancelDeleteBtn) cancelDeleteBtn.onclick = closeAllModals;

    const cancelReplyBtn = document.getElementById('cancel-reply');
    if (cancelReplyBtn) cancelReplyBtn.onclick = closeAllModals;

    // Gán sự kiện click ra ngoài vùng modal để đóng
    window.onclick = function(event) {
        if (event.target == viewModal || event.target == deleteModal || event.target == replyModal) {
            closeAllModals();
        }
    }
});