package model.product;

public class ProductVariant {
    private int id;
    private int productId;
    private String sku;
    private String size;
    private String color;
    private double currentPrice;
    private int stockQuantity;

    public ProductVariant(){}

    public ProductVariant(int id, int productId, String sku, String size, String color, double currentPrice, int stockQuantity) {
        this.id = id;
        this.productId = productId;
        this.sku = sku;
        this.size = size;
        this.color = color;
        this.currentPrice = currentPrice;
        this.stockQuantity = stockQuantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
}
