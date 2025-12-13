package controller;

import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.user.User;
import services.UserService;

import java.io.IOException;

@WebServlet(name = "Login", value = "/Login")
public class LoginController extends HttpServlet {
    private UserService userService = new UserService(new UserDao());
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("account") != null) {
            response.sendRedirect("account.jsp");
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phone = request.getParameter("phone");
        String pass = request.getParameter("password");

        User user = userService.login(phone, pass);

        if (user != null) {
            createSession(request, response, user);
        } else {
            request.setAttribute("error", "Sai số điện thoại hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    private void createSession(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("account", user);
        if ("admin".equals(user.getRole())) {
            resp.sendRedirect("admin/dashboard.jsp");
        } else {
            resp.sendRedirect("account.jsp");
        }
    }
}