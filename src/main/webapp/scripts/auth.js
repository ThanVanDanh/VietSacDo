document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login');
    const signupForm = document.getElementById('signup');

    if (loginForm) {
        loginForm.addEventListener('submit', function (event) {
            event.preventDefault();
            const phone = document.getElementById('phone').value.trim();
            const password = document.getElementById('customer_password').value.trim();
            if (phone === '123' && password === '123') {
                window.location.href = '../admin/dashboard.jsp';
            } else {
                window.location.href = 'account.jsp';
            }
        });
    }
    if (signupForm) {
        signupForm.addEventListener('submit', function (event) {
            event.preventDefault();

            window.location.href = 'account.jsp';
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

    // chuyển tab
    const accountInfo = document.getElementById('nav-details');
    const address = document.getElementById('nav-addresses');
    const contentInfo = document.getElementById('account-details');
    const contentAddress = document.getElementById('account-addresses');
    if (accountInfo && address && contentInfo && contentAddress) {
        accountInfo.addEventListener('click', e => {
            contentInfo.style.display = 'block';
            contentAddress.style.display = 'none';
            accountInfo.classList.add('active');
            address.classList.remove('active');
        });

        address.addEventListener('click', e => {
            contentInfo.style.display = 'none';
            contentAddress.style.display = 'block';
            accountInfo.classList.remove('active');
            address.classList.add('active');
        });
    }
    const addModal = document.getElementById('add-address-modal');
    const editModal = document.getElementById('edit-address-modal');

    const addBtn = document.getElementById('add-address-btn');
    const editBtn = document.getElementById('edit-address-btn');
    //Mở modal
    if (addBtn && addModal) {
        addBtn.addEventListener('click', () => addModal.style.display = 'flex');
    }
    if (editBtn && editModal) {
        editBtn.addEventListener('click', e => editModal.style.display = 'flex');
    }

    // Đóng modal
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', () => {
            btn.closest('.modal-overlay').style.display = 'none';
        }); 
    });


});
