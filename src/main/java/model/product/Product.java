package model.product;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Product implements Serializable {
    private int id;
    private String nameProduct;
    private String productCode;
    private String description;
    private LocalDateTime createdAt;
    private String statusProduct;
    private int categoryId;

    public Product() {
    }

    public Product(int id, String nameProduct, String productCode, String description, LocalDateTime createdAt, String statusProduct, int categoryId) {
        this.id = id;
        this.nameProduct = nameProduct;
        this.productCode = productCode;
        this.description = description;
        this.createdAt = createdAt;
        this.statusProduct = statusProduct;
        this.categoryId = categoryId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNameProduct() {
        return nameProduct;
    }

    public void setNameProduct(String nameProduct) {
        this.nameProduct = nameProduct;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatusProduct() {
        return statusProduct;
    }

    public void setStatusProduct(String statusProduct) {
        this.statusProduct = statusProduct;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}



