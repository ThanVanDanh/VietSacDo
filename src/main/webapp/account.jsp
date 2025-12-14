<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việt Sắc Đỏ - Thông tin</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/auth.css">
    <script src="scripts/auth.js"></script>
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/breadcrumb.css">
    <link rel="stylesheet" href="style/aodai.css">
    <script src="scripts/home.js"></script>
    <link rel="stylesheet" href="style/account.css">
</head>
<body>
<div class="search-overlay-container" id="searchOverlay">

    <div class="search-overlay-header">
        <div class="logo">
            <a href="index.jsp">
                <img src="image/logo.png" alt="Logo Việt Sắc Đỏ">
            </a>
        </div>

        <form class="search-overlay-form">
            <input type="text" id="searchInput" placeholder="áo dài truyền thống, quần áo dài, vòng tay...">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="icons">
            <div class="user-menu">
                <a><i class="fa-regular fa-user"></i></a>
                <ul class="user">
                    <li><a href="login.jsp">Đăng nhập</a></li>
                    <li><a href="signup.jsp">Đăng ký</a></li>
                </ul>
            </div>
            <div class="mini-cart-menu">
                <a href="giohang.jsp" title="Giỏ hàng">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="mini-count_item count_item_pr">3</span>
                </a>
                <div class="mini-cart-content">
                    <div class="mini-empty-cart">
                        <p>Chưa có sản phẩm trong giỏ hàng</p>
                    </div>
                    <ul class="mini-cart-items-list">
                        <li> <img src="image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân">
                            <div class="mini-item-info">
                                <a href="product-information.jsp" class="mini-item-name">Áo dài truyền thống Quỳnh Hân</a>
                                <span class="mini-item-meta">Size A / Quỳnh Hân</span>
                                <span class="mini-item-price">711,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li> <img src="image/truyenthong3.png" alt="Áo dài truyền thống Phúc Hương">
                            <div class="mini-item-info">
                                <a href="product-information.jsp" class="mini-item-name">Áo dài truyền thống Phúc Hương</a>
                                <span class="mini-item-meta">Size A / Phúc Hương</span>
                                <span class="mini-item-price">880,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li> <img src="image/truyenthong4.png" alt="Áo dài truyền thống Quỳnh Châu">
                            <div class="mini-item-info">
                                <a href="product-information.jsp" class="mini-item-name">Áo dài truyền thống Quỳnh Châu</a>
                                <span class="mini-item-meta">Size A / Quỳnh Châu</span>
                                <span class="mini-item-price">790,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                    </ul>
                    <div class="mini-cart-footer">
                        <div class="mini-cart-total">
                            <span >Tổng tiền tạm tính: <strong class="mini-total-price">2,281,000₫</strong></span>
                        </div>
                        <a href="giohang.jsp" class="btn-pay">Tiến hành thanh toán</a>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="search-overlay-close-area" id="searchCloseArea"></div>
</div>
<jsp:include page="header.jsp" />
<div class="breadcrumb-container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
           <li class="breadcrumb-item active" aria-current="page">Tài khoản</li>
        </ol>
    </nav>
</div>
<main>
    <div class="account-container">
        <nav class="account-nav">
            <h2>TRANG TÀI KHOẢN</h2>
            <p>Xin chào, Phùng Thư</p>
            <ul>
                <li>
                    <a class="active tab-btn" id="nav-details">Thông tin tài khoản</a>
                </li>
                <li>
                    <a class="tab-btn" id="nav-addresses">Sổ địa chỉ (1)</a>
                </li>
                <li>
                    <a href="login.jsp">Đăng xuất</a>
                </li>
            </ul>
        </nav>
        <div class="account-content">
            <div class="content-section" id="account-details">
                <h3>TÀI KHOẢN</h3>
                <p><strong>Tên tài khoản:</strong> Phùng Thư</p>
                <p><strong>Địa chỉ:</strong> TP Thủ Đức,Vietnam</p>
                <p><strong>Điện thoại:</strong> 0333333333</p>

                <hr class="account-divider">

                <h3>ĐƠN HÀNG CỦA BẠN</h3>
                <div class="order-history-table">
                    <table>
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Thành tiền</th>
                            <th>Thông tin thanh toán</th>
                            <th>Thông tin vận chuyển</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>DH001</td>
                            <td>10/10/2025</td>
                            <td>500.000₫</td>
                            <td>Đã thanh toán</td>
                            <td>Đang vận chuyển</td>
                        </tr>
                        <tr>
                            <td>DH002</td>
                            <td>08/10/2025</td>
                            <td>1.200.000₫</td>
                            <td>Chưa thanh toán</td>
                            <td>Chưa vận chuyển</td>
                        </tr>
                        <tr>
                            <td colspan="5">Không có đơn hàng nào khác.</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="content-section" id="account-addresses" style="display: none;">
                <h3>ĐỊA CHỈ CỦA BẠN</h3>
                <button type="button" class="btn-primary open-modal" id="add-address-btn">Thêm địa chỉ</button>

                <div class="address-card">
                    <p><strong>Họ tên:</strong> Phùng Thư <span class="default-badge">Địa chỉ mặc định</span></p>
                    <p><strong>Địa chỉ:</strong> TP Thủ Đức, Vietnam</p>
                    <p><strong>Số điện thoại:</strong> 0333333333</p>
                    <a href="#" class="edit-address-link open-modal" id="edit-address-btn">Chỉnh sửa địa chỉ</a>
                </div>
            </div>

        </div>
    </div>
</main>
<div class="modal-overlay" id="add-address-modal" style="display: none;">
    <div class="modal-content">
        <button class="modal-close" id="close-add-modal">&times;</button>
        <h4>THÊM ĐỊA CHỈ MỚI</h4>
        <form>
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="add-ho">Họ</label>
                    <input type="text" id="add-ho">
                </div>
                <div class="form-group half-width">
                    <label for="add-ten">Tên</label>
                    <input type="text" id="add-ten">
                </div>
            </div>
            <div class="form-group">
                <label for="add-sdt">Số điện thoại</label>
                <input type="text" id="add-sdt">
            </div>
            <div class="form-group">
                <label for="add-congty">Công ty</label>
                <input type="text" id="add-congty">
            </div>
            <div class="form-group">
                <label for="add-diachi">Địa chỉ</label>
                <input type="text" id="add-diachi">
            </div>
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="add-quocgia">Quốc gia</label>
                    <select id="add-quocgia">
                        <option value="">- Please Select -</option>
                        <option value="Vietnam">Vietnam</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="add-tinhthanh">Tỉnh thành</label>
                    <select id="add-tinhthanh">
                        <option value="">- Please Select -</option>
                        <option value="HCM">Hồ Chí Minh</option>
                    </select>
                </div>
            </div>
            <div class="form-group-checkbox">
                <input type="checkbox" id="add-default">
                <label for="add-default">Đặt làm địa chỉ mặc định?</label>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-secondary modal-close" id="cancel-add-modal">Hủy</button>
                <button type="submit" class="btn-primary">Thêm địa chỉ</button>
            </div>
        </form>
    </div></div>
<div class="modal-overlay" id="edit-address-modal" style="display: none;">
    <div class="modal-content">
        <button class="modal-close" id="close-edit-modal">&times;</button>
        <h4>SỬA ĐỊA CHỈ</h4>
        <form>
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="edit-ho">Họ</label>
                    <input type="text" id="edit-ho" value="Phùng">
                </div>
                <div class="form-group half-width">
                    <label for="edit-ten">Tên</label>
                    <input type="text" id="edit-ten" value="Thư">
                </div>
            </div>
            <div class="form-group">
                <label for="edit-sdt">Số điện thoại</label>
                <input type="text" id="edit-sdt" value="0333333333">
            </div>
            <div class="form-group">
                <label for="edit-congty">Công ty</label>
                <input type="text" id="edit-congty">
            </div>
            <div class="form-group">
                <label for="edit-diachi">Địa chỉ</label>
                <input type="text" id="edit-diachi">
            </div>
            <div class="form-row">
                <div class="form-group half-width">
                    <label for="edit-quocgia">Quốc gia</label>
                    <select id="edit-quocgia">
                        <option value="Vietnam" selected>Vietnam</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="edit-tinhthanh">Tỉnh thành</label>
                    <select id="edit-tinhthanh">
                        <option value="HCM">Hồ Chí Minh</option>
                    </select>
                </div>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-secondary modal-close" id="cancel-edit-modal">Hủy</button>
                <button type="submit" class="btn-primary">Cập nhật địa chỉ</button>
            </div>
        </form>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>