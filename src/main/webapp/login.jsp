<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việt Sắc Đỏ - Đăng nhập</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/auth.css">
    <script type="module" src="scripts/auth.js"></script>
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/breadcrumb.css">
    <script src="scripts/home.js"></script>
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
                    <li><a href="login.html">Đăng nhập</a></li>
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
<!--breadcrumb-->
<div class="breadcrumb-container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="login.html">Tài khoản</a></li> <li class="breadcrumb-item active" aria-current="page">Đăng nhập</li>
        </ol>
    </nav>
</div>
<main>
    <section class="section">
        <div class="container">
            <div class="wrap_background" id="login_view">
                <div class="heading-bar">
                    <h1>Đăng nhập tài khoản</h1>
                    <p>Bạn chưa có tài khoản? <a href="signup.jsp">Đăng ký tại đây</a></p>
                </div>
                <div class="row">
                    <div class="col">
                        <form class="page_auth" id="login" action="Login" method="POST">
                            <fieldset class="form-group">
                                <label>
                                    Số điện thoại hoặc Email
                                    <span class="req">*</span>
                                </label>
                                <input type="text" id="username" name="username" placeholder="Nhập email hoặc số điện thoại...">
                            </fieldset>
                            <fieldset class="form-group">
                                <label>
                                    Mật khẩu
                                    <span class="req">*</span>
                                </label>
                                <input type="password" id="customer_password" name="password" placeholder="Mật khẩu" required autocomplete="current-password">
                                <small>Quên mật khẩu? Nhấn vào <a href="#" id="show_forgot_view">đây</a></small>
                            </fieldset>
                            <% if (request.getAttribute("error") != null) { %>
                            <p style="color: red; font-style: italic;">${error}</p>
                            <% } %>
                            <div>
                                <button type="submit">Đăng nhập</button>
                            </div>
                        </form>
                        <div class="social-auth">
                            <p>Hoặc đăng nhập bằng</p>
                            <div class="wrap-social-auth">
                                <button type="button" id="btn-google" aria-label="Đăng nhập bằng Google">
                                    <div class="btn-google">
                                        <i class="fa-brands fa-google"></i>
                                    </div>
                                    <div>Đăng nhập Google</div>
                                </button>
                                <button type="button" id="btn-facebook" aria-label="Đăng nhập bằng Facebook">
                                    <div class="btn-facebook">
                                        <i class="fab fa-facebook-f"></i>
                                    </div>
                                    <div>Đăng nhập Facebook</div>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="wrap_background" id="forgot_view" style="display: none;">
                <div class="heading-bar">
                    <h1>Khôi phục mật khẩu</h1>
                    <p>Bạn đã nhớ mật khẩu? <a href="#" id="show_login_view">Quay lại đăng nhập</a></p>
                </div>
                <div class="row">
                    <div class="col">
                        <form class="page_auth" id="forgot_password_form" action="forgot-password" method="POST">
                            <input type="hidden" name="action" value="request">
                            <fieldset class="form-group">
                                <label>
                                    Email
                                    <span class="req">*</span>
                                </label>
                                <input type="email" name="email" id="email_reset" placeholder="Email" required autocomplete="email">
                                <small>Chúng tôi sẽ gửi mã otp đến email để khôi phục mật khẩu của bạn.</small>
                            </fieldset>
                            <p style="color: red; font-style: italic;">${error}</p>
                            <div>
                                <button type="submit">Gửi yêu cầu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="footer.jsp" />
</body>
</html>