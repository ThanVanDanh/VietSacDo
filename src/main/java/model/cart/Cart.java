package model.cart;

import model.product.Product;
import model.user.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    Map<String, CartItem> cartItemMap;
    private User user;
    public Cart() { cartItemMap = new HashMap<>(); }
    public void addItem(Product product, int quantity, double price, String sku, String size) {
        if (quantity <= 0) quantity = 1;
        if (sku == null) sku = "";
        if (size == null) size = "";
        
        // Trim khoảng trắng
        sku = sku.trim();
        size = size.trim();

        // Key duy nhất vẫn là ProductID + SKU
        String key = product.getId() + "-" + sku;

        System.out.println("=== DEBUG Cart.addItem() ===");
        System.out.println("Product ID: " + product.getId());
        System.out.println("SKU: [" + sku + "]");
        System.out.println("Size: [" + size + "]");
        System.out.println("Key: [" + key + "]");

        CartItem item = cartItemMap.get(key);
        if (item != null) {
            item.upQuantity(quantity);
        } else {
            cartItemMap.put(key, new CartItem(quantity, product, price, sku, size));
        }
    }
    public void updateQuantity(int productId, String sku, int quantity) {
        if (sku == null) sku = "";
        String key = productId + "-" + sku;

        CartItem item = cartItemMap.get(key);
        if (item != null) {
            if (quantity <= 0) cartItemMap.remove(key);
            else item.setQuantity(quantity);
        }
    }
    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : cartItemMap.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : cartItemMap.values()) {
            total += item.getQuantity();
        }
        return total;
    }
    public void clear() {
        cartItemMap.clear();
    }
    public void remove(int productId, String sku) {

        if (sku == null) sku = "";
        sku = sku.trim();
        String keyToRemove = productId + "-" + sku;

        System.out.println("=== DEBUG Cart.remove() ===");
        System.out.println("Trying to remove Key: [" + keyToRemove + "]");
        boolean exists = cartItemMap.containsKey(keyToRemove);
        System.out.println("Key exists in map? " + exists);

        if (cartItemMap.containsKey(keyToRemove)) {
            cartItemMap.remove(keyToRemove);
            System.out.println("Successfully removed!");
        } else {
            System.out.println("Key NOT FOUND in cart!");
        }
    }
    public CartItem get(String key) {
        return cartItemMap.get(key);
    }
    public List<CartItem> getItems() {
        return new ArrayList<>(cartItemMap.values());
    }
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
