package dao;

import model.product.ProductVariant;
import org.jdbi.v3.core.Handle;

public class ProductVariantDao extends BaseDao{
    public int insert(ProductVariant productVariant){
        String sql = "INSERT INTO product_variants(product_id, sku, size, color, current_price, stock_quantity) VALUES (:productId, :sku, :size, :color, :currentPrice, :stockQuantity)";
        return get().withHandle(handle -> handle.createUpdate(sql)
                .bind("productId", productVariant.getProductId())
                .bind("sku", productVariant.getSku())
                .bind("size", productVariant.getSize())
                .bind("color",productVariant.getColor())
                .bind("currentPrice", productVariant.getCurrentPrice())
                .bind("stockQuantity", productVariant.getStockQuantity())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class).one());
    }
    //transaction
    public int insert(Handle handle,ProductVariant productVariant){
        String sql = "INSERT INTO product_variants(product_id, sku, size, color, current_price, stock_quantity) VALUES (:productId, :sku, :size, :color, :currentPrice, :stockQuantity)";
        return handle.createUpdate(sql)
                .bind("productId", productVariant.getProductId())
                .bind("sku", productVariant.getSku())
                .bind("size", productVariant.getSize())
                .bind("color",productVariant.getColor())
                .bind("currentPrice", productVariant.getCurrentPrice())
                .bind("stockQuantity", productVariant.getStockQuantity())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class).one();
    }

}
