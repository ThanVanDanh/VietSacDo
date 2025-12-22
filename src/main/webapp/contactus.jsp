<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=">
    <title>Liên hệ</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/contactus.css">
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/breadcrumb.css">
    <script src="scripts/home.js"></script>
    <link rel="stylesheet" href="style/contactus.css">
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
                <a href="#"><i class="fa-regular fa-user"></i></a>
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
            <li class="breadcrumb-item"><a href="contactus.html">Liên hệ</a></li> <li class="breadcrumb-item active" aria-current="page">Gửi</li>
        </ol>
    </nav>
</div>
<section style="background-image: url('image/Contact.png');">
    <div class="section-header">
        <div class="container">
            <h2>Liên hệ</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
        </div>
    </div>

    <div class="container">
        <div class="row">

            <div class="contact-info">
                <div class="contact-info-item">
                    <div class="contact-info-icon">
                        <i class="fas fa-home"></i>
                    </div>

                    <div class="contact-info-content">
                        <h4>Địa chỉ</h4>
                        <p>16 tổ 3,Linh Trung, Tp.Thủ Đức,Tp.Hồ Chí Minh</p>
                    </div>
                </div>

                <div class="contact-info-item">
                    <div class="contact-info-icon">
                        <i class="fas fa-phone"></i>
                    </div>

                    <div class="contact-info-content">
                        <h4>Số điện thoại</h4>
                        <p>0901.234.567</p>
                    </div>
                </div>

                <div class="contact-info-item">
                    <div class="contact-info-icon">
                        <i class="fas fa-envelope"></i>
                    </div>

                    <div class="contact-info-content">
                        <h4>Email</h4>
                        <p>info@vietsacdo.com</p>
                    </div>
                </div>
            </div>

            <div class="contact-form">
                <form action="" id="contact-form" method="post">
                    <h2>Gửi tin nhắn</h2>
                    <c:if test="${not empty success}">
                        <p style="color: green; margin-bottom: 10px;">${success}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red; margin-bottom: 10px;">${error}</p>
                    </c:if>
                    <div class="input-box">
                        <input type="text" name="fullName" placeholder="Họ và Tên" required>
                    </div>

                    <div class="input-box">
                        <input type="email" name="email" placeholder="Địa chỉ Email" required>
                    </div>

                    <div class="input-box">
                        <textarea name="messageBody" placeholder="Lời nhắn..." required></textarea >

                    </div>

                    <div class="input-box">
                        <input type="submit" value="Gửi"  name="">
                    </div>
                </form>
            </div>

        </div>
    </div>
</section>
<jsp:include page="footer.jsp" />
</body>
</html>