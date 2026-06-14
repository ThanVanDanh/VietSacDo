package util;

import model.cart.CartItem;
import model.order.Order;

import java.util.List;

public class OrderSignatureDataBuilder {

    public static String buildFromCart(Order order, List<CartItem> cartItems, String voucherCode) {
        StringBuilder sb = new StringBuilder();

        sb.append("order_code=").append(safe(order.getOrderCode())).append("\n");
        sb.append("user_id=").append(order.getUserId() != null ? order.getUserId() : "").append("\n");
        sb.append("customer_fullname=").append(safe(order.getCustomerFullname())).append("\n");
        sb.append("customer_email=").append(safe(order.getCustomerEmail())).append("\n");
        sb.append("customer_phone=").append(safe(order.getCustomerPhone())).append("\n");
        sb.append("shipping_address=").append(safe(order.getShippingAddress())).append("\n");
        sb.append("customer_note=").append(safe(order.getCustomerNote())).append("\n");
        sb.append("subtotal_amount=").append(formatAmount(order.getSubtotalAmount())).append("\n");
        sb.append("shipping_fee=").append(formatAmount(order.getShippingFee())).append("\n");
        sb.append("discount_amount=").append(formatAmount(order.getDiscountAmount())).append("\n");
        sb.append("total_amount=").append(formatAmount(order.getTotalAmount())).append("\n");
        sb.append("voucher_code=").append(safe(voucherCode)).append("\n");
        sb.append("payment_method=").append(safe(order.getPaymentMethod())).append("\n");

        sb.append("items=[\n");
        if (cartItems != null) {
            for (int i = 0; i < cartItems.size(); i++) {
                CartItem item = cartItems.get(i);
                String productName = item.getProduct() != null ? item.getProduct().getNameProduct() : "";
                String productCode = item.getProduct() != null ? item.getProduct().getProductCode() : "";
                double lineTotal = item.getQuantity() * item.getPrice();

                sb.append("  {");
                sb.append("product_name=").append(safe(productName));
                sb.append(",product_code=").append(safe(productCode));
                sb.append(",sku=").append(safe(item.getSku()));
                sb.append(",size=").append(safe(item.getSize()));
                sb.append(",color=").append(getColorFromSku(item));
                sb.append(",quantity=").append(item.getQuantity());
                sb.append(",price=").append(formatAmount(item.getPrice()));
                sb.append(",line_total=").append(formatAmount(lineTotal));
                sb.append("}");

                if (i < cartItems.size() - 1) {
                    sb.append("\n");
                }
            }
        }
        sb.append("\n]");

        return sb.toString();
    }

    public static String buildFromOrder(Order order, List<model.order.OrderItem> orderItems, String voucherCode) {
        StringBuilder sb = new StringBuilder();

        sb.append("order_code=").append(safe(order.getOrderCode())).append("\n");
        sb.append("user_id=").append(order.getUserId() != null ? order.getUserId() : "").append("\n");
        sb.append("customer_fullname=").append(safe(order.getCustomerFullname())).append("\n");
        sb.append("customer_email=").append(safe(order.getCustomerEmail())).append("\n");
        sb.append("customer_phone=").append(safe(order.getCustomerPhone())).append("\n");
        sb.append("shipping_address=").append(safe(order.getShippingAddress())).append("\n");
        sb.append("customer_note=").append(safe(order.getCustomerNote())).append("\n");
        sb.append("subtotal_amount=").append(formatAmount(order.getSubtotalAmount())).append("\n");
        sb.append("shipping_fee=").append(formatAmount(order.getShippingFee())).append("\n");
        sb.append("discount_amount=").append(formatAmount(order.getDiscountAmount())).append("\n");
        sb.append("total_amount=").append(formatAmount(order.getTotalAmount())).append("\n");
        sb.append("voucher_code=").append(safe(voucherCode)).append("\n");
        sb.append("payment_method=").append(safe(order.getPaymentMethod())).append("\n");

        sb.append("items=[\n");
        if (orderItems != null) {
            for (int i = 0; i < orderItems.size(); i++) {
                model.order.OrderItem item = orderItems.get(i);
                double lineTotal = item.getQuantity() * item.getPriceAtPurchase();

                sb.append("  {");
                sb.append("product_name=").append(safe(item.getProductNameAtPurchase()));
                sb.append(",product_code=").append(safe(item.getProductCodeAtPurchase()));
                sb.append(",sku=").append(safe(item.getVariantSkuAtPurchase()));
                sb.append(",size=").append(safe(item.getSizeAtPurchase()));
                sb.append(",color=").append(safe(item.getColorAtPurchase()));
                sb.append(",quantity=").append(item.getQuantity());
                sb.append(",price=").append(formatAmount(item.getPriceAtPurchase()));
                sb.append(",line_total=").append(formatAmount(lineTotal));
                sb.append("}");

                if (i < orderItems.size() - 1) {
                    sb.append("\n");
                }
            }
        }
        sb.append("\n]");

        return sb.toString();
    }

    private static String safe(String value) {
        return value == null ? "" : value.trim();
    }

    private static String formatAmount(double amount) {
        long rounded = Math.round(amount * 100);
        return String.valueOf(rounded / 100.0);
    }

    private static String getColorFromSku(CartItem item) {
        if (item.getProduct() != null && item.getProduct().getVariants() != null) {
            for (model.product.ProductVariant v : item.getProduct().getVariants()) {
                if (v.getSku() != null && v.getSku().equals(item.getSku())) {
                    return safe(v.getColor());
                }
            }
        }
        return "";
    }
}
