package dao;

import model.product.ProductVariant;
import org.jdbi.v3.core.Handle;

/**
 * ProductVariantDao - thao tác với bảng Product_variants
 */
public class ProductVariantDao extends BaseDao {

    public int insert(ProductVariant variant) {
        return get().withHandle(handle -> insert(handle, variant));
    }

    public int insert(Handle handle, ProductVariant variant) {
        String sql = "INSERT INTO Product_variants (product_id, sku, size, color, current_price, stock_quantity) " +
                "VALUES (:productId, :sku, :size, :color, :currentPrice, :stockQuantity)";

        return handle.createUpdate(sql)
                .bind("productId", variant.getProductId())
                .bind("sku", variant.getSku())
                .bind("size", variant.getSize())
                .bind("color", variant.getColor())
                .bind("currentPrice", variant.getCurrentPrice())
                .bind("stockQuantity", variant.getStockQuantity())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }
}
