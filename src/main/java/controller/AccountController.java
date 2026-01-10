package controller;

import dao.UserDao;
import dao.AddressDao;
import model.user.User;
import model.user.Address;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/account")
public class AccountController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        // 1. Kiểm tra session với key "account" (khớp với LoginController)
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy User từ Session ra
        User user = (User) session.getAttribute("account");

        // 3. Đẩy user vào request để file JSP hiển thị (VD: ${user.fullName})
        req.setAttribute("user", user);

        // 4. Lấy danh sách địa chỉ dựa trên ID của user trong session
        AddressDao addressDao = new AddressDao();
        java.util.List<Address> addresses = addressDao.findByUserId(user.getId());

        // 5. Đẩy danh sách địa chỉ vào request
        req.setAttribute("addresses", addresses);

        // 6. Forward sang trang JSP hiển thị
        req.getRequestDispatcher("account.jsp").forward(req, resp);
    }
}
