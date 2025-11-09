document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById('customer-modal');
    const dongNut = modal.querySelector('.close-modal');
    const moNutXem = document.querySelectorAll('.customer-table .btn-view');
    const tabLinks = document.querySelectorAll(".tab-link");
    const tabContents = document.querySelectorAll(".tab-content");

    moNutXem.forEach(nut => {
        nut.addEventListener('click', () => {
            modal.style.display = 'flex';
        });
    });

    dongNut.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            modal.style.display = 'none';
        }
    });

    tabLinks.forEach(link => {
        link.addEventListener("click", () => {
            tabLinks.forEach(btn => btn.classList.remove("active"));

            tabContents.forEach(tab => tab.classList.remove("active"));

            link.classList.add("active");
            document.getElementById(link.dataset.tab).classList.add("active");
        });
    });
});