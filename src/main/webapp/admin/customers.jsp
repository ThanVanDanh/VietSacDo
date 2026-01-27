<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý khách hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="../style/customers.css">
    <link rel="stylesheet" href="../style/charts.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../scripts/admin/admin.js"></script>
    <script>
        // App context path for AJAX endpoints (set by server)
        var APP_CTX = '${pageContext.request.contextPath}';
    </script>
    <script src="../scripts/admin.js"></script>
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
                <li class="nav-item active"><a href="customers.html"><i class="fas fa-users"></i> Quản lý Khách hàng</a></li>
                <li class="nav-item"><a href="contact-admin.jsp"><i class="fa-regular fa-address-book"></i> Quản lý Liên hệ</a></li>
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
        <h1>QUẢN LÝ KHÁCH HÀNG</h1>
        <section class="overview-cards-customer">
            <div class="stat-card-customer">
                <div class="card-icon" style="background-color: #e0f7fa;">
                    <i class="fas fa-users" style="color: #00796b;"></i>
                </div>
                <div class="card-info">
                    <h4>Tổng số khách hàng</h4>
                    <p>${totalCustomers}</p>
                </div>
            </div>
            <div class="stat-card-customer">
                <div class="card-icon" style="background-color: #e8f5e9;">
                    <i class="fas fa-user-plus" style="color: #388e3c;"></i>
                </div>
                <div class="card-info">
                    <h4>Khách mới trong tuần</h4>
                    <p>${newCustomersThisWeek}</p>
                </div>
            </div>
        </section>
        <section class="chart-container">
            <h3>Top khách hàng theo số đơn hàng</h3>
            <canvas id="customerOrdersChart"></canvas>
        </section>
        <section class="table-container">
            <div class="table-toolbar">
                <div class="filters">
                    <select name="filter-status" id="filter-status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="active">Hoạt động</option>
                        <option value="blocked">Bị khóa</option>
                    </select>
                    <input type="text" placeholder="Tìm theo tên hoặc email..." class="table-search">
                </div>
                <button class="btn-csv"><i class="fas fa-file-csv"></i> Xuất CSV</button>
            </div>
            <table class="table-general customer-table">
                <thead>
                <tr>
                    <th>Tên</th>
                    <th>Email</th>
                    <th>Điện thoại</th>
                    <th>Ngày đăng ký</th>
                    <th>Địa chỉ</th>
                    <th>Số đơn hàng</th>
                    <th>Tài khoản</th>
                    <th>Trạng thái tài khoản</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>${user.createdAt}</td>
                        <td>${user.authProvider}</td>
                        <td>0</td>
                        <td>
                            <form method="post" action="update-role" style="margin:0;">
                                <input type="hidden" name="userId" value="${user.id}" />
                                <select name="role" onchange="this.form.submit()">
                                    <option value="user" ${user.role eq 'user' ? 'selected' : ''}>User</option>
                                    <option value="admin" ${user.role eq 'admin' ? 'selected' : ''}>Admin</option>
                                </select>
                            </form>
                        </td>
                        <td>
                            <span class="status-badge status-active" style="${user.status eq 'active' ? '' : 'display:none;'}">Hoạt động</span>
                            <span class="status-badge status-blocked" style="${user.status eq 'banned' ? '' : 'display:none;'}">Bị khóa</span>
                            <span class="status-badge status-inactive" style="${user.status eq 'inactive' ? '' : 'display:none;'}">Chưa kích hoạt</span>
                        </td>
                        <td class="table-actions">
                            <button class="btn-action btn-view"
                                    title="Xem"
                                    data-fullname="${user.fullName}"
                                    data-email="${user.email}"
                                    data-phone="${user.phone}"
                                    data-address="${user.authProvider}"
                                    data-createdat="${user.createdAt}"
                                    data-status="${user.status}">
                                <i class="fas fa-eye"></i>
                            </button>

                            <button class="btn-action btn-block"
                                    title="Khóa"
                                    data-id="${user.id}"
                                    data-name="${user.fullName}"
                                    style="${user.status eq 'banned' ? 'display: none;' : ''}">
                                <i class="fas fa-ban"></i>
                            </button>

                            <button class="btn-action btn-unlock"
                                    title="Mở khóa"
                                    data-id="${user.id}"
                                    data-name="${user.fullName}"  style="${user.status eq 'banned' ? '' : 'display: none;'}">
                                <i class="fas fa-check-circle"></i>
                            </button>

                            <button class="btn-action btn-delete"
                                    title="Xóa"
                                    data-id="${user.id}"
                                    data-name="${user.fullName}">
                                <i class="fas fa-trash-alt"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr class="empty-state-row">
                        <td colspan="7" style="text-align: center; padding: 40px; color: #666;">Hiện tại không có khách hàng nào.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <div class="pagination">
                <a href="#">Trước</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">Sau</a>
            </div>
        </section>

    </main>
</div>
<div id="customer-modal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h2>Chi tiết khách hàng: <span id="modal-fullName"></span></h2>
        <div class="modal-body">
            <div class="modal-tabs">
                <button class="tab-link active" data-tab="tab-info">Thông tin cá nhân</button>
                <button class="tab-link" data-tab="tab-history">Lịch sử đơn hàng</button>
                <button class="tab-link" data-tab="tab-log">Hoạt động tài khoản</button>
            </div>
            <div id="tab-info" class="tab-content active">
                <h3>Thông tin cá nhân</h3>
                <p><strong>Email:</strong> <span id="modal-email"></span></p>
                <p><strong>Điện thoại:</strong> <span id="modal-phone"></span></p>
                <p><strong>Địa chỉ:</strong> <span id="modal-address"></span></p>
                <p><strong>Ngày đăng ký:</strong> <span id="modal-createdAt"></span></p>
                <p><strong>Trạng thái tài khoản:</strong> <span id="modal-status"></span></p>
            </div>
                    <div id="tab-history" class="tab-content">
                        <h3>Lịch sử đơn hàng (5)</h3>
                        <ul>
                            <li>Đơn hàng #1052 _ 2025-03-28 _ <strong class="status-complete">Hoàn tất</strong>
                                <p>Áo dài truyền thống Phúc Hương - <strong>880,000₫</strong></p>
                            </li>
                            <li>Đơn hàng #1044 _ 2024-12-26 _ <strong class="status-cancel">Đã hủy</strong>
                                <p>Hoa tai NK-185 hoa hồng phối trái mâm xôi rũ - <strong>80,750₫</strong></p>
                            </li>
                            <li>Đơn hàng #1032 _ 2024-11-15 _ <strong class="status-complete">Hoàn tất</strong>
                                <p>Vòng tay VO-092 Phụng Nghi đỏ hoa xanh trắng vân vàng - 10mm - <strong>153,000₫</strong></p>
                            </li>
                            <li>Đơn hàng #1020 _ 2024-11-05 _ <strong class="status-complete">Hoàn tất</strong>
                                <p>Mấn Trơn Hai Sợi Phối Dây Hạt Ngọc (Hạt to) - <strong>212,500₫</strong></p>
                            </li>
                            <li>Đơn hàng #1003 _ 2024-10-26 _ <strong class="status-cancel">Đã hủy</strong>
                                <p>Guốc gỗ Đế cao bọc vải Phụng Lan - Đỏ - <strong>212,500₫</strong></p>
                            </li>
                        </ul>
                    </div>
                    <div id="tab-log" class="tab-content">
                        <h3>Hoạt động tài khoản</h3>
                        <ul>
                            <li>2025-03-28 20:00: Đặt đơn hàng #1052</li>
                            <li>2024-12-26 22:20: Đặt đơn hàng #1044</li>
                            <li>2024-11-15 10:40: Đặt đơn hàng #1032</li>
                            <li>2024-11-05 08:30: Đặt đơn hàng #1020</li>
                            <li>2024-10-26 15:20: Đặt đơn hàng #1003</li>
                            <li>2024-10-25 09:15: Tạo tài khoản</li>
                        </ul>
                    </div>
                </div>
    </div>
</div>
<div id="delete-confirm-modal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close-modal">&times;</span>
        <h2>Xác nhận xóa</h2>
        <p>Bạn có chắc chắn muốn xóa khách hàng <strong id="customer-name-to-delete">${user.fullName}</strong> không?</p>
        <p>Hành động này không thể hoàn tác.</p>

        <div class="confirm-actions">
            <button id="btn-cancel-delete" class="btn-secondary">Hủy bỏ</button>
            <button id="btn-confirm-delete" class="btn-danger">Xác nhận Xóa</button>
        </div>
    </div>
</div>
<div id="status-confirm-modal" class="modal" style="display: none;">
    <div class="modal-content">
        <span class="close-modal">&times;</span>

        <h2 id="modal-status-title">Xác nhận thay đổi</h2>

        <p>Bạn có chắc chắn muốn <strong id="modal-action-text" style="color: #d9534f;">...</strong>
            tài khoản của khách hàng <strong id="modal-customer-name">...</strong> không?</p>

        <div class="confirm-actions">
            <button id="btn-cancel-status" class="btn-secondary">Hủy bỏ</button>
            <button id="btn-confirm-status" class="btn-danger">Xác nhận</button>
        </div>
    </div>
</div>
</body>
</html>