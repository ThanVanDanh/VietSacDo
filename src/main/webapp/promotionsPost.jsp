<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giảm 10% Album Mới & Tặng Quà - Sumire Store</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="style/style-header.css">
    <link rel="stylesheet" href="style/footer.css">
    <link rel="stylesheet" href="style/promotionsPoststyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
                    <ul class="sub-menu">
                        <div class="mega-menu-container">
                            <div class="mega-menu-content">

                                <div class="category-column">
                                    <h3>Quần & váy phối áo dài</h3>
                                    <ul>
                                        <li><a href="chanvay.jsp">Chân Váy</a></li>
                                        <li><a href="quanphuongchi.jsp">Quần Phương Chi</a></li>
                                        <li><a href="quanquechi.jsp">Quần Quế Chi</a></li>
                                        <li><a href="quanvanchi.jsp">Quần Vân Chi</a></li>
                                        <li><a href="quanmaichi.jsp">Quần Mai Chi</a></li>
                                        <li><a href="quantrucchi.jsp">Quần Trúc Chi</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Phụ kiện</h3>
                                    <ul>
                                        <li><a href="manaodai.jsp">Mấn áo dài</a></li>
                                        <li><a href="vongtay.jsp">Vòng tay</a></li>
                                        <li><a href="hoatai.jsp">Hoa tai</a></li>
                                        <li><a href="guocgo.jsp">Guốc gỗ</a></li>
                                        <li><a href="tuixach.jsp">Túi xách</a></li>
                                        <li><a href="daychuyen.jsp">Dây chuyền</a></li>
                                        <li><a href="kepvanocaitoc.jsp">Kẹp & nơ cài tóc</a></li>
                                    </ul>
                                </div>

                                <div class="category-column">
                                    <h3>Nón Lá</h3>
                                    <ul>
                                        <li><a href="nonlahodiep.jsp">Nón lá bọc vải Hồ điệp</a></li>
                                        <li><a href="nonlahoabuoi.jsp">Nón lá bọc vải Chè hoa bưởi</a></li>
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
</header>

<main>
    <article class="blog-post">
            <h1>Giảm 10% Album Mới & Tặng Quạt gỗ kèm dây charm Hồ điệp</h1>
            <p class="post-meta">Đăng bởi Sumire Store | Ngày 24/12/2024</p>

        <div class="image-placeholder">
            <img id="imgpost" src="image/promotionspost.jpg" alt="">
        </div>

        <div class="post-content">
            <p><strong>Áo khoác Tứ thân cách tân & Đầm cổ yếm "Nhạn vũ huyên ca"</strong></p>

            <ul>
                <li>Mua sớm hoặc Pre-order từ hôm nay để nhận ưu đãi giảm 10%, áp dụng cho kênh bán FB/Insta và Cửa hàng (kết thúc vào 31.12.2024)</li>
                <li>Quà tặng cùng khi mua Set Áo khoác + Đầm yếm: Quạt gỗ kèm dây charm Hồ điệp 90k</li>
            </ul>

            <p>Sau những mùa Tứ thân được chị bạn yêu quý vô cùng, Sumire Store đã sẵn sàng đem form dáng tựa như thơ ấy quay trở lại mùa Tết Xuân năm nay rồi đây ạ.</p>

            <p><strong>"Nhạn vũ huyên ca"</strong> – mang nghĩa cánh nhạn bay lượn trong khúc ca mùa xuân. Bộ đôi Áo khoác Tứ thân Xuân Huyên và Đầm cổ yếm Xuân Nhạn, tựa như câu đối đáp mùa Lễ - Hội, mang trên mình nét bay bổng thi vị và màu sắc rạng rỡ yêu kiều của những ngày đất trời xinh đẹp nhất lòng người.</p>

            <p>Với nhiều chất liệu kết hợp tỉ mỉ, từ tằm nhung vân mờ đến organza ánh nhũ hay những lớp tùng váy tơ thêu hoa, đến viền cửa tay đính hạt thủ công chu toàn và lớp vải lót mịn mềm hiền dịu... Sumire Store mong chị bạn mình sẽ có thêm nhiều sự lựa chọn...</p>

            <p>Khi chọn mua cả Set Áo khoác + Đầm yếm, Sumire xin gửi cùng món quà nhỏ xinh là chiếc Quạt gỗ kèm dây charm Hồ điệp, để khung hình Tết Xuân này của chị bạn thêm xinh xắn và thanh tú.</p>

            <h3>Thông tin sản phẩm:</h3>
            <ul>
                <li>🌸 Áo khoác Tứ thân Xuân Huyên - Giá Mua sớm/Pre-order 675.000 (Giá gốc 750.000)</li>
                <li>🌸 Đầm cổ yếm Xuân Nhạn - Giá Mua sớm/Pre-order 792.000 (Giá gốc 880.000)</li>
                <li>🌸 Quần Phương Chi /Vĩnh Chi - 390.000 ~ 490.000</li>
                <li>🌸 Guốc gỗ đế cao/nhung kim sa - 250.000 ~ 350.000</li>
            </ul>

            <p>Mời chị bạn ghé chơi ướm thử áo xinh, mang thử guốc nhỏ, hoặc nàng có thể inbox để chúng mình tư vấn thật chu đáo.</p>
            <p>Mã giảm 10% Album Mới & Tặng Quạt gỗ kèm dây charm Hồ điệp: BA214JBA</p>
            <p><em>Từ Việt Sắc Đỏ, với-rất-nhiều-yêu-thương.</em></p>

            <p class="disclaimer">* Hình ảnh và sản phẩm được thực hiện bởi Việt Sắc Đỏ. Vui lòng không đăng tải lại nơi khác.</p>
        </div>
    </article>
</main>

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

<script src="script.js"></script>
</body>
</html>