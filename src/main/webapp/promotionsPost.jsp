<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title id="page-title">Chi tiết Khuyến mãi - Việt Sắc Đỏ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style-header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/promotionsPoststyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="${pageContext.request.contextPath}/scripts/home.js"></script>
</head>
<body>

<jsp:include page="header.jsp"/>

<main>
    <div id="loading-container" style="text-align:center; padding:80px 20px;">
        <i class="fas fa-spinner fa-spin" style="font-size:48px; color:#320000;"></i>
        <p style="margin-top:20px; color:#666;">Đang tải bài viết...</p>
    </div>

    <article class="blog-post" id="article-container" style="display:none;">
        <h1 id="article-title"></h1>
        <p class="post-meta" id="article-meta"></p>

        <div class="image-placeholder" id="article-banner-container">
        </div>

        <div class="post-content" id="article-content">
        </div>

        <div id="voucher-info" class="voucher-box" style="display:none;">
            <h3>
                <i class="fas fa-ticket-alt"></i> Thông tin mã khuyến mãi
            </h3>
            <div style="display:flex; align-items:center; gap:20px; flex-wrap:wrap;">
                <div style="flex:1; min-width:250px;">
                    <p style="margin:10px 0; font-size:15px;">
                        <strong>🎫 Mã voucher:</strong>
                        <span id="voucher-code" class="voucher-code"></span>
                    </p>
                    <p id="voucher-discount" style="margin:10px 0; font-size:15px;"></p>
                    <p id="voucher-min-order" style="margin:10px 0; font-size:15px;"></p>
                    <p id="voucher-valid" style="margin:10px 0; font-size:14px; color:#666;"></p>
                </div>
                <button onclick="copyVoucherCode()" class="btn-copy-voucher">
                    <i class="fas fa-copy"></i> Sao chép mã
                </button>
            </div>
        </div>
    </article>

    <div id="error-container" style="display:none; text-align:center; padding:80px 20px;">
        <i class="fas fa-exclamation-circle" style="font-size:64px; color:#e74c3c;"></i>
        <h2 style="color:#e74c3c; margin-top:20px;">Không tìm thấy bài viết</h2>
        <p style="color:#666; margin:20px 0;">Bài viết này không tồn tại hoặc đã bị xóa.</p>
    </div>
</main>

<jsp:include page="footer.jsp"/>

<script>
    const CTX = '${pageContext.request.contextPath}';

    function getArticleIdFromUrl() {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('id');
    }

    function formatDateTime(dateStr) {
        if (!dateStr) return 'N/A';
        var date = new Date(dateStr);
        if (isNaN(date.getTime())) return 'N/A';

        var d = String(date.getDate()).padStart(2, '0');
        var m = String(date.getMonth() + 1).padStart(2, '0');
        var y = date.getFullYear();

        return d + '/' + m + '/' + y;
    }

    function formatCurrency(amount) {
        return Number(amount).toLocaleString('vi-VN') + 'đ';
    }

    function copyVoucherCode() {
        var code = document.getElementById('voucher-code').textContent;

        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(code).then(function() {
                alert('Đã sao chép mã: ' + code);
            }).catch(function() {
                fallbackCopy(code);
            });
        } else {
            fallbackCopy(code);
        }
    }

    function fallbackCopy(text) {
        var textarea = document.createElement('textarea');
        textarea.value = text;
        textarea.style.position = 'fixed';
        textarea.style.opacity = '0';
        document.body.appendChild(textarea);
        textarea.select();
        try {
            document.execCommand('copy');
            alert('Đã sao chép mã: ' + text);
        } catch (err) {
            alert('Không thể sao chép. Vui lòng copy thủ công: ' + text);
        }
        document.body.removeChild(textarea);
    }

    function showLoading() {
        document.getElementById('loading-container').style.display = 'block';
        document.getElementById('article-container').style.display = 'none';
        document.getElementById('error-container').style.display = 'none';
    }

    function showArticle() {
        document.getElementById('loading-container').style.display = 'none';
        document.getElementById('article-container').style.display = 'block';
        document.getElementById('error-container').style.display = 'none';
    }

    function showError() {
        document.getElementById('loading-container').style.display = 'none';
        document.getElementById('article-container').style.display = 'none';
        document.getElementById('error-container').style.display = 'block';
    }

    function loadArticle(articleId) {
        if (!articleId) {
            showError();
            return;
        }

        showLoading();

        fetch(CTX + '/admin/article/get?id=' + articleId)
            .then(function (response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function (article) {
                displayArticle(article);
            })
            .catch(function (error) {
                console.error('Error loading article:', error);
                showError();
            });
    }

    function displayArticle(article) {
        console.log('Article data:', article);
        console.log('Voucher object:', article.voucher);

        document.getElementById('article-title').textContent = article.title || 'Chương trình khuyến mãi';

        var metaText = 'Đăng bởi Việt Sắc Đỏ';
        if (article.startDate || article.createdAt) {
            var dateStr = formatDateTime(article.startDate || article.createdAt);
            metaText += ' | Ngày ' + dateStr;
        }
        document.getElementById('article-meta').textContent = metaText;

        var bannerContainer = document.getElementById('article-banner-container');
        if (article.bannerImageUrl) {
            bannerContainer.innerHTML = '<img id="imgpost" src="' + article.bannerImageUrl + '" ' +
                'alt="' + (article.title || '') + '" ' +
                'style="width:auto; max-width:100%; height:auto; display:block; margin:0 auto;" ' +
                'onerror="this.style.display=\'none\'">';
        } else {
            bannerContainer.style.display = 'none';
        }

        var contentDiv = document.getElementById('article-content');
        if (article.content) {
            contentDiv.innerHTML = article.content;
        } else {
            contentDiv.innerHTML = '<p>Nội dung đang được cập nhật...</p>';
        }

        // ✅ Only show top voucher box
        if (article.voucher && article.voucher.voucherCode) {
            console.log('✅ Article has voucher, displaying voucher info...');
            displayVoucherInfo(article.voucher);
        } else {
            console.log('❌ Article has NO voucher');
        }

        document.getElementById('page-title').textContent = article.title + ' - Việt Sắc Đỏ';

        showArticle();
    }

    function displayVoucherInfo(voucher) {
        var voucherInfo = document.getElementById('voucher-info');
        voucherInfo.style.display = 'block';

        document.getElementById('voucher-code').textContent = voucher.voucherCode;

        var discountText = '';
        if (voucher.discountType === 'percentage') {
            discountText = '<strong>💰 Giá trị giảm:</strong> Giảm ' + voucher.discountValue + '%';
        } else {
            discountText = '<strong>💰 Giá trị giảm:</strong> Giảm ' + formatCurrency(voucher.discountValue);
        }
        document.getElementById('voucher-discount').innerHTML = discountText;

        if (voucher.minOrderAmount && voucher.minOrderAmount > 0) {
            document.getElementById('voucher-min-order').innerHTML =
                '<strong>📦 Đơn tối thiểu:</strong> ' + formatCurrency(voucher.minOrderAmount);
        } else {
            document.getElementById('voucher-min-order').innerHTML =
                '<strong>📦 Đơn tối thiểu:</strong> Không yêu cầu';
        }

        var validText = '';
        if (voucher.validFrom && voucher.validTo) {
            validText = '<strong>Thời hạn:</strong> Từ ' + formatDateTime(voucher.validFrom) +
                ' đến ' + formatDateTime(voucher.validTo);
        }
        document.getElementById('voucher-valid').innerHTML =
            '<i class="far fa-calendar-alt"></i> ' + validText;
    }

    document.addEventListener('DOMContentLoaded', function () {
        var articleId = getArticleIdFromUrl();
        loadArticle(articleId);
    });
</script>

</body>
</html>
