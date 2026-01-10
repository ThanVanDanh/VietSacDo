package controller;

import dao.AddressDao;
import model.user.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/delete-address")
public class DeleteAddressController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("account") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            // 2. Lấy ID địa chỉ cần xóa từ URL (ví dụ: delete-address?id=5)
            String idStr = req.getParameter("id");
            if (idStr != null) {
                int addressId = Integer.parseInt(idStr);
                int userId = user.getId();

                // 3. Gọi DAO để xóa
                AddressDao dao = new AddressDao();
                dao.deleteAddress(addressId, userId);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // 4. Quay lại trang quản lý tài khoản
        resp.sendRedirect("account");
    }
}