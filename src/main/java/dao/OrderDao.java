package dao;

import model.cart.CartItem;
import model.order.Order;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class OrderDao extends BaseDao {
    private final Jdbi jdbi;

    public OrderDao() {
        this.jdbi = get();
    }

    public int createOrder(Order order, List<CartItem> cartItems) {
        return jdbi.inTransaction(handle -> {
            String orderSql = "INSERT INTO Orders (user_id, order_code, customer_fullname, customer_email, " +
                    "customer_phone, shipping_address, customer_note, subtotal_amount, shipping_fee, " +
                    "discount_amount, total_amount, voucher_id, order_status, payment_method, payment_status, created_at) "
                    +
                    "VALUES (:userId, :orderCode, :customerFullname, :customerEmail, " +
                    ":customerPhone, :shippingAddress, :customerNote, :subtotalAmount, :shippingFee, " +
                    ":discountAmount, :totalAmount, :voucherId, :orderStatus, :paymentMethod, :paymentStatus, NOW())";

            int orderId = handle.createUpdate(orderSql)
                    .bindBean(order)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(int.class)
                    .one();

            String itemSql = "INSERT INTO Order_items (order_id, variant_id, quantity, price_at_purchase) " +
                    "VALUES (:orderId, :variantId, :quantity, :priceAtPurchase)";

            for (CartItem item : cartItems) {
                Integer variantId = getVariantIdByProductAndSku(handle, item.getProduct().getId(), item.getSku(),
                        item.getSize());

                if (variantId != null) {
                    handle.createUpdate(itemSql)
                            .bind("orderId", orderId)
                            .bind("variantId", variantId)
                            .bind("quantity", item.getQuantity())
                            .bind("priceAtPurchase", item.getPrice())
                            .execute();
                } else {
                    System.err.println("Warning: Cannot find Variant ID for SKU: " + item.getSku());
                }
            }

            return orderId;
        });
    }

    private Integer getVariantIdByProductAndSku(Handle handle, int productId, String sku, String size) {
        if (sku != null && !sku.isEmpty()) {
            return handle.createQuery("SELECT id FROM Product_variants WHERE sku = :sku")
                    .bind("sku", sku)
                    .mapTo(Integer.class)
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    public Integer getVariantId(String sku) {
        return jdbi.withHandle(handle -> handle.createQuery("SELECT id FROM Product_variants WHERE sku = :sku")
                .bind("sku", sku)
                .mapTo(Integer.class)
                .findFirst()
                .orElse(null));
    }

    public List<Order> getOrdersByUserId(int userId) {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM Orders WHERE user_id = :userId ORDER BY created_at DESC")
                        .bind("userId", userId)
                        .mapToBean(Order.class)
                        .list());
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return jdbi.withHandle(
                handle -> handle.createUpdate("UPDATE Orders SET order_status = :status WHERE id = :orderId")
                        .bind("status", status)
                        .bind("orderId", orderId)
                        .execute() > 0);
    }

    public boolean cancelOrderWithReason(int orderId, String status, String cancelReason) {
        return jdbi.withHandle(
                handle -> handle
                        .createUpdate(
                                "UPDATE Orders SET order_status = :status, cancel_reason = :reason WHERE id = :orderId")
                        .bind("status", status)
                        .bind("reason", cancelReason)
                        .bind("orderId", orderId)
                        .execute() > 0);
    }

    public List<model.order.OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT oi.*, " +
                "p.name_product AS productName, " +
                "(SELECT pi.image_url FROM Product_images pi WHERE pi.product_id = p.id AND pi.is_thumbnail = 1 LIMIT 1) AS productImage, "
                +
                "pv.size AS size " +
                "FROM Order_items oi " +
                "LEFT JOIN Product_variants pv ON oi.variant_id = pv.id " +
                "LEFT JOIN Products p ON pv.product_id = p.id " +
                "WHERE oi.order_id = :orderId";

        return jdbi.withHandle(handle -> handle.createQuery(sql)
                .bind("orderId", orderId)
                .mapToBean(model.order.OrderItem.class)
                .list());
    }

    public List<Order> getAllOrders() {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM Orders ORDER BY created_at DESC")
                        .mapToBean(Order.class)
                        .list());
    }

    public Order getOrderById(int orderId) {
        return jdbi.withHandle(
                handle -> handle.createQuery("SELECT * FROM Orders WHERE id = :orderId")
                        .bind("orderId", orderId)
                        .mapToBean(Order.class)
                        .findFirst()
                        .orElse(null));
    }

    public boolean deleteOrder(int orderId) {
        return jdbi.inTransaction(handle -> {
            // Delete order items first (foreign key constraint)
            handle.createUpdate("DELETE FROM Order_items WHERE order_id = :orderId")
                    .bind("orderId", orderId)
                    .execute();

            // Delete the order
            int deleted = handle.createUpdate("DELETE FROM Orders WHERE id = :orderId")
                    .bind("orderId", orderId)
                    .execute();

            return deleted > 0;
        });
    }
}
