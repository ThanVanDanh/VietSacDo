<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việt Sắc Đỏ - Trang Chủ</title>
    <link rel="icon" href="${pageContext.request.contextPath}/image/logoaodai.jpg" type="image/jpeg">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/aodai.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/backtop.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style-header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/quick-view.css">
    
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>

<jsp:include page="header.jsp" />

<main>
    <div class="pixfort_pix_slider pix_builder_bg" id="section_slider">
        <div class="container">
            <div class="sixteen columns">
                <div id="myCarousel" class="carousel slide" data-interval="false">
                    <div class="carousel-inner">
                        <c:choose>
                            <c:when test="${not empty banners}">
                                <c:forEach var="banner" items="${banners}" varStatus="status">
                                    <div class="item ${status.index == 0 ? 'active' : ''}">
                                        <img src="${banner.imageUrl}" alt="${not empty banner.altText ? banner.altText : 'Banner'}">
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="item active">
                                    <a href="${pageContext.request.contextPath}/promotionsPost.jsp">
                                        <img src="${pageContext.request.contextPath}/image/aodai.png" alt="Banner 1">
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="${pageContext.request.contextPath}/promotion.jsp">
                                        <img src="${pageContext.request.contextPath}/image/linen.png" alt="Banner 2">
                                    </a>
                                </div>
                                <div class="item">
                                    <a href="${pageContext.request.contextPath}/promotion.jsp">
                                        <img src="${pageContext.request.contextPath}/image/phukien.png" alt="Banner 3">
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <a class="left carousel-control fui-arrow-left" href="#myCarousel" data-slide="prev">
                        <i class="fa-solid fa-chevron-left"></i>
                    </a>
                    <a class="right carousel-control fui-arrow-right" href="#myCarousel" data-slide="next">
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
<%--section--%>
    <c:forEach var="section" items="${dynamicSections}" varStatus="sectionStatus">
        <c:set var="sectionClass" value="${sectionStatus.index % 2 == 0 ? 'product-showcase' : 'product-showcase-top'}" />
        
        <section class="${sectionClass} tab-component">
            <div class="signature-header">
                <h1>${section.title}</h1>
            </div>
            <nav class="main-nav">
                <ul>
                    <c:forEach var="tab" items="${section.tabs}" varStatus="tabStatus">
                        <li>
                            <a href="#" class="tab-link ${tabStatus.index == 0 ? 'active' : ''}"
                               data-target="sec-${section.key}-tab-${tab.index}">
                                ${tab.title}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>

            <c:forEach var="tab" items="${section.tabs}" varStatus="tabStatus">
                <div id="sec-${section.key}-tab-${tab.index}"
                     class="product-gallery ${tabStatus.index == 0 ? 'active-gallery' : 'hidden-gallery'} tab-content">

                    <c:forEach var="product" items="${tab.products}">
                        <div class="product-card">
                            <div class="product-image-wrapper">
                                <div class="product-image">
                                    <c:set var="thumbnail" value="${not empty product.thumbnail ? product.thumbnail : ''}" />
                                    <c:if test="${empty thumbnail}">
                                        <c:set var="thumbnail" value="${pageContext.request.contextPath}/image/no-image.png" />
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">
                                        <img src="${thumbnail}" alt="${product.nameProduct}">
                                    </a>
                                </div>
                                <div class="product-overlay">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}" 
                                       class="icon-button" title="Xem chi tiết">
                                        <i class="fa-solid fa-cart-shopping"></i>
                                    </a>
                                    <a href="#" class="icon-button quick-view-btn" 
                                       data-id="${product.id}" title="Xem nhanh">
                                        <i class="fa-solid fa-eye"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="product-info">
                                <a href="${pageContext.request.contextPath}/product-detail?id=${product.id}">
                                    <p class="product-name">${product.nameProduct}</p>
                                </a>
                                <div class="product-price">
                                    <span class="current-price">
                                        <fmt:formatNumber value="${product.price}" pattern="#,###"/>₫
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tab.products}">
                        <div class="empty-products" style="text-align: center; padding: 40px; color: #999;">
                            <i class="fas fa-box-open" style="font-size: 48px; margin-bottom: 15px;"></i>
                            <p>Chưa có sản phẩm trong danh mục này</p>
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </section>
    </c:forEach>

    <c:if test="${empty dynamicSections}">
        <section class="product-showcase">
            <div class="signature-header">
                <h1>Sản phẩm nổi bật</h1>
            </div>
            <div class="empty-products" style="text-align: center; padding: 60px; color: #999;">
                <i class="fas fa-cog" style="font-size: 48px; margin-bottom: 15px;"></i>
                <p>Chưa có cấu hình trang chủ. Vui lòng cấu hình trong Admin.</p>
            </div>
        </section>
    </c:if>
<%--intagram--%>
    <section class="sumire-review-section">
        <div class="instagram-follow">
            <p class="follow-text">Follow @vietsacdo</p>
            <div class="instagram-gallery">
                <c:forEach var="i" begin="1" end="5">
                    <div class="gallery-item">
                        <img src="${pageContext.request.contextPath}/image/insta${i}.jpg" alt="Sản phẩm Việt Sắc Đỏ">
                        <a href="#" class="insta-overlay" target="_blank">
                            <i class="fab fa-instagram"></i>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="thank-you-message">
            <p>Cảm ơn bạn và chị đã lựa chọn sản phẩm của Việt Sắc Đỏ</p>
        </div>

    </section>
</main>

<div id="quick-view-model" class="model-overlay">
    <div class="quick-content-model">
        <div class="model-image">
            <img class="large-image" src="${pageContext.request.contextPath}/image/truyenthong1.png" alt="Áo dài">
            <div class="model-group-img swiper">
                <div class="swiper-wrapper">
                    <c:forEach var="i" begin="1" end="6">
                        <div class="swiper-slide">
                            <img src="${pageContext.request.contextPath}/image/truyenthong1.png">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="model-content">
            <h2>Áo dài truyền thống Quỳnh Hân</h2>
            <div class="model-info">
                <p>Thương hiệu: <a href="${pageContext.request.contextPath}/home">Việt Sắc Đỏ</a>
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
                    <c:forTokens items="S,M,L,XL,XXL" delims="," var="size">
                        <input type="radio" name="size" id="size-${size}">
                        <label for="size-${size}">${size}</label>
                    </c:forTokens>
                </div>
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
        <div class="success-footer">
            <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">Thanh toán</a>
            <a href="${pageContext.request.contextPath}/cart" class="success-btn">Xem giỏ hàng</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />

<button onclick="scrollToTop()" id="backToTopBtn" title="Trở về đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>

<script src="${pageContext.request.contextPath}/scripts/home.js"></script>
<script src="${pageContext.request.contextPath}/scripts/backtop.js"></script>
</body>
</html>
