package controller.admin.order;

import dao.OrderDao;
import model.order.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            OrderDao orderDao = new OrderDao();

            // Get all orders from database
            List<Order> orders = orderDao.getAllOrders();

            // Set attribute for JSP
            req.setAttribute("orders", orders);

            // Forward to orders.jsp
            req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tải danh sách đơn hàng: " + e.getMessage());
            req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
        }
    }
}
