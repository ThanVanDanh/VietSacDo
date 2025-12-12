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
                                        <option value="">-- Tải danh mục --</option>
                                        <!-- server render categories or frontend will populate -->
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
                                <!-- variants as array inputs -->
                                <div id="variantsContainer" class="variants-list"></div>
                                <a href="#" id="addVariantBtn" class="btn btn-secondary" style="margin-top:8px;">+ Thêm Biến thể</a>
                            </div>

                            <div class="form-group-modal full-width">
                                <h3>Hình ảnh (Product_images)</h3>
                                <label class="product-image-upload" for="product-image-input">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Nhấn để tải ảnh lên (Hỗ trợ nhiều ảnh)</p>
                                </label>
                                <input type="file" id="product-image-input" name="productImages[]" accept="image/*" multiple>
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

        <!-- Add Category Modal (simple demo) -->
        <div id="addCategoryModal" class="modal-overlay" aria-hidden="true">
            <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="categoryModalTitle">
                <div class="modal-header">
                    <h3 id="categoryModalTitle">Thêm Danh mục</h3>
                    <span class="close-button" id="closeCategoryModalBtn">&times;</span>
                </div>

                <form id="addCategoryForm" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="category-name">Tên danh mục <span style="color:red">*</span></label>
                                <input type="text" id="category-name" placeholder="VD: Áo dài" required>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-slug">Slug (tự động nếu để trống)</label>
                                <input type="text" id="category-slug" placeholder="ao-dai">
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-description">Mô tả</label>
                                <textarea id="category-description"></textarea>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-parent">Danh mục cha (nếu có)</label>
                                <select id="category-parent">
                                    <option value="">-- Không --</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-modal-secondary" id="cancelAddCategory">Hủy</button>
                        <button type="submit" class="btn-modal btn-modal-primary">Lưu Danh mục</button>
                    </div>
                </form>
            </div>
        </div>

    </main>
</div>

<!-- JavaScript: chỉ chứa logic cần thiết cho thêm sản phẩm -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // ============================
        // Biến DOM chính
        // ============================
        const addProductModal = document.getElementById('addProductModal');
        const addProductBtn = document.getElementById('addProductBtn');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelModalBtn = document.getElementById('cancelModalBtn');
        const addProductForm = document.getElementById('addProductForm');

        const addCategoryBtn = document.getElementById('addCategoryBtn');
        const addCategoryModal = document.getElementById('addCategoryModal');
        const closeCategoryModalBtn = document.getElementById('closeCategoryModalBtn');
        const cancelAddCategory = document.getElementById('cancelAddCategory');
        const addCategoryForm = document.getElementById('addCategoryForm');
        const openAddCategoryFromProduct = document.getElementById('openAddCategoryFromProduct');

        const productCategorySelect = document.getElementById('product-category');
        const categoryParentSelect = document.getElementById('category-parent');

        const imageInput = document.getElementById('product-image-input');
        const imagePreviewGrid = document.getElementById('imagePreviewGrid');
        const variantsContainer = document.getElementById('variantsContainer');
        const addVariantBtn = document.getElementById('addVariantBtn');
        const modalSubmitBtn = document.getElementById('modalSubmitBtn');

        // Kiểm tra nhanh để tránh lỗi nếu DOM thiếu
        if (!addProductForm) {
            console.warn('addProductForm không tồn tại trên trang. Kiểm tra lại id trong JSP.');
            return;
        }

        // ============================
        // Helpers (Tiếng Việt)
        // ============================
        // escapeHtml: tránh XSS khi chèn text vào value/innerHTML
        function escapeHtml(s) {
            if (s === null || s === undefined) return '';
            return String(s)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        // slugify: tạo slug đơn giản từ tên
        function slugify(text) {
            if (!text) return '';
            return text.toString().toLowerCase()
                .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
                .replace(/đ/g,'d').replace(/[^a-z0-9 -]/g,'').trim().replace(/\s+/g,'-');
        }

        // ============================
        // Modal open / close
        // ============================
        function openModal(modal) {
            if (!modal) return;
            modal.style.display = 'block';
            modal.setAttribute('aria-hidden', 'false');
            modal.style.zIndex = 9999;
            // focus first input để tiện thao tác
            const first = modal.querySelector('input, select, textarea, button');
            if (first) first.focus();
        }
        function closeModal(modal) {
            if (!modal) return;
            modal.style.display = 'none';
            modal.setAttribute('aria-hidden', 'true');
        }

        // Gắn event cho các nút modal
        if (addProductBtn) {
            addProductBtn.addEventListener('click', function (e) {
                e.preventDefault();
                resetProductForm();
                document.getElementById('modalTitle').textContent = 'Thêm Sản phẩm mới';
                openModal(addProductModal);
            });
        } else {
            console.warn('Không tìm thấy nút addProductBtn');
        }
        if (closeModalBtn) closeModalBtn.addEventListener('click', function () { closeModal(addProductModal); });
        if (cancelModalBtn) cancelModalBtn.addEventListener('click', function () { closeModal(addProductModal); });
        // đóng khi click ra ngoài
        window.addEventListener('click', function (evt) {
            if (evt.target === addProductModal) closeModal(addProductModal);
            if (evt.target === addCategoryModal) closeModal(addCategoryModal);
        });

        // Category modal
        if (addCategoryBtn) addCategoryBtn.addEventListener('click', function (e) { e.preventDefault(); openModal(addCategoryModal); });
        if (closeCategoryModalBtn) closeCategoryModalBtn.addEventListener('click', function () { closeModal(addCategoryModal); });
        if (cancelAddCategory) cancelAddCategory.addEventListener('click', function () { closeModal(addCategoryModal); });
        if (openAddCategoryFromProduct) openAddCategoryFromProduct.addEventListener('click', function (e) { e.preventDefault(); openModal(addCategoryModal); });

        // ============================
        // Demo categories (bạn thay bằng dữ liệu thật server-side)
        // ============================
        var categories = [
            {id:1, name_category:'Áo dài', slug:'ao-dai', description:'', parent_category_id:null}
        ];
        function refreshCategorySelects(){
            if (!productCategorySelect || !categoryParentSelect) return;
            productCategorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';
            categoryParentSelect.innerHTML = '<option value="">-- Không --</option>';
            categories.forEach(function(cat){
                var opt = document.createElement('option'); opt.value = cat.id; opt.textContent = cat.name_category;
                productCategorySelect.appendChild(opt);
                var opt2 = document.createElement('option'); opt2.value = cat.id; opt2.textContent = cat.name_category;
                categoryParentSelect.appendChild(opt2);
            });
        }
        refreshCategorySelects();

        // Add category demo (nếu muốn gửi server thì đổi phần này thành AJAX POST)
        if (addCategoryForm) {
            addCategoryForm.addEventListener('submit', function (e) {
                e.preventDefault();
                var name = document.getElementById('category-name').value.trim();
                var slug = document.getElementById('category-slug').value.trim();
                var desc = document.getElementById('category-description').value.trim();
                var parent = document.getElementById('category-parent').value || null;
                if (!name) { alert('Tên danh mục là bắt buộc'); return; }
                if (!slug) slug = slugify(name);
                // demo local push
                var newCat = { id: Date.now(), name_category: name, slug: slug, description: desc, parent_category_id: parent };
                categories.push(newCat);
                refreshCategorySelects();
                closeModal(addCategoryModal);
            });
        }

        // ============================
        // Variants UI: tạo hàng biến thể (dùng name arrays để form gửi dễ)
        // ============================
        function createVariantRow(data) {
            data = data || {sku:'', size:'', color:'', price:'', stock:''};

            var row = document.createElement('div');
            row.className = 'variant-row';

            var html = '';
            html += '<input name="sku[]" placeholder="SKU" class="variant-sku" value="' + escapeHtml(data.sku) + '" />';
            html += '<input name="size[]" placeholder="Size" class="variant-size" value="' + escapeHtml(data.size) + '" />';
            html += '<input name="color[]" placeholder="Color" class="variant-color" value="' + escapeHtml(data.color) + '" />';
            html += '<input name="current_price[]" type="number" step="0.01" placeholder="Giá" class="variant-price" value="' + escapeHtml(data.price) + '" />';
            html += '<input name="stock_quantity[]" type="number" placeholder="Tồn" class="variant-stock" value="' + escapeHtml(data.stock) + '" />';
            html += '<button class="btn btn-secondary btn-remove-variant" type="button">Xóa</button>';

            row.innerHTML = html;

            // gắn event xóa
            var btn = row.querySelector('.btn-remove-variant');
            if (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    row.remove();
                });
            }

            variantsContainer.appendChild(row);
            return row;
        }

        if (addVariantBtn) {
            addVariantBtn.addEventListener('click', function (e) { e.preventDefault(); createVariantRow(); });
        }
        // tạo 1 row mặc định nếu chưa có
        if (variantsContainer && !variantsContainer.querySelector('.variant-row')) createVariantRow();

        // ============================
        // Image preview + chọn thumbnail
        // ============================
        if (imageInput && imagePreviewGrid) {
            imageInput.addEventListener('change', function (e) {
                var files = Array.prototype.slice.call(e.target.files || []);
                imagePreviewGrid.innerHTML = '';
                files.forEach(function (file, idx) {
                    var reader = new FileReader();
                    reader.onload = function (ev) {
                        var wrapper = document.createElement('div');
                        wrapper.className = 'image-preview-item';
                        wrapper.style.position = 'relative';
                        wrapper.style.display = 'inline-block';
                        wrapper.style.margin = '8px';
                        wrapper.dataset.filename = file.name;
                        wrapper.dataset.isThumbnail = '0';

                        var img = document.createElement('img');
                        img.src = ev.target.result;
                        img.alt = file.name;
                        img.style.width = '160px';
                        img.style.height = '160px';
                        img.style.objectFit = 'cover';
                        img.style.borderRadius = '8px';
                        wrapper.appendChild(img);

                        var label = document.createElement('div');
                        label.style.fontSize = '12px';
                        label.style.marginTop = '6px';
                        label.style.textAlign = 'center';
                        label.textContent = file.name;
                        wrapper.appendChild(label);

                        var thumbBtn = document.createElement('button');
                        thumbBtn.className = 'btn btn-secondary';
                        thumbBtn.type = 'button';
                        thumbBtn.style.position = 'absolute';
                        thumbBtn.style.bottom = '6px';
                        thumbBtn.style.left = '6px';
                        thumbBtn.textContent = 'Thumbnail';
                        thumbBtn.addEventListener('click', function (evt) {
                            evt.preventDefault();
                            // clear previous
                            var items = imagePreviewGrid.querySelectorAll('.image-preview-item');
                            Array.prototype.forEach.call(items, function(it){
                                it.dataset.isThumbnail = '0';
                                var iimg = it.querySelector('img');
                                if (iimg) iimg.style.outline = '';
                            });
                            wrapper.dataset.isThumbnail = '1';
                            img.style.outline = '3px solid ' + (getComputedStyle(document.documentElement).getPropertyValue('--brand') || '#640100').trim();
                        });
                        wrapper.appendChild(thumbBtn);

                        var removeBtn = document.createElement('button');
                        removeBtn.className = 'btn btn-secondary';
                        removeBtn.type = 'button';
                        removeBtn.style.position = 'absolute';
                        removeBtn.style.bottom = '6px';
                        removeBtn.style.right = '6px';
                        removeBtn.textContent = 'Xóa';
                        removeBtn.addEventListener('click', function (evt) { evt.preventDefault(); wrapper.remove(); });
                        wrapper.appendChild(removeBtn);

                        imagePreviewGrid.appendChild(wrapper);
                    };
                    reader.readAsDataURL(file);
                });
            });
        }

        // ============================
        // Trước khi submit: tạo hidden inputs cho alt + isThumbnail theo thứ tự preview
        // Form dùng gửi truyền thống (multipart/form-data) đến servlet
        // ============================
        addProductForm.addEventListener('submit', function (e) {
            // basic validation
            var name = document.getElementById('product-name').value.trim();
            if (!name) { e.preventDefault(); alert('Tên sản phẩm là bắt buộc'); return; }

            // disable nút submit để tránh bấm 2 lần
            if (modalSubmitBtn) {
                modalSubmitBtn.disabled = true;
                modalSubmitBtn.textContent = 'Đang lưu...';
            }

            // xóa các hidden cũ (nếu có)
            var oldAlts = addProductForm.querySelectorAll('input[name="productImageAlt[]"], input[name="productImageIsThumb[]"]');
            Array.prototype.forEach.call(oldAlts, function(n){ n.remove(); });

            // build metadata từ preview grid (nếu có), nếu không dùng file input
            var previewItems = imagePreviewGrid ? imagePreviewGrid.querySelectorAll('.image-preview-item') : [];
            if (previewItems && previewItems.length > 0) {
                Array.prototype.forEach.call(previewItems, function(item){
                    var fname = item.dataset.filename || '';
                    var alt = (item.querySelector('img') && item.querySelector('img').alt) ? item.querySelector('img').alt : fname;
                    var isThumb = item.dataset.isThumbnail === '1' ? '1' : '0';

                    var altInput = document.createElement('input');
                    altInput.type = 'hidden';
                    altInput.name = 'productImageAlt[]';
                    altInput.value = alt;
                    addProductForm.appendChild(altInput);

                    var thumbInput = document.createElement('input');
                    thumbInput.type = 'hidden';
                    thumbInput.name = 'productImageIsThumb[]';
                    thumbInput.value = isThumb;
                    addProductForm.appendChild(thumbInput);
                });
            } else {
                // fallback: lấy file input theo thứ tự file list
                var fileInput = document.getElementById('product-image-input');
                if (fileInput && fileInput.files && fileInput.files.length > 0) {
                    for (var i = 0; i < fileInput.files.length; i++) {
                        var f = fileInput.files[i];
                        var altInput2 = document.createElement('input');
                        altInput2.type = 'hidden';
                        altInput2.name = 'productImageAlt[]';
                        altInput2.value = f.name;
                        addProductForm.appendChild(altInput2);

                        var thumbInput2 = document.createElement('input');
                        thumbInput2.type = 'hidden';
                        thumbInput2.name = 'productImageIsThumb[]';
                        thumbInput2.value = '0';
                        addProductForm.appendChild(thumbInput2);
                    }
                }
            }
            // form sẽ submit tự nhiên; servlet sẽ xử lý upload + lưu DB
        });

        // ============================
        // Reset helper
        // ============================
        function resetProductForm() {
            addProductForm.reset();
            if (variantsContainer) variantsContainer.innerHTML = '';
            if (imagePreviewGrid) imagePreviewGrid.innerHTML = '';
            // tạo 1 dòng biến thể mặc định
            if (variantsContainer) createVariantRow();
            refreshCategorySelects();
            if (modalSubmitBtn) {
                modalSubmitBtn.disabled = false;
                modalSubmitBtn.textContent = 'Lưu Sản phẩm';
            }
        }

        // ============================
        // Tính năng tìm kiếm bảng (giữ lại)
        // ============================
        (function () {
            var searchInput = document.getElementById('globalSearchInput');
            if (!searchInput) return;
            searchInput.addEventListener('input', function () {
                var q = this.value.trim().toLowerCase();
                var rows = document.querySelectorAll('#productTableBody tr');
                Array.prototype.forEach.call(rows, function (row) {
                    var name = (row.querySelector('td:nth-child(2)') && row.querySelector('td:nth-child(2)').innerText) ? row.querySelector('td:nth-child(2)').innerText.toLowerCase() : '';
                    var codeMeta = (row.querySelector('.meta') && row.querySelector('.meta').innerText) ? row.querySelector('.meta').innerText.toLowerCase() : '';
                    var category = (row.querySelector('td:nth-child(3)') && row.querySelector('td:nth-child(3)').innerText) ? row.querySelector('td:nth-child(3)').innerText.toLowerCase() : '';
                    var all = (row.innerText || '').toLowerCase();
                    var match = !q || name.indexOf(q) !== -1 || codeMeta.indexOf(q) !== -1 || category.indexOf(q) !== -1 || all.indexOf(q) !== -1;
                    row.style.display = match ? '' : 'none';
                });
            });
            window.addEventListener('keydown', function (e) {
                if (e.key === '/' && !/INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName)) {
                    e.preventDefault();
                    var s = document.getElementById('globalSearchInput');
                    if (s) s.focus();
                }
            });
        })();

    }); // DOMContentLoaded end
</script>


</body>
</html>
