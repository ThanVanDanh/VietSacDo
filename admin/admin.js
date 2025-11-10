document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById('customer-modal');
    const customerViewBtn = document.querySelectorAll('.customer-table .btn-view');

    if (modal) {
        const  customerClose = modal.querySelector('.close-modal');
        customerViewBtn.forEach(nut => {
            nut.addEventListener('click', () => {
                modal.style.display = 'flex';
            });
        });

        customerClose.addEventListener('click', () => {
            modal.style.display = 'none';
        });

        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    }

    //order
    const order = document.getElementById('order-modal');
    const orderViewBtn = document.querySelectorAll('.order-table .btn-view');
    if (order) {
        const orderClose = order.querySelector('.close-modal');
        orderViewBtn.forEach(nut => {
            nut.addEventListener('click', () => {
                order.style.display = 'flex';
            });
        });
        orderClose.addEventListener('click', () => {
            order.style.display = 'none';
            });

        order.addEventListener('click', (e) => {
            if (e.target === order) {
                order.style.display = 'none';
            }
        });
    }
    const tabLinks = document.querySelectorAll(".tab-link");
    const tabContents = document.querySelectorAll(".tab-content");
    if (tabLinks) {
        tabLinks.forEach(link => {
            link.addEventListener("click", () => {
                tabLinks.forEach(btn => btn.classList.remove("active"));

                tabContents.forEach(tab => tab.classList.remove("active"));

                link.classList.add("active");
                document.getElementById(link.dataset.tab).classList.add("active");
            });
        });
    }
});