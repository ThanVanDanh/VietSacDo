<%--
  Created by IntelliJ IDEA.
  User: laiqua
  Date: 14/12/25
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
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
                <li><a href="${pageContext.request.contextPath}/contactus.jsp">Liên Hệ</a></li>
                <li><a href="${pageContext.request.contextPath}/promotion.jsp">Chương trình khuyến mãi</a></li>
            </ul>
        </nav>
        <div class="icons">

            <a href="#" id="searchTrigger"><i class="fa-solid fa-magnifying-glass"></i></a>

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
                    <span class="mini-count_item count_item_pr">3</span>
                </a>
                <div class="mini-cart-content">
                    <div class="mini-empty-cart">
                        <p>Chưa có sản phẩm trong giỏ hàng</p>
                    </div>
                    <ul class="mini-cart-items-list">
                        <li>
                            <img src="${pageContext.request.contextPath}/image/truyenthong1.png" alt="Áo dài truyền thống Quỳnh Hân">
                            <div class="mini-item-info">
                                <a href="${pageContext.request.contextPath}/product-information.jsp" class="mini-item-name">Áo dài truyền thống Quỳnh Hân</a>
                                <span class="mini-item-meta">Size A / Quỳnh Hân</span>
                                <span class="mini-item-price">711,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li>
                            <img src="${pageContext.request.contextPath}/image/truyenthong3.png" alt="Áo dài truyền thống Phúc Hương">
                            <div class="mini-item-info">
                                <a href="${pageContext.request.contextPath}/product-information.jsp" class="mini-item-name">Áo dài truyền thống Phúc Hương</a>
                                <span class="mini-item-meta">Size A / Phúc Hương</span>
                                <span class="mini-item-price">880,000₫</span>
                                <span class="mini-quantity">x1</span>
                            </div>
                            <button class="remove-item"><i class="fa-solid fa-xmark"></i></button>
                        </li>
                        <li>
                            <img src="${pageContext.request.contextPath}/image/truyenthong4.png" alt="Áo dài truyền thống Quỳnh Châu">
                            <div class="mini-item-info">
                                <a href="${pageContext.request.contextPath}/product-information.jsp" class="mini-item-name">Áo dài truyền thống Quỳnh Châu</a>
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
                        <a href="${pageContext.request.contextPath}/giohang.jsp" class="btn-pay">Tiến hành thanh toán</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</header>
