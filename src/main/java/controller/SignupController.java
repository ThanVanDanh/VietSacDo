package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.UserService;
import dao.UserDao;

import java.io.IOException;

@WebServlet(name = "Signup", value = "/signup")
public class SignupController extends HttpServlet {
    private UserService userService = new UserService(new UserDao());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("account") != null) {
            response.sendRedirect("index.jsp");
        } else {
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        if (fullName == null || phone == null || email == null || password == null ||
                fullName.isEmpty() || phone.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
        boolean isRegistered = userService.register(fullName, phone, email, password);
        if (isRegistered) {
            request.getSession().setAttribute("successMessage", "Đăng ký thành công!");
            response.sendRedirect("account.jsp");
        } else {
            request.setAttribute("error", "Đăng ký thất bại! Email hoặc số điện thoại đã tồn tại.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}