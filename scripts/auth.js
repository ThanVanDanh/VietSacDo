document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login');
    const signupForm = document.getElementById('signup');

    if (loginForm) {
        loginForm.addEventListener('submit', function (event) {
            event.preventDefault();
            console.log('Form Đăng nhập đã được submit');
            const phone = document.getElementById('phone').value;
            const password = document.getElementById('customer_password').value;

            if (phone === '') {
                alert('Vui lòng nhập số điện thoại');
                return;
            }
            if (password === '') {
                alert('Vui lòng nhập Mật khẩu');
                return;
            }

            console.log('Dữ liệu đăng nhập hợp lệ:', { phone, password });

            // TODO (khi có database): Gửi {phone, password} lên server

            //-----------------
            let users = JSON.parse(localStorage.getItem('users')) || [];
            const foundUser = users.find(user => user.phone === phone && user.password === password);

            if (foundUser) {
                alert('Đăng nhập thành công! Chào mừng ' + foundUser.firstName);
                // TODO: Chuyển hướng người dùng về trang chủ
                window.location.href = 'index.html';
            } else {
                alert('Sai số điện thoại hoặc mật khẩu!');
            }
            //-----------------
        });
    }
    if (signupForm) {
        signupForm.addEventListener('submit', function (event) {
            event.preventDefault();
            console.log('Form Đăng ký đã được submit');
            const name = document.getElementById('name').value;
            const phone = document.getElementById('phone').value;
            const email = document.getElementById('customer_email').value;
            const password = document.getElementById('customer_password').value;

            if (name === '') {
                alert('Vui lòng nhập đầy đủ Họ và Tên');
                return;
            }
            if (phone === '') {
                alert('Vui lòng nhập số điện thoại');
                return;
            }
            if (email === '') {
                alert('Vui lòng nhập Email');
                return;
            }
            if (password.length < 6) {
                alert('Mật khẩu phải có ít nhất 6 ký tự');
                return;
            }

            // TODO (khi có database): Gửi 'userData' lên server

            //--------------------------
            let users = JSON.parse(localStorage.getItem('users')) || [];
            const existingUser = users.find(user => user.phone === phone);
            if (existingUser) {
                alert('Số điện thoại này đã được sử dụng. Vui lòng chọn số điện thoại khác.');
                return;
            }
            const userData = { name, phone, email, password };
            users.push(userData);
            localStorage.setItem('users', JSON.stringify(users));
            console.log('Dữ liệu đăng ký hợp lệ và đã lưu:', userData);
            alert('Đăng ký thành công! Bạn sẽ được chuyển đến trang đăng nhập.');
            window.location.href = 'login.html';
            //--------------------
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
            const emailReset = document.getElementById('email_reset').value;

            if (emailReset === '') {
                alert('Vui lòng nhập email của bạn.');
                return;
            }

            // TODO: Gửi email này lên server Java của bạn

            //-------------------------------
            console.log('Yêu cầu khôi phục mật khẩu cho email:', emailReset);
            alert('Chúng tôi đã gửi một link khôi phục đến đó. (Hiện tại đây là thông báo giả).');

            // (Tùy chọn) Có thể chuyển về trang đăng nhập sau khi thông báo
            loginView.style.display = 'block';
            forgotView.style.display = 'none';
            document.title = 'Việt Sắc Đỏ - Đăng nhập';
            //-------------------------------
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
