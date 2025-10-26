document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login');

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
});
