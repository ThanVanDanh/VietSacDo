<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/contact-admin.css">

    <script src="${pageContext.request.contextPath}/scripts/contact.js"></script>
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
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-${sessionScope.messageType == 'success' ? 'success' : 'danger'}"
             style="padding: 10px; background: #d4edda; color: #155724; margin-bottom: 15px;">
                ${sessionScope.message}
        </div>
        <% session.removeAttribute("message"); %>
    </c:if>
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
                    <c:forEach var="c" items="${contactList}">
                        <tr>
                            <td>#${c.id}</td>
                            <td>${c.fullName}</td>
                            <td>${c.email}</td>
                            <td>${c.formattedDate}</td> <td class="excerpt-column">
                            <div style="max-width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                    ${c.messageBody}
                            </div>
                        </td>

                            <td>
                <span class="status-badge ${c.statusMessage == 'new' ? 'status-new' : ''}">
                        ${c.statusMessage != null ? c.statusMessage : 'Mới'}
                </span>
                            </td>

                            <td>
                                <button class="btn btn-sm btn-reply-email" title="Phản hồi Email"
                                        data-recipient-email="${c.email}">
                                    <i class="fas fa-reply"></i>
                                </button>

                                <button class="btn btn-sm btn-view-detail"
                                        data-id="${c.id}"
                                        data-name="${c.fullName}"
                                        data-email="${c.email}"
                                        data-date="${c.formattedDate}"
                                        data-message="${c.messageBody}">
                                    <i class="fas fa-eye"></i>
                                </button>

                                <button class="btn btn-sm delete" title="Xóa" data-id="${c.id}">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
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
        <p>Bạn có chắc muốn xóa tin nhắn của: <strong id="delete-name"></strong>?</p>
        <p>ID tin nhắn: <strong id="delete-id-display"></strong></p>

        <form action="${pageContext.request.contextPath}/admin/contact-delete" method="post">
            <input type="hidden" name="id" id="input-delete-id">

            <div class="modal-actions">
                <button type="button" class="btn btn-sm status-complete" id="cancel-delete">Hủy</button>
                <button type="submit" class="btn btn-sm status-cancel">Xác nhận Xóa</button>
            </div>
        </form>
    </div>
</div>
<div id="reply-modal" class="modal reply-modal">
    <div class="modal-content">
        <form id="reply-form" action="${pageContext.request.contextPath}/admin/contact-reply" method="post">
            <div class="form-group">
                <label>Đến:</label>
                <input type="text" name="email" id="reply-to" class="form-control" readonly>
            </div>

            <input type="hidden" name="subject" value="Re: Hỗ trợ Việt Sắc Đỏ">

            <div class="form-group">
                <label>Nội dung:</label>
                <textarea name="content" id="reply-body" class="form-control" required></textarea>
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