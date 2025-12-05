<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="../style/promitionsStyle.css">
    <script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
</head>
<body>
<div class="admin-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="dashboard.jsp">
                <img src="/image/logo.png" alt="Logo Việt Sắc Đỏ">
            </a>
            <h2>Trang Admin</h2>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li class="nav-item "><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
                <li class="nav-item"><a href="product.jsp"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a></li>
                <li class="nav-item"><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a></li>
                <li class="nav-item"><a href="customers.jsp"><i class="fas fa-users"></i> Quản lý Khách hàng</a></li>
                <li class="nav-item"><a href="contact-admin.jsp"><i class="fa-regular fa-address-book"></i> Quản lý Liên hệ</a></li>
                <li class="nav-item active"><a href="promotions.html"><i class="fas fa-tags"></i> Khuyến mãi</a></li>
                <li class="nav-item">
                    <a href="../index.jsp"><i class="fas fa-sign-out-alt"></i> Trở về Trang Chủ</a>
                </li>
            </ul>
        </nav>
    </div>
    <main class="main-content">
        <header class="admin-header">
            <div class="header-actions">
                <a href="../login.jsp" class="btn-logout"><i class="fas fa-user-circle"></i> Đăng xuất</a>
            </div>
        </header>

        <div class="promotion-editor-header">
            <h2>Tạo bài viết khuyến mãi mới</h2>
        </div>
        <div class="promotion-editor-container">
            <div class="editor-main">
                <div class="form-group">
                    <label for="promo-title">Tiêu đề bài viết</label>
                    <input type="text" id="promo-title" placeholder="Ví dụ: Giảm giá sốc cuối năm 50%...">
                </div>
                <div class="form-group">
                    <label for="promo-content">Nội dung bài viết</label>
                    <textarea id="promo-content" name="promo-content">
                    </textarea>
                </div>
            </div>

            <div class="editor-sidebar">
                <div class="publish-card">
                    <h3><i class="fas fa-play-circle"></i> Hành động</h3>
                    <div class="publish-actions">
                        <button class="btn btn-draft">Lưu nháp</button>
                        <button class="btn btn-publish">Đăng bài</button>
                    </div>
                </div>

                <div class="publish-card">
                    <h3><i class="fas fa-calendar-alt"></i> Lịch hoạt động</h3>
                    <div class="form-group-sidebar">
                        <label for="promo-start-date">Ngày bắt đầu</label>
                        <input type="datetime-local" id="promo-start-date" name="promo-start-date">
                    </div>
                    <div class="form-group-sidebar">
                        <label for="promo-end-date">Ngày kết thúc</label>
                        <input type="datetime-local" id="promo-end-date" name="promo-end-date">
                    </div>
                </div>
                <div class="publish-card">
                    <h3><i class="fas fa-image"></i> Ảnh đại diện (Banner)</h3>
                    <input type="file" id="promo-image-input" accept="image/*">
                    <label for="promo-image-input" class="image-upload-box">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <p>Nhấn để tải ảnh lên</p>
                    </label>
                    <div id="image-preview-container">
                        <img src="" alt="Xem trước ảnh" id="image-preview">
                    </div>
                </div>
            </div>
        </div>
        <div class="promotion-list-section">
            <h2>Danh sách Khuyến mãi</h2>

            <table class="promo-table">
                <thead>
                <tr>
                    <th>Tiêu đề bài viết</th>
                    <th>Trạng thái</th>
                    <th>Thời gian hoạt động</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><strong>Giảm giá 50% toàn bộ cửa hàng</strong></td>
                    <td><span class="status active">Đang chạy</span></td>
                    <td class="period">
                        Bắt đầu: 10/11/2025 00:00<br>
                        Kết thúc: 20/11/2025 23:59
                    </td>
                    <td class="action-icons">
                        <a href="#" title="Sửa"><i class="fas fa-edit"></i></a>
                        <a href="#" class="delete" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><strong>Khuyến mãi tri ân 20/11</strong></td>
                    <td><span class="status expired">Hết hạn</span></td>
                    <td class="period">
                        Bắt đầu: 20/10/2025 09:00<br>
                        Kết thúc: 30/10/2025 22:00
                    </td>
                    <td class="action-icons">
                        <a href="#" title="Sửa"><i class="fas fa-edit"></i></a>
                        <a href="#" class="delete" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><strong>Flash Sale 12.12 (Bản nháp)</strong></td>
                    <td><span class="status draft">Nháp</span></td>
                    <td class="period">Chưa lên lịch</td>
                    <td class="action-icons">
                        <a href="#" title="Sửa"><i class="fas fa-edit"></i></a>
                        <a href="#" class="delete" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </main>
</div>

<script>
    // 1. Khởi tạo CKEditor 4
    CKEDITOR.replace('promo-content', {
        height: 500,
        language: 'vi',
        toolbar: [
            { name: 'document', items: [ 'Source', '-', 'Preview', 'Print' ] },
            { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
            { name: 'editing', items: [ 'Find', 'Replace', '-', 'SelectAll' ] },
            '/',
            { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat' ] },
            { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
            { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
            { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak' ] },
            '/',
            { name: 'styles', items: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
            { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
            { name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] }
        ]
    });

    // 2. Xử lý xem trước ảnh (Giữ nguyên)
    const imageInput = document.getElementById('promo-image-input');
    const imagePreview = document.getElementById('image-preview');

    imageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                // SỬA LỖI: gõ nhầm targe.result -> e.target.result
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>