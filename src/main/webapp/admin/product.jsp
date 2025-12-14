<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý Sản phẩm</title>

    <!-- Single CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="../style/productStyle.css">
</head>
<body>
<div class="admin-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="dashboard.jsp"><img src="${pageContext.request.contextPath}/image/logo.png" alt="Logo"></a>
            <h2>Trang Admin</h2>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li class="nav-item"><a href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Tổng quan</a></li>
                <li class="nav-item active"><a href="#"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a></li>
                <li class="nav-item"><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a></li>
                <li class="nav-item"><a href="customers.jsp"><i class="fas fa-users"></i> Quản lý Khách hàng</a></li>
                <li class="nav-item"><a href="contact-admin.jsp"><i class="fa-regular fa-address-book"></i> Quản lý Liên hệ</a></li>
                <li class="nav-item"><a href="promotions.jsp"><i class="fas fa-tags"></i> Khuyến mãi</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-sign-out-alt"></i> Trở về Trang Chủ</a></li>
            </ul>
        </nav>
    </div>

    <!-- Main -->
    <main class="main-content">
        <header class="admin-header">
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-logout"><i class="fas fa-user-circle"></i> Đăng xuất</a>
            </div>
        </header>

        <section class="product-section">
            <div class="product-list-header">
                <h2>Danh sách Sản phẩm</h2>

                <!-- SEARCH INPUT -->
                <div class="search-wrapper" style="margin-left:auto; margin-right:12px;">
                    <input type="search" id="globalSearchInput" class="search-input" placeholder="Tìm theo tên, mã, danh mục..." aria-label="Tìm sản phẩm">
                </div>

                <div class="actions-row">
                    <a href="#" class="btn btn-secondary" id="addCategoryBtn"><i class="fas fa-folder-plus"></i> Thêm Danh mục</a>
                    <a href="#" class="btn btn-primary" id="addProductBtn"><i class="fas fa-plus"></i> Thêm Sản phẩm</a>
                </div>
            </div>

            <!-- Table (server-side render recommended) -->
            <table class="product-table">
                <thead>
                <tr>
                    <th>Ảnh</th>
                    <th>Tên / Mã</th>
                    <th>Danh mục</th>
                    <th>Trạng thái</th>
                    <th>Biến thể</th>
                    <th>Tồn kho</th>
                    <th>Giá</th>
                    <th>Ngày tạo</th>
                    <th>Cài đặt</th>
                </tr>
                </thead>
                <tbody id="productTableBody">
                <!-- Server should render rows here -->
                </tbody>
            </table>

            <div class="pagination">
                <a href="#">Trước</a>
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">Sau</a>
            </div>
        </section>

        <!-- Add/Edit Product Modal -->
        <div id="addProductModal" class="modal-overlay" aria-hidden="true">
            <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
                <div class="modal-header">
                    <h2 id="modalTitle">Thêm Sản phẩm mới</h2>
                    <span class="close-button" id="closeModalBtn">&times;</span>
                </div>

                <!-- FORM gửi trực tiếp tới servlet AddProductServlet -->
                <form id="addProductForm" action="${pageContext.request.contextPath}/admin/product/add" method="post" enctype="multipart/form-data" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="product-name">Tên Sản phẩm <span style="color:red">*</span></label>
                                <input name="product-name" type="text" id="product-name" required placeholder="Tên sản phẩm">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-code">Mã sản phẩm (product_code)</label>
                                <input name="product-code" type="text" id="product-code" placeholder="VD: ADTT01">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-category">Danh mục <span style="color:red">*</span></label>
                                <div style="display:flex; gap:8px; align-items:center;">
                                    <select name="product-category" id="product-category" required>
                                        <option value="">-- Đang tải danh mục --</option>
                                    </select>
                                    <a href="#" id="openAddCategoryFromProduct" class="btn btn-secondary">Thêm</a>
                                </div>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-status">Trạng thái</label>
                                <select name="product-status" id="product-status">
                                    <option value="active">active</option>
                                    <option value="inactive">inactive</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-created-at">Ngày tạo (tùy chọn)</label>
                                <input name="product-created-at" type="datetime-local" id="product-created-at">
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="product-description">Mô tả</label>
                                <textarea name="product-description" id="product-description" placeholder="Mô tả chi tiết (sẽ lưu vào Products.description)"></textarea>
                            </div>

                            <div class="form-group-modal full-width">
                                <h3>Biến thể (Product_variants)</h3>
                                <div id="variantsContainer" class="variants-list"></div>
                                <a href="#" id="addVariantBtn" class="btn btn-secondary" style="margin-top:8px;">+ Thêm Biến thể</a>
                            </div>

                            <div class="form-group-modal full-width">
                                <h3>Hình ảnh (Product_images)</h3>
                                <label class="product-image-upload" for="product-image-input">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Nhấn để tải ảnh lên (Hỗ trợ nhiều ảnh)</p>
                                </label>
                                <input type="file" id="product-image-input" name="productImages" accept="image/*" multiple style="display:none;">
                                <div class="image-preview-grid" id="imagePreviewGrid"></div>
                                <p class="meta">Bạn có thể đánh dấu 1 ảnh làm thumbnail. Ảnh sẽ được upload lên server khi lưu.</p>
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

        <!-- Add Category Modal -->
        <div id="addCategoryModal" class="modal-overlay" aria-hidden="true">
            <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="categoryModalTitle">
                <div class="modal-header">
                    <h3 id="categoryModalTitle">Thêm Danh mục</h3>
                    <span class="close-button" id="closeCategoryModalBtn">&times;</span>
                </div>

                <form id="addCategoryForm" action="${pageContext.request.contextPath}/admin/category/add" method="post" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="category-name">Tên danh mục <span style="color:red">*</span></label>
                                <input type="text" id="category-name" name="category-name" placeholder="VD: Áo dài" required>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-slug">Slug (tự động nếu để trống)</label>
                                <input type="text" id="category-slug" name="category-slug" placeholder="ao-dai">
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-description">Mô tả</label>
                                <textarea id="category-description" name="category-description"></textarea>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-parent">Danh mục cha (nếu có)</label>
                                <select id="category-parent" name="category-parent">
                                    <option value="">-- Không --</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-modal-secondary" id="cancelCategoryModalBtn">Hủy</button>
                        <button type="submit" class="btn-modal btn-modal-primary" id="categorySubmitBtn">Lưu Danh mục</button>
                    </div>
                </form>
            </div>
        </div>

    </main>
</div>

<!-- JavaScript -->
<script>
    // Context path từ JSP
    const CTX = '${pageContext.request.contextPath}';

    document.addEventListener('DOMContentLoaded', function () {
        // ============================
        // DOM Elements
        // ============================
        const addProductModal = document.getElementById('addProductModal');
        const addProductBtn = document.getElementById('addProductBtn');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelModalBtn = document.getElementById('cancelModalBtn');
        const addProductForm = document.getElementById('addProductForm');
        const modalSubmitBtn = document.getElementById('modalSubmitBtn');

        const addCategoryBtn = document.getElementById('addCategoryBtn');
        const addCategoryModal = document.getElementById('addCategoryModal');
        const closeCategoryModalBtn = document.getElementById('closeCategoryModalBtn');
        const cancelCategoryModalBtn = document.getElementById('cancelCategoryModalBtn');
        const addCategoryForm = document.getElementById('addCategoryForm');
        const categorySubmitBtn = document.getElementById('categorySubmitBtn');
        const openAddCategoryFromProduct = document.getElementById('openAddCategoryFromProduct');

        const productCategorySelect = document.getElementById('product-category');
        const categoryParentSelect = document.getElementById('category-parent');

        const imageInput = document.getElementById('product-image-input');
        const imagePreviewGrid = document.getElementById('imagePreviewGrid');
        const variantsContainer = document.getElementById('variantsContainer');
        const addVariantBtn = document.getElementById('addVariantBtn');

        // ============================
        // Helper Functions
        // ============================
        function escapeHtml(s) {
            if (s === null || s === undefined) return '';
            return String(s)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function openModal(modal) {
            if (!modal) return;
            modal.classList.add('active');
            modal.style.display = 'block';
            modal.setAttribute('aria-hidden', 'false');
        }

        function closeModal(modal) {
            if (!modal) return;
            modal.classList.remove('active');
            modal.style.display = 'none';
            modal.setAttribute('aria-hidden', 'true');
        }

        // ============================
        // Load Categories từ Server
        // ============================
        function loadCategories() {
            console.log('Đang tải danh mục...');

            fetch(CTX + '/admin/category/list')
                .then(function(response) {
                    console.log('Response status:', response.status);
                    if (!response.ok) {
                        throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                    }
                    return response.json();
                })
                .then(function(categories) {
                    console.log('Đã tải ' + categories.length + ' danh mục:', categories);
                    refreshCategorySelects(categories);
                })
                .catch(function(error) {
                    console.error('Lỗi tải danh mục:', error);
                    alert('Không thể tải danh sách danh mục: ' + error.message + '\n\nKiểm tra:\n1. Servlet có chạy?\n2. URL đúng?\n3. Database có kết nối?');
                });
        }

        // ============================
        // Refresh Category Selects
        // ============================
        function refreshCategorySelects(categories) {
            console.log('Cập nhật dropdowns với', categories.length, 'danh mục');

            // Update product category select
            if (productCategorySelect) {
                const currentValue = productCategorySelect.value;
                productCategorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';

                if (categories && categories.length > 0) {
                    categories.forEach(function(cat) {
                        const opt = document.createElement('option');
                        opt.value = cat.id;
                        opt.textContent = cat.nameCategory;
                        productCategorySelect.appendChild(opt);
                    });
                    console.log('Đã thêm', categories.length, 'options vào product-category');
                }

                if (currentValue) productCategorySelect.value = currentValue;
            }

            // Update parent category select
            if (categoryParentSelect) {
                const currentValue = categoryParentSelect.value;
                categoryParentSelect.innerHTML = '<option value="">-- Không --</option>';

                if (categories && categories.length > 0) {
                    categories.forEach(function(cat) {
                        const opt = document.createElement('option');
                        opt.value = cat.id;
                        opt.textContent = cat.nameCategory;
                        categoryParentSelect.appendChild(opt);
                    });
                    console.log('Đã thêm', categories.length, 'options vào category-parent');
                }

                if (currentValue) categoryParentSelect.value = currentValue;
            }
        }

        // ============================
        // Product Modal Events
        // ============================
        if (addProductBtn) {
            addProductBtn.addEventListener('click', function(e) {
                e.preventDefault();
                console.log('Mở modal thêm sản phẩm');
                resetProductForm();
                openModal(addProductModal);
                loadCategories(); // Tải danh mục khi mở modal
            });
        }

        if (closeModalBtn) {
            closeModalBtn.addEventListener('click', function() {
                closeModal(addProductModal);
            });
        }

        if (cancelModalBtn) {
            cancelModalBtn.addEventListener('click', function() {
                closeModal(addProductModal);
            });
        }

        // Đóng khi click ngoài modal
        window.addEventListener('click', function(evt) {
            if (evt.target === addProductModal) closeModal(addProductModal);
            if (evt.target === addCategoryModal) closeModal(addCategoryModal);
        });

        // ============================
        // Category Modal Events
        // ============================
        if (addCategoryBtn) {
            addCategoryBtn.addEventListener('click', function(e) {
                e.preventDefault();
                console.log('Mở modal thêm danh mục');
                addCategoryForm.reset();
                openModal(addCategoryModal);
                loadCategories(); // Tải danh mục cho parent select
            });
        }

        if (openAddCategoryFromProduct) {
            openAddCategoryFromProduct.addEventListener('click', function(e) {
                e.preventDefault();
                console.log('Mở modal thêm danh mục từ form sản phẩm');
                addCategoryForm.reset();
                openModal(addCategoryModal);
                loadCategories();
            });
        }

        if (closeCategoryModalBtn) {
            closeCategoryModalBtn.addEventListener('click', function() {
                closeModal(addCategoryModal);
            });
        }

        if (cancelCategoryModalBtn) {
            cancelCategoryModalBtn.addEventListener('click', function() {
                closeModal(addCategoryModal);
            });
        }

        // ============================
        // Submit Category Form với AJAX
        // ============================
        if (addCategoryForm) {
            addCategoryForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const name = document.getElementById('category-name').value.trim();
                if (!name) {
                    alert('Tên danh mục là bắt buộc');
                    return;
                }

                console.log('Đang gửi form thêm danh mục...');

                // Disable button
                if (categorySubmitBtn) {
                    categorySubmitBtn.disabled = true;
                    categorySubmitBtn.textContent = 'Đang lưu...';
                }

                const formData = new FormData(addCategoryForm);

                fetch(CTX + '/admin/category/add', {
                    method: 'POST',
                    headers: {
                        'Accept': 'application/json'
                    },
                    body: formData
                })
                    .then(function(response) {
                        console.log('Response status:', response.status);
                        if (!response.ok) {
                            return response.text().then(function(text) {
                                throw new Error(text || 'Lỗi server: ' + response.status);
                            });
                        }
                        return response.json();
                    })
                    .then(function(data) {
                        console.log('Server response:', data);
                        if (data && data.success) {
                            alert('Thêm danh mục thành công!');
                            closeModal(addCategoryModal);
                            addCategoryForm.reset();

                            // Reload categories và chọn category vừa tạo
                            loadCategories();

                            // Chọn category mới trong dropdown
                            setTimeout(function() {
                                if (productCategorySelect && data.id) {
                                    productCategorySelect.value = data.id;
                                }
                            }, 500);
                        } else {
                            alert('Thêm danh mục thất bại. Server trả về: ' + JSON.stringify(data));
                        }
                    })
                    .catch(function(error) {
                        console.error('Lỗi:', error);
                        alert('Lỗi khi thêm danh mục: ' + error.message);
                    })
                    .finally(function() {
                        // Re-enable button
                        if (categorySubmitBtn) {
                            categorySubmitBtn.disabled = false;
                            categorySubmitBtn.textContent = 'Lưu Danh mục';
                        }
                    });
            });
        }

        // ============================
        // Variants Management
        // ============================
        function createVariantRow(data) {
            data = data || {sku:'', size:'', color:'', price:'', stock:''};

            const row = document.createElement('div');
            row.className = 'variant-row';

            let html = '';
            html += '<input name="variant-sku[]" placeholder="SKU" class="variant-sku" value="' + escapeHtml(data.sku) + '" />';
            html += '<input name="variant-size[]" placeholder="Size" class="variant-size" value="' + escapeHtml(data.size) + '" />';
            html += '<input name="variant-color[]" placeholder="Color" class="variant-color" value="' + escapeHtml(data.color) + '" />';
            html += '<input name="variant-price[]" type="number" step="0.01" placeholder="Giá" class="variant-price" value="' + escapeHtml(data.price) + '" />';
            html += '<input name="variant-quantity[]" type="number" placeholder="Tồn" class="variant-stock" value="' + escapeHtml(data.stock) + '" />';
            html += '<button class="btn btn-secondary btn-remove-variant" type="button">Xóa</button>';

            row.innerHTML = html;

            const btnRemove = row.querySelector('.btn-remove-variant');
            if (btnRemove) {
                btnRemove.addEventListener('click', function(e) {
                    e.preventDefault();
                    row.remove();
                });
            }

            variantsContainer.appendChild(row);
            return row;
        }

        if (addVariantBtn) {
            addVariantBtn.addEventListener('click', function(e) {
                e.preventDefault();
                createVariantRow();
            });
        }

        // Tạo 1 variant mặc định
        if (variantsContainer) {
            createVariantRow();
        }

        // ============================
        // Image Preview
        // ============================
        if (imageInput && imagePreviewGrid) {
            imageInput.addEventListener('change', function(e) {
                const files = Array.prototype.slice.call(e.target.files || []);
                imagePreviewGrid.innerHTML = '';

                files.forEach(function(file, idx) {
                    const reader = new FileReader();
                    reader.onload = function(ev) {
                        const wrapper = document.createElement('div');
                        wrapper.className = 'image-preview-item';
                        wrapper.style.position = 'relative';
                        wrapper.style.display = 'inline-block';
                        wrapper.style.margin = '8px';
                        wrapper.dataset.filename = file.name;
                        wrapper.dataset.isThumbnail = '0';

                        const img = document.createElement('img');
                        img.src = ev.target.result;
                        img.alt = file.name;
                        img.style.width = '160px';
                        img.style.height = '160px';
                        img.style.objectFit = 'cover';
                        img.style.borderRadius = '8px';
                        wrapper.appendChild(img);

                        const label = document.createElement('div');
                        label.style.fontSize = '12px';
                        label.style.marginTop = '6px';
                        label.style.textAlign = 'center';
                        label.textContent = file.name;
                        wrapper.appendChild(label);

                        const thumbBtn = document.createElement('button');
                        thumbBtn.className = 'btn btn-primary';
                        thumbBtn.type = 'button';
                        thumbBtn.style.position = 'absolute';
                        thumbBtn.style.bottom = '6px';
                        thumbBtn.style.left = '6px';
                        thumbBtn.textContent = 'Thumbnail';
                        thumbBtn.addEventListener('click', function(evt) {
                            evt.preventDefault();
                            const items = imagePreviewGrid.querySelectorAll('.image-preview-item');
                            Array.prototype.forEach.call(items, function(it) {
                                it.dataset.isThumbnail = '0';
                                const iimg = it.querySelector('img');
                                if (iimg) iimg.style.outline = '';
                            });
                            wrapper.dataset.isThumbnail = '1';
                            img.style.outline = '3px solid #640100';
                        });
                        wrapper.appendChild(thumbBtn);

                        const removeBtn = document.createElement('button');
                        removeBtn.className = 'btn btn-secondary';
                        removeBtn.type = 'button';
                        removeBtn.style.position = 'absolute';
                        removeBtn.style.bottom = '6px';
                        removeBtn.style.right = '6px';
                        removeBtn.textContent = 'Xóa';
                        removeBtn.addEventListener('click', function(evt) {
                            evt.preventDefault();
                            wrapper.remove();
                        });
                        wrapper.appendChild(removeBtn);

                        imagePreviewGrid.appendChild(wrapper);
                    };
                    reader.readAsDataURL(file);
                });
            });
        }

        // ============================
        // Submit Product Form
        // ============================
        if (addProductForm) {
            addProductForm.addEventListener('submit', function(e) {
                const name = document.getElementById('product-name').value.trim();
                if (!name) {
                    e.preventDefault();
                    alert('Tên sản phẩm là bắt buộc');
                    return;
                }

                // Disable submit button
                if (modalSubmitBtn) {
                    modalSubmitBtn.disabled = true;
                    modalSubmitBtn.textContent = 'Đang lưu...';
                }

                // Xóa hidden inputs cũ
                const oldInputs = addProductForm.querySelectorAll('input[name="productImageAlt[]"], input[name="productImageIsThumb[]"]');
                Array.prototype.forEach.call(oldInputs, function(input) {
                    input.remove();
                });

                // Tạo hidden inputs cho image metadata
                const previewItems = imagePreviewGrid.querySelectorAll('.image-preview-item');
                if (previewItems.length > 0) {
                    Array.prototype.forEach.call(previewItems, function(item) {
                        const fname = item.dataset.filename || '';
                        const alt = item.querySelector('img') ? item.querySelector('img').alt : fname;
                        const isThumb = item.dataset.isThumbnail === '1' ? '1' : '0';

                        const altInput = document.createElement('input');
                        altInput.type = 'hidden';
                        altInput.name = 'productImageAlt[]';
                        altInput.value = alt;
                        addProductForm.appendChild(altInput);

                        const thumbInput = document.createElement('input');
                        thumbInput.type = 'hidden';
                        thumbInput.name = 'productImageIsThumb[]';
                        thumbInput.value = isThumb;
                        addProductForm.appendChild(thumbInput);
                    });
                }

                console.log('Đang submit form sản phẩm...');
                // Form sẽ submit bình thường đến servlet
            });
        }

        // ============================
        // Reset Product Form
        // ============================
        function resetProductForm() {
            addProductForm.reset();
            if (variantsContainer) {
                variantsContainer.innerHTML = '';
                createVariantRow();
            }
            if (imagePreviewGrid) {
                imagePreviewGrid.innerHTML = '';
            }
            if (modalSubmitBtn) {
                modalSubmitBtn.disabled = false;
                modalSubmitBtn.textContent = 'Lưu Sản phẩm';
            }
        }

        // ============================
        // Search Function
        // ============================
        const searchInput = document.getElementById('globalSearchInput');
        if (searchInput) {
            searchInput.addEventListener('input', function() {
                const q = this.value.trim().toLowerCase();
                const rows = document.querySelectorAll('#productTableBody tr');

                Array.prototype.forEach.call(rows, function(row) {
                    const text = row.innerText.toLowerCase();
                    const match = !q || text.indexOf(q) !== -1;
                    row.style.display = match ? '' : 'none';
                });
            });

            // Shortcut: press '/' to focus search
            window.addEventListener('keydown', function(e) {
                if (e.key === '/' && !/INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName)) {
                    e.preventDefault();
                    searchInput.focus();
                }
            });
        }

        // ============================
        // Load categories on page load
        // ============================
        console.log('Page loaded, loading categories...');
        loadCategories();

    }); // DOMContentLoaded end
</script>

</body>
</html>
