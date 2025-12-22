<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin - Quản lý Sản phẩm</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="../style/admin.css">
    <link rel="stylesheet" href="../style/productStyle.css">
    <style>
        /* Category Tree Styles */
        .category-row {
            transition: background-color 0.2s;
        }
        .category-row:hover {
            background-color: #f8f9fa;
        }
        .category-indent {
            display: inline-block;
            width: 30px;
            text-align: center;
            color: #999;
        }
        .category-name-cell {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .parent-category {
            font-weight: 600;
            color: #2c3e50;
        }
        .child-category {
            color: #555;
        }
        .category-icon {
            color: #999;
            font-size: 14px;
        }
    </style>
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
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-logout">
                    <i class="fas fa-user-circle"></i> Đăng xuất
                </a>
            </div>
        </header>

        <!-- Category Section -->
        <section class="category-section" style="margin-bottom: 40px;">
            <div class="category-list-header" style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px;">
                <h2>Danh sách Danh mục</h2>
                <div class="actions-row">
                    <a href="#" class="btn btn-primary" id="addCategoryBtnTop">
                        <i class="fas fa-folder-plus"></i> Thêm Danh mục
                    </a>
                </div>
            </div>

            <table class="product-table">
                <thead>
                <tr>
                    <th>Tên Danh mục</th>
                    <th style="width: 200px;">Slug</th>
                    <th>Mô tả</th>
                    <th style="width: 100px; text-align: center">Số SP</th>
                    <th style="width: 120px; text-align: center">Cài đặt</th>
                </tr>
                </thead>
                <tbody id="categoryTableBody">
                <!-- Categories will be loaded here -->
                </tbody>
            </table>
        </section>

        <!-- Product Section -->
        <section class="product-section">
            <div class="product-list-header">
                <h2>Danh sách Sản phẩm</h2>

                <div class="search-wrapper" style="margin-left:auto; margin-right:12px;">
                    <input type="search" id="globalSearchInput" class="search-input"
                           placeholder="Tìm theo tên, mã, danh mục..." aria-label="Tìm sản phẩm">
                </div>

                <div class="actions-row">
                    <a href="#" class="btn btn-primary" id="addProductBtn">
                        <i class="fas fa-plus"></i> Thêm Sản phẩm
                    </a>
                </div>
            </div>

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
                <!-- Products will be loaded here -->
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

                <form id="addProductForm" action="${pageContext.request.contextPath}/admin/product/add"
                      method="post" enctype="multipart/form-data" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="product-name">Tên Sản phẩm <span style="color:red">*</span></label>
                                <input name="product-name" type="text" id="product-name" required
                                       placeholder="Tên sản phẩm">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-code">Mã sản phẩm</label>
                                <input name="product-code" type="text" id="product-code"
                                       placeholder="VD: ADTT01">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-category">Danh mục <span style="color:red">*</span></label>
                                <select name="product-category" id="product-category" required>
                                    <option value="">-- Đang tải danh mục --</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-status">Trạng thái</label>
                                <select name="product-status" id="product-status">
                                    <option value="active">active</option>
                                    <option value="inactive">inactive</option>
                                </select>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="product-description">Mô tả</label>
                                <textarea name="product-description" id="product-description"
                                          placeholder="Mô tả chi tiết"></textarea>
                            </div>

                            <div class="form-group-modal full-width">
                                <h3>Biến thể (Product_variants)</h3>
                                <div id="variantsContainer" class="variants-list"></div>
                                <a href="#" id="addVariantBtn" class="btn btn-secondary" style="margin-top:8px;">
                                    + Thêm Biến thể
                                </a>
                            </div>

                            <div class="form-group-modal full-width">
                                <h3>Hình ảnh (Product_images)</h3>
                                <label class="product-image-upload" for="product-image-input">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Nhấn để tải ảnh lên (Hỗ trợ nhiều ảnh)</p>
                                </label>
                                <input type="file" id="product-image-input" name="productImages"
                                       accept="image/*" multiple style="display:none;">
                                <div class="image-preview-grid" id="imagePreviewGrid"></div>
                                <p class="meta">Bạn có thể đánh dấu 1 ảnh làm thumbnail.</p>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-modal btn-modal-secondary" id="cancelModalBtn">
                            Hủy
                        </button>
                        <button type="submit" class="btn-modal btn-modal-primary" id="modalSubmitBtn">
                            Lưu Sản phẩm
                        </button>
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

                <form id="addCategoryForm" action="${pageContext.request.contextPath}/admin/category/add"
                      method="post" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="category-name">Tên danh mục <span style="color:red">*</span></label>
                                <input type="text" id="category-name" name="category-name"
                                       placeholder="VD: Áo dài" required>
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="category-slug">Slug (tự động nếu để trống)</label>
                                <input type="text" id="category-slug" name="category-slug"
                                       placeholder="ao-dai">
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
                        <button type="button" class="btn-modal btn-modal-secondary" id="cancelCategoryModalBtn">
                            Hủy
                        </button>
                        <button type="submit" class="btn-modal btn-modal-primary" id="categorySubmitBtn">
                            Lưu Danh mục
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </main>
</div>

<script>
    const CTX = '${pageContext.request.contextPath}';

    function formatDateTime(dateStr) {
        if (!dateStr) return '-';
        var str = String(dateStr);
        var datetime = str.includes('T') ? new Date(str) : new Date(str.replace(' ', 'T'));
        if (!datetime || isNaN(datetime.getTime())) return '-';

        var d = String(datetime.getDate()).padStart(2, '0');
        var m = String(datetime.getMonth() + 1).padStart(2, '0');
        var y = datetime.getFullYear();
        var h = String(datetime.getHours()).padStart(2, '0');
        var min = String(datetime.getMinutes()).padStart(2, '0');
        var s = String(datetime.getSeconds()).padStart(2, '0');

        return d + '/' + m + '/' + y + ' ' + h + ':' + min + ':' + s;
    }

    function displayCategoriesTable(categories) {
        var tbody = document.getElementById('categoryTableBody');
        if (!tbody) return;

        tbody.innerHTML = '';

        if (!categories || categories.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:40px;">Chưa có danh mục nào</td></tr>';
            return;
        }

        // Map categories
        var categoryMap = {};
        categories.forEach(function (cat) {
            categoryMap[cat.id] = cat;
        });

        // Phân loại parent và children
        var parentCategories = [];
        var childrenByParent = {};

        categories.forEach(function (cat) {
            // ✅ FIX: Kiểm tra parentCategoryId (không phải parentId)
            if (!cat.parentCategoryId || cat.parentCategoryId === null) {
                parentCategories.push(cat);
            } else {
                if (!childrenByParent[cat.parentCategoryId]) {
                    childrenByParent[cat.parentCategoryId] = [];
                }
                childrenByParent[cat.parentCategoryId].push(cat);
            }
        });

        // Render: parent → children
        parentCategories.forEach(function (parent) {
            renderCategoryRow(tbody, parent, 0);

            var children = childrenByParent[parent.id];
            if (children && children.length > 0) {
                children.forEach(function (child) {
                    renderCategoryRow(tbody, child, 1);
                });
            }
        });
    }

    function renderCategoryRow(tbody, category, level) {
        var row = document.createElement('tr');
        row.className = 'category-row';

        // 2. Tên (với indent nếu là child)
        var nameCell = document.createElement('td');
        var nameDiv = document.createElement('div');
        nameDiv.className = 'category-name-cell';

        if (level > 0) {
            var indent = document.createElement('span');
            indent.className = 'category-indent';
            indent.innerHTML = '└─';
            nameDiv.appendChild(indent);
        }

        var icon = document.createElement('i');
        icon.className = level === 0 ? 'fas fa-folder category-icon' : 'fas fa-folder-open category-icon';
        nameDiv.appendChild(icon);

        var nameSpan = document.createElement('span');
        nameSpan.textContent = category.nameCategory || 'N/A';
        nameSpan.className = level === 0 ? 'parent-category' : 'child-category';
        nameDiv.appendChild(nameSpan);

        nameCell.appendChild(nameDiv);
        row.appendChild(nameCell);

        // 3. Slug
        var slugCell = document.createElement('td');
        if (category.slug) {
            var slugSpan = document.createElement('span');
            slugSpan.textContent = category.slug;
            slugSpan.style.color = '#666';
            slugSpan.style.fontSize = '13px';
            slugSpan.style.fontFamily = 'monospace';
            slugCell.appendChild(slugSpan);
        } else {
            slugCell.textContent = '-';
            slugCell.style.color = '#999';
        }
        row.appendChild(slugCell);

        // 4. Mô tả
        var descCell = document.createElement('td');
        if (category.description) {
            var desc = category.description;
            if (desc.length > 40) desc = desc.substring(0, 40) + '...';
            descCell.textContent = desc;
            descCell.style.fontSize = '13px';
            descCell.style.color = '#555';
        } else {
            descCell.textContent = '-';
            descCell.style.color = '#999';
        }
        row.appendChild(descCell);

        // 5. Số sản phẩm - ✅ FIX: Lấy từ productCount trong response
        var countCell = document.createElement('td');
        countCell.textContent = category.productCount || 0;
        countCell.style.textAlign = 'center';
        countCell.style.fontWeight = '500';

        // Thêm màu sắc cho số lượng
        if (category.productCount > 0) {
            countCell.style.color = '#28a745';
        } else {
            countCell.style.color = '#999';
        }
        row.appendChild(countCell);

        // 6. Actions
        var actionCell = document.createElement('td');
        actionCell.style.textAlign = 'center';

        var editBtn = document.createElement('a');
        editBtn.href = '#';
        editBtn.className = 'btn-icon';
        editBtn.innerHTML = '<i class="fas fa-edit" style="color: var(--brand)"></i>';
        editBtn.title = 'Sửa';
        editBtn.style.marginRight = '8px';
        editBtn.onclick = function (e) {
            e.preventDefault();
            editCategory(category);
        };

        var deleteBtn = document.createElement('a');
        deleteBtn.href = '#';
        deleteBtn.className = 'btn-icon btn-icon-danger';
        deleteBtn.innerHTML = '<i class="fas fa-trash" style="color: var(--brand)"></i>';
        deleteBtn.title = 'Xóa';
        deleteBtn.onclick = function (e) {
            e.preventDefault();
            deleteCategory(category);
        };

        actionCell.appendChild(editBtn);
        actionCell.appendChild(deleteBtn);
        row.appendChild(actionCell);

        tbody.appendChild(row);
    }

    function editCategory(category) {
        var modal = document.getElementById('addCategoryModal');
        var form = document.getElementById('addCategoryForm');

        document.getElementById('categoryModalTitle').textContent = 'Chỉnh sửa Danh mục';

        document.getElementById('category-name').value = category.nameCategory || '';
        document.getElementById('category-slug').value = category.slug || '';
        document.getElementById('category-description').value = category.description || '';
        document.getElementById('category-parent').value = category.parentCategoryId || '';

        form.dataset.editId = category.id;
        document.getElementById('categorySubmitBtn').textContent = 'Cập nhật';

        openModal(modal);
        loadCategories();
    }

    function deleteCategory(category) {
        if (!confirm('Bạn có chắc muốn xóa danh mục "' + category.nameCategory + '"?')) {
            return;
        }

        fetch(CTX + '/admin/category/delete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Accept': 'application/json'
            },
            body: 'id=' + category.id
        })
            .then(function (response) {
                return response.json().then(function (data) {
                    return {status: response.status, data: data};
                });
            })
            .then(function (result) {
                if (result.data && result.data.success) {
                    alert('Xóa danh mục thành công!');
                    loadCategories();
                } else if (result.data && result.data.canDelete === false) {
                    var childCount = result.data.childCount || 0;
                    var productCount = result.data.productCount || 0;

                    var msg = 'Không thể xóa danh mục "' + category.nameCategory + '" vì:\n\n';
                    if (childCount > 0) msg += '• Còn ' + childCount + ' danh mục con\n';
                    if (productCount > 0) msg += '• Còn ' + productCount + ' sản phẩm\n';

                    msg += '\nVui lòng ';
                    if (childCount > 0 && productCount > 0) {
                        msg += 'xóa các danh mục con và chuyển/xóa các sản phẩm';
                    } else if (childCount > 0) {
                        msg += 'xóa các danh mục con';
                    } else {
                        msg += 'chuyển hoặc xóa các sản phẩm';
                    }
                    msg += ' trước.';

                    alert(msg);
                } else {
                    alert('Xóa thất bại: ' + (result.data.error || 'Unknown error'));
                }
            })
            .catch(function (error) {
                alert('Lỗi: ' + error.message);
            });
    }

    function loadCategories() {
        fetch(CTX + '/admin/category/list')
            .then(function (response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function (categories) {
                refreshCategorySelects(categories);
                displayCategoriesTable(categories);
            })
            .catch(function (error) {
                alert('Không thể tải danh mục: ' + error.message);
            });
    }

    document.addEventListener('DOMContentLoaded', function () {
        const addProductModal = document.getElementById('addProductModal');
        const addProductBtn = document.getElementById('addProductBtn');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const cancelModalBtn = document.getElementById('cancelModalBtn');
        const addProductForm = document.getElementById('addProductForm');
        const modalSubmitBtn = document.getElementById('modalSubmitBtn');

        const addCategoryBtn = document.getElementById('addCategoryBtn');
        const addCategoryBtnTop = document.getElementById('addCategoryBtnTop');
        const addCategoryModal = document.getElementById('addCategoryModal');
        const closeCategoryModalBtn = document.getElementById('closeCategoryModalBtn');
        const cancelCategoryModalBtn = document.getElementById('cancelCategoryModalBtn');
        const addCategoryForm = document.getElementById('addCategoryForm');
        const categorySubmitBtn = document.getElementById('categorySubmitBtn');

        const productCategorySelect = document.getElementById('product-category');
        const categoryParentSelect = document.getElementById('category-parent');

        const imageInput = document.getElementById('product-image-input');
        const imagePreviewGrid = document.getElementById('imagePreviewGrid');
        const variantsContainer = document.getElementById('variantsContainer');
        const addVariantBtn = document.getElementById('addVariantBtn');

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

        window.refreshCategorySelects = function (categories) {
            if (productCategorySelect) {
                const currentValue = productCategorySelect.value;
                productCategorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';

                if (categories && categories.length > 0) {
                    categories.forEach(function (cat) {
                        const opt = document.createElement('option');
                        opt.value = cat.id;
                        opt.textContent = cat.nameCategory;
                        productCategorySelect.appendChild(opt);
                    });
                }

                if (currentValue) productCategorySelect.value = currentValue;
            }

            if (categoryParentSelect) {
                const currentValue = categoryParentSelect.value;
                categoryParentSelect.innerHTML = '<option value="">-- Không --</option>';

                if (categories && categories.length > 0) {
                    categories.forEach(function (cat) {
                        const opt = document.createElement('option');
                        opt.value = cat.id;
                        opt.textContent = cat.nameCategory;
                        categoryParentSelect.appendChild(opt);
                    });
                }

                if (currentValue) categoryParentSelect.value = currentValue;
            }
        };

        if (addProductBtn) {
            addProductBtn.addEventListener('click', function (e) {
                e.preventDefault();
                resetProductForm();
                openModal(addProductModal);
                loadCategories();
            });
        }

        if (closeModalBtn) {
            closeModalBtn.addEventListener('click', function () {
                closeModal(addProductModal);
            });
        }

        if (cancelModalBtn) {
            cancelModalBtn.addEventListener('click', function () {
                closeModal(addProductModal);
            });
        }

        window.addEventListener('click', function (evt) {
            if (evt.target === addProductModal) closeModal(addProductModal);
            if (evt.target === addCategoryModal) closeModal(addCategoryModal);
        });

        if (addCategoryBtnTop) {
            addCategoryBtnTop.addEventListener('click', function (e) {
                e.preventDefault();

                var form = document.getElementById('addCategoryForm');
                var modal = document.getElementById('addCategoryModal');

                form.reset();
                delete form.dataset.editId;

                document.getElementById('categoryModalTitle').textContent = 'Thêm Danh mục';
                document.getElementById('categorySubmitBtn').textContent = 'Lưu Danh mục';

                openModal(modal);
                loadCategories();
            });
        }

        if (closeCategoryModalBtn) {
            closeCategoryModalBtn.addEventListener('click', function () {
                closeModal(addCategoryModal);
            });
        }

        if (cancelCategoryModalBtn) {
            cancelCategoryModalBtn.addEventListener('click', function () {
                closeModal(addCategoryModal);
            });
        }

        if (addCategoryForm) {
            addCategoryForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const name = document.getElementById('category-name').value.trim();
                if (!name) {
                    alert('Tên danh mục là bắt buộc');
                    return;
                }

                if (categorySubmitBtn) {
                    categorySubmitBtn.disabled = true;
                    categorySubmitBtn.textContent = 'Đang lưu...';
                }

                const formData = new FormData(addCategoryForm);
                const editId = addCategoryForm.dataset.editId;
                if (editId) {
                    formData.append('id', editId);
                }

                fetch(CTX + '/admin/category/add', {
                    method: 'POST',
                    headers: {'Accept': 'application/json'},
                    body: formData
                })
                    .then(function (response) {
                        if (!response.ok) {
                            return response.text().then(function (text) {
                                throw new Error(text || 'Lỗi server');
                            });
                        }
                        return response.json();
                    })
                    .then(function (data) {
                        if (data && data.success) {
                            alert(editId ? 'Cập nhật thành công!' : 'Thêm danh mục thành công!');
                            closeModal(addCategoryModal);
                            addCategoryForm.reset();
                            delete addCategoryForm.dataset.editId;
                            loadCategories();
                        }
                    })
                    .catch(function (error) {
                        alert('Lỗi: ' + error.message);
                    })
                    .finally(function () {
                        if (categorySubmitBtn) {
                            categorySubmitBtn.disabled = false;
                            categorySubmitBtn.textContent = editId ? 'Cập nhật' : 'Lưu Danh mục';
                        }
                    });
            });
        }

        function createVariantRow(data) {
            data = data || {sku: '', size: '', color: '', price: '', stock: ''};

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
                btnRemove.addEventListener('click', function (e) {
                    e.preventDefault();
                    row.remove();
                });
            }

            variantsContainer.appendChild(row);
            return row;
        }

        if (addVariantBtn) {
            addVariantBtn.addEventListener('click', function (e) {
                e.preventDefault();
                createVariantRow();
            });
        }

        if (variantsContainer) {
            createVariantRow();
        }

        if (imageInput && imagePreviewGrid) {
            imageInput.addEventListener('change', function (e) {
                const files = Array.prototype.slice.call(e.target.files || []);
                imagePreviewGrid.innerHTML = '';

                files.forEach(function (file) {
                    const reader = new FileReader();
                    reader.onload = function (ev) {
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
                        thumbBtn.addEventListener('click', function (evt) {
                            evt.preventDefault();
                            const items = imagePreviewGrid.querySelectorAll('.image-preview-item');
                            Array.prototype.forEach.call(items, function (it) {
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
                        removeBtn.addEventListener('click', function (evt) {
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

        if (addProductForm) {
            addProductForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const name = document.getElementById('product-name').value.trim();
                if (!name) {
                    alert('Tên sản phẩm là bắt buộc');
                    return;
                }

                if (modalSubmitBtn) {
                    modalSubmitBtn.disabled = true;
                    modalSubmitBtn.textContent = 'Đang lưu...';
                }

                const oldInputs = addProductForm.querySelectorAll('input[name="productImageAlt[]"], input[name="productImageIsThumb[]"]');
                Array.prototype.forEach.call(oldInputs, function (input) {
                    input.remove();
                });

                const previewItems = imagePreviewGrid.querySelectorAll('.image-preview-item');
                if (previewItems.length > 0) {
                    Array.prototype.forEach.call(previewItems, function (item) {
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

                const formData = new FormData(addProductForm);

                fetch(CTX + '/admin/product/add', {
                    method: 'POST',
                    body: formData
                })
                    .then(function (response) {
                        if (!response.ok) {
                            return response.json().then(function (data) {
                                throw new Error(data.error || 'Lỗi server');
                            });
                        }
                        return response.json();
                    })
                    .then(function (data) {
                        if (data && data.success) {
                            alert('Thêm sản phẩm thành công!');
                            closeModal(addProductModal);
                            resetProductForm();
                            loadProducts();
                        }
                    })
                    .catch(function (error) {
                        alert('Lỗi: ' + error.message);
                    })
                    .finally(function () {
                        if (modalSubmitBtn) {
                            modalSubmitBtn.disabled = false;
                            modalSubmitBtn.textContent = 'Lưu Sản phẩm';
                        }
                    });
            });
        }

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

        const searchInput = document.getElementById('globalSearchInput');
        if (searchInput) {
            searchInput.addEventListener('input', function () {
                const q = this.value.trim().toLowerCase();
                const rows = document.querySelectorAll('#productTableBody tr');

                Array.prototype.forEach.call(rows, function (row) {
                    const text = row.innerText.toLowerCase();
                    const match = !q || text.indexOf(q) !== -1;
                    row.style.display = match ? '' : 'none';
                });
            });

            window.addEventListener('keydown', function (e) {
                if (e.key === '/' && !/INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName)) {
                    e.preventDefault();
                    searchInput.focus();
                }
            });
        }

        loadCategories();
        loadProducts();

    });

    function loadProducts() {
        fetch(CTX + '/admin/product/add')
            .then(function (response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function (products) {
                displayProducts(products);
            })
            .catch(function (error) {
                alert('Không thể tải danh sách sản phẩm: ' + error.message);
            });
    }

    function displayProducts(products) {
        var tbody = document.getElementById('productTableBody');
        if (!tbody) return;

        tbody.innerHTML = '';

        if (!products || products.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;padding:40px;">Chưa có sản phẩm nào</td></tr>';
            return;
        }

        products.forEach(function (product) {
            var row = document.createElement('tr');

            var imgCell = document.createElement('td');
            if (product.thumbnail) {
                var img = document.createElement('img');
                img.src = product.thumbnail;
                img.alt = product.nameProduct;
                img.style.width = '60px';
                img.style.height = '60px';
                img.style.objectFit = 'cover';
                img.style.borderRadius = '4px';
                imgCell.appendChild(img);
            } else {
                imgCell.textContent = 'N/A';
                imgCell.style.color = '#999';
            }
            row.appendChild(imgCell);

            var nameCell = document.createElement('td');
            var nameDiv = document.createElement('div');
            nameDiv.className = 'product-name';
            nameDiv.textContent = product.nameProduct || 'N/A';
            nameCell.appendChild(nameDiv);

            if (product.sku || product.productCode) {
                var metaDiv = document.createElement('div');
                metaDiv.className = 'meta';
                metaDiv.style.fontSize = '12px';
                metaDiv.style.color = '#666';
                metaDiv.style.marginTop = '4px';

                var metaText = '';
                if (product.sku) metaText += 'SKU: ' + product.sku;
                if (product.productCode) {
                    if (metaText) metaText += ' | ';
                    metaText += 'Mã: ' + product.productCode;
                }
                metaDiv.textContent = metaText;
                nameCell.appendChild(metaDiv);
            }
            row.appendChild(nameCell);

            var catCell = document.createElement('td');
            catCell.textContent = product.categoryName || 'N/A';
            if (!product.categoryName) catCell.style.color = '#999';
            row.appendChild(catCell);

            var statusCell = document.createElement('td');
            var badge = document.createElement('span');
            badge.className = 'badge';

            if (product.statusProduct === 'active') {
                badge.className += ' badge-active';
                badge.textContent = 'Active';
                badge.style.background = '#d4edda';
                badge.style.color = '#155724';
            } else {
                badge.className += ' badge-inactive';
                badge.textContent = 'Inactive';
                badge.style.background = '#f8d7da';
                badge.style.color = '#721c24';
            }

            badge.style.padding = '4px 8px';
            badge.style.borderRadius = '4px';
            badge.style.fontSize = '12px';
            statusCell.appendChild(badge);
            row.appendChild(statusCell);

            var variantCell = document.createElement('td');
            variantCell.textContent = product.variantCount || 0;
            row.appendChild(variantCell);

            var stockCell = document.createElement('td');
            if (product.totalStock !== null && product.totalStock !== undefined) {
                stockCell.textContent = product.totalStock;

                if (product.totalStock === 0) {
                    stockCell.style.color = 'red';
                    stockCell.style.fontWeight = 'bold';
                } else if (product.totalStock < 10) {
                    stockCell.style.color = 'orange';
                }
            } else {
                stockCell.textContent = '-';
                stockCell.style.color = '#999';
            }
            row.appendChild(stockCell);

            var priceCell = document.createElement('td');
            if (product.price !== null && product.price !== undefined) {
                priceCell.textContent = Number(product.price).toLocaleString('vi-VN') + 'đ';
            } else {
                priceCell.textContent = 'N/A';
                priceCell.style.color = '#999';
            }
            row.appendChild(priceCell);

            var dateCell = document.createElement('td');
            dateCell.textContent = formatDateTime(product.createdAt);
            dateCell.style.fontSize = '13px';
            if (!product.createdAt) dateCell.style.color = '#999';
            row.appendChild(dateCell);

            var actionCell = document.createElement('td');

            var editBtn = document.createElement('a');
            editBtn.href = '#';
            editBtn.className = 'btn-icon';
            editBtn.innerHTML = '<i class="fas fa-edit" style="color: var(--brand)"></i>';
            editBtn.title = 'Sửa';
            editBtn.style.marginRight = '8px';
            editBtn.onclick = function (e) {
                e.preventDefault();
                alert('Chức năng sửa đang phát triển. ID: ' + product.id);
            };

            var deleteBtn = document.createElement('a');
            deleteBtn.href = '#';
            deleteBtn.className = 'btn-icon btn-icon-danger';
            deleteBtn.innerHTML = '<i class="fas fa-trash" style="color: var(--brand)"></i>';
            deleteBtn.title = 'Xóa';
            deleteBtn.onclick = function (e) {
                e.preventDefault();
                if (confirm('Bạn có chắc muốn xóa sản phẩm "' + product.nameProduct + '"?')) {
                    alert('Chức năng xóa đang phát triển. ID: ' + product.id);
                }
            };

            actionCell.appendChild(editBtn);
            actionCell.appendChild(deleteBtn);
            row.appendChild(actionCell);

            tbody.appendChild(row);
        });
    }

</script>

</body>
</html>
