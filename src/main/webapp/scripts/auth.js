import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
import { getAuth, GoogleAuthProvider, FacebookAuthProvider, signInWithPopup } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js";

//Cấu hình FireBase
const firebaseConfig = {
    apiKey: "AIzaSyBcuuZMwTkWjkFTGlVlB38cLtOW_FlWxVQ",
    authDomain: "vietsacdo-ck.firebaseapp.com",
    projectId: "vietsacdo-ck",
    storageBucket: "vietsacdo-ck.firebasestorage.app",
    messagingSenderId: "57602782048",
    appId: "1:57602782048:web:7df607358f7769c7c5e405",
    measurementId: "G-LTWM6DGKHZ"
};
// Khởi tạo Firebase
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const provider = new GoogleAuthProvider();
const facebookProvider = new FacebookAuthProvider();

document.addEventListener('DOMContentLoaded', function () {
    const googleBtn = document.querySelector('.btn-google');
    if(googleBtn) {
        const btnWrapper = googleBtn.closest('button');

        if (btnWrapper) {
            btnWrapper.addEventListener('click', (e) => {
                e.preventDefault();
                signInWithPopup(auth, provider)
                    .then((result) => {
                        const user = result.user;
                        doLoginSocial(user.email, user.displayName, user.uid, 'google');
                    })
                    .catch((error) => {
                        console.error("Lỗi Google Login:", error);
                        alert("Đăng nhập thất bại: " + error.message);
                    });
            });
        }
    }

    const facebookBtn = document.getElementById('btn-facebook');
    if (facebookBtn) {
        facebookBtn.addEventListener('click', (e) => {
            e.preventDefault();
            signInWithPopup(auth, facebookProvider)
                .then((result) => {
                    const user = result.user;
                    doLoginSocial(user.email, user.displayName, user.uid, 'facebook');
                })
                .catch((error) => {
                    console.error("Lỗi Facebook Login:", error);
                    if (error.code === 'auth/account-exists-with-different-credential') {
                        alert("Email này đã được đăng ký bằng phương thức khác (Google/Email).");
                    } else {
                        alert("Đăng nhập Facebook thất bại: " + error.message);
                    }
                });
        });
    }

    const forgotForm = document.getElementById('forgot_password_form');
    const loginView = document.getElementById('login_view');
    const forgotView = document.getElementById('forgot_view');

    const showForgotLink = document.getElementById('show_forgot_view');
    const showLoginLink = document.getElementById('show_login_view');

    // if (forgotForm) {
    //     forgotForm.addEventListener('submit', function(event) {
    //         event.preventDefault();
    //         alert('Chúng tôi đã gửi một link khôi phục đến đó.');
    //         if (loginView && forgotView) {
    //             loginView.style.display = 'block';
    //             forgotView.style.display = 'none';
    //             document.title = 'Việt Sắc Đỏ - Đăng nhập';
    //         }
    //     });
    // }

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

function doLoginSocial(email, name, uid, providerType) {
    const params = new URLSearchParams();
    params.append('action', providerType);
    params.append('email', email);
    params.append('name', name);
    params.append('uid', uid);

    fetch('Login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
        body: params
    }).then(response => {
        if (response.redirected) {
            window.location.href = response.url;
        } else {
            return response.text().then(text => {
                console.log("Server response:", text);
                window.location.href = "index.jsp";
            });
        }
    }).catch(err => console.error("Fetch error:", err));
}
