package controller;

import dao.AddressDao;
import model.user.Address;
import model.user.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-address")
public class AddAddressController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Xử lý Tiếng Việt
        req.setCharacterEncoding("UTF-8");

        // 2. Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 3. Lấy dữ liệu từ form (dựa vào attribute 'name' ở Bước 1)
        String ho = req.getParameter("ho");
        String ten = req.getParameter("ten");
        String sdt = req.getParameter("sdt");
        // String congty = req.getParameter("congty"); // Trong Model Address của bạn chưa có field công ty, tạm bỏ qua
        String diachi = req.getParameter("diachi");
        String quocgia = req.getParameter("quocgia");
        String tinhthanh = req.getParameter("tinhthanh");
        boolean isDefault = "true".equals(req.getParameter("macdinh"));

        // 4. Tạo đối tượng Address
        Address newAddr = new Address();
        newAddr.setUserId(user.getId());
        newAddr.setRecipientName(ho + " " + ten); // Ghép họ tên
        newAddr.setRecipientPhone(sdt);
        newAddr.setAddressLine(diachi);
        newAddr.setCityProvince(tinhthanh);
        newAddr.setCountry(quocgia);
        newAddr.setDefault(isDefault);

        // 5. Gọi DAO lưu vào DB
        AddressDao dao = new AddressDao();
        dao.insertAddress(newAddr);

        // 6. Quay lại trang tài khoản
        resp.sendRedirect("account");
    }
}