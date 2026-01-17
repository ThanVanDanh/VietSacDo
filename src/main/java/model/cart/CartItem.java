package model.cart;

import model.product.Product;

import java.io.Serializable;

public class CartItem implements Serializable {
    private int quantity;
    private Product product;
    private double price;

    public CartItem(int quantity, Product product, double price) {
        this.quantity = quantity;
        this.product = product;
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public void upQuantity(int quantity) {
        this.quantity += quantity;
    }
    public double getTotalPrice() {
        return this.quantity * this.price;
    }


}
