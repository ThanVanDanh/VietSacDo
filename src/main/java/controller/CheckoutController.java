package controller;

import dao.AddressDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.cart.Cart;
import model.user.Address;
import model.user.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutController", value = "/checkout")
public class CheckoutController extends HttpServlet {
    private AddressDao addressDao;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.addressDao = new AddressDao();
        } catch (Exception ex) {
            throw new ServletException("Failed to initialize CheckoutController: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        // Kiểm tra giỏ hàng
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalQuantity() == 0) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Kiểm tra đăng nhập
        User user = (User) session.getAttribute("user");
        if (user != null) {
            // Load địa chỉ mặc định của user
            try {
                List<Address> addresses = addressDao.findByUserId(user.getId());
                if (addresses != null && !addresses.isEmpty()) {
                    // Tìm địa chỉ mặc định
                    Address defaultAddress = addresses.stream()
                            .filter(Address::isDefault)
                            .findFirst()
                            .orElse(addresses.get(0)); // Nếu không có địa chỉ mặc định, lấy địa chỉ đầu tiên

                    session.setAttribute("defaultAddress", defaultAddress);
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Không block việc checkout nếu không load được địa chỉ
            }
        }

        // Forward đến trang thanh toán
        request.getRequestDispatcher("/thanhtoan.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Xử lý đặt hàng
        // Sẽ implement sau khi có bảng Orders trong database
        response.sendRedirect(request.getContextPath() + "/account.jsp");
    }
}
