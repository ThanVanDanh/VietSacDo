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

function displayCategoriesTable(categories) {
    var tbody = document.getElementById('categoryTableBody');
    if (!tbody) return;

    tbody.innerHTML = '';

    if (!categories || categories.length === 0) {
        tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:40px;">Chưa có danh mục nào</td></tr>';
        return;
    }

    var categoryMap = {};
    var rootCategories = [];

    categories.forEach(function (cat) {
        categoryMap[cat.id] = cat;
        cat.children = [];
    });

    categories.forEach(function (cat) {
        if (!cat.parentCategoryId || cat.parentCategoryId === null) {
            rootCategories.push(cat);
        } else {
            var parent = categoryMap[cat.parentCategoryId];
            if (parent) {
                parent.children.push(cat);
            }
        }
    });

    rootCategories.forEach(function (rootCat) {
        renderCategoryRecursive(tbody, rootCat, 0);
    });
}

function renderCategoryRecursive(tbody, category, level) {
    renderCategoryRow(tbody, category, level);

    if (category.children && category.children.length > 0) {
        category.children.forEach(function (child) {
            renderCategoryRecursive(tbody, child, level + 1);
        });
    }
}

function renderCategoryRow(tbody, category, level) {
    var row = document.createElement('tr');
    row.className = 'category-row';

    var nameCell = document.createElement('td');
    var nameDiv = document.createElement('div');
    nameDiv.className = 'category-name-cell';
    nameDiv.style.display = 'flex';
    nameDiv.style.alignItems = 'center';

    if (level > 0) {
        var indent = document.createElement('span');
        indent.className = 'category-indent';
        indent.style.marginLeft = (level * 20) + 'px';
        indent.innerHTML = '└─';
        nameDiv.appendChild(indent);
    }

    var icon = document.createElement('i');
    icon.className = level === 0 ? 'fas fa-folder category-icon' : 'fas fa-folder-open category-icon';
    icon.style.marginRight = '8px';
    nameDiv.appendChild(icon);

    var nameSpan = document.createElement('span');
    nameSpan.textContent = category.nameCategory || 'N/A';
    nameSpan.className = level === 0 ? 'parent-category' : 'child-category';
    nameDiv.appendChild(nameSpan);

    nameCell.appendChild(nameDiv);
    row.appendChild(nameCell);

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

    var countCell = document.createElement('td');
    countCell.textContent = category.productCount || 0;
    countCell.style.textAlign = 'center';
    countCell.style.fontWeight = '500';

    if (category.productCount > 0) {
        countCell.style.color = '#28a745';
    } else {
        countCell.style.color = '#999';
    }
    row.appendChild(countCell);

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

function refreshCategorySelects(categories) {
    var productCategorySelect = document.getElementById('product-category');
    var categoryParentSelect = document.getElementById('category-parent');
    var editForm = document.getElementById('addCategoryForm');

    var editingCategoryId = editForm && editForm.dataset.editId
        ? parseInt(editForm.dataset.editId)
        : null;

    if (productCategorySelect) {
        var currentValue = productCategorySelect.value;
        productCategorySelect.innerHTML = '<option value="">-- Chọn danh mục --</option>';

        if (categories && categories.length > 0) {
            var tree = buildCategoryTree(categories);

            tree.forEach(function (rootCat) {
                appendCategoryOption(productCategorySelect, rootCat, 0);
            });
        }

        if (currentValue) productCategorySelect.value = currentValue;
    }

    if (categoryParentSelect) {
        var currentValue = categoryParentSelect.value;
        categoryParentSelect.innerHTML = '<option value="">-- Không --</option>';

        if (categories && categories.length > 0) {
            var tree = buildCategoryTree(categories);

            tree.forEach(function (rootCat) {
                appendCategoryOption(categoryParentSelect, rootCat, 0, editingCategoryId);
            });
        }

        if (currentValue) categoryParentSelect.value = currentValue;
    }
}

function buildCategoryTree(categories) {
    var categoryMap = {};
    var roots = [];

    categories.forEach(function (cat) {
        categoryMap[cat.id] = Object.assign({}, cat);
        categoryMap[cat.id].children = [];
    });

    categories.forEach(function (cat) {
        if (!cat.parentCategoryId || cat.parentCategoryId === null) {
            roots.push(categoryMap[cat.id]);
        } else {
            var parent = categoryMap[cat.parentCategoryId];
            if (parent) {
                parent.children.push(categoryMap[cat.id]);
            }
        }
    });

    return roots;
}

function appendCategoryOption(select, category, level, excludeId) {
    if (excludeId && category.id === excludeId) {
        return;
    }

    var opt = document.createElement('option');
    opt.value = category.id;

    var prefix = '';
    for (var i = 0; i < level; i++) {
        prefix += '　';
    }
    if (level > 0) {
        prefix += '└─ ';
    }

    opt.textContent = prefix + category.nameCategory;
    select.appendChild(opt);

    if (category.children && category.children.length > 0) {
        category.children.forEach(function (child) {
            appendCategoryOption(select, child, level + 1, excludeId);
        });
    }
}

function editCategory(category) {
    var modal = document.getElementById('addCategoryModal');
    var form = document.getElementById('addCategoryForm');

    document.getElementById('categoryModalTitle').textContent = 'Chỉnh sửa Danh mục';
    document.getElementById('category-name').value = category.nameCategory || '';
    document.getElementById('category-slug').value = category.slug || '';
    document.getElementById('category-description').value = category.description || '';

    var parentSelect = document.getElementById('category-parent');
    if (parentSelect) {
        parentSelect.value = category.parentCategoryId || '';
    }

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

function deleteProduct(product) {
    var message = 'Bạn có chắc muốn xóa sản phẩm "' + product.nameProduct + '"?\n\n';
    message += 'Thao tác này sẽ xóa:\n';
    message += '• Sản phẩm chính\n';

    if (product.variantCount && product.variantCount > 0) {
        message += '• ' + product.variantCount + ' biến thể\n';
    }

    message += '• Tất cả hình ảnh liên quan\n';
    message += '\nThao tác này KHÔNG THỂ hoàn tác!';

    if (!confirm(message)) {
        return;
    }

    fetch(CTX + '/admin/product/delete', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json'
        },
        body: 'id=' + product.id
    })
        .then(function (response) {
            return response.json().then(function (data) {
                return {status: response.status, data: data};
            });
        })
        .then(function (result) {
            if (result.data && result.data.success) {
                alert('Xóa sản phẩm thành công!');
                loadProducts();
            } else {
                alert('Xóa thất bại: ' + (result.data.error || 'Unknown error'));
            }
        })
        .catch(function (error) {
            alert('Lỗi: ' + error.message);
        });
}

function editProduct(product) {
    var modalTitle = document.getElementById('modalTitle');
    var modalSubmitBtn = document.getElementById('modalSubmitBtn');
    var addProductForm = document.getElementById('addProductForm');

    if (!modalTitle || !modalSubmitBtn || !addProductForm) {
        alert('Lỗi: Không tìm thấy elements trong form');
        return;
    }

    modalTitle.textContent = 'Chỉnh sửa Sản phẩm';
    modalSubmitBtn.textContent = 'Cập nhật Sản phẩm';
    modalSubmitBtn.style.backgroundColor = '#ff8c00';

    fetch(CTX + '/admin/product/get?id=' + product.id)
        .then(function (response) {
            if (!response.ok) throw new Error('HTTP ' + response.status);
            return response.json();
        })
        .then(function (productDetail) {
            document.getElementById('product-name').value = productDetail.nameProduct || '';
            document.getElementById('product-code').value = productDetail.productCode || '';
            document.getElementById('product-description').value = productDetail.description || '';
            document.getElementById('product-status').value = productDetail.statusProduct || 'active';
            document.getElementById('product-category').value = productDetail.categoryId || '';

            addProductForm.dataset.editId = product.id;

            var variantsContainer = document.getElementById('variantsContainer');
            variantsContainer.innerHTML = '';

            if (productDetail.variants && productDetail.variants.length > 0) {
                productDetail.variants.forEach(function (variant) {
                    createVariantRow({
                        sku: variant.sku || '',
                        size: variant.size || '',
                        color: variant.color || '',
                        price: variant.currentPrice || 0,
                        stock: variant.stockQuantity || 0
                    });
                });
            } else {
                createVariantRow();
            }

            var imagePreviewGrid = document.getElementById('imagePreviewGrid');
            imagePreviewGrid.innerHTML = '';

            if (productDetail.images && productDetail.images.length > 0) {
                productDetail.images.forEach(function (image) {
                    createExistingImagePreview(image);
                });
            }

            openModal(document.getElementById('addProductModal'));
            loadCategories();
        })
        .catch(function (error) {
            alert('Không thể tải thông tin sản phẩm: ' + error.message);
        });
}

function createExistingImagePreview(image) {
    var imagePreviewGrid = document.getElementById('imagePreviewGrid');

    var wrapper = document.createElement('div');
    wrapper.className = 'image-preview-item existing-image';
    wrapper.style.position = 'relative';
    wrapper.style.display = 'inline-block';
    wrapper.style.margin = '8px';
    wrapper.style.border = '2px solid #28a745';
    wrapper.style.borderRadius = '8px';
    wrapper.style.padding = '4px';
    wrapper.dataset.imageId = image.id;
    wrapper.dataset.isThumbnail = image.thumbnail ? '1' : '0';

    var img = document.createElement('img');
    img.src = image.imageUrl;
    img.alt = image.altText || '';
    img.style.width = '150px';
    img.style.height = '150px';
    img.style.objectFit = 'cover';
    img.style.borderRadius = '4px';
    img.style.display = 'block';

    if (image.thumbnail) {
        img.style.border = '3px solid #640100';
    }

    wrapper.appendChild(img);

    var label = document.createElement('div');
    label.style.fontSize = '11px';
    label.style.marginTop = '4px';
    label.style.textAlign = 'center';
    label.style.color = '#28a745';
    label.style.fontWeight = 'bold';
    label.textContent = 'Ảnh hiện có';
    wrapper.appendChild(label);

    var btnContainer = document.createElement('div');
    btnContainer.style.display = 'flex';
    btnContainer.style.gap = '4px';
    btnContainer.style.marginTop = '4px';
    btnContainer.style.justifyContent = 'center';

    var thumbBtn = document.createElement('button');
    thumbBtn.className = 'btn btn-primary';
    thumbBtn.type = 'button';
    thumbBtn.style.fontSize = '11px';
    thumbBtn.style.padding = '4px 8px';
    thumbBtn.textContent = image.thumbnail ? '★ Thumb' : 'Thumbnail';
    thumbBtn.addEventListener('click', function (evt) {
        evt.preventDefault();
        setThumbnailForImage(wrapper);
    });
    btnContainer.appendChild(thumbBtn);

    var removeBtn = document.createElement('button');
    removeBtn.className = 'btn btn-secondary';
    removeBtn.type = 'button';
    removeBtn.style.fontSize = '11px';
    removeBtn.style.padding = '4px 8px';
    removeBtn.textContent = 'Xóa';
    removeBtn.addEventListener('click', function (evt) {
        evt.preventDefault();
        if (confirm('Xóa ảnh này khỏi sản phẩm?')) {
            wrapper.remove();
        }
    });
    btnContainer.appendChild(removeBtn);

    wrapper.appendChild(btnContainer);
    imagePreviewGrid.appendChild(wrapper);
}

function setThumbnailForImage(selectedWrapper) {
    var imagePreviewGrid = document.getElementById('imagePreviewGrid');
    var items = imagePreviewGrid.querySelectorAll('.image-preview-item');

    Array.prototype.forEach.call(items, function (item) {
        item.dataset.isThumbnail = '0';
        var img = item.querySelector('img');
        if (img) img.style.border = '';

        var thumbBtn = item.querySelector('.btn-primary');
        if (thumbBtn) thumbBtn.textContent = 'Thumbnail';
    });

    selectedWrapper.dataset.isThumbnail = '1';
    var img = selectedWrapper.querySelector('img');
    if (img) img.style.border = '3px solid #640100';

    var thumbBtn = selectedWrapper.querySelector('.btn-primary');
    if (thumbBtn) thumbBtn.textContent = '★ Thumb';
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
            editProduct(product);
        };

        var deleteBtn = document.createElement('a');
        deleteBtn.href = '#';
        deleteBtn.className = 'btn-icon btn-icon-danger';
        deleteBtn.innerHTML = '<i class="fas fa-trash" style="color: var(--brand)"></i>';
        deleteBtn.title = 'Xóa';
        deleteBtn.onclick = function (e) {
            e.preventDefault();
            deleteProduct(product);
        };

        actionCell.appendChild(editBtn);
        actionCell.appendChild(deleteBtn);
        row.appendChild(actionCell);

        tbody.appendChild(row);
    });
}

function resetProductForm() {
    var addProductForm = document.getElementById('addProductForm');
    var modalSubmitBtn = document.getElementById('modalSubmitBtn');
    var variantsContainer = document.getElementById('variantsContainer');
    var imagePreviewGrid = document.getElementById('imagePreviewGrid');

    if (addProductForm) {
        addProductForm.reset();
        delete addProductForm.dataset.editId;
    }

    var modalTitle = document.getElementById('modalTitle');
    if (modalTitle) {
        modalTitle.textContent = 'Thêm Sản phẩm';
    }

    if (modalSubmitBtn) {
        modalSubmitBtn.textContent = 'Lưu Sản phẩm';
        modalSubmitBtn.style.backgroundColor = '';
        modalSubmitBtn.disabled = false;
    }

    if (variantsContainer) {
        variantsContainer.innerHTML = '';
        createVariantRow();
    }

    if (imagePreviewGrid) {
        imagePreviewGrid.innerHTML = '';
    }
}

function createVariantRow(data) {
    data = data || {sku: '', size: '', color: '', price: '', stock: ''};

    var variantsContainer = document.getElementById('variantsContainer');

    if (!variantsContainer) {
        return null;
    }

    var row = document.createElement('div');
    row.className = 'variant-row';

    var html = '';
    html += '<input name="variant-sku[]" placeholder="SKU" class="variant-sku" value="' + escapeHtml(data.sku) + '" />';
    html += '<input name="variant-size[]" placeholder="Size" class="variant-size" value="' + escapeHtml(data.size) + '" />';
    html += '<input name="variant-color[]" placeholder="Color" class="variant-color" value="' + escapeHtml(data.color) + '" />';
    html += '<input name="variant-price[]" type="number" step="0.01" placeholder="Giá" class="variant-price" value="' + escapeHtml(data.price) + '" />';
    html += '<input name="variant-quantity[]" type="number" placeholder="Tồn" class="variant-stock" value="' + escapeHtml(data.stock) + '" />';
    html += '<button class="btn btn-secondary btn-remove-variant" type="button">Xóa</button>';

    row.innerHTML = html;

    var btnRemove = row.querySelector('.btn-remove-variant');
    if (btnRemove) {
        btnRemove.addEventListener('click', function (e) {
            e.preventDefault();
            if (confirm('Xóa variant này?')) {
                row.remove();
            }
        });
    }

    variantsContainer.appendChild(row);
    return row;
}

document.addEventListener('DOMContentLoaded', function () {
    var addProductModal = document.getElementById('addProductModal');
    var addProductBtn = document.getElementById('addProductBtn');
    var closeModalBtn = document.getElementById('closeModalBtn');
    var cancelModalBtn = document.getElementById('cancelModalBtn');
    var addProductForm = document.getElementById('addProductForm');
    var modalSubmitBtn = document.getElementById('modalSubmitBtn');

    var addCategoryBtnTop = document.getElementById('addCategoryBtnTop');
    var addCategoryModal = document.getElementById('addCategoryModal');
    var closeCategoryModalBtn = document.getElementById('closeCategoryModalBtn');
    var cancelCategoryModalBtn = document.getElementById('cancelCategoryModalBtn');
    var addCategoryForm = document.getElementById('addCategoryForm');
    var categorySubmitBtn = document.getElementById('categorySubmitBtn');

    var imageInput = document.getElementById('product-image-input');
    var imagePreviewGrid = document.getElementById('imagePreviewGrid');
    var variantsContainer = document.getElementById('variantsContainer');
    var addVariantBtn = document.getElementById('addVariantBtn');

    document.querySelectorAll('.tab-button').forEach(function(button) {
        button.addEventListener('click', function() {
            var tabId = this.getAttribute('data-tab');
            switchTab(tabId);
        });
    });

    function switchTab(tabId) {
        document.querySelectorAll('.tab-content').forEach(function(tab) {
            tab.classList.remove('active');
        });

        document.querySelectorAll('.tab-button').forEach(function(btn) {
            btn.classList.remove('active');
        });

        document.getElementById(tabId).classList.add('active');
        document.querySelector('[data-tab="' + tabId + '"]').classList.add('active');

        if (tabId === 'categories-tab') {
            loadCategories();
        }
    }

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

    if (addCategoryBtnTop) {
        addCategoryBtnTop.addEventListener('click', function (e) {
            e.preventDefault();

            addCategoryForm.reset();
            delete addCategoryForm.dataset.editId;

            document.getElementById('categoryModalTitle').textContent = 'Thêm Danh mục';
            document.getElementById('categorySubmitBtn').textContent = 'Lưu Danh mục';

            openModal(addCategoryModal);
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

    window.addEventListener('click', function (evt) {
        if (evt.target === addProductModal) closeModal(addProductModal);
        if (evt.target === addCategoryModal) closeModal(addCategoryModal);
    });

    if (addCategoryForm) {
        addCategoryForm.addEventListener('submit', function (e) {
            e.preventDefault();

            var name = document.getElementById('category-name').value.trim();
            if (!name) {
                alert('Tên danh mục là bắt buộc');
                return;
            }

            if (categorySubmitBtn) {
                categorySubmitBtn.disabled = true;
                categorySubmitBtn.textContent = 'Đang lưu...';
            }

            var formData = new FormData(addCategoryForm);
            var editId = addCategoryForm.dataset.editId;
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
            var files = Array.prototype.slice.call(e.target.files || []);

            files.forEach(function (file) {
                var reader = new FileReader();
                reader.onload = function (ev) {
                    var wrapper = document.createElement('div');
                    wrapper.className = 'image-preview-item new-image';
                    wrapper.style.position = 'relative';
                    wrapper.style.display = 'inline-block';
                    wrapper.style.margin = '8px';
                    wrapper.style.border = '2px solid #007bff';
                    wrapper.style.borderRadius = '8px';
                    wrapper.style.padding = '4px';
                    wrapper.dataset.filename = file.name;
                    wrapper.dataset.isThumbnail = '0';

                    var img = document.createElement('img');
                    img.src = ev.target.result;
                    img.alt = file.name;
                    img.style.width = '150px';
                    img.style.height = '150px';
                    img.style.objectFit = 'cover';
                    img.style.borderRadius = '4px';
                    img.style.display = 'block';
                    wrapper.appendChild(img);

                    var label = document.createElement('div');
                    label.style.fontSize = '11px';
                    label.style.marginTop = '4px';
                    label.style.textAlign = 'center';
                    label.style.color = '#007bff';
                    label.style.fontWeight = 'bold';
                    label.textContent = 'Ảnh mới';
                    wrapper.appendChild(label);

                    var btnContainer = document.createElement('div');
                    btnContainer.style.display = 'flex';
                    btnContainer.style.gap = '4px';
                    btnContainer.style.marginTop = '4px';
                    btnContainer.style.justifyContent = 'center';

                    var thumbBtn = document.createElement('button');
                    thumbBtn.className = 'btn btn-primary';
                    thumbBtn.type = 'button';
                    thumbBtn.style.fontSize = '11px';
                    thumbBtn.style.padding = '4px 8px';
                    thumbBtn.textContent = 'Thumbnail';
                    thumbBtn.addEventListener('click', function (evt) {
                        evt.preventDefault();
                        setThumbnailForImage(wrapper);
                    });
                    btnContainer.appendChild(thumbBtn);

                    var removeBtn = document.createElement('button');
                    removeBtn.className = 'btn btn-secondary';
                    removeBtn.type = 'button';
                    removeBtn.style.fontSize = '11px';
                    removeBtn.style.padding = '4px 8px';
                    removeBtn.textContent = 'Xóa';
                    removeBtn.addEventListener('click', function (evt) {
                        evt.preventDefault();
                        wrapper.remove();
                    });
                    btnContainer.appendChild(removeBtn);

                    wrapper.appendChild(btnContainer);
                    imagePreviewGrid.appendChild(wrapper);
                };
                reader.readAsDataURL(file);
            });
        });
    }

    if (addProductForm) {
        addProductForm.addEventListener('submit', function (e) {
            e.preventDefault();

            var name = document.getElementById('product-name').value.trim();
            if (!name) {
                alert('Tên sản phẩm là bắt buộc');
                return;
            }

            if (modalSubmitBtn) {
                modalSubmitBtn.disabled = true;
                modalSubmitBtn.textContent = 'Đang lưu...';
            }

            var oldInputs = addProductForm.querySelectorAll(
                'input[name="productImageAlt[]"], ' +
                'input[name="productImageIsThumb[]"], ' +
                'input[name="keepImageId[]"], ' +
                'input[name="product-id"]'
            );
            Array.prototype.forEach.call(oldInputs, function (input) {
                input.remove();
            });

            var editId = addProductForm.dataset.editId;
            var isEditMode = editId && editId.trim() !== '';

            if (isEditMode) {
                var productIdInput = document.createElement('input');
                productIdInput.type = 'hidden';
                productIdInput.name = 'product-id';
                productIdInput.value = editId;
                addProductForm.appendChild(productIdInput);
            }

            var previewItems = imagePreviewGrid.querySelectorAll('.image-preview-item');

            if (previewItems.length > 0) {
                Array.prototype.forEach.call(previewItems, function (item) {
                    var isExisting = item.classList.contains('existing-image');

                    if (isExisting) {
                        var imageId = item.dataset.imageId;
                        if (imageId) {
                            var keepInput = document.createElement('input');
                            keepInput.type = 'hidden';
                            keepInput.name = 'keepImageId[]';
                            keepInput.value = imageId;
                            addProductForm.appendChild(keepInput);
                        }
                    } else {
                        var fname = item.dataset.filename || '';
                        var img = item.querySelector('img');
                        var alt = img ? img.alt : fname;
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
                    }
                });
            }

            var formData = new FormData(addProductForm);

            var url = isEditMode
                ? CTX + '/admin/product/update'
                : CTX + '/admin/product/add';

            fetch(url, {
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
                        var message = isEditMode
                            ? 'Cập nhật sản phẩm thành công!'
                            : 'Thêm sản phẩm thành công!';
                        alert(message);
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
                        var btnText = isEditMode
                            ? 'Cập nhật Sản phẩm'
                            : 'Lưu Sản phẩm';
                        modalSubmitBtn.textContent = btnText;
                    }
                });
        });
    }

    var searchInput = document.getElementById('globalSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function () {
            var q = this.value.trim().toLowerCase();
            var rows = document.querySelectorAll('#productTableBody tr');

            Array.prototype.forEach.call(rows, function (row) {
                var text = row.innerText.toLowerCase();
                var match = !q || text.indexOf(q) !== -1;
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