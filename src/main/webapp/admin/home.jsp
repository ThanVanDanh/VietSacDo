<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Trang chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/alert.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/adminhome.css">
</head>
<body>
<div class="admin-container">
    <jsp:include page="sidebar.jsp" />
    <main class="main-content">
        <header class="admin-header">
            <h2><i class="fas fa-home"></i> Quản lý Trang chủ</h2>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/home" target="_blank" class="btn-preview">
                    <i class="fas fa-eye"></i> Xem trang chủ
                </a>
            </div>
        </header>
        <div class="home-config-container">
            <div id="alert-container"></div>
            <button class="btn-add-section" onclick="addNewSection()">
                <i class="fas fa-plus-circle"></i> Thêm Section Mới
            </button>
            <div id="sections-container">
                <div class="empty-state" id="empty-state">
                    <i class="fas fa-inbox"></i>
                    <p>Đang tải cấu hình...</p>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    var CTX = '<c:out value="${pageContext.request.contextPath}" />';
    
    var ALL_CATEGORIES = [
        <c:forEach var="c" items="${categories}" varStatus="s">
        { id: <c:out value="${c.id}" />, name: '<c:out value="${c.nameCategory}" />' }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    var DEFAULT_SECTIONS = ['section_1', 'section_2'];
    var loadedSections = {};

    document.addEventListener('DOMContentLoaded', function() {
        console.log('Admin Home Page loaded');
        console.log('Categories:', ALL_CATEGORIES.length);
        
        if (ALL_CATEGORIES.length === 0) {
            showAlert('Chưa có danh mục nào. Vui lòng tạo danh mục trước.', 'danger');
        }
        
        DEFAULT_SECTIONS.forEach(function(key) {
            loadSection(key);
        });
    });

    function loadSection(sectionKey) {
        if (loadedSections[sectionKey]) return;
        
        console.log('Loading section:', sectionKey);
        
        fetch(CTX + '/admin/home/api/' + sectionKey)
            .then(function(response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function(data) {
                console.log('Loaded:', sectionKey, data);
                renderSection(sectionKey, data);
                loadedSections[sectionKey] = true;
                hideEmptyState();
            })
            .catch(function(error) {
                console.error('Error loading section:', sectionKey, error);
                renderSection(sectionKey, { title: '', tabs: [] });
                loadedSections[sectionKey] = true;
                hideEmptyState();
            });
    }

    function renderSection(sectionKey, data) {
        var container = document.getElementById('sections-container');
        var isSetType = sectionKey.indexOf('set_') === 0;
        var typeLabel = isSetType ? 'Set đồ (1 danh mục)' : 'Section thường (tối đa 4 tabs)';
        var titleValue = data.title || '';
        
        var html = '<div class="section-card" id="section-' + sectionKey + '">' +
            '<div class="section-header">' +
                '<h3><i class="fas fa-layer-group"></i> ' + sectionKey + ' <small>' + typeLabel + '</small></h3>' +
                '<button class="btn-delete-section" onclick="removeSection(\'' + sectionKey + '\')" title="Xóa section"><i class="fas fa-trash"></i></button>' +
            '</div>' +
            '<div class="section-body">' +
                '<div class="form-group">' +
                    '<label><i class="fas fa-heading"></i> Tiêu đề hiển thị</label>' +
                    '<input type="text" id="title-' + sectionKey + '" value="' + titleValue + '" placeholder="Nhập tiêu đề section...">' +
                '</div>' +
                '<div class="tabs-container">' +
                    '<h4><i class="fas fa-list"></i> Danh sách Tab</h4>' +
                    '<div id="tabs-' + sectionKey + '"></div>' +
                    (isSetType ? '' : '<button class="btn-add-tab" onclick="addTab(\'' + sectionKey + '\')"><i class="fas fa-plus"></i> Thêm Tab</button>') +
                '</div>' +
            '</div>' +
            '<div class="section-footer">' +
                '<button class="btn-save" onclick="saveSection(\'' + sectionKey + '\')" id="btn-save-' + sectionKey + '">' +
                    '<i class="fas fa-save"></i> Lưu cấu hình' +
                '</button>' +
            '</div>' +
        '</div>';
        
        container.insertAdjacentHTML('beforeend', html);
        
        if (isSetType) {
            var categoryId = data.categoryId || (data.tabs && data.tabs[0] ? data.tabs[0].categoryId : '');
            addTab(sectionKey, categoryId);
        } else {
            if (data.tabs && data.tabs.length > 0) {
                data.tabs.forEach(function(tab) {
                    addTab(sectionKey, tab.categoryId);
                });
            } else {
                addTab(sectionKey);
            }
        }
    }

    function addTab(sectionKey, selectedId) {
        selectedId = selectedId || '';
        var container = document.getElementById('tabs-' + sectionKey);
        var isSetType = sectionKey.indexOf('set_') === 0;
        var currentTabs = container.querySelectorAll('.tab-row').length;
        
        if (isSetType && currentTabs >= 1) {
            showAlert('Set đồ chỉ có thể chọn 1 danh mục', 'danger');
            return;
        }
        if (!isSetType && currentTabs >= 4) {
            showAlert('Tối đa 4 tabs cho mỗi section', 'danger');
            return;
        }
        
        var tabIndex = currentTabs + 1;
        var options = '<option value="">-- Chọn danh mục --</option>';
        ALL_CATEGORIES.forEach(function(c) {
            var selected = (c.id == selectedId) ? 'selected' : '';
            options += '<option value="' + c.id + '" ' + selected + '>' + c.name + '</option>';
        });
        
        var removeBtn = isSetType ? '' : '<button class="btn-remove-tab" onclick="removeTab(this, \'' + sectionKey + '\')" title="Xóa tab"><i class="fas fa-times"></i></button>';
        
        var html = '<div class="tab-row" data-position="' + tabIndex + '">' +
            '<label>Tab ' + tabIndex + ':</label>' +
            '<select class="tab-select" onchange="validateTabs(\'' + sectionKey + '\')">' + options + '</select>' +
            removeBtn +
        '</div>';
        
        container.insertAdjacentHTML('beforeend', html);
    }

    function removeTab(button, sectionKey) {
        var tabRow = button.closest('.tab-row');
        tabRow.remove();
        
        var container = document.getElementById('tabs-' + sectionKey);
        var tabs = container.querySelectorAll('.tab-row');
        tabs.forEach(function(tab, index) {
            tab.dataset.position = index + 1;
            tab.querySelector('label').textContent = 'Tab ' + (index + 1) + ':';
        });
    }

    function validateTabs(sectionKey) {
        var container = document.getElementById('tabs-' + sectionKey);
        var selects = container.querySelectorAll('.tab-select');
        var values = [];
        var hasDuplicate = false;
        
        selects.forEach(function(select) {
            if (select.value && values.indexOf(select.value) !== -1) {
                hasDuplicate = true;
                select.style.borderColor = '#dc3545';
            } else {
                select.style.borderColor = '#ced4da';
                if (select.value) values.push(select.value);
            }
        });
        
        if (hasDuplicate) {
            showAlert('Không được chọn trùng danh mục!', 'danger');
        }
        
        return !hasDuplicate;
    }

    function saveSection(sectionKey) {
        if (!validateTabs(sectionKey)) return;
        
        var title = document.getElementById('title-' + sectionKey).value.trim();
        var container = document.getElementById('tabs-' + sectionKey);
        var selects = container.querySelectorAll('.tab-select');
        var isSetType = sectionKey.indexOf('set_') === 0;
        
        var payload = { title: title };
        
        if (isSetType) {
            var categoryId = selects[0] ? selects[0].value : '';
            if (!categoryId) {
                showAlert('Vui lòng chọn danh mục cho Set đồ', 'danger');
                return;
            }
            payload.categoryId = parseInt(categoryId);
        } else {
            var tabs = [];
            selects.forEach(function(select, index) {
                if (select.value) {
                    tabs.push({ position: index + 1, categoryId: parseInt(select.value) });
                }
            });
            
            if (tabs.length === 0) {
                showAlert('Vui lòng chọn ít nhất 1 danh mục', 'danger');
                return;
            }
            payload.tabs = tabs;
        }
        
        var saveBtn = document.getElementById('btn-save-' + sectionKey);
        var originalHtml = saveBtn.innerHTML;
        saveBtn.disabled = true;
        saveBtn.innerHTML = '<span class="loading"></span> Đang lưu...';
        
        console.log('Saving section:', sectionKey, payload);
        
        fetch(CTX + '/admin/home/api/' + sectionKey, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            console.log('Response:', data);
            if (data.success) {
                showAlert('Lưu cấu hình thành công!', 'success');
            } else {
                showAlert('Lỗi: ' + (data.error || 'Không xác định'), 'danger');
            }
        })
        .catch(function(error) {
            console.error('Error:', error);
            showAlert('Lỗi kết nối server', 'danger');
        })
        .finally(function() {
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalHtml;
        });
    }

    function addNewSection() {
        var name = prompt('Nhập mã ID cho section mới (viết liền, không dấu):\n\nVí dụ: tet_2026, summer_sale, set_combo');
        if (!name) return;
        
        var key = name.trim().toLowerCase().replace(/\s+/g, '_').replace(/[^a-z0-9_]/g, '');
        
        if (!key) {
            showAlert('Mã section không hợp lệ', 'danger');
            return;
        }
        
        if (loadedSections[key]) {
            showAlert('Section này đã tồn tại!', 'danger');
            return;
        }
        
        loadSection(key);
    }

    function removeSection(sectionKey) {
        if (!confirm('Bạn có chắc muốn xóa section "' + sectionKey + '"?')) return;
        
        var sectionEl = document.getElementById('section-' + sectionKey);
        if (sectionEl) {
            sectionEl.remove();
            delete loadedSections[sectionKey];
        }
        
        if (Object.keys(loadedSections).length === 0) {
            showEmptyState();
        }
    }

    function showAlert(message, type) {
        var container = document.getElementById('alert-container');
        var id = 'alert-' + Date.now();
        var icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle';
        
        var html = '<div class="alert alert-' + type + '" id="' + id + '">' +
            '<i class="fas ' + icon + '"></i> ' + message +
            '<button onclick="this.parentElement.remove()" style="float:right;background:none;border:none;cursor:pointer;font-size:18px;">&times;</button>' +
        '</div>';
        
        container.insertAdjacentHTML('beforeend', html);
        
        setTimeout(function() {
            var alertEl = document.getElementById(id);
            if (alertEl) alertEl.remove();
        }, 5000);
    }

    function hideEmptyState() {
        var emptyState = document.getElementById('empty-state');
        if (emptyState) emptyState.style.display = 'none';
    }

    function showEmptyState() {
        var emptyState = document.getElementById('empty-state');
        if (emptyState) {
            emptyState.innerHTML = '<i class="fas fa-inbox"></i><p>Chưa có section nào.</p>';
            emptyState.style.display = 'block';
        }
    }
</script>
<script src="${pageContext.request.contextPath}/scripts/admin/admin.js"></script>
</body>
</html>
