<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chương trình Khuyến Mãi</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/promotion.css">
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/backtop.css">
    <script src="scripts/backtop.js"></script>
    <link rel="stylesheet" href="style/footer.css">
    <script src="scripts/home.js"></script>
    <link rel="stylesheet" href="style/breadcrumb.css">
    <link rel="stylesheet" href="style/style.css">
    <script src="scripts/product-information.js"></script>
    <script src="scripts/auth.js"></script>
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
            <li class="breadcrumb-item"><a href="login.jsp">Tài khoản</a></li> <li class="breadcrumb-item active" aria-current="page">Chương trình Khuyến mãi</li>
        </ol>
    </nav>
<div class="promotion-container">
    <h1>Chương trình Khuyến Mãi</h1>

    <div class="articles-list">

        <article class="article-item">
            <div class="article-image">
                <a href="promotionsPost.jsp">
                    <img src="image/aodai1.png" alt="Giảm 100k cho mỗi áo Áo gấm Hố Điệp">
                </a>
            </div>
            <div class="article-content">
                <h3>
                    <a href="promotionsPost.jsp">
                        Giảm 100k cho mỗi áo Áo gấm Hố Điệp phối tơ bay</a>
                </h3>
                <div class="meta">
                    <span><i class="far fa-calendar-alt"></i> Th 2 19/08/2025</span>
                    <span><i class="far fa-clock"></i> 3 phút đọc</span>
                </div>
                <p>[mới] Áo gấm Hố Điệp phối tơ bay! Vải em gầy guộc nhè nhẹ, như cánh vạc bay* Ưu đãi mua sắm: giảm 100k cho mỗi áo...</p>
                <a href="promotionsPost.jsp" class="read-more">Đọc tiếp</a>
            </div>
        </article>

        <article class="article-item">
            <div class="article-image">
                <a href="promotionsPost.jsp">
                    <img src="image/aodai2.png" alt="Tặng vòng-cổ-handmade">
                </a>
            </div>
            <div class="article-content">
                <h3>
                    <a href="promotionsPost.jsp">
                        [Tặng vòng-cổ-handmade] cho tất cả đơn hàng áo yếm mùa hè từ 700k</a>
                </h3>
                <div class="meta">
                    <span><i class="far fa-calendar-alt"></i> CN 04/05/2025</span>
                    <span><i class="far fa-clock"></i> 3 phút đọc</span>
                </div>
                <p>[Tặng vòng-cổ-handmade] cho tất cả đơn hàng áo yếm mùa hè từ 700k Áp dụng cho mọi kênh bán của chúng mình với màu sắc ngẫu nhiên...</p>
                <a href="promotionsPost.jsp" class="read-more">Đọc tiếp</a>
            </div>
        </article>

        <article class="article-item">
            <div class="article-image">
                <a href="promotionsPost.jsp">
                    <img src="image/aodai3.png" alt="CLEARANCE SALE">
                </a>
            </div>
            <div class="article-content">
                <h3>
                    <a href="promotionsPost.jsp">[CLEARANCE SALE] ĐỒNG GIÁ TỪ 99K - DỊP DUY NHẤT TRONG NĂM</a>
                </h3>
                <div class="meta">
                    <span><i class="far fa-calendar-alt"></i> Th 5 27/02/2025</span>
                    <span><i class="far fa-clock"></i> 1 phút đọc</span>
                </div>
                <p>Thông báo cho chị em mình chung, Sumire Store chuẩn bị ra mắt ưu đãi thật đặc biệt - như một món quà tri ân vô giá...</p>
                <a href="promotionsPost.jsp" class="read-more">Đọc tiếp</a>
            </div>
        </article>

    </div>

    <article class="article-item">
        <div class="article-image">
            <a href="promotionsPost.jsp">
                <img src="image/aodai4.png" alt="VỪA NHẮM MẮT VỪA MỞ TÚI XUÂN">
            </a>
        </div>
        <div class="article-content">
            <h3>
                <a href="promotionsPost.jsp">🌸 VỪA NHẮM MẮT VỪA MỞ TÚI XUÂN 🌸 voucher lên đến 500k cùng quà tặng phụ kiện xinh xắn</a>
            </h3>
            <div class="meta">
                <span><i class="far fa-calendar-alt"></i> Th 6 03/01/2025</span>
                <span><i class="far fa-clock"></i> 2 phút đọc</span>
            </div>
            <p>[Ưu-đãi-đầu-năm] VỪA NHẮM MẮT VỪA MỞ TÚI XUÂN voucher lên đến 500k cùng quà tặng phụ kiện xinh xắn đầu xuân...</p>
            <a href="promotionsPost.jsp" class="read-more">Đọc tiếp</a>
        </div>
    </article>

    <article class="article-item">
        <div class="article-image">
            <a href="promotionsPost.jsp">
                <img src="image/aodai5.png" alt="Giảm 10% Album Mới">
            </a>
        </div>
        <div class="article-content">
            <h3>
                <a href="promotionsPost.jsp">Giảm 10% Album Mới & Tặng Quạt gỗ kèm dây charm Hố điệp</a>
            </h3>
            <div class="meta">
                <span><i class="far fa-calendar-alt"></i> Th 3 24/12/2024</span>
                <span><i class="far fa-clock"></i> 3 phút đọc</span>
            </div>
            <p>[Mới-mới-mới] Áo khoác Tứ thân cách tân & Đầm cổ yếm "Nhan vô Huyên cơ". Mua sắm hoặc Pre-order từ hôm nay để nhận ưu đãi...</p>
            <a href="/promotionsPost.jsp" class="read-more">Đọc tiếp</a>
        </div>
    </article>

    <article class="article-item">
        <div class="article-image">
            <a href="promotionsPost.jsp">
                <img src="image/aodai6.jpg" alt="Sale ưu đãi đến 60%">
            </a>
        </div>
        <div class="article-content">
            <h3>
                <a href="promotionsPost.jsp">Sale ưu đãi đến 60% từ ngày 11 đến 15/12/2024</a>
            </h3>
            <div class="meta">
                <span><i class="far fa-calendar-alt"></i> Th 4 11/12/2024</span>
                <span><i class="far fa-clock"></i> 1 phút đọc</span>
            </div>
            <p>Dưới đây là danh sách các sản phẩm sale. Chị/bạn truy cập vào từng link để xem nhé. Chúc Chị/bạn lựa được sản phẩm ưng ý....</p>
            <a href="promotionsPost.jsp" class="read-more">Đọc tiếp</a>
        </div>
    </article>

</div> <nav class="pagination">
    <a href="#" class="page-number active">1</a>
    <a href="#" class="page-number">2</a>
    <a href="#" class="page-number">3</a>
</nav>

</div>
<jsp:include page="footer.jsp" />
<button onclick="scrollToTop()" id="backToTopBtn" title="Trở về đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>
</body>
</html>