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

                <!-- SEARCH INPUT: hiện tại cố định, không tạo động -->
                <div class="search-wrapper" style="margin-left:auto; margin-right:12px;">
                    <input type="search" id="globalSearchInput" class="search-input" placeholder="Tìm theo tên, mã, danh mục..." aria-label="Tìm sản phẩm">
                </div>

                <div class="actions-row">
                    <a href="#" class="btn btn-secondary" id="addCategoryBtn"><i class="fas fa-folder-plus"></i> Thêm Danh mục</a>
                    <a href="#" class="btn btn-primary" id="addProductBtn"><i class="fas fa-plus"></i> Thêm Sản phẩm</a>
                </div>
            </div>

            <!-- Table (data ideally rendered server-side) -->
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
                <!-- Example row (replace with server-side loop rendering from DB) -->
                <tr>
                    <td><img src="${pageContext.request.contextPath}/image/adtt01.png" alt="adtt01"></td>
                    <td>
                        <div><strong>Áo dài Bách Hoa - thêu tay Hương Lài Đỏ</strong></div>
                        <div class="meta">Mã: ADTT01</div>
                    </td>
                    <td><span class="meta">Áo dài</span></td>
                    <td><span class="status active">Hoạt động</span></td>
                    <td>3</td>
                    <td><span class="stock in-stock">700</span></td>
                    <td>10.00</td>
                    <td>2025-10-01</td>
                    <td class="settings-icons">
                        <a href="#" class="edit-btn" title="Sửa"
                           data-id="1"
                           data-name="Áo dài Bách Hoa - thêu tay Hương Lài Đỏ"
                           data-code="ADTT01"
                           data-description="Mẫu thêu tay"
                           data-status="active"
                           data-category-id="1"
                           data-variants='[{"sku":"ADTT01-RED-S","size":"S","color":"Đỏ","price":"10.00","stock":200}]'
                           data-images='[{"url":"${pageContext.request.contextPath}/image/adtt01.png","alt":"adtt01","is_thumbnail":true}]'
                        ><i class="fas fa-edit"></i></a>

                        <a href="#" class="delete-btn" title="Xóa"><i class="fa-solid fa-trash"></i></a>
                    </td>
                </tr>
                <!-- END sample row -->
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

        <!-- Add/Edit Product Modal (unchanged) -->
        <div id="addProductModal" class="modal-overlay" aria-hidden="true">
            <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
                <div class="modal-header">
                    <h2 id="modalTitle">Thêm Sản phẩm mới</h2>
                    <span class="close-button" id="closeModalBtn">&times;</span>
                </div>

                <form id="addProductForm" novalidate>
                    <div class="modal-body">
                        <div class="modal-form-grid">
                            <div class="form-group-modal full-width">
                                <label for="product-name">Tên Sản phẩm <span style="color:red">*</span></label>
                                <input type="text" id="product-name" required placeholder="Tên sản phẩm">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-code">Mã sản phẩm (product_code)</label>
                                <input type="text" id="product-code" placeholder="VD: ADTT01">
                            </div>

                            <div class="form-group-modal">
                                <label for="product-category">Danh mục <span style="color:red">*</span></label>
                                <div style="display:flex; gap:8px; align-items:center;">
                                    <select id="product-category" required>
                                        <option value="">-- Tải danh mục --</option>
                                        <!-- server render categories here -->
                                    </select>
                                    <a href="#" id="openAddCategoryFromProduct" class="btn btn-secondary">Thêm</a>
                                </div>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-status">Trạng thái</label>
                                <select id="product-status">
                                    <option value="active">active</option>
                                    <option value="inactive">inactive</option>
                                </select>
                            </div>

                            <div class="form-group-modal">
                                <label for="product-created-at">Ngày tạo (tùy chọn)</label>
                                <input type="datetime-local" id="product-created-at">
                            </div>

                            <div class="form-group-modal full-width">
                                <label for="product-description">Mô tả</label>
                                <textarea id="product-description" placeholder="Mô tả chi tiết (sẽ lưu vào Products.description)"></textarea>
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
                                <input type="file" id="product-image-input" accept="image/*" multiple>
                                <div class="image-preview-grid" id="imagePreviewGrid"></div>
                                <p class="meta">Bạn có thể đánh dấu 1 ảnh làm thumbnail sau khi upload.</p>
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

<!-- JavaScript (kept in JSP file; this is not CSS) -->
<script>
    /* --- DOM refs --- */
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

    const productCategorySelect = document.getElementById('product-category');
    const categoryParentSelect = document.getElementById('category-parent');
    const openAddCategoryFromProduct = document.getElementById('openAddCategoryFromProduct');

    const imageInput = document.getElementById('product-image-input');
    const imagePreviewGrid = document.getElementById('imagePreviewGrid');
    const variantsContainer = document.getElementById('variantsContainer');
    const addVariantBtn = document.getElementById('addVariantBtn');

    /* --- demo in-memory categories (replace by server API) --- */
    let categories = [ {id:1, name_category:'Áo dài', slug:'ao-dai', description:'', parent_category_id:null} ];

    function slugify(text){
        return text.toString().toLowerCase()
            .normalize('NFD').replace(/[\u0300-\u036f]/g, '')
            .replace(/đ/g,'d').replace(/[^a-z0-9 -]/g,'').trim().replace(/\s+/g,'-');
    }

    /* --- populate selects --- */
    function refreshCategorySelects(){
        productCategorySelect.innerHTML = '<option value=\"\">-- Chọn danh mục --</option>';
        categoryParentSelect.innerHTML = '<option value=\"\">-- Không --</option>';
        categories.forEach(cat=>{
            const opt = document.createElement('option'); opt.value = cat.id; opt.textContent = cat.name_category;
            productCategorySelect.appendChild(opt);
            const opt2 = document.createElement('option'); opt2.value = cat.id; opt2.textContent = cat.name_category;
            categoryParentSelect.appendChild(opt2);
        });
    }
    refreshCategorySelects();

    /* --- modal open/close --- */
    function openModal(modal){
        if(!modal) return;
        modal.style.display = 'block';
        modal.setAttribute('aria-hidden', 'false');
    }
    function closeModal(modal){
        if(!modal) return;
        modal.style.display = 'none';
        modal.setAttribute('aria-hidden', 'true');
    }

    addProductBtn.addEventListener('click', (e)=>{ e.preventDefault(); resetProductForm(); document.getElementById('modalTitle').textContent='Thêm Sản phẩm mới'; openModal(addProductModal); });
    closeModalBtn.addEventListener('click', ()=> closeModal(addProductModal));
    cancelModalBtn.addEventListener('click', ()=> closeModal(addProductModal));

    addCategoryBtn.addEventListener('click', (e)=>{ e.preventDefault(); openModal(addCategoryModal); });
    closeCategoryModalBtn.addEventListener('click', ()=> closeModal(addCategoryModal));
    cancelAddCategory.addEventListener('click', ()=> closeModal(addCategoryModal));
    openAddCategoryFromProduct.addEventListener('click', (e)=>{ e.preventDefault(); openModal(addCategoryModal); });

    /* --- Add category (demo) --- */
    addCategoryForm.addEventListener('submit', function(e){
        e.preventDefault();
        const name = document.getElementById('category-name').value.trim();
        let slug = document.getElementById('category-slug').value.trim();
        const desc = document.getElementById('category-description').value.trim();
        const parent = document.getElementById('category-parent').value || null;
        if(!name) return alert('Tên danh mục là bắt buộc');
        if(!slug) slug = slugify(name);
        // TODO: POST /api/categories -> real backend
        const newCat = { id: Date.now(), name_category: name, slug: slug, description: desc, parent_category_id: parent };
        categories.push(newCat);
        refreshCategorySelects();
        closeModal(addCategoryModal);
    });

    /* --- Variants --- */
    function createVariantRow(data={sku:'', size:'', color:'', price:'', stock:''}){
        const row = document.createElement('div'); row.className = 'variant-row';
        row.innerHTML = `
    <input placeholder="SKU" class="variant-sku" value="${data.sku}" />
    <input placeholder="Size" class="variant-size" value="${data.size}" />
    <input placeholder="Color" class="variant-color" value="${data.color}" />
    <input type="number" placeholder="Giá" class="variant-price" value="${data.price}" step="0.01" />
    <input type="number" placeholder="Tồn" class="variant-stock" value="${data.stock}" />
    <button class="btn-remove-variant">Xóa</button>
  `;
        row.querySelector('.btn-remove-variant').addEventListener('click', (e)=>{ e.preventDefault(); row.remove(); });
        variantsContainer.appendChild(row);
        return row;
    }
    addVariantBtn.addEventListener('click', (e)=>{ e.preventDefault(); createVariantRow(); });

    /* --- Images preview --- */
    imageInput.addEventListener('change', function(e){
        const files = Array.from(e.target.files);
        imagePreviewGrid.innerHTML = '';
        files.forEach((file, idx)=>{
            const reader = new FileReader();
            reader.onload = function(ev){
                const wrapper = document.createElement('div'); wrapper.style.position='relative';
                const img = document.createElement('img'); img.src = ev.target.result; img.alt = file.name;
                img.style.width='200px'; img.style.height='200px'; img.style.objectFit='cover'; img.style.borderRadius='8px';
                const thumbBtn = document.createElement('button'); thumbBtn.className='btn btn-secondary'; thumbBtn.style.position='absolute'; thumbBtn.style.bottom='6px'; thumbBtn.style.left='6px'; thumbBtn.textContent='Thumbnail';
                thumbBtn.addEventListener('click', function(e){ e.preventDefault(); [...imagePreviewGrid.querySelectorAll('img')].forEach(i=> i.style.outline=''); img.style.outline='3px solid '+getComputedStyle(document.documentElement).getPropertyValue('--brand'); img.dataset.isThumbnail = '1'; });
                const removeBtn = document.createElement('button'); removeBtn.className='btn btn-secondary'; removeBtn.style.position='absolute'; removeBtn.style.bottom='6px'; removeBtn.style.right='6px'; removeBtn.textContent='Xóa';
                removeBtn.addEventListener('click', function(ev){ ev.preventDefault(); wrapper.remove(); });
                wrapper.appendChild(img); wrapper.appendChild(thumbBtn); wrapper.appendChild(removeBtn);
                imagePreviewGrid.appendChild(wrapper);
            }
            reader.readAsDataURL(file);
        });
    });

    /* --- Product form submit (collect payload matching DB) --- */
    addProductForm.addEventListener('submit', function(e){
        e.preventDefault();
        const payload = {};
        payload.name = document.getElementById('product-name').value.trim();
        payload.product_code = document.getElementById('product-code').value.trim();
        payload.description = document.getElementById('product-description').value.trim();
        payload.status_product = document.getElementById('product-status').value;
        payload.category_id = document.getElementById('product-category').value || null;
        const createdAt = document.getElementById('product-created-at').value; if(createdAt) payload.created_at = createdAt;
        payload.variants = [];
        variantsContainer.querySelectorAll('.variant-row').forEach(row =>{
            const sku = row.querySelector('.variant-sku').value.trim();
            if(!sku) return;
            payload.variants.push({
                sku: sku,
                size: row.querySelector('.variant-size').value.trim(),
                color: row.querySelector('.variant-color').value.trim(),
                current_price: row.querySelector('.variant-price').value || 0,
                stock_quantity: parseInt(row.querySelector('.variant-stock').value||0)
            });
        });
        payload.images = [];
        imagePreviewGrid.querySelectorAll('img').forEach(img=>{
            payload.images.push({ image_url: img.src, alt_text: img.alt || '', is_thumbnail: img.dataset.isThumbnail === '1' ? 1 : 0 });
        });

        console.log('Payload (Products, Product_variants, Product_images):', payload);
        // TODO: replace with real POST to server: fetch('/api/products', {method:'POST', headers:{'Content-Type':'application/json'}, body: JSON.stringify(payload)})
        alert('Dữ liệu sẵn sàng gửi. Kiểm tra console để xem payload mẫu.');
        closeModal(addProductModal);
    });

    /* --- Reset product form helper --- */
    function resetProductForm(){
        addProductForm.reset();
        variantsContainer.innerHTML = '';
        imagePreviewGrid.innerHTML = '';
        createVariantRow();
        refreshCategorySelects();
    }

    /* --- Edit product (delegated) --- */
    document.getElementById('productTableBody').addEventListener('click', function(e){
        const editBtn = e.target.closest('.edit-btn');
        if(!editBtn) return;
        e.preventDefault();
        resetProductForm();
        const data = editBtn.dataset;
        document.getElementById('modalTitle').textContent = 'Chỉnh sửa Sản phẩm';
        document.getElementById('product-name').value = data.name || '';
        document.getElementById('product-code').value = data.code || '';
        document.getElementById('product-description').value = data.description || '';
        document.getElementById('product-status').value = data.status || 'active';
        if(data.categoryId) document.getElementById('product-category').value = data.categoryId;
        try{
            const variants = JSON.parse(data.variants || '[]');
            variantsContainer.innerHTML = '';
            variants.forEach(v => createVariantRow({ sku:v.sku, size:v.size, color:v.color, price:v.price, stock:v.stock }));
        }catch(err){}
        try{
            const imgs = JSON.parse(data.images || '[]');
            imagePreviewGrid.innerHTML = '';
            imgs.forEach(img => {
                const wrapper = document.createElement('div'); wrapper.style.position='relative';
                const el = document.createElement('img'); el.src = img.url; el.alt = img.alt || '';
                if(img.is_thumbnail) { el.style.outline='3px solid '+getComputedStyle(document.documentElement).getPropertyValue('--brand'); el.dataset.isThumbnail = '1'; }
                const removeBtn = document.createElement('button'); removeBtn.className='btn btn-secondary'; removeBtn.style.position='absolute'; removeBtn.style.bottom='6px'; removeBtn.style.right='6px'; removeBtn.textContent='Xóa';
                removeBtn.addEventListener('click', ()=> wrapper.remove());
                wrapper.appendChild(el); wrapper.appendChild(removeBtn);
                imagePreviewGrid.appendChild(wrapper);
            });
        }catch(err){}
        openModal(addProductModal);
    });

    /* --- Convert status spans to editable select (quick inline edit) --- */
    (function makeStatusEditable(){
        const rows = document.querySelectorAll('.product-table tbody tr');
        rows.forEach(row=>{
            const statusSpan = row.querySelector('.status');
            if(!statusSpan) return;
            if(row.querySelector('.status-select')) return;
            const current = statusSpan.classList.contains('active') ? 'active' :  'inactive';
            const select = document.createElement('select'); select.className = 'status-select ' + current;
            ['active','inactive'].forEach(s=>{
                const opt = document.createElement('option'); opt.value = s; opt.textContent = s;
                if(s===current) opt.selected = true;
                select.appendChild(opt);
            });
            statusSpan.parentNode.replaceChild(select, statusSpan);
            select.addEventListener('change', function(){
                ['active','inactive'].forEach(c=> select.classList.remove(c));
                select.classList.add(this.value);
                const productRow = select.closest('tr');
                const productId = productRow.querySelector('.edit-btn') ? productRow.querySelector('.edit-btn').dataset.id : null;
                console.log('Change status for productId:', productId, '->', this.value);
                // TODO: send PATCH to server to update status
            });
        });
    })();
    (function(){
        const searchInput = document.getElementById('globalSearchInput');
        if(!searchInput) return;
        searchInput.addEventListener('input', function(){
            const q = this.value.trim().toLowerCase();
            const rows = document.querySelectorAll('#productTableBody tr');
            rows.forEach(row=>{
                // Search in visible columns: name, code (meta), category, and full text fallback
                const name = (row.querySelector('td:nth-child(2)')?.innerText || '').toLowerCase();
                const codeMeta = (row.querySelector('.meta')?.innerText || '').toLowerCase();
                const category = (row.querySelector('td:nth-child(3)')?.innerText || '').toLowerCase();
                const all = (row.innerText || '').toLowerCase();
                const match = !q || name.includes(q) || codeMeta.includes(q) || category.includes(q) || all.includes(q);
                row.style.display = match ? '' : 'none';
            });
        });

        // keyboard quick-focus '/' to focus search
        window.addEventListener('keydown', function(e){
            if(e.key === '/' && !/INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName)){
                e.preventDefault();
                searchInput.focus();
            }
        });
    })();
</script>

</body>
</html>