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
        deleteModalBtn.forEach(button => {
            button.addEventListener('click', () => {
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
            deleteModal.style.display = 'none';
        });
    }
    //Xác nhận block
    const blockModal = document.getElementById('block-confirm-modal');
    if (blockModal) {
        const blockButtons = document.querySelectorAll('.btn-block');
        const blockClose = blockModal.querySelector('.close-modal');
        const cancelBlockBtn = document.getElementById('btn-cancel-block');
        const confirmBlockBtn = document.getElementById('btn-confirm-block');
        blockButtons.forEach(btn => {
            btn.addEventListener('click', (e) => {
                blockModal.style.display = 'flex';
            });
        });
        blockClose.addEventListener('click', () => {
            blockModal.style.display = 'none';
        });
        cancelBlockBtn.addEventListener('click', () => {
            blockModal.style.display = 'none';
        });
        confirmBlockBtn.addEventListener('click', () => {
            blockModal.style.display = 'none';
        });
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