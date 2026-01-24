<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Áo dài Linen</title>
                <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
                    integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
                    crossorigin="anonymous" referrerpolicy="no-referrer" />
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

                <jsp:include page="header.jsp" />
                <div class="breadcrumb-container">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.jsp">Trang Chủ</a></li>
                            <li class="breadcrumb-item"><a href="thanhtoan.jsp">Thanh toán</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Tiến hành thanh toán</li>
                        </ol>
                    </nav>
                </div>
                <div class="container">
                    <main class="checkout-layout">
                        <div class="left-column">
                            <div class="card shipping-info">
                                <h3>Thông tin giao hàng</h3>
                                <input type="text" placeholder="Nhập họ và tên"
                                    value="${not empty sessionScope.user ? sessionScope.user.fullName : ''}">
                                <div class="input-with-icon">
                                    <input type="tel" placeholder="Nhập số điện thoại"
                                        value="${not empty sessionScope.user ? sessionScope.user.phone : ''}">
                                    <span class="flag-icon">🇻🇳</span>
                                </div>
                                <input type="email" placeholder="Nhập email"
                                    value="${not empty sessionScope.user ? sessionScope.user.email : ''}">
                                <input type="text"
                                    value="${not empty sessionScope.defaultAddress ? sessionScope.defaultAddress.country : 'Vietnam'}"
                                    readonly>
                                <input type="text" placeholder="Địa chỉ, tên đường"
                                    value="${not empty sessionScope.defaultAddress ? sessionScope.defaultAddress.addressLine : ''}">
                                <input type="text" placeholder="Tỉnh/TP, Quận/Huyện, Phường/Xã"
                                    value="${not empty sessionScope.defaultAddress ? sessionScope.defaultAddress.cityProvince : ''}">
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
                                        <img src="image/payoo-logo-jpg-inkythuatso.jpg" alt="Payoo"
                                            style="height: 15px;">
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
                                <c:choose>
                                    <c:when test="${empty sessionScope.cart or sessionScope.cart.totalQuantity == 0}">
                                        <div style="text-align: center; padding: 20px;">
                                            <p>Giỏ hàng của bạn đang trống</p>
                                            <a href="all-product.jsp"
                                                style="color: #d32f2f; text-decoration: none;">Tiếp tục mua sắm</a>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="item" items="${sessionScope.cart.items}">
                                            <div class="cart-item js-cart-item" data-product-id="${item.product.id}"
                                                data-sku="${item.sku}">
                                                <img src="${not empty item.product.images ? item.product.images[0].imageUrl : 'image/no-image.png'}"
                                                    alt="${item.product.nameProduct}" class="product-image">
                                                <div class="item-details">
                                                    <p>${item.product.nameProduct}</p>
                                                    <p class="item-variant">${item.sku} / ${item.size}</p>
                                                    <p class="current-price">
                                                        <fmt:formatNumber value="${item.price}" pattern="#,###" />₫
                                                    </p>
                                                </div>
                                                <div class="item-controls">
                                                    <button class="remove-btn js-open-modal"
                                                        aria-label="Xóa sản phẩm"><i
                                                            class="fa-solid fa-trash-can"></i></button>
                                                    <div class="overlay js-overlay">
                                                        <div class="popup">
                                                            <h2>Bạn muốn bỏ khỏi giỏ hàng</h2>
                                                            <p class="product">${item.product.nameProduct}</p>
                                                            <div class="actions">
                                                                <button class="btn normal js-close-modal">Quay
                                                                    lại</button>
                                                                <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}&sku=${item.sku}"
                                                                    class="btn danger js-remove-item-link"
                                                                    style="text-decoration: none; color: white;">Bỏ sản
                                                                    phẩm</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="quantity-control">
                                                        <button class="js-decrease-quantity">-</button>
                                                        <span class="js-quantity-display"
                                                            data-quantity="${item.quantity}">${item.quantity}</span>
                                                        <button class="js-increase-quantity">+</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="spacer"></div>

                            <div class="card promotion">
                                <h3>Mã khuyến mãi</h3>
                                <div class="select-promo">
                                    <span>Chọn mã</span>
                                    <button class="btnKhuyenMai" id="btnOpenkm"><i
                                            class="fa-solid fa-chevron-right"></i></button>
                                    <div class="popupOverlay" id="popupOverlay">
                                        <div class="promoModal">
                                            <div class="header-khuyenMai">
                                                <span class="btnCloseTop" id="btnCloseTop"><i
                                                        class="fa-solid fa-xmark"></i></span>
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
                                <c:set var="cartTotal" value="${sessionScope.cart.totalPrice}" />
                                <c:set var="shippingFee" value="${cartTotal >= 1000000 ? 0 : 30000}" />
                                <c:set var="finalTotal" value="${cartTotal + shippingFee}" />

                                <div class="total-row">
                                    <span>Tổng tiền hàng</span>
                                    <span>
                                        <fmt:formatNumber value="${cartTotal}" pattern="#,###" />₫
                                    </span>
                                </div>
                                <div class="total-row">
                                    <span>Phí vận chuyển</span>
                                    <span>
                                        <c:choose>
                                            <c:when test="${shippingFee == 0}">
                                                <span style="color: green;">Miễn phí</span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${shippingFee}" pattern="#,###" />₫
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <hr>
                                <div class="total-row final-total">
                                    <span>Tổng thanh toán</span>
                                    <span>
                                        <fmt:formatNumber value="${finalTotal}" pattern="#,###" />₫
                                    </span>
                                </div>
                                <button class="btn-order"><a href="account.jsp">Đặt hàng</a> </button>
                            </div>
                        </div>
                </div>
                </main>
                </div>
                <jsp:include page="footer.jsp" />
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
                    const btnCloseTop = document.getElementById("btnCloseTop");
                    const btnCloseBottom = document.getElementById("btnCloseBottom");

                    if (btnShowPromo && popupOverlay) {
                        btnShowPromo.onclick = () => popupOverlay.style.display = "flex";
                    }
                    if (btnCloseTop && popupOverlay) {
                        btnCloseTop.onclick = () => popupOverlay.style.display = "none";
                    }
                    if (btnCloseBottom && popupOverlay) {
                        btnCloseBottom.onclick = () => popupOverlay.style.display = "none";
                    }

                </script>
            </body>

            </html>