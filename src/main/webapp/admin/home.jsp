<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/contact-admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/alert.css">


</head>
<body>
<div class="admin-container">
    <jsp:include page="sidebar.jsp" />
    <c:if test="${not empty sessionScope.message}">
        <div id="alert-message"
             class="alert-toast ${sessionScope.messageType == 'success' ? 'alert-toast-success' : 'alert-toast-danger'}">
            <i class="fas ${sessionScope.messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"
               style="margin-right: 10px;"></i>

            <span>${sessionScope.message}</span>
            <span id="close-alert" onclick="this.parentElement.remove()" style="margin-left: auto; cursor: pointer; font-weight: bold; padding-left: 15px; pointer-events: auto;">&times;</span>
        </div>
        <% session.removeAttribute("message"); %>
    </c:if>
    <main class="main-content">
        <header class="admin-header">
            <div class="header-actions">
                <a href="../login.jsp" class="btn-logout"><i class="fas fa-user-circle"></i> Đăng xuất</a>
            </div>
        </header>
    </main>
</div>
<script src="${pageContext.request.contextPath}/scripts/admin.js"></script>
</body>
</html>