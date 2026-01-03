<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link rel="icon" href="image/logoaodai.jpg" type="image/jpeg">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style/product-infomation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="scripts/home.js"></script>
<%--    <script src="scripts/product-information.js"></script>--%>
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/backtop.css">
    <script src="scripts/backtop.js"></script>
    <link rel="stylesheet" href="style/breadcrumb.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/quick-view.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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
                                <a href="product-information.html" class="mini-item-name">Áo dài truyền thống Quỳnh Hân</a>
                                <span class="mini-item-meta">Size A / Quỳnh Hân</span>
                                <span class="mini-item-price">711,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li> <img src="image/truyenthong3.png" alt="Áo dài truyền thống Phúc Hương">
                            <div class="mini-item-info">
                                <a href="product-information.html" class="mini-item-name">Áo dài truyền thống Phúc Hương</a>
                                <span class="mini-item-meta">Size A / Phúc Hương</span>
                                <span class="mini-item-price">880,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li> <img src="image/truyenthong4.png" alt="Áo dài truyền thống Quỳnh Châu">
                            <div class="mini-item-info">
                                <a href="product-information.html" class="mini-item-name">Áo dài truyền thống Quỳnh Châu</a>
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
            <li class="breadcrumb-item"><a href="all-product.jsp">Áo dài</a></li> <li class="breadcrumb-item active" aria-current="page">Chi tiết sản phẩm </li>
        </ol>
    </nav>
</div>
<div class="product-container">

    <div class="product-image-gallery">
        <div class="thumbnails">
            <c:forEach items="${p.images}" var="img" varStatus="status">
                <img src="${img.imageUrl}" alt="Ảnh nhỏ ${status.count}" class="thumbnail ${status.first ? 'active' : ''}">
            </c:forEach>
        </div>
        <div class="main-image-wrapper">
            <c:if test="${not empty p.images}">
                <img id="mainImg" src="${p.images[0].imageUrl}"
                     alt="${p.nameProduct}" class="main-image">
            </c:if>
            <c:if test="${empty p.images}">
                <img id="mainImg" src="image/default.jpg" alt="Chưa có ảnh" class="main-image">
            </c:if>
            <a class="left carousel-control fui-arrow-left" href="#myCarousel" data-slide="prev"><i class="fa-solid fa-chevron-left"></i></a>
            <a class="right carousel-control fui-arrow-right" href="#myCarousel" data-slide="next"><i class="fa-solid fa-chevron-right"></i></a>
        </div>
    </div>

    <div class="product-details">
        <h1>${p.nameProduct}</h1>
        <p class="sku">
            Mã sản phẩm: <span id="sku-value">${p.variants[0].sku}</span>
        </p>

        <div class="product-price">
            <span class="old-price">850,000₫</span>
            <span class="current-price">${p.variants[0].currentPrice}</span>
            <span class="discount-tag">15%</span>
            <p class="saving">(<span class="save">Tiết kiệm</span> <span class="price">118.500₫</span>)</p>
        </div>
        <fieldset class="promotion-box-fieldset">
            <legend class="promotion-header-legend">
                🎁 KHUYẾN MÃI - ƯU ĐÃI
            </legend>
            <ul>
                <li>Freeship toàn quốc khi mua hàng qua các kênh Web, FB, Insta (Không áp dụng cho đơn chỉ có phụ kiện dưới 350K)</li>
                <li>Hỏa tốc mọi ngày trong tuần</li>
            </ul>
        </fieldset>
        <div class="section-title">Mã giảm giá</div>
        <div class="section-title">Kích thước: <span id="selected-size">${p.variants[0].size}</span></div>

        <div class="size-options">
            <c:forEach items="${p.variants}" var="variant" varStatus="status">
                <button class="size-btn ${status.first ? 'active' : ''}"
                        data-price="${variant.currentPrice}"
                        data-sku="${variant.sku}"
                        data-color="${variant.color}"
                        data-stock="${variant.stock}"
                        onclick="updateVariant(this, '${variant.size}')">
                        ${variant.size}
                </button>
            </c:forEach>
        </div>

        <div class="section-title">
            Màu sắc: <span id="selected-color">${p.variants[0].color}</span>
        </div>
        <div class="purchase-actions">
            <div class="quantity-control">
                <button type="button" class="qty-btn qty-minus">-</button>
                <input type="text" name="quantity" id="product-quantity" value="1" readonly>
                <button type="button" class="qty-btn qty-plus">+</button>
            </div>

            <button class="add-to-cart-btn" id="them-vao-gio-hang">THÊM VÀO GIỎ</button>
        </div>
        <button class="buy-now-btn"><a href="thanhtoan.jsp">MUA NGAY</a></button>
        <button id="het-hang" class="het_hang" style="display:none;">Hết hàng </button>
        <hr class="dashed-line">
        <div class="shipping">
            <p><span><i class="fa-solid fa-truck-fast"></i></span><span>Giao hàng toàn quốc - quốc tế</span></p>

        </div>
        <details class="baohanh-details">
            <summary>Xem thêm chi tiết</summary>
            <div class="content-chitiet">
                <h5>Thông tin sản phẩm</h5>
                <p>Chất liệu: Vải Linen </p>
                <p style="color: #880000; font-style: italic">Giá trên chưa bao gồm quần và phụ kiện. </p>
                <p>Sản phẩm có sẵn sẽ được gửi đến khách hàng trong thời gian 3-4 ngày kể từ lúc thanh toán online.</p>
            </div>
            <div class="baohanh-img">
                <img src="image/giaiphap.png" alt="Hướng dẫn sử dụng">

            </div>
        </details>
        <hr class="dashed-line">
        <details class="doitra-details">
            <summary>Chính sách đổi trả</summary>
            <hr>
            <ol>
                <li>
                    <div class="content-chinhsach">
                        <p>Việt Sắc Đỏ nhận đổi size, KHÔNG HỖ TRỢ ĐỔI MÀU HAY MẪU KHÁC. Chỉ được đổi size 1 lần với điều kiện cùng mẫu sản phẩm trong vòng 05 ngày kể từ ngày mua hàng. Khi đổi, sản phẩm phải còn hóa đơn, chưa giặt, chưa sử dụng, không có mùi lạ, không bị hư hỏng, còn nguyên nhãn tag.</p>
                    </div>
                </li>
                <li>
                    <div class="content-chinhsach">
                        <p>Chỉ nhận trả hàng hoàn tiền trong trường hợp: hàng gửi đến khách là hàng lỗi, hoặc sai sản phẩm nhưng không có sản phẩm khác thay thế. Sau khi kiểm tra hàng trả còn nhãn tag, chưa qua sử dụng thì Việt Sắc Đỏ sẽ hoàn tiền cho khách hàng trong 1-2 ngày làm việc.</p>
                    </div>
                </li>
                <li>
                    <div class="content-chinhsach">
                        KHÁCH HÀNG VUI LÒNG BÁO TRƯỚC NẾU CÓ NHU CẦU ĐỔI/TRẢ ĐỂ ĐƯỢC HỖ TRỢ. Khách hàng vui lòng đến cửa hàng để đổi hoặc trả phí ship 2 chiều khi đổi hàng từ xa.
                    </div>
                </li>
                <li>
                    <div class="content-chinhsach">
                        Không áp dụng các phương thức đổi/trả cho sản phẩm SALE.
                    </div>
                </li>
                <li>
                    <div class="content-chinhsach">
                        Ngoài những vấn đề trên Việt Sắc Đỏ không nhận đổi/trả hàng trong mọi trường hợp khác.
                    </div>
                </li>
                
            </ol>
           
        </details>
    </div>

</div>
<section class="product-showcase-information tab-component">
    <div class="title-h1-linen">
        <h1>SẢN PHẨM CÙNG LOẠI</h1>
    </div>
    <div class="product-grid">
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_5.png" alt="Áo dài linen hoa Ý Nhiên"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen hoa Ý Nhiên</p></a>
                <div class="product-price">
                    <span class="current-price">720,000₫</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_6.png" alt="Áo dài linen hoa Ý Xuân"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen hoa Ý Xuân</p></a>
                <div class="product-price">
                    <span class="current-price">790,000₫</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_8.png" alt="Áo dài linen Mộc Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Mộc Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="product-showcase-information tab-component">
    <div class="title-h1-linen">
        <h1>SẢN PHẨM ĐÃ XEM</h1>
    </div>
    <div class="product-grid">
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_5.png" alt="Áo dài linen hoa Ý Nhiên"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen hoa Ý Nhiên</p></a>
                <div class="product-price">
                    <span class="current-price">720,000₫</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_6.png" alt="Áo dài linen hoa Ý Xuân"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen hoa Ý Xuân</p></a>
                <div class="product-price">
                    <span class="current-price">790,000₫</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_7.jpg" alt="Áo dài linen Khả Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Khả Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
        <div class="product-card">
            <div class="product-image-wrapper">
                <div class="product-image">
                    <a href=""><img src="image/linen_8.png" alt="Áo dài linen Mộc Lan cổ đứng"></a>
                </div>
                <div class="product-overlay">
                    <a href="product-information.html" class="icon-button" title="Tùy chọn">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </a>
                    <a href="#" class="icon-button" title="Xem nhanh">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                </div>
            </div>

            <div class="product-info">
                <a href=""><p class="product-name">Áo dài linen Mộc Lan cổ đứng</p></a>
                <div class="product-price">
                    <span class="old-price">790,000₫</span>
                    <span class="current-price">671,500₫</span>
                    <span class="discount-tag">15%</span>
                </div>
            </div>
        </div>
    </div>
</section>
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
            <a href="giohang.jsp" class="success-btn">Xem giỏ hàng</a>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
<button onclick="scrollToTop()" id="backToTopBtn" title="Trở về đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>
<script src="${pageContext.request.contextPath}/scripts/product-information.js"></script>
</body>
</html>