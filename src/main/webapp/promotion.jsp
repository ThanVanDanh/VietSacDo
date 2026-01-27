<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chương trình Khuyến Mãi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles.css">
    <link rel="icon" href="${pageContext.request.contextPath}/image/logoaodai.jpg" type="image/jpeg">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
          integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/promotion.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style-header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/backtop.css">
    <script src="${pageContext.request.contextPath}/scripts/backtop.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/footer.css">
    <script src="${pageContext.request.contextPath}/scripts/home.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/breadcrumb.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    <script src="${pageContext.request.contextPath}/scripts/product-information.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/auth.js"></script>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="breadcrumb-container">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/login.jsp">Tài khoản</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chương trình Khuyến mãi</li>
        </ol>
    </nav>

    <div class="promotion-container">
        <h1>Chương trình Khuyến Mãi</h1>

        <div class="articles-list" id="articlesContainer">
            <div style="text-align:center; padding:40px;">
                <i class="fas fa-spinner fa-spin" style="font-size:32px; color:#320000;"></i>
                <p>Đang tải danh sách khuyến mãi...</p>
            </div>
        </div>

        <nav class="pagination" id="paginationContainer" style="display:none;">
        </nav>
    </div>
</div>

<jsp:include page="footer.jsp"/>

<button onclick="scrollToTop()" id="backToTopBtn" title="Trở về đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>

<script>
    const CTX = '${pageContext.request.contextPath}';

    function formatDateTime(dateStr) {
        if (!dateStr) return 'N/A';
        var date = new Date(dateStr);
        if (isNaN(date.getTime())) return 'N/A';

        var days = ['CN', 'Th 2', 'Th 3', 'Th 4', 'Th 5', 'Th 6', 'Th 7'];
        var day = days[date.getDay()];
        var d = String(date.getDate()).padStart(2, '0');
        var m = String(date.getMonth() + 1).padStart(2, '0');
        var y = date.getFullYear();

        return day + ' ' + d + '/' + m + '/' + y;
    }

    function stripHtml(html) {
        var tmp = document.createElement('DIV');
        tmp.innerHTML = html;
        return tmp.textContent || tmp.innerText || '';
    }

    function truncateText(text, maxLength) {
        if (!text) return '';
        if (text.length <= maxLength) return text;
        return text.substring(0, maxLength) + '...';
    }


    function loadArticles() {
        fetch(CTX + '/admin/article/list')
            .then(function (response) {
                if (!response.ok) throw new Error('HTTP ' + response.status);
                return response.json();
            })
            .then(function (articles) {
                displayArticles(articles);
            })
            .catch(function (error) {
                console.error('Error loading articles:', error);
                var container = document.getElementById('articlesContainer');
                container.innerHTML = '<div style="text-align:center; padding:40px; color:#e74c3c;">' +
                    '<i class="fas fa-exclamation-triangle" style="font-size:32px;"></i>' +
                    '<p>Không thể tải danh sách khuyến mãi. Vui lòng thử lại sau.</p>' +
                    '</div>';
            });
    }

    function displayArticles(articles) {
        var container = document.getElementById('articlesContainer');

        if (!articles || articles.length === 0) {
            container.innerHTML = '<div style="text-align:center; padding:40px;">' +
                '<i class="fas fa-inbox" style="font-size:48px; color:#ccc;"></i>' +
                '<p style="color:#999; margin-top:20px;">Hiện chưa có chương trình khuyến mãi nào.</p>' +
                '</div>';
            return;
        }

        var publishedArticles = articles.filter(function (article) {
            return article.statusArticles === 'published';
        });

        publishedArticles.sort(function (a, b) {
            var dateA = new Date(a.startDate || a.createdAt);
            var dateB = new Date(b.startDate || b.createdAt);
            return dateB - dateA;
        });

        if (publishedArticles.length === 0) {
            container.innerHTML = '<div style="text-align:center; padding:40px;">' +
                '<i class="fas fa-inbox" style="font-size:48px; color:#ccc;"></i>' +
                '<p style="color:#999; margin-top:20px;">Hiện chưa có chương trình khuyến mãi nào được công bố.</p>' +
                '</div>';
            return;
        }

        container.innerHTML = '';

        publishedArticles.forEach(function (article) {
            var articleHtml = createArticleHTML(article);
            container.innerHTML += articleHtml;
        });
    }

    function createArticleHTML(article) {
        var title = article.title || 'Chương trình khuyến mãi';
        var bannerUrl = article.bannerImageUrl || (CTX + '/image/default-promotion.jpg');
        var content = article.content || '';
        var plainText = stripHtml(content);
        var excerpt = truncateText(plainText, 150);
        var publishDate = formatDateTime(article.startDate || article.createdAt);
        var detailUrl = CTX + '/promotionsPost.jsp?id=' + article.id;

        var voucherBadge = '';
        if (article.voucherCode) {
            voucherBadge = '<span style="display:inline-block; background:#e74c3c; color:white; padding:4px 8px; ' +
                'border-radius:4px; font-size:12px; font-weight:bold; margin-left:10px;">' +
                '<i class="fas fa-ticket-alt"></i> ' + article.voucherCode +
                '</span>';
        }

        var html = '<article class="article-item">' +
            '<div class="article-image">' +
            '<a href="' + detailUrl + '">' +
            '<img src="' + bannerUrl + '" alt="' + escapeHtml(title) + '" ' +
            'onerror="this.src=\'' + CTX + '/image/default-promotion.jpg\'">' +
            '</a>' +
            '</div>' +
            '<div class="article-content">' +
            '<h3>' +
            '<a href="' + detailUrl + '">' + escapeHtml(title) + '</a>' +
            voucherBadge +
            '</h3>' +
            '<div class="meta">' +
            '<span><i class="far fa-calendar-alt"></i> ' + publishDate + '</span>' +
            '</div>' +
            '<p>' + escapeHtml(excerpt) + '</p>' +
            '<a href="' + detailUrl + '" class="read-more">Đọc thông tin chi tiết...</a>' +
            '</div>' +
            '</article>';

        return html;
    }

    function escapeHtml(text) {
        if (!text) return '';
        var map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return String(text).replace(/[&<>"']/g, function (m) {
            return map[m];
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        loadArticles();
    });
</script>

</body>
</html>
