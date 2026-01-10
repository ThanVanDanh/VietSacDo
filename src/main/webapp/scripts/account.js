document.addEventListener('DOMContentLoaded', function () {
    // 1. Xử lý chuyển Tab (Thông tin tài khoản <-> Sổ địa chỉ)
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

    // 2. Xử lý Modal (Popup) Thêm/Sửa địa chỉ
    const addModal = document.getElementById('add-address-modal');
    const editModal = document.getElementById('edit-address-modal');
    const addBtn = document.getElementById('add-address-btn');
    const editBtns = document.querySelectorAll('.edit-address-link');

    if (addBtn && addModal) {
        addBtn.addEventListener('click', () => {
            addModal.style.display = 'flex';
        });
    }

    editBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();

            // 1. Lấy dữ liệu từ data attribute trong JSP
            const id = btn.getAttribute('data-id');
            const fullName = btn.getAttribute('data-name');
            const phone = btn.getAttribute('data-phone');
            const addr = btn.getAttribute('data-addr');
            const city = btn.getAttribute('data-city');
            const isDefault = btn.getAttribute('data-default') === 'true';

            // 2. Xử lý tách Họ và Tên (Vì DB lưu gộp, nhưng form tách riêng)
            // Logic đơn giản: Lấy từ cuối cùng làm Tên, phần còn lại là Họ
            let lastSpaceIndex = fullName.lastIndexOf(" ");
            let ho = "";
            let ten = fullName;
            if(lastSpaceIndex !== -1) {
                ho = fullName.substring(0, lastSpaceIndex);
                ten = fullName.substring(lastSpaceIndex + 1);
            }

            // 3. Điền vào Form Sửa
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-ho').value = ho;
            document.getElementById('edit-ten').value = ten;
            document.getElementById('edit-sdt').value = phone;
            document.getElementById('edit-diachi').value = addr;
            document.getElementById('edit-default').checked = isDefault;

            // Set select option (cần đảm bảo value option khớp với data)
            const citySelect = document.getElementById('edit-tinhthanh');
            if(citySelect) citySelect.value = city;

            // 4. Hiển thị Modal
            editModal.style.display = 'flex';
        });
    });
    const deleteModal = document.getElementById('delete-address-modal');
    const deleteBtns = document.querySelectorAll('.delete-address-link');
    const confirmDeleteBtn = document.getElementById('confirm-delete-btn');

    // Bắt sự kiện click vào nút "Xóa" ở danh sách
    deleteBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault(); // Ngăn không cho load lại trang

            // Lấy ID từ attribute data-id
            const id = btn.getAttribute('data-id');

            // Cập nhật href cho nút "Xóa ngay" trong modal để trỏ về Controller
            // Controller của bạn là DeleteAddressController mapped tại /delete-address
            confirmDeleteBtn.href = `delete-address?id=${id}`;

            // Hiển thị Modal
            if (deleteModal) {
                deleteModal.style.display = 'flex';
            }
        });
    });
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', () => {
            const overlay = btn.closest('.modal-overlay');
            if (overlay) {
                overlay.style.display = 'none';
            }
        });
    });

    window.addEventListener('click', (e) => {
        if (e.target === addModal) addModal.style.display = 'none';
        if (e.target === editModal) editModal.style.display = 'none';
        if (deleteModal && e.target === deleteModal) deleteModal.style.display = 'none';
    });
});