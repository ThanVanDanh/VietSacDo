
    function handleIncreaseQuantity(event) {
    const btn = event.currentTarget;
    const quantityDisplay = btn.previousElementSibling;

    if (quantityDisplay) {
    let currentQuantity = parseInt(quantityDisplay.textContent);
    currentQuantity += 1; // Tăng lên 1

    quantityDisplay.textContent = currentQuantity;
    quantityDisplay.dataset.quantity = currentQuantity;

}
}

    function handleDecreaseQuantity(event) {
    const btn = event.currentTarget;
    const quantityDisplay = btn.nextElementSibling;

    if (quantityDisplay) {
    let currentQuantity = parseInt(quantityDisplay.textContent);

    if (currentQuantity > 1) {
    currentQuantity -= 1;

    quantityDisplay.textContent = currentQuantity;
    quantityDisplay.dataset.quantity = currentQuantity;

} else {
    alert("Số lượng tối thiểu là 1. Nhấn thùng rác để xóa sản phẩm.");
}
}
}


    const btnIncreaseList = document.querySelectorAll(".js-increase-quantity");
    const btnDecreaseList = document.querySelectorAll(".js-decrease-quantity");

    btnIncreaseList.forEach(btn => {
    btn.addEventListener('click', handleIncreaseQuantity);
});

    btnDecreaseList.forEach(btn => {
    btn.addEventListener('click', handleDecreaseQuantity);
});


    // Chọn tất cả các nút mở modal
    const btnOpenList = document.querySelectorAll(".js-open-modal");
    // Chọn tất cả các nút đóng modal
    const btnCloseList = document.querySelectorAll(".js-close-modal");
    // Chọn tất cả các nút XÓA sản phẩm
    const btnRemoveList = document.querySelectorAll(".js-remove-item");

    // --- 1. Xử lý Mở Modal ---
    btnOpenList.forEach(btnOpen => {
    btnOpen.onclick = () => {
        // Tìm element overlay (js-overlay) ngay bên cạnh nút (trong cùng một item-controls)
        const overlay = btnOpen.nextElementSibling;
        if (overlay) {
            overlay.style.display = "flex";
        }
    };
});

    // --- 2. Xử lý Đóng Modal ---
    btnCloseList.forEach(btnClose => {
    btnClose.onclick = () => {
        // Lấy element popup -> element overlay
        const overlay = btnClose.closest(".js-overlay");
        if (overlay) {
            overlay.style.display = "none";
        }
    };
});

    // --- 3. Xử lý Bỏ Sản Phẩm và Xóa khỏi DOM ---
    btnRemoveList.forEach(btnRemove => {
    btnRemove.onclick = () => {
        // 1. Tìm element overlay để đóng modal
        const overlay = btnRemove.closest(".js-overlay");
        if (overlay) {
            overlay.style.display = "none";
        }


        const cartItem = btnRemove.closest(".js-cart-item");

        if (cartItem) {
            // Hiển thị thông báo và xóa khỏi DOM
            alert(`Đã bỏ sản phẩm: ${cartItem.querySelector('.item-details p').textContent}!`);
            cartItem.remove();
        } else {
            alert("Lỗi: Không tìm thấy sản phẩm để xóa!");
        }
    };
});

    // --- Xử lý Popup Khuyến Mãi ---
    // Lưu ý: Đoạn này sẽ chỉ hoạt động nếu các ID này là duy nhất trong HTML.
    const popupOverlay = document.getElementById("popupOverlay");
    const btnShowPromo = document.getElementById("btnOpenkm");
    const btnCloseTop  = document.getElementById("btnCloseTop");
    const btnCloseBottom = document.getElementById("btnCloseBottom");

    if (btnShowPromo && popupOverlay) {
    btnShowPromo.onclick = ()=> popupOverlay.style.display = "flex";
}
    if (btnCloseTop && popupOverlay) {
    btnCloseTop.onclick = ()=> popupOverlay.style.display = "none";
}
    if (btnCloseBottom && popupOverlay) {
    btnCloseBottom.onclick = ()=> popupOverlay.style.display = "none";
}