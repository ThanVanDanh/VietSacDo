<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../style/dashboard.css">
    <link rel="stylesheet" href="../style/contact.css">
    <script src="../scripts/contact.js"></script>
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
                <li class="nav-item active"><a href="contact-admin.html"><i class="fa-regular fa-address-book"></i> Quản lý Liên hệ</a></li>
                <li class="nav-item"><a href="promotions.jsp"><i class="fas fa-tags"></i> Khuyến mãi</a></li>
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
        <div class="dashboard-recent-activity">
            <div class="recent-panel" style="grid-column: 1 / -1;">
                <h1>Quản lý Liên hệ</h1>

                <table class="recent-table">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>Tên Khách hàng</th>
                        <th>Email</th>
                        <th>Ngày gửi</th>
                        <th>Trích đoạn</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>C-005</td>
                        <td>Nguyễn Văn A</td>
                        <td>a.nguyen@example.com</td>
                        <td>2025-11-20 10:30</td>
                        <td class="excerpt-column">Sản phẩm X có đang giảm giá không? Tôi muốn biết các voucher giảm giá. </td>
                        <td><span class="status-badge">Mới</span></td>
                        <td>
                            <button class="btn btn-sm btn-reply-email" title="Phản hồi Email"
                                    data-recipient-email="a.nguyen@example.com">
                                <i class="fas fa-reply"></i>
                            </button>
                            <button class="btn btn-sm xemchitiet btn-view-detail" title="Xem chi tiết"
                                    data-full-message="Sản phẩm X có đang giảm giá không? Tôi muốn biết các voucher giảm giá mà cửa hàng đang áp dụng cho đơn hàng lớn.">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm delete" title="Xóa">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <td>C-004</td>
                        <td>Trần Thị B</td>
                        <td>b.tran@example.com</td>
                        <td>2025-11-19 15:45</td>
                        <td class="excerpt-column">Tôi đã nhận được đơn hàng rồi, nhưng có vấn đề về mặt hàng này.</td>
                        <td><span class="status-badge ">Đã trả lời</span></td>
                        <td>
                            <button class="btn btn-sm btn-reply-email" title="Phản hồi Email"
                                    data-recipient-email="b.tran@example.com">
                                <i class="fas fa-reply"></i>
                            </button>
                            <button class="btn btn-sm xemchitiet btn-view-detail" title="Xem chi tiết"
                                    data-full-message="Tôi đã nhận được đơn hàng rồi, nhưng có vấn đề về mặt hàng này. Sản phẩm bị trầy xước nhẹ. Vui lòng hỗ trợ đổi trả.">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm delete"  title="Xóa">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>

                    <tr>
                        <td>C-003</td>
                        <td>Lê Văn C</td>
                        <td>c.le@example.com</td>
                        <td>2025-11-19 09:00</td>
                        <td class="excerpt-column">Tôi cần tư vấn về chính sách đổi trả hàng</td>
                        <td><span class="status-badge ">Mới</span></td>
                        <td>
                            <button class="btn btn-sm btn-reply-email" title="Phản hồi Email"
                                    data-recipient-email="c.le@example.com">
                                <i class="fas fa-reply"></i>
                            </button>
                            <button class="btn btn-sm xemchitiet btn-view-detail" title="Xem chi tiết"
                                    data-full-message="Tôi cần tư vấn chi tiết về chính sách đổi trả hàng, đặc biệt là thời gian quy định và thủ tục cần thiết cho mặt hàng dễ vỡ.">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn btn-sm delete"  title="Xóa">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
<div id="contact-modal" class="modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h3>Chi tiết Tin nhắn Liên hệ</h3>
        <p><strong>ID:</strong> <span id="modal-id"></span></p>
        <p><strong>Tên Khách hàng:</strong> <span id="modal-name"></span></p>
        <p><strong>Email:</strong> <span id="modal-email"></span></p>
        <p><strong>Ngày gửi:</strong> <span id="modal-date"></span></p>
        <hr>
        <div class="message-body">
            <h4>Nội dung đầy đủ:</h4>
            <p id="modal-message-full"></p>
        </div>
    </div>
</div>
<div id="delete-modal" class="modal delete-modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h3>Xác nhận Xóa Tin nhắn</h3>
        <p>Bạn có chắc chắn muốn xóa tin nhắn liên hệ của <strong id="delete-name"></strong> (ID: <strong id="delete-id"></strong>) không?</p>
        <div class="modal-actions">
            <button class="btn btn-sm status-complete" id="cancel-delete">Hủy</button>
            <button class="btn btn-sm status-cancel" id="confirm-delete">Xác nhận Xóa</button>
        </div>
    </div>
</div>
<div id="reply-modal" class="modal reply-modal">
    <div class="modal-content">
        <span class="close-button">&times;</span>
        <h3>Phản hồi Email cho Khách hàng</h3>
        <form id="reply-form">
            <div class="form-group">
                <label for="reply-to">Đến:</label>
                <input type="text" id="reply-to" class="form-control" readonly>
            </div>
            <div class="form-group">
                <label for="reply-subject">Tiêu đề:</label>
                <input type="text" id="reply-subject" class="form-control" value="Re: Yêu cầu hỗ trợ từ Việt Sắc Đỏ">
            </div>
            <div class="form-group">
                <label for="reply-body">Nội dung:</label>
                <textarea id="reply-body" class="form-control" rows="10" placeholder="Viết nội dung phản hồi tại đây..."></textarea>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-sm status-cancel" id="cancel-reply">Hủy</button>
                <button type="submit" class="btn btn-sm status-shipping">Gửi Email</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>