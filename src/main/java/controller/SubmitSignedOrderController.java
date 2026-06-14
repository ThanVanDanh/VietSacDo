package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.KeyDao;
import dao.OrderDao;
import model.cart.CartItem;
import model.order.Order;
import model.user.User;
import services.SignatureService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet("/checkout/submit-signed-order")
public class SubmitSignedOrderController extends HttpServlet {
    private KeyDao keyDao;
    private OrderDao orderDao;

    @Override
    public void init() throws ServletException {
        super.init();
        this.keyDao = new KeyDao();
        this.orderDao = new OrderDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        Gson gson = new Gson();
        JsonObject responseJson = new JsonObject();

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại.");
            out.write(gson.toJson(responseJson));
            return;
        }

        User user = (User) session.getAttribute("account");
        
        Order tempOrder = (Order) session.getAttribute("tempOrder");
        @SuppressWarnings("unchecked")
        List<CartItem> tempCartItems = (List<CartItem>) session.getAttribute("tempCartItems");

        if (tempOrder == null || tempCartItems == null) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Không tìm thấy thông tin đơn hàng tạm. Vui lòng thử đặt hàng lại.");
            out.write(gson.toJson(responseJson));
            return;
        }

        String signatureBase64 = req.getParameter("orderSignature");
        if (signatureBase64 == null || signatureBase64.trim().isEmpty()) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Thiếu chữ ký điện tử.");
            out.write(gson.toJson(responseJson));
            return;
        }

        String activePublicKey = keyDao.getActivePublicKey(user.getId());
        if (activePublicKey == null) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Không tìm thấy khóa bảo mật hợp lệ.");
            out.write(gson.toJson(responseJson));
            return;
        }

        //Verify chữ ký RSA
        boolean isValid = SignatureService.verify(tempOrder.getOrderHash(), signatureBase64.trim(), activePublicKey);
        
        if (!isValid) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Chữ ký điện tử không hợp lệ hoặc dữ liệu bị thay đổi.");
            out.write(gson.toJson(responseJson));
            return;
        }

        //Cập nhật trạng thái
        tempOrder.setOrderSignature(signatureBase64.trim());
        tempOrder.setSignatureStatus("valid");

        //Lưu DB
        try {
            int orderId = orderDao.createSignedOrder(tempOrder, tempCartItems);
            if (orderId > 0) {
                session.removeAttribute("cart");
                session.removeAttribute("tempOrder");
                session.removeAttribute("tempCartItems");
                session.removeAttribute("appliedVoucher");

                responseJson.addProperty("success", true);
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("message", "Lưu đơn hàng thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Lỗi hệ thống khi lưu đơn hàng.");
        }

        out.write(gson.toJson(responseJson));
    }
}
