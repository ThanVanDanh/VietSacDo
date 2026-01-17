package model.cart;

import model.product.Product;
import model.user.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
    Map<Integer, CartItem> items;
    private User user;
    public Cart() { items = new HashMap<>(); }
    public void addItem(Product product, int quantity,double price) {
        if (quantity <= 0)
            quantity = 1;
        CartItem item = items.get(product.getId());
        if (item != null) {
            item.upQuantity(quantity);
        } else {
            item = new CartItem(quantity, product, price);
            items.put(product.getId(), item);
        }
    }
    public void updateQuantity(int productId, int quantity) {
        CartItem item = items.get(productId);
        if (item != null) {
            if (quantity <= 0) {
                items.remove(productId);
            } else {
                item.setQuantity(quantity);
            }
        }
    }
    public double getTotalPrice() {
        double total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }
    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }
    public void clear() {
        items.clear();
    }
    public void remove(int productId) {
        items.remove(productId);
    }
    public CartItem get(int id) {
        return items.get(id);
    }
    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
