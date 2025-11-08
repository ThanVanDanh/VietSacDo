document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login');
    const signupForm = document.getElementById('signup');

    if (loginForm) {
        loginForm.addEventListener('submit', function (event) {
            event.preventDefault();

            window.location.href = 'index.html';
        });
    }
    if (signupForm) {
        signupForm.addEventListener('submit', function (event) {
            event.preventDefault();

            window.location.href = 'login.html';
        });
    }
    const forgotForm = document.getElementById('forgot_password_form');
    const loginView = document.getElementById('login_view');
    const forgotView = document.getElementById('forgot_view');

    const showForgotLink = document.getElementById('show_forgot_view');
    const showLoginLink = document.getElementById('show_login_view');

    if (forgotForm) {
        forgotForm.addEventListener('submit', function(event) {
            event.preventDefault();
            alert('Chúng tôi đã gửi một link khôi phục đến đó.');
            if (loginView && forgotView) {
                loginView.style.display = 'block';
                forgotView.style.display = 'none';
                document.title = 'Việt Sắc Đỏ - Đăng nhập';
            }
        });
    }

    // Ẩn/hiện form
    if (showForgotLink) {
        showForgotLink.addEventListener('click', function(event) {
            event.preventDefault();

            if (loginView && forgotView) {
                loginView.style.display = 'none';
                forgotView.style.display = 'block';
                document.title = 'Việt Sắc Đỏ - Khôi phục mật khẩu';
            }
        });
    }

    if (showLoginLink) {
        showLoginLink.addEventListener('click', function(event) {
            event.preventDefault();

            if (loginView && forgotView) {
                loginView.style.display = 'block';
                forgotView.style.display = 'none';
                document.title = 'Việt Sắc Đỏ - Đăng nhập';
            }
        });
    }
});
