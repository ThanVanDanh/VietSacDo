document.addEventListener('DOMContentLoaded', () => {
    const viewModal = document.getElementById('contact-modal');
    const viewCloseButton = viewModal.querySelector('.close-button');
    const deleteModal = document.getElementById('delete-modal');
    const confirmDeleteButton = document.getElementById('confirm-delete');
    const cancelDeleteButton = document.getElementById('cancel-delete');
    const deleteCloseButton = deleteModal.querySelector('.close-button');
    const replyModal = document.getElementById('reply-modal');
    const replyCloseButton = replyModal.querySelector('.close-button');
    const cancelReplyButton = document.getElementById('cancel-reply');
    const replyForm = document.getElementById('reply-form');
    let currentDeleteRow = null; // Biến lưu trữ hàng cần xóa
    document.querySelectorAll('.btn-view-detail').forEach(button => {
        button.addEventListener('click', function() {
            const row = this.closest('tr');
            const id = row.cells[0].textContent.trim();
            const name = row.cells[1].textContent.trim();
            const email = row.cells[2].textContent.trim();
            const date = row.cells[3].textContent.trim();
            const fullMessage = this.getAttribute('data-full-message');

            document.getElementById('modal-id').textContent = id;
            document.getElementById('modal-name').textContent = name;
            document.getElementById('modal-email').textContent = email;
            document.getElementById('modal-date').textContent = date;
            document.getElementById('modal-message-full').textContent = fullMessage;

            viewModal.style.display = 'block';
        });
    });
    viewCloseButton.onclick = function() {
        viewModal.style.display = 'none';
    }
    document.querySelectorAll('.delete').forEach(button => {
        button.addEventListener('click', function() {
            currentDeleteRow = this.closest('tr');
            const id = currentDeleteRow.cells[0].textContent.trim();
            const name = currentDeleteRow.cells[1].textContent.trim();

            document.getElementById('delete-id').textContent = id;
            document.getElementById('delete-name').textContent = name;

            deleteModal.style.display = 'block';
        });
    });

    confirmDeleteButton.onclick = function() {
        if (currentDeleteRow) {
            currentDeleteRow.remove();
            currentDeleteRow = null;
        }
        deleteModal.style.display = 'none';
    }

    cancelDeleteButton.onclick = function() {
        deleteModal.style.display = 'none';
    }
    deleteCloseButton.onclick = function() {
        deleteModal.style.display = 'none';
    }
    window.onclick = function(event) {
        if (event.target == viewModal) {
            viewModal.style.display = 'none';
        }
        if (event.target == deleteModal) {
            deleteModal.style.display = 'none';
        }
    }
    document.querySelectorAll('.btn-reply-email').forEach(button => {
        button.addEventListener('click', function() {
            const recipientEmail = this.getAttribute('data-recipient-email');

            // Điền thông tin người nhận vào form
            document.getElementById('reply-to').value = `${recipientEmail}`;

            // Hiển thị Modal Phản hồi
            replyModal.style.display = 'block';
        });
    });

// Đóng Modal Phản hồi khi nhấn nút X hoặc Hủy
    replyCloseButton.onclick = function() {
        replyModal.style.display = 'none';
        replyForm.reset(); // Xóa nội dung form khi đóng
    }
    cancelReplyButton.onclick = function() {
        replyModal.style.display = 'none';
        replyForm.reset(); // Xóa nội dung form khi đóng
    }

// Xử lý sự kiện gửi form (DEMO)
    replyForm.addEventListener('submit', function(e) {
        e.preventDefault();

        const recipient = document.getElementById('reply-to').value;
        const subject = document.getElementById('reply-subject').value;
        const body = document.getElementById('reply-body').value;

        if (body.trim() === "") {
            alert("Nội dung email không được để trống!");
            return;
        }

        // THỰC TẾ: GỌI AJAX/FETCH TỚI SERVER ĐỂ XỬ LÝ GỬI EMAIL
        console.log(`Đang gửi email tới: ${recipient} với tiêu đề: ${subject}`);

        alert(`Đã mô phỏng gửi email thành công tới ${recipient}!`);

        replyModal.style.display = 'none';
        replyForm.reset();
    });

// Bổ sung vào hàm window.onclick hiện có để đóng Modal Phản hồi
    window.onclick = function(event) {
        // ... code cũ cho viewModal và deleteModal ...
        if (event.target == replyModal) {
            replyModal.style.display = 'none';
            replyForm.reset();
        }
    }
});