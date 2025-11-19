document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById('customer-modal');
    //Chi tiết khách hàng
    if (modal) {
        const customerViewBtn = document.querySelectorAll('.customer-table .btn-view');
        const  customerClose = modal.querySelector('.close-modal');
        //Xem
        customerViewBtn.forEach(nut => {
            nut.addEventListener('click', () => {
                modal.style.display = 'flex';
            });
        });
        //Đóng
        customerClose.addEventListener('click', () => {
            modal.style.display = 'none';
        });
        //Click vào vùng nền mờ bên ngoài
        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    }

    //Chi tiết đơn hàng
    const order = document.getElementById('order-modal');
    const orderViewBtn = document.querySelectorAll('.order-table .btn-view');
    if (order) {
        const orderClose = order.querySelector('.close-modal');
        //Xem
        orderViewBtn.forEach(nut => {
            nut.addEventListener('click', () => {
                order.style.display = 'flex';
            });
        });
        //Đóng
        orderClose.addEventListener('click', () => {
            order.style.display = 'none';
            });
        // Click vào vùng nền mờ bên ngoài
        order.addEventListener('click', (e) => {
            if (e.target === order) {
                order.style.display = 'none';
            }
        });
    }

    //Chuyển tab trong chi tiết khách hàng
    const tabLinks = document.querySelectorAll(".tab-link");
    if (tabLinks) {
        const tabContents = document.querySelectorAll(".tab-content");
        tabLinks.forEach(link => {
            link.addEventListener("click", () => {
                //Xóa
                tabLinks.forEach(btn => btn.classList.remove("active"));
                tabContents.forEach(tab => tab.classList.remove("active"));
                //Thêm
                link.classList.add("active");
                document.getElementById(link.dataset.tab).classList.add("active");
            });
        });
    }

    // Xác nhận xóa (chung)
    const deleteModal = document.getElementById('delete-confirm-modal');
    if (deleteModal) {
        const deleteModalBtn = document.querySelectorAll('.btn-delete');
        const deleteClose = deleteModal.querySelector('.close-modal');
        const cancelDeleteBtn = document.getElementById('btn-cancel-delete');
        const confirmDeleteBtn = document.getElementById('btn-confirm-delete');
        // Biến tạm để lưu dòng (tr) đang muốn xóa
        let rowToDelete = null;

        deleteModalBtn.forEach(button => {
            button.addEventListener('click', function() {
                rowToDelete = this.closest('tr');
                deleteModal.style.display = 'flex';
            });
        });

        deleteClose.addEventListener('click', () => {
            deleteModal.style.display = 'none';
        });

        cancelDeleteBtn.addEventListener('click', () => {
            deleteModal.style.display = 'none';
        });

        confirmDeleteBtn.addEventListener('click', () => {
            if (rowToDelete) {
                // Hiệu ứng mờ dần (Optional - cho mượt)
                rowToDelete.style.transition = "opacity 0.5s";
                rowToDelete.style.opacity = "0";

                setTimeout(() => {
                    // Xóa dòng khỏi DOM (Giao diện)
                    rowToDelete.remove();

                    const tbody = document.querySelector('.table-general tbody');
                    checkEmptyTable(tbody);
                    // Đóng modal
                    deleteModal.style.display = 'none';
                    rowToDelete = null;
                }, 100);
            }
        });
    }
    function checkEmptyTable(tbody) {
        // Lấy tất cả các dòng dữ liệu (trừ dòng thông báo)
        const emptyRow = tbody.querySelector('.empty-state-row');
        const allRows = tbody.querySelectorAll('tr:not(#empty-state-row)');
        const pagination = document.querySelector('.pagination');

        // Đếm số dòng đang hiển thị (style.display khác 'none')
        let visibleRowCount = 0;
        allRows.forEach(row => {
            if (row.style.display !== 'none') {
                visibleRowCount++;
            }
        });

        // Logic hiển thị/ẩn thông báo
        if (visibleRowCount === 0) {
            if (emptyRow) emptyRow.style.display = 'table-row';
            if (pagination) pagination.style.display = 'none';
        } else {
            if (emptyRow) emptyRow.style.display = 'none';
            if (pagination) pagination.style.display = 'flex';
        }
    }

    // Xác nhận block
    const blockModal = document.getElementById('block-confirm-modal');
    if (blockModal) {
        const blockButtons = document.querySelectorAll('.btn-block');
        const unlockButtons = document.querySelectorAll('.btn-unlock'); // Thêm dòng này để bắt nút Mở khóa

        const blockClose = blockModal.querySelector('.close-modal');
        const cancelBlockBtn = document.getElementById('btn-cancel-block');
        const confirmBlockBtn = document.getElementById('btn-confirm-block');
        const nameSpan = document.getElementById('customer-name-to-block'); // Chỗ hiển thị tên trong modal

        let rowAction = null;

        // 2. Xử lý nút KHÓA
        blockButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                rowAction = this.closest('tr');
                blockModal.style.display = 'flex';
            });
        });

        // 3. Xử lý nút XÁC NHẬN
        confirmBlockBtn.addEventListener('click', () => {
            if (rowAction) {
                toggleLockStatus(rowAction, 'blocked');
                blockModal.style.display = 'none';
                rowAction = null;
            }
        });

        // 4. Xử lý nút MỞ KHÓA (Click là mở luôn, ko cần modal)
        unlockButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                const row = this.closest('tr');
                toggleLockStatus(row, 'active');
            });
        });

        blockClose.addEventListener('click', () => {
            blockModal.style.display = 'none';
            rowAction = null;
        });
        cancelBlockBtn.addEventListener('click', () => {
            blockModal.style.display = 'none';
            rowAction = null;
        });
        // Thêm: Click ra ngoài để đóng
        window.addEventListener('click', (e) => {
            if (e.target === blockModal) {
                blockModal.style.display = 'none';
                rowAction = null;
            }
        });

        // --- HÀM PHỤ TRỢ: Đổi trạng thái hiển thị (Ẩn/Hiện) ---
        function toggleLockStatus(row, status) {
            const badgeActive = row.querySelector('.status-active');
            const badgeBlocked = row.querySelector('.status-blocked');
            const btnBlock = row.querySelector('.btn-block');
            const btnUnlock = row.querySelector('.btn-unlock');

            if (status === 'blocked') {
                // Nếu muốn KHÓA:
                if(badgeActive) badgeActive.style.display = 'none';         // Ẩn Hoạt động
                if(badgeBlocked) badgeBlocked.style.display = 'inline-block'; // Hiện Bị khóa

                if(btnBlock) btnBlock.style.display = 'none';             // Ẩn nút Khóa
                if(btnUnlock) btnUnlock.style.display = 'inline-block';   // Hiện nút Mở khóa
            } else {
                // Nếu muốn MỞ KHÓA (Active):
                if(badgeActive) badgeActive.style.display = 'inline-block';
                if(badgeBlocked) badgeBlocked.style.display = 'none';

                if(btnBlock) btnBlock.style.display = 'inline-block';
                if(btnUnlock) btnUnlock.style.display = 'none';
            }
        }
    }

    //------Chart------------
            //------ Biểu đồ khách hàng ------------
    const ctx1 = document.getElementById('customerOrdersChart');
    if (ctx1) {
        new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: ['Minh Thư', 'Lại Thị Hoa', 'Văn Danh', 'Văn Đô', 'Văn Điền', 'Minh Hoài'],
                datasets: [{label: 'Số đơn hàng', data: [8, 6, 5, 1, 4, 1], backgroundColor: '#640100'}]
            },
            options: {responsive: true, scales: {y: {beginAtZero: true}}, plugins: {legend: {display: false}}}
        });
    }
            //------Biểu đồ đơn hàng-----
    const ctx2 = document.getElementById('revenueChart');
    if (ctx2) {
        new Chart(ctx2, {
            type: 'line',
            data: {
                labels: ['Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: [9500000, 12300000, 8800000, 14500000, 15500000, 15500000],
                    borderColor: '#640100',
                    backgroundColor: 'rgba(100,1,0,0.1)',
                    fill: true, tension: 0.3, pointRadius: 4, pointBackgroundColor: '#640100'
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {callback: v => v.toLocaleString('vi-VN') + '₫'}
                    }
                },
                plugins: {
                    legend: {display: true, position: 'bottom'},
                    tooltip: {callbacks: {label: ctx => ctx.parsed.y.toLocaleString('vi-VN') + '₫'}}
                }
            }
        });
    }
});