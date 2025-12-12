package model.product;

import model.AId;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class ProductListDTO extends AId {
    @ColumnName("name_product")
    private String nameProduct;
    private Double price;
    private String thumbnail;
    private String sku;
    public ProductListDTO(int id) {
        super(id);
    }
    public ProductListDTO() {}


    public String getNameProduct() { return nameProduct; }
    public void setNameProduct(String nameProduct) { this.nameProduct = nameProduct; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }
}
