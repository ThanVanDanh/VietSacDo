<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việt Sắc Đỏ - Giỏ hàng</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/giohang.css">
    <link rel="stylesheet" href="style/style-header.css">
    <script src="scripts/home.js"></script>
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/backtop.css">
    <script src="scripts/backtop.js"></script>
    <link rel="stylesheet" href="style/breadcrumb.css">
    <link rel="stylesheet" href="style/aodai.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="style/quick-view.css">
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
                <a href="giohang.html" title="Giỏ hàng">
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
                        <a href="giohang.html" class="btn-pay">Tiến hành thanh toán</a>
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
            <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
        </ol>
    </nav>
</div>
<main>
    <section class="shopping-cart">
        <div class="container-sp">
            <form action="">
                <div class="header-cart-sp">
                    <h1>GIỎ HÀNG</h1>
                </div>
                <div id="empty-cart-message" style="display: none; text-align: center; padding: 50px 20px;">
                    <img src="./image/empty_cart.png" alt="Giỏ hàng trống" style="width: 100px; margin-bottom: 20px; opacity: 0.5;">
                    <h3>Giỏ hàng của bạn đang trống</h3>
                    <p>Hãy dạo một vòng và chọn những món đồ ưng ý nhé!</p>
                    <a href="all-product.jsp" class="btn-pay" style=" margin-top: 20px; text-decoration: none;">Tiếp tục mua sắm</a>
                </div>
                <div class="content-sp" id="cart-data-container">
                    <div class="cart-content-sp">
                        <div class="upsell-card-sp">
                            <div class="progress-bar-sp">
                                <div class="progress-sp" style="width: 100%; background-color: darkgreen;"></div>
                                <span class="percent-sp">100%</span>
                            </div>
                            <p>🎉 Chúc mừng! Đơn hàng của bạn đã đủ điều kiện được Freeship!</p>
                        </div>
                        <ul class="cart-items-list-sp">
                            <li class="cart-item-sp">
                                <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                                <img src="image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân">
                                <div class="item-info-sp">
                                    <a href="" class="item-name-sp">Áo dài truyền thống Quỳnh Hân</a>
                                    <span class="item-meta-sp">Size A / Quỳnh Hân</span>
                                </div>
                                <div class="box-quantity-sp">
                                    <div class="item-price-sp">
                                        <span>711,000₫</span>
                                    </div>
                                    <div class="quatity-sp">
                                        <button type="button" class="btn-minus"><i class="fa-solid fa-minus"></i></button>
                                        <input type="text" value="1" class="quantity-input">
                                        <button type="button" class="btn-plus"><i class="fa-solid fa-plus"></i></button>
                                    </div>
                                </div>
                            </li>
                            <li class="cart-item-sp">
                                <div><button class="remove-item"><i class="fa-solid fa-xmark"></i></button></div>

                                <img src="image/truyenthong3.png" alt="Áo dài truyền thống Phúc Hương">
                                <div class="item-info-sp">
                                    <a href="" class="item-name-sp">Áo dài truyền thống Phúc Hương</a>
                                    <span class="item-meta-sp">Size A / Phúc Hương</span>
                                </div>
                                <div class="box-quantity-sp">
                                    <div class="item-price-sp">
                                        <span>880,000₫</span>
                                    </div>
                                    <div class="quatity-sp">
                                        <button type="button" class="btn-minus"><i class="fa-solid fa-minus"></i></button>
                                        <input type="text" value="1" class="quantity-input">
                                        <button type="button" class="btn-plus"><i class="fa-solid fa-plus"></i></button>
                                    </div>
                                </div>
                            </li>
                            <li class="cart-item-sp">
                                <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                                <img src="image/truyenthong4.png" alt="Áo dài truyền thống Quỳnh Châu">
                                <div class="item-info-sp">
                                    <a href="" class="item-name-sp">Áo dài truyền thống Quỳnh Châu</a>
                                    <span class="item-meta-sp">Size A / Quỳnh Châu</span>
                                </div>
                                <div class="box-quantity-sp">
                                    <div class="item-price-sp">
                                        <span>790,000₫</span>
                                    </div>
                                    <div class="quatity-sp">
                                        <button type="button" class="btn-minus"><i class="fa-solid fa-minus"></i></button>
                                        <input type="text" value="1" class="quantity-input">
                                        <button type="button" class="btn-plus"><i class="fa-solid fa-plus"></i></button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                        <div class="cart-note-sp">
                            <label>Ghi chú đơn hàng</label>
                            <textarea rows="2"></textarea>
                        </div>
                    </div>
                    <div class="cart-price-sp" id="cart-summary">
                        <div class="total-sp">
                            <h3>Tổng cộng</h3>
                            <span>2,281,000đ</span>
                        </div>
                        <div><button ><span><a href="thanhtoan.jsp">Thanh toán</a></span></button></div>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <section class="product-showcase tab-component">
        <div class="title-h1-linen">
            <h1>CÓ THỂ BẠN SẼ THÍCH</h1>
        </div>
        <div class="product-grid">
            <div class="product-card">
                <div class="product-image-wrapper">
                    <div class="product-image">
                        <a href="product-information.jsp"><img src="image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân"></a>
                    </div>
                    <div class="product-overlay">
                        <a href="#" class="icon-button" title="Tùy chọn">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                        <a href="#" class="icon-button" title="Xem nhanh">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </div>
                </div>

                <div class="product-info">
                    <a href="product-information.jsp"><p class="product-name">Áo dài truyền thống Quỳnh Hân</p></a>
                    <div class="product-price">
                        <span class="current-price">711,000₫</span>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <div class="product-image-wrapper">
                    <div class="product-image">
                        <a href="product-information.jsp"><img src="image/truyenthong6.png" alt="Áo dài truyền thống Gấm Khuê Gia - Trắng dệt hoa"></a>
                    </div>
                    <div class="product-overlay">
                        <a href="product-information.jsp" class="icon-button" title="Tùy chọn">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                        <a href="#" class="icon-button" title="Xem nhanh">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </div>
                </div>

                <div class="product-info">
                    <a href="product-information.jsp"><p class="product-name">Áo dài truyền thống Gấm Khuê Gia - Trắng dệt hoa</p></a>
                    <div class="product-price">
                        <span class="current-price">720,000₫</span>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <div class="product-image-wrapper">
                    <div class="product-image">
                        <a href="product-information.jsp"><img src="image/truyenthong3.png" alt="Áo dài truyền thống Phúc Hương"></a>
                    </div>
                    <div class="product-overlay">
                        <a href="product-information.jsp" class="icon-button" title="Tùy chọn">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                        <a href="#" class="icon-button" title="Xem nhanh">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </div>
                </div>
                <div class="product-info">
                    <a href="product-information.jsp"><p class="product-name">Áo dài truyền thống Phúc Hương</p></a>
                    <div class="product-price">
                        <span class="current-price">880,000₫</span>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <div class="product-image-wrapper">
                    <div class="product-image">
                        <a href="product-information.jsp"><img src="image/truyenthong4.png" alt="Áo dài truyền thống Quỳnh Châu"></a>
                    </div>
                    <div class="product-overlay">
                        <a href="product-information.jsp" class="icon-button" title="Tùy chọn">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                        <a href="#" class="icon-button" title="Xem nhanh">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </div>
                </div>

                <div class="product-info">
                    <a href="product-information.jsp"><p class="product-name">Áo dài truyền thống Quỳnh Châu</p></a>
                    <div class="product-price">
                        <span class="current-price">790,000₫</span>
                    </div>
                </div>
            </div>
            <div class="product-card">
                <div class="product-image-wrapper">
                    <div class="product-image">
                        <a href="product-information.jsp"><img src="image/truyenthong8.png" alt="Áo dài truyền thống khảm hoa Cát Tường"></a>
                    </div>
                    <div class="product-overlay">
                        <a href="product-information.jsp" class="icon-button" title="Tùy chọn">
                            <i class="fa-solid fa-cart-shopping"></i>
                        </a>
                        <a href="#" class="icon-button" title="Xem nhanh">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </div>
                </div>

                <div class="product-info">
                    <a href="product-information.jsp"><p class="product-name">Áo dài truyền thống khảm hoa Cát Tường</p></a>
                    <div class="product-price">
                        <span class="current-price">671,500₫</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="pagination">
            <a href="#"><img src="image/chevron_left.png" alt=""></a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#"><img src="image/chevron_right.png" alt=""></a>
        </div>
    </section>
</main>
<div id="quick-view-model" class="model-overlay">
    <div class="quick-content-model">
        <div class="model-image">
            <img class="large-image" src="image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân">
            <div class="model-group-img swiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><img src="image/truyenthong1.png"></div>
                    <div class="swiper-slide"><img src="image/truyenthong12.png"></div>
                    <div class="swiper-slide"><img src="image/truyenthong13.png"></div>
                    <div class="swiper-slide"><img src="image/truyenthong14.png"></div>
                    <div class="swiper-slide"><img src="image/truyenthong15.png"></div>
                    <div class="swiper-slide"><img src="image/truyenthong16.png"></div>
                </div>
            </div>
        </div>
        <div class="model-content">
            <h2>Áo dài truyền thống Quỳnh Hân</h2>
            <div class="model-info">
                <p>Thương hiệu: <a href="index.jsp">Việt Sắc Đỏ</a>
                    <span>|</span>
                    Mã sản phẩm: <span>ADTT2326A</span>
                </p>
            </div>
            <div class="product-price">
                <span class="current-price">671,500₫</span>
                <span class="old-price">790,000₫</span>
                <span class="discount-tag">15%</span>
            </div>
            <div class="model-size">
                <label>Kích thước:</label>
                <div class="group-size">
                    <input type="radio" name="size" id="size-s">
                    <label for="size-s">S</label>
                    <input type="radio" name="size" id="size-m">
                    <label for="size-m">M</label>
                    <input type="radio" name="size" id="size-l">
                    <label for="size-l">L</label>
                    <input type="radio" name="size" id="size-Xl">
                    <label for="size-Xl">XL</label>
                    <input type="radio" name="size" id="size-XXl">
                    <label for="size-XXl">XXL</label>
                </div>
                <div class="size-table">
                    <a href="#">Bảng quy đổi kích cỡ</a>
                    <div class="size">
                        <img src="image/size-ao.png" alt="">
                    </div>
                </div>
            </div>
            <div class="model-color">
                <label>Màu sắc:</label>
                <div class="group-color">
                    <input type="radio" name="color-swatch" class="color-swatch" style="background: #cab6a1">
                    <input type="radio" name="color-swatch" class="color-swatch" style="background: #d575c9">
                    <input type="radio" name="color-swatch" class="color-swatch" style="background: #e84569">
                    <input type="radio" name="color-swatch" class="color-swatch" style="background: #5b25bc">
                </div>
            </div>
            <div class="model-promotion">
                <span class="promotion-title">🎁 KHUYẾN MÃI - ƯU ĐÃI</span>
                <ul class="promotion-box">
                    <li>Freeship toàn quốc khi mua hàng (Không áp dụng cho đơn CHỈ CÓ phụ kiện dưới 350k)</li>
                    <li>Hỏa tốc mọi ngày trong tuần</li>
                </ul>
            </div>
            <div class="model-footer">
                <div class="quantity">
                    <button type="button" class="btn-minus"><i class="fa-solid fa-minus"></i></button>
                    <input type="text" value="1" class="quantity-input">
                    <button type="button" class="btn-plus"><i class="fa-solid fa-plus"></i></button>
                </div>
                <button class="add-shopping"><span>Thêm vào giỏ</span></button>
            </div>
        </div>
        <button id="close-model" class="model-remove-item"><i class="fa-solid fa-xmark"></i></button>
    </div>
</div>
<div id="success-add-shopping" class="model-success-overlay">
    <div class="success-content-model">
        <button id="close-success-popup" class="model-remove-item"><i class="fa-solid fa-xmark"></i></button>
        <div class="success-header">
            <i class="fa-solid fa-check-circle"></i>
            <span>Thêm vào giỏ hàng thành công</span>
        </div>
        <div class="success-product-info">
            <img src="image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân">
            <div class="item-info">
                <a href="" class="item-name">Áo dài truyền thống Quỳnh Hân</a>
                <span class="item-meta">Size A / Quỳnh Hân</span>
            </div>
        </div>
        <div class="success-box-quantity">
            <span>Giỏ hàng hiện có</span>
            <div class="item-price">
                <span>711,000₫</span>
                <small>(1) sản phẩm</small>
            </div>
        </div>
        <div class="success-footer">
            <a href="thanhtoan.jsp" class="checkout-btn">Thanh toán</a>
            <a href="giohang.html" class="success-btn">Xem giỏ hàng</a>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
<button onclick="scrollToTop()" id="backToTopBtn" title="Trở về đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>
</body>
</html>