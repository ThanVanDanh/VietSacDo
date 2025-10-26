// tải nội dung header cho trang index, login, signup
fetch("components/header.html")
    .then(response => response.text())
    .then(data => {
        document.getElementById("header-placeholder").innerHTML = data;
    });
// tải nội dung footer cho trang index, login, signup
fetch("components/footer.html")
    .then(response => response.text())
    .then(data => {
        document.getElementById("footer-placeholder").innerHTML = data;
    });
