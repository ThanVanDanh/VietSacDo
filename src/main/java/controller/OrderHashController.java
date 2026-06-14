package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.KeyDao;
import model.cart.Cart;
import model.cart.CartItem;
import model.order.Order;
import model.user.User;
import services.SignatureService;
import util.OrderSignatureDataBuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet chuẩn bị dữ liệu hash cho đơn hàng trước khi ký.
 */
@WebServlet("/checkout/prepare-signature")
public class OrderHashController extends HttpServlet {
    private KeyDao keyDao;

    @Override
    public void init() throws ServletException {
        super.init();
        this.keyDao = new KeyDao();
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
            responseJson.addProperty("message", "Vui lòng đăng nhập để tiếp tục.");
            out.write(gson.toJson(responseJson));
            return;
        }

        User user = (User) session.getAttribute("account");
        
        String activePublicKey = keyDao.getActivePublicKey(user.getId());
        if (activePublicKey == null) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Bạn chưa có khóa bảo mật. Vui lòng vào trang Quản lý khóa để tạo khóa trước khi đặt hàng.");
            out.write(gson.toJson(responseJson));
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getTotalQuantity() == 0) {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Giỏ hàng trống.");
            out.write(gson.toJson(responseJson));
            return;
        }

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String paymentMethod = req.getParameter("paymentMethod");
        String orderNote = req.getParameter("orderNote");
        String shippingAddress = (address != null ? address : "") + ", " + (city != null ? city : "");

        Order order = new Order();
        order.setUserId(user.getId());
        order.setOrderCode("ORD" + System.currentTimeMillis());
        order.setCustomerFullname(fullName);
        order.setCustomerPhone(phone);
        order.setCustomerEmail(email);
        order.setShippingAddress(shippingAddress);
        order.setCustomerNote(orderNote);
        order.setPaymentMethod(paymentMethod != null ? paymentMethod : "cod");

        double subtotal = cart.getTotalPrice();
        double shippingFee = (subtotal >= 1000000) ? 0 : 30000;
        
        model.voucher.Voucher voucher = (model.voucher.Voucher) session.getAttribute("appliedVoucher");
        double discountAmount = 0;
        Integer voucherId = null;
        String voucherCode = "";

        if (voucher != null) {
            if ("percentage".equalsIgnoreCase(voucher.getDiscountType()) || "percent".equalsIgnoreCase(voucher.getDiscountType())) {
                discountAmount = subtotal * (voucher.getDiscountValue() / 100.0);
            } else {
                discountAmount = voucher.getDiscountValue();
            }
            voucherId = voucher.getId();
            voucherCode = voucher.getVoucherCode();
        }

        double totalAmount = subtotal + shippingFee - discountAmount;
        if (totalAmount < 0) totalAmount = 0;

        order.setSubtotalAmount(subtotal);
        order.setShippingFee(shippingFee);
        order.setDiscountAmount(discountAmount);
        order.setTotalAmount(totalAmount);
        order.setVoucherId(voucherId);
        order.setOrderStatus("chờ xử lý");
        order.setPaymentStatus("chưa thanh toán");
        
        Integer keyId = keyDao.getActiveKeyId(user.getId());
        order.setKeyId(keyId);

        List<CartItem> cartItems = cart.getItems();
        String canonicalData = OrderSignatureDataBuilder.buildFromCart(order, cartItems, voucherCode);
        String orderHash = SignatureService.computeHash(canonicalData);

        order.setSignedOrderData(canonicalData);
        order.setOrderHash(orderHash);

        session.setAttribute("tempOrder", order);
        session.setAttribute("tempCartItems", cartItems);

        responseJson.addProperty("success", true);
        responseJson.addProperty("orderCode", order.getOrderCode());
        responseJson.addProperty("subtotal", subtotal);
        responseJson.addProperty("shippingFee", shippingFee);
        responseJson.addProperty("discount", discountAmount);
        responseJson.addProperty("total", totalAmount);
        responseJson.addProperty("orderHash", orderHash);

        JsonArray itemsArray = new JsonArray();
        for (CartItem item : cartItems) {
            JsonObject itemObj = new JsonObject();
            itemObj.addProperty("productName", item.getProduct() != null ? item.getProduct().getNameProduct() : "");
            itemObj.addProperty("sku", item.getSku());
            itemObj.addProperty("quantity", item.getQuantity());
            itemObj.addProperty("price", item.getPrice());
            itemsArray.add(itemObj);
        }
        responseJson.add("items", itemsArray);

        out.write(gson.toJson(responseJson));
    }
}
