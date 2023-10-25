<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Áo dài Linen</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="style/aodai.css">
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/breadcrumb.css">
    <script src="scripts/home.js"></script>
    <script src="scripts/backtop.js"></script>
    <link rel="stylesheet" href="style/backtop.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="style/quick-view.css">
    <link rel="stylesheet" href="style/thanhtoan.css">

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
<header>
    <div class="header">
        <div class="logo">
            <a href="index.jsp">
                <img src="image/logo.png" alt="Logo Việt Sắc Đỏ">
            </a>
        </div>
        <nav>
            <ul class="menu">
                <li><a href="index.jsp">Trang Chủ</a></li>
                <li><a href="#">Áo dài<i class="fa-solid fa-chevron-down"></i></a>
                    <ul class="sub-menu">
                        <li><a href="aodaitruyenthong.jsp">Áo dài truyền thống</a></li>
                        <li><a href="aodaitheutay.jsp">Áo dài thêu tay</a></li>
                        <li><a href="aodailinen.jsp">Áo dài linen</a></li>
                    </ul>
                </li>
                <li class="has-megamenu"><a href="#">Quần & Phụ kiện<i class="fa-solid fa-chevron-down"></i></a>
                    <!--                    <ul class="sub-menu">-->
                    <!--                        <li><a href="#">Quần lụa</a></li>-->
                    <!--                        <li><a href="#">Mấn đội đầu</a></li>-->
                    <!--                        <li><a href="#">Guốc mộc</a></li>-->
                    <!--                        <li><a href="#">Phụ kiện khác</a></li>-->
                    <!--                    </ul>-->
                    <ul class="sub-menu">
                        <div class="mega-menu-container">
                            <div class="mega-menu-content">

                                <div class="category-column">
                                    <h3>Quần & váy phối áo dài</h3>
                                    <ul>
                                        <li><a href="#">Chân Váy</a></li>
                                        <li><a href="#">Quần Phương Chi</a></li>
                                        <li><a href="#">Quần Quế Chi</a></li>
                                        <li><a href="#">Quần Vân Chi</a></li>
                                        <li><a href="#">Quần Mai Chi</a></li>
                                        <li><a href="#">Quần Trúc Chi</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Phụ kiện</h3>
                                    <ul>
                                        <li><a href="#">Mấn áo dài</a></li>
                                        <li><a href="#">Vòng tay</a></li>
                                        <li><a href="#">Hoa tai</a></li>
                                        <li><a href="#">Guốc gỗ</a></li>
                                        <li><a href="#">Túi xách</a></li>
                                        <li><a href="#">Dây chuyền</a></li>
                                        <li><a href="kepvanocaitoc.jsp">Kẹp & nơ cài tóc</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Nón Lá</h3>
                                    <ul>
                                        <li><a href="nonlahodiep.jsp">Nón lá bọc vải Hồ điệp</a></li>
                                        <li><a href="#">Nón lá bọc vải Chè hoa bưởi</a></li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </ul>
                </li>
                <li><a href="contactus.jsp">Liên Hệ</a></li>
                <li><a href="promotion.jsp">Chương trình khuyến mãi</a></li>
            </ul>
        </nav>
        <div class="icons">

            <a href="#" id="searchTrigger"><i class="fa-solid fa-magnifying-glass"></i></a>

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
</header>
<div class="breadcrumb-container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="thanhtoan.html">Thanh toán</a></li><li class="breadcrumb-item active" aria-current="page">Tiến hành thanh toán</li>
        </ol>
    </nav>
</div>
<div class="container">
    <main class="checkout-layout">
        <div class="left-column">
            <div class="card shipping-info">
                <h3>Thông tin giao hàng</h3>
                <input type="text" placeholder="Nhập họ và tên">
                <div class="input-with-icon">
                    <input type="tel" placeholder="Nhập số điện thoại">
                    <span class="flag-icon">🇻🇳</span>
                </div>
                <input type="email" placeholder="Nhập email">
                <input type="text" value="Vietnam" readonly>
                <input type="text" placeholder="Địa chỉ, tên đường">
                <input type="text" placeholder="Tỉnh/TP, Quận/Huyện, Phường/Xã">
            </div>

            <div class="spacer"></div>

            <div class="card shipping-method">
                <h3>Phương thức giao hàng</h3>
                <input type="text" placeholder="Nhập địa chỉ để xem các phương thức giao hàng" disabled>
            </div>

            <div class="spacer"></div>

            <div class="card payment-method">
                <h3>Phương thức thanh toán</h3>

                <label class="radio-option">
                    <input type="radio" name="payment" checked>
                    Thanh toán online qua Payoo (Thẻ ATM, VISA, Mastercard, v.v...)
                    <div class="payment-logos">
                        <img src="image/payoo-logo-jpg-inkythuatso.jpg" alt="Payoo" style="height: 15px;">
                        <i class="fab fa-cc-visa"></i>
                        <i class="fab fa-cc-mastercard"></i>
                        <i class="fas fa-credit-card"></i>
                    </div>
                </label>

                <label class="radio-option">
                    <input type="radio" name="payment">
                    Thanh toán khi nhận hàng
                </label>
            </div>

            <div class="spacer"></div>

            <div class="card order-note">
                <input type="text" placeholder="Ghi chú đơn hàng">
            </div>
        </div>

        <div class="right-column">

            <div class="card cart-summary">
                <h3>Giỏ hàng</h3>
                    <div class="cart-item js-cart-item">
                        <img src="image/linen_3.png" alt="Áo dài linen" class="product-image">
                        <div class="item-details">
                            <p>Áo dài linen Thêu tay Nguyệt Trà</p>
                            <p class="item-variant">Nguyệt Trà / Size C</p>
                            <p class="old-price">1,480,000₫</p>
                            <p class="current-price">1,180,000₫</p>
                        </div>
                        <div class="item-controls">
                            <button class="remove-btn js-open-modal" aria-label="Xóa sản phẩm"><i class="fa-solid fa-trash-can"></i></button>
                            <div class="overlay js-overlay">
                                <div class="popup">
                                    <h2>Bạn muốn bỏ khỏi giỏ hàng</h2>
                                    <p class="product">Áo dài linen Thêu tay Nguyệt Trà</p>
                                    <div class="actions">
                                        <button class="btn normal js-close-modal">Quay lại</button>
                                        <button class="btn danger js-remove-item">Bỏ sản phẩm</button>
                                    </div>
                                </div>
                            </div>
                            <div class="quantity-control">
                                <button class="js-decrease-quantity">-</button>
                                <span class="js-quantity-display" data-quantity="1">1</span>
                                <button class="js-increase-quantity">+</button>
                            </div>
                        </div>
                    </div>

                    <div class="cart-item js-cart-item">
                        <img src="image/linen_3.png" alt="Áo dài linen" class="product-image">
                        <div class="item-details">
                            <p>Áo dài linen Thêu tay Nguyệt Trà</p>
                            <p class="item-variant">Nguyệt Trà / Size C</p>
                            <p class="old-price">1,480,000₫</p>
                            <p class="current-price">1,180,000₫</p>
                        </div>
                        <div class="item-controls">
                            <button class="remove-btn js-open-modal" aria-label="Xóa sản phẩm"><i class="fa-solid fa-trash-can"></i></button>
                            <div class="overlay js-overlay">
                                <div class="popup">
                                    <h2>Bạn muốn bỏ khỏi giỏ hàng</h2>
                                    <p class="product">Áo dài linen Thêu tay Nguyệt Trà</p>
                                    <div class="actions">
                                        <button class="btn normal js-close-modal">Quay lại</button>
                                        <button class="btn danger js-remove-item">Bỏ sản phẩm</button>
                                    </div>
                                </div>
                            </div>
                            <div class="quantity-control">
                                <button class="js-decrease-quantity">-</button>
                                <span class="js-quantity-display" data-quantity="1">1</span>
                                <button class="js-increase-quantity">+</button>
                            </div>
                        </div>
                    </div>

                    <div class="discount-message">
                        Bạn đã được giảm **300,000₫**
                    </div>

            </div>

            <div class="spacer"></div>

            <div class="card promotion">
                <h3>Mã khuyến mãi</h3>
                <div class="select-promo">
                    <span>Chọn mã</span>
                    <button class="btnKhuyenMai" id="btnOpenkm"><i class="fa-solid fa-chevron-right"></i></button>
                    <div class="popupOverlay" id="popupOverlay">
                        <div class="promoModal">
                            <div class="header-khuyenMai">
                                <span class="btnCloseTop" id="btnCloseTop"><i class="fa-solid fa-xmark"></i></span>
                                <h3 class="h3-khuyenmai">Chọn mã khuyến mãi</h3>
                            </div>
                            <div class="noPromoBox">
                                <img src="image/discount.png" class="promoIcon">
                                <p>Không có mã khuyến mãi phù hợp</p>
                            </div>
                            <div class="bottomZone">
                                <button class="btnCloseBottom" id="btnCloseBottom">Đóng</button>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="apply-promo">
                    <input type="text" placeholder="Nhập mã khuyến mãi">
                    <button class="btn-apply">Áp dụng</button>
                </div>
            </div>

            <div class="spacer"></div>

            <div class="card order-total">
                <h3>Tóm tắt đơn hàng</h3>
                <div class="total-row">
                    <span>Tổng tiền hàng</span>
                    <span>1,180,000₫</span>
                </div>
                <div class="total-row">
                    <span>Phí vận chuyển</span>
                    <span>0₫</span>
                </div>
                <hr>
                <div class="total-row final-total">
                    <span>Tổng thanh toán</span>
                    <span>1,180,000₫</span>
                </div>
                <button class="btn-order"><a href="account.jsp">Đặt hàng</a> </button>
            </div>
        </div>
    </main>
</div>
<footer>
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-column about">
                <h4>Về Việt Sắc Đỏ</h4>
                <p>Chuyên cung cấp các sản phẩm áo dài, vải linen và phụ kiện
                    thời trang truyền thống, tôn vinh vẻ đẹp Việt.</p>
                <p>
                    <i class="fa-solid fa-location-dot"></i> 16 tổ 3, khu phố 6, Linh Trung, Tp.Thủ Đức, Tp.Hồ Chí Minh
                </p>
                <p>
                    <i class="fa-solid fa-phone"></i> 0901.234.567
                </p>
                <p>
                    <i class="fa-solid fa-envelope"></i> info@vietsacdo.com
                </p>
            </div>

            <div class="footer-column links">
                <h4>Liên kết nhanh</h4>
                <ul class="footer-links">
                    <li><a href="aodaitruyenthong.jsp">Áo dài truyền thống</a></li>
                    <li><a href="aodaitheutay.jsp">Áo dài thêu tay</a></li>
                    <li><a href="aodailinen.jsp">Áo dài linen</a></li>
                    <li><a href="quantrucchi.jsp">Quần trúc chi</a></li>
                    <li><a href="guocgo.jsp">Guốc mộc</a></li>
                    <li><a href="contactus.jsp">Liên hệ</a></li>
                </ul>
            </div>

            <div class="footer-column connect">
                <h4>Kết nối với chúng tôi</h4>
                <div class="social-icons">
                    <a href="#" title="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" title="Zalo"><i class="fa-solid fa-comment-dots"></i></a>
                </div>
                <p class="follow-text-footer">Theo dõi để cập nhật sản phẩm mới nhất!</p>
            </div>
        </div>

        <div class="footer-copyright">
            <p>&copy; 2025 Việt Sắc Đỏ — Tôn vinh vẻ đẹp truyền thống Việt Nam.</p>
        </div>
    </div>
</footer>
<script>
    function handleIncreaseQuantity(event) {
        const btn = event.currentTarget;
        const quantityDisplay = btn.previousElementSibling;

        if (quantityDisplay) {
            let currentQuantity = parseInt(quantityDisplay.textContent);
            currentQuantity += 1; // Tăng lên 1

            quantityDisplay.textContent = currentQuantity;
            quantityDisplay.dataset.quantity = currentQuantity;

        }
    }

    function handleDecreaseQuantity(event) {
        const btn = event.currentTarget;
        const quantityDisplay = btn.nextElementSibling;

        if (quantityDisplay) {
            let currentQuantity = parseInt(quantityDisplay.textContent);

            if (currentQuantity > 1) {
                currentQuantity -= 1;

                quantityDisplay.textContent = currentQuantity;
                quantityDisplay.dataset.quantity = currentQuantity;

            } else {
                alert("Số lượng tối thiểu là 1. Nhấn thùng rác để xóa sản phẩm.");
            }
        }
    }


    const btnIncreaseList = document.querySelectorAll(".js-increase-quantity");
    const btnDecreaseList = document.querySelectorAll(".js-decrease-quantity");

    btnIncreaseList.forEach(btn => {
        btn.addEventListener('click', handleIncreaseQuantity);
    });

    btnDecreaseList.forEach(btn => {
        btn.addEventListener('click', handleDecreaseQuantity);
    });


    // Chọn tất cả các nút mở modal
    const btnOpenList = document.querySelectorAll(".js-open-modal");
    // Chọn tất cả các nút đóng modal
    const btnCloseList = document.querySelectorAll(".js-close-modal");
    // Chọn tất cả các nút XÓA sản phẩm
    const btnRemoveList = document.querySelectorAll(".js-remove-item");

    // --- 1. Xử lý Mở Modal ---
    btnOpenList.forEach(btnOpen => {
        btnOpen.onclick = () => {
            // Tìm element overlay (js-overlay) ngay bên cạnh nút (trong cùng một item-controls)
            const overlay = btnOpen.nextElementSibling;
            if (overlay) {
                overlay.style.display = "flex";
            }
        };
    });

    // --- 2. Xử lý Đóng Modal ---
    btnCloseList.forEach(btnClose => {
        btnClose.onclick = () => {
            // Lấy element popup -> element overlay
            const overlay = btnClose.closest(".js-overlay");
            if (overlay) {
                overlay.style.display = "none";
            }
        };
    });

    // --- 3. Xử lý Bỏ Sản Phẩm và Xóa khỏi DOM ---
    btnRemoveList.forEach(btnRemove => {
        btnRemove.onclick = () => {
            // 1. Tìm element overlay để đóng modal
            const overlay = btnRemove.closest(".js-overlay");
            if (overlay) {
                overlay.style.display = "none";
            }


            const cartItem = btnRemove.closest(".js-cart-item");

            if (cartItem) {
                // Hiển thị thông báo và xóa khỏi DOM
                alert(`Đã bỏ sản phẩm: ${cartItem.querySelector('.item-details p').textContent}!`);
                cartItem.remove();
            } else {
                alert("Lỗi: Không tìm thấy sản phẩm để xóa!");
            }
        };
    });

    // --- Xử lý Popup Khuyến Mãi ---
    // Lưu ý: Đoạn này sẽ chỉ hoạt động nếu các ID này là duy nhất trong HTML.
    const popupOverlay = document.getElementById("popupOverlay");
    const btnShowPromo = document.getElementById("btnOpenkm");
    const btnCloseTop  = document.getElementById("btnCloseTop");
    const btnCloseBottom = document.getElementById("btnCloseBottom");

    if (btnShowPromo && popupOverlay) {
        btnShowPromo.onclick = ()=> popupOverlay.style.display = "flex";
    }
    if (btnCloseTop && popupOverlay) {
        btnCloseTop.onclick = ()=> popupOverlay.style.display = "none";
    }
    if (btnCloseBottom && popupOverlay) {
        btnCloseBottom.onclick = ()=> popupOverlay.style.display = "none";
    }

</script>
</body>
</html>