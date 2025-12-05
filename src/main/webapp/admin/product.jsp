<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="../style/productStyle.css">
</head>
<body>
<div class="admin-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="dashboard.jsp">
                <img src="/image/logo.png" alt="Logo Việt Sắc Đỏ">
            </a>
            <h2>Trang Admin</h2>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li class="nav-item"><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
                <li class="nav-item active"><a href="product.html"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a></li>
                <li class="nav-item"><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a></li>
                <li class="nav-item"><a href="customers.jsp"><i class="fas fa-users"></i> Quản lý Khách hàng</a></li>
                <li class="nav-item"><a href="contact-admin.jsp"><i class="fa-regular fa-address-book"></i> Quản lý Liên hệ</a></li>
                <li class="nav-item"><a href="promotions.jsp"><i class="fas fa-tags"></i> Khuyến mãi</a></li>
                <li class="nav-item">
                    <a href="../index.jsp"><i class="fas fa-sign-out-alt"></i> Trở về Trang Chủ</a>
                </li>
            </ul>
        </nav>
    </div>
    <main class="main-content">
        <header class="admin-header">
            <div class="header-actions">
                <a href="../login.jsp" class="btn-logout"><i class="fas fa-user-circle"></i> Đăng xuất</a>
            </div>
        </header>

        <div class="product-section">
            <div class="product-list-header">
                <h2>Danh sách Sản phẩm</h2>
                <a href="#" class="btn-add-product" id="addProductBtn">
                    <i class="fas fa-plus"></i> Thêm Sản phẩm
                </a>
            </div>

            <table class="product-table">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên Sản phẩm</th>
                    <th>Trạng thái</th>
                    <th>Lượt mua</th>
                    <th>Doanh số</th>
                    <th>Tồn kho</th>
                    <th>Giá</th>
                    <th>Cài đặt</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><img src="/image/adtt01.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa - thêu tay Hương Lài Đỏ</td>
                    <td><span class="status active">Hoạt động</span></td>
                    <td>50</td>
                    <td>$750</td>
                    <td><span class="stock in-stock">700</span></td>
                    <td>$15</td>
                    <td class="settings-icons">
                        <a href="#" class="edit-btn" title="Sửa"
                           data-id="P001"
                           data-name="Áo dài thêu tay"
                           data-img="/image/adtt01.png"
                           data-category="ao-dai"
                           data-type="ao-dai-theu-tay"
                           data-quantity="50"
                           data-sku="ADTT01"
                           data-price="15">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><img src="../image/adtt06.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa Thêu tay Hương Lài - Xanh biển nhạt</td>
                    <td><span class="status disabled">Không hoạt động</span></td>
                    <td>60</td>
                    <td>$1020</td>
                    <td><span class="stock in-stock">10</span></td>
                    <td>$17</td>
                    <td class="settings-icons">
                        <a href="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><img src="../image/adtt02.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa Thêu tay Hương Lài - Hồng đào</td>
                    <td><span class="status disabled">Không hoạt động</span></td>
                    <td>70</td>
                    <td>$1050</td>
                    <td><span class="stock out-of-stock">0</span></td>
                    <td>$15</td>
                    <td class="settings-icons">
                        <a href="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><img src="../image/adtt03.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa Thêu tay Hương Lài - Hồng dâu</td>
                    <td><span class="status active">Hoạt động</span></td>
                    <td>120</td>
                    <td>$1440</td>
                    <td><span class="stock in-stock">250</span></td>
                    <td>$12</td>
                    <td class="settings-icons">
                        <a href="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><img src="../image/adtt04.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa Thêu tay Hương Lài - Kem nhạt</td>
                    <td><span class="status active">Hoạt động</span></td>
                    <td>30</td>
                    <td>$540</td>
                    <td><span class="stock in-stock">100</span></td>
                    <td>$18</td>
                    <td class="settings-icons">
                        <a href="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <tr>
                    <td><img src="../image/adtt05.png" alt="Product Image"></td>
                    <td>Áo dài Bách Hoa Thêu tay Hương Lài - Tím nhạt</td>
                    <td><span class="status disabled">Không hoạt động</span></td>
                    <td>400</td>
                    <td>$4000</td>
                    <td><span class="stock out-of-stock">0</span></td>
                    <td>$10</td>
                    <td class="settings-icons">
                        <a href="#" title="Sửa"><i class="fa-solid fa-pen-to-square"></i></a>
                        <a href="#" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="pagination">
                <a href="#">Trước</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">Sau</a>
            </div>
        </div>
        <div id="addProductModal" class="modal-overlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle">Thêm Sản phẩm mới</h2>
                    <span class="close-button" id="closeModalBtn">&times;</span>
                </div>

                <form id="addProductForm">
                    <div class="modal-body">
                        <div class="modal-form-grid">

                            <h3 style="grid-column: 1 / -1; font-size: 16px; border-bottom: 1px solid #ddd; padding-bottom: 5px; margin-top: 0;">
                                1. Thông tin chung
                            </h3>

                            <div class="form-group-modal">
                                <label for="product-name">Tên Sản phẩm <span style="color:red">*</span></label>
                                <input type="text" id="product-name" required placeholder="Nhập tên sản phẩm">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-category">Danh mục <span style="color:red">*</span></label>
                                <select id="product-category" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <option value="ao-dai">Áo dài</option>
                                    <option value="quan-phu-kien">Quần & Phụ kiện</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-type">Loại sản phẩm</label>
                                <select id="product-type" required disabled>
                                    <option value="">-- Chọn danh mục trước --</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-status">Trạng thái</label>
                                <select id="product-status">
                                    <option value="active">Hoạt động</option>
                                    <option value="inactive">Không hoạt động</option>
                                </select>
                            </div>

                            <div class="form-group-modal" style="grid-column: 1 / -1;">
                                <label for="product-description">Mô tả sản phẩm</label>
                                <textarea id="product-description" rows="3" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;" placeholder="Nhập mô tả chi tiết..."></textarea>
                            </div>

                            <h3 style="grid-column: 1 / -1; font-size: 16px; border-bottom: 1px solid #ddd; padding-bottom: 5px; margin-top: 10px;">
                                2. Chi tiết biến thể
                            </h3>

                            <div class="form-group-modal">
                                <label for="variant-size">Kích thước (Size)</label>
                                <select id="variant-size">
                                    <option value="S">S</option>
                                    <option value="M">M</option>
                                    <option value="L">L</option>
                                    <option value="XL">XL</option>
                                    <option value="FREE">Freesize</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="variant-color">Màu sắc</label>
                                <input type="text" id="variant-color" placeholder="Vd: Đỏ, Xanh...">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-sku">Mã SKU</label>
                                <input type="text" id="product-sku" placeholder="Mã kho">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-quantity">Tồn kho <span style="color:red">*</span></label>
                                <input type="number" id="product-quantity" min="0" value="0" required>
                            </div>

                            <div class="form-group-modal">
                                <label for="original-price">Giá gốc (VND)</label>
                                <input type="number" id="original-price" min="0" step="1000" placeholder="Giá trước giảm">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-price">Giá bán (VND) <span style="color:red">*</span></label>
                                <input type="number" id="product-price" min="0" step="1000" required placeholder="Giá thực tế">
                            </div>

                            <h3 style="grid-column: 1 / -1; font-size: 16px; border-bottom: 1px solid #ddd; padding-bottom: 5px; margin-top: 10px;">
                                3. Hình ảnh
                            </h3>

                            <div class="form-group-modal" style="grid-column: 1 / -1;">
                                <input type="file" id="product-image-input" accept="image/*" multiple>
                                <label for="product-image-input" class="product-image-upload">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Nhấn để tải ảnh lên (Hỗ trợ nhiều ảnh)</p>
                                    <img src="" alt="Xem trước" id="product-image-preview">
                                </label>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-modal-secondary" id="cancelModalBtn">Hủy</button>
                        <button type="submit" class="btn-modal btn-modal-primary" id="modalSubmitBtn">Lưu Sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
</div>

<script>
    // --- 1. LẤY CÁC PHẦN TỬ CHÍNH ---
    const modal = document.getElementById("addProductModal");
    const modalTitle = document.getElementById("modalTitle");
    const modalSubmitBtn = document.getElementById("modalSubmitBtn");
    const openBtn = document.getElementById("addProductBtn");
    const closeBtn = document.getElementById("closeModalBtn");
    const cancelBtn = document.getElementById("cancelModalBtn");

    // Form fields
    const addProductForm = document.getElementById("addProductForm");
    const productName = document.getElementById("product-name");
    const productCategory = document.getElementById("product-category");
    const productType = document.getElementById("product-type");
    const productQuantity = document.getElementById("product-quantity");
    const productSku = document.getElementById("product-sku");
    const productPrice = document.getElementById("product-price");

    // Image preview
    const imageInput = document.getElementById('product-image-input');
    const imagePreview = document.getElementById('product-image-preview');
    const uploadIcon = document.querySelector('.product-image-upload i');
    const uploadText = document.querySelector('.product-image-upload p');

    // --- 2. LOGIC DROPDOWN PHỤ THUỘC ---
    const categoryTypes = {
        "ao-dai": ["Áo dài truyền thống", "Áo dài thêu tay", "Áo dài linen"],
        "quan-phu-kien": ["Chân váy", "Quần Phương Chi", "Quần Quế Chi", "Mấn áo dài", "Vòng tay", "Hoa tai", "Guốc gỗ"]
    };

    function populateProductTypes(selectedCategory) {
        productType.innerHTML = ''; // Xóa sạch
        if (selectedCategory) {
            productType.disabled = false;
            let defaultOption = document.createElement('option');
            defaultOption.value = "";
            defaultOption.textContent = "-- Chọn loại sản phẩm --";
            productType.appendChild(defaultOption);

            const types = categoryTypes[selectedCategory];
            if (types) {
                types.forEach(function(type) {
                    let option = document.createElement('option');
                    let optionValue = type.toLowerCase()
                        .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
                        .replace(/đ/g, 'd').replace(/ /g, '-');
                    option.value = optionValue;
                    option.textContent = type;
                    productType.appendChild(option);
                });
            }
        } else {
            let defaultOption = document.createElement('option');
            defaultOption.value = "";
            defaultOption.textContent = "-- Vui lòng chọn danh mục trước --";
            productType.appendChild(defaultOption);
            productType.disabled = true;
        }
    }

    productCategory.addEventListener('change', function() {
        populateProductTypes(this.value);
    });

    // --- 3. HÀM DỌN DẸP VÀ MỞ/ĐÓNG MODAL ---

    // Hàm dọn dẹp form
    function resetModalForm() {
        addProductForm.reset(); // Reset tất cả input
        productType.innerHTML = ''; // Xóa sạch loại SP
        let defaultOption = document.createElement('option');
        defaultOption.value = "";
        defaultOption.textContent = "-- Vui lòng chọn danh mục trước --";
        productType.appendChild(defaultOption);
        productType.disabled = true;

        // Reset ảnh
        imagePreview.style.display = 'none';
        imagePreview.src = "";
        uploadIcon.style.display = 'block';
        uploadText.style.display = 'block';
    }

    // Mở modal (cho nút "Thêm")
    openBtn.onclick = function(event) {
        event.preventDefault();
        resetModalForm(); // Dọn dẹp form
        modalTitle.textContent = "Thêm Sản phẩm mới"; // Đặt lại tiêu đề
        modalSubmitBtn.textContent = "Lưu Sản phẩm"; // Đặt lại nút
        modal.style.display = "block";
    }

    // Đóng modal (chung)
    function closeModal() {
        modal.style.display = "none";
    }
    closeBtn.onclick = closeModal;
    cancelBtn.onclick = closeModal;
    window.onclick = function(event) {
        if (event.target == modal) {
            closeModal();
        }
    }

    // --- 4. LOGIC NÚT "CHỈNH SỬA" ---

    // Lấy TẤT CẢ các nút Sửa
    const editButtons = document.querySelectorAll(".edit-btn");

    // Gắn sự kiện click cho từng nút
    editButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault(); // Ngăn <a>

            resetModalForm(); // Dọn dẹp form trước

            // Lấy data từ các thuộc tính data-* của nút <a>
            const data = this.dataset;

            // 1. Đổi tiêu đề & nút
            modalTitle.textContent = "Chỉnh sửa Sản phẩm";
            modalSubmitBtn.textContent = "Cập nhật Sản phẩm";

            // 2. Nạp (fill) dữ liệu vào form
            productName.value = data.name;
            productSku.value = data.sku;
            productQuantity.value = data.quantity;
            productPrice.value = data.price;

            // 3. Nạp (fill) ảnh
            imagePreview.src = data.img;
            imagePreview.style.display = 'block';
            uploadIcon.style.display = 'none';
            uploadText.style.display = 'none';

            // 4. Nạp (fill) dropdown phụ thuộc (QUAN TRỌNG)
            // 4.1. Đặt giá trị cho Danh mục
            productCategory.value = data.category;

            // 4.2. "Giả lập" sự kiện change để nó tự nạp Loại sản phẩm
            // Cách 1: dispatchEvent (chuẩn)
            // productCategory.dispatchEvent(new Event('change'));

            // Cách 2: Gọi thẳng hàm (dễ hiểu hơn)
            populateProductTypes(data.category);

            // 4.3. Đặt giá trị cho Loại sản phẩm
            productType.value = data.type;

            // 5. Hiển thị modal
            modal.style.display = "block";
        });
    });


    // --- 5. LOGIC XEM TRƯỚC ẢNH KHI UPLOAD ---
    imageInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.src = e.target.result;
                imagePreview.style.display = 'block';
                uploadIcon.style.display = 'none';
                uploadText.style.display = 'none';
            }
            reader.readAsDataURL(file);
        }
    });

</script>

</body>
</html>