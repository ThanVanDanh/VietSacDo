<%--
  Created by IntelliJ IDEA.
  User: laiqua
  Date: 14/12/25
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
    <div class="header">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/index.jsp">
                <img src="${pageContext.request.contextPath}/image/logo.png" alt="Logo Việt Sắc Đỏ">
            </a>
        </div>
        <nav>
            <ul class="menu">
                <li><a href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a></li>

                <li><a href="#">Áo dài<i class="fa-solid fa-chevron-down"></i></a>
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/danh-muc/ao-dai-truyen-thong">Áo dài truyền thống</a></li>
                        <li><a href="${pageContext.request.contextPath}/danh-muc/ao-dai-theu-tay">Áo dài thêu tay</a></li>
                        <li><a href="${pageContext.request.contextPath}/danh-muc/ao-dai-linen">Áo dài linen</a></li>
                    </ul>
                </li>

                <li class="has-megamenu"><a href="#">Quần & Phụ kiện<i class="fa-solid fa-chevron-down"></i></a>
                    <ul class="sub-menu">
                        <div class="mega-menu-container">
                            <div class="mega-menu-content">

                                <div class="category-column">
                                    <h3>Quần & váy phối áo dài</h3>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/chan-vay">Chân Váy</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/quan-phuong-chi">Quần Phương Chi</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/quan-que-chi">Quần Quế Chi</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/quan-van-chi">Quần Vân Chi</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/quan-mai-chi">Quần Mai Chi</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/quan-truc-chi">Quần Trúc Chi</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Phụ kiện</h3>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/man-doi-dau">Mấn áo dài</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/vong-tay">Vòng tay</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/hoa-tai">Hoa tai</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/guoc-go">Guốc gỗ</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/tui-xach">Túi xách</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/day-chuyen">Dây chuyền</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/kep-no-cai-toc">Kẹp & nơ cài tóc</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Nón Lá</h3>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/non-la-ho-diep">Nón lá bọc vải Hồ điệp</a></li>
                                        <li><a href="${pageContext.request.contextPath}/danh-muc/non-la-hoa-buoi">Nón lá bọc vải Chè hoa bưởi</a></li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                    </ul>
                </li>
                <li><a href="${pageContext.request.contextPath}/contact_us">Liên Hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/promotion.jsp">Chương trình khuyến mãi</a></li>
            </ul>
        </nav>
        <div class="icons">

            <a href="#" id="searchTrigger"><i class="fa-solid fa-magnifying-glass"></i></a>

            <div class="user-menu">
                <a><i class="fa-regular fa-user"></i></a>
                <ul class="user">
                    <% if (session.getAttribute("account") != null) { %>
                    <li><a href="${pageContext.request.contextPath}/account">Tài khoản</a></li>
                    <li><a href="${pageContext.request.contextPath}/Logout">Đăng xuất</a></li>
                    <% } else { %>
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a></li>
                    <li><a href="${pageContext.request.contextPath}/signup.jsp">Đăng ký</a></li>
                    <% } %>
                </ul>
            </div>

            <div class="mini-cart-menu">
                <a href="${pageContext.request.contextPath}/giohang.jsp" title="Giỏ hàng">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="mini-count_item count_item_pr">
                        ${sessionScope.cart == null ? 0 : sessionScope.cart.totalQuantity}
                    </span>
                </a>

                <div class="mini-cart-content">
                    <%-- KHỐI 1: GIỎ HÀNG TRỐNG --%>
                    <div class="mini-empty-cart js-mini-cart-empty"
                         style="display: ${sessionScope.cart == null || sessionScope.cart.totalQuantity == 0 ? 'block' : 'none'}; text-align: center; padding: 20px;">
                        <p>Chưa có sản phẩm trong giỏ hàng</p>
                    </div>

                    <%-- KHỐI 2: CÓ SẢN PHẨM --%>
                    <div class="js-mini-cart-has-item"
                         style="display: ${sessionScope.cart != null && sessionScope.cart.totalQuantity > 0 ? 'block' : 'none'};">

                        <ul class="mini-cart-items-list js-mini-cart-list">
                            <c:if test="${sessionScope.cart != null}">
                                <c:forEach var="item" items="${sessionScope.cart.items}">
                                    <li class="item-cart-row">
                                        <div class="img-container">
                                            <img src="${not empty item.product.images ? item.product.images[0].imageUrl : pageContext.request.contextPath.concat('/image/no-image.png')}"
                                                 alt="${item.product.nameProduct}">
                                        </div>

                                        <div class="mini-item-info">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}" class="mini-item-name">
                                                    ${item.product.nameProduct}
                                            </a>
                                            <div class="mini-item-meta" style="font-size: 12px; color: #666; margin-bottom: 5px;">
                                                <c:if test="${not empty item.size}">Size: <strong>${item.size}</strong></c:if>
                                                <c:if test="${not empty item.sku}"> / Mã: ${item.sku}</c:if>
                                            </div>
                                            <span class="mini-item-price">
                                                <fmt:formatNumber value="${item.price}" pattern="#,###"/>₫
                                            </span>
                                            <span class="mini-quantity">x${item.quantity}</span>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/CartController?action=remove&id=${item.product.id}&sku=${item.sku}"
                                           class="remove-item" onclick="return confirm('Xóa sản phẩm này?')">
                                            <i class="fa-solid fa-xmark"></i>
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>

                        <div class="mini-cart-footer">
                            <div class="mini-cart-total">
                                <span>Tổng tiền tạm tính:
                                    <strong class="mini-total-price js-mini-total-price">
                                        <fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/>₫
                                    </strong>
                                </span>
                            </div>
                            <a href="${pageContext.request.contextPath}/giohang.jsp" class="btn-pay">Tiến hành thanh toán</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="search-overlay-container" id="searchOverlay">
    <div class="search-overlay-header">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/index.jsp">
                <img src="${pageContext.request.contextPath}/image/logo.png" alt="Logo Việt Sắc Đỏ">
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
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a></li>
                    <li><a href="${pageContext.request.contextPath}/signup.jsp">Đăng ký</a></li>
                </ul>
            </div>

            <div class="mini-cart-menu">
                <a href="${pageContext.request.contextPath}/giohang.jsp" title="Giỏ hàng">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="mini-count_item count_item_pr">
                        ${sessionScope.cart == null ? 0 : sessionScope.cart.totalQuantity}
                    </span>
                </a>

                <div class="mini-cart-content">
                    <%-- KHỐI 1: GIỎ HÀNG TRỐNG --%>
                    <div class="mini-empty-cart js-mini-cart-empty"
                         style="display: ${sessionScope.cart == null || sessionScope.cart.totalQuantity == 0 ? 'block' : 'none'}; text-align: center; padding: 20px;">
                        <p>Chưa có sản phẩm trong giỏ hàng</p>
                    </div>

                    <%-- KHỐI 2: CÓ SẢN PHẨM --%>
                    <div class="js-mini-cart-has-item"
                         style="display: ${sessionScope.cart != null && sessionScope.cart.totalQuantity > 0 ? 'block' : 'none'};">

                        <ul class="mini-cart-items-list js-mini-cart-list">
                            <c:if test="${sessionScope.cart != null}">
                                <c:forEach var="item" items="${sessionScope.cart.items}">
                                    <li class="item-cart-row">
                                        <div class="img-container">
                                            <img src="${not empty item.product.images ? item.product.images[0].imageUrl : pageContext.request.contextPath.concat('/image/no-image.png')}"
                                                 alt="${item.product.nameProduct}">
                                        </div>

                                        <div class="mini-item-info">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}" class="mini-item-name">
                                                    ${item.product.nameProduct}
                                            </a>
                                            <div class="mini-item-meta" style="font-size: 12px; color: #666; margin-bottom: 5px;">
                                                <c:if test="${not empty item.size}">Size: <strong>${item.size}</strong></c:if>
                                                <c:if test="${not empty item.sku}"> / Mã: ${item.sku}</c:if>
                                            </div>
                                            <span class="mini-item-price">
                                                <fmt:formatNumber value="${item.price}" pattern="#,###"/>₫
                                            </span>
                                            <span class="mini-quantity">x${item.quantity}</span>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/CartController?action=remove&id=${item.product.id}&sku=${item.sku}"
                                           class="remove-item" onclick="return confirm('Xóa sản phẩm này?')">
                                            <i class="fa-solid fa-xmark"></i>
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:if>
                        </ul>

                        <div class="mini-cart-footer">
                            <div class="mini-cart-total">
                                <span>Tổng tiền tạm tính:
                                    <strong class="mini-total-price js-mini-total-price">
                                        <fmt:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###"/>₫
                                    </strong>
                                </span>
                            </div>
                            <a href="${pageContext.request.contextPath}/giohang.jsp" class="btn-pay">Tiến hành thanh toán</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="search-overlay-close-area" id="searchCloseArea"></div>
</div>