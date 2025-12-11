package dao;

import model.product.ProductImage;
import org.jdbi.v3.core.Handle;

public class ProductImageDao extends BaseDao{
    public int insert(ProductImage productImage){
        String sql = "INSERT INTO product_images(product_id,image_url, alt_text, is_thumbnail) VALUES (:productId, :imageUrl, :altText, :isThumbnail)";
        return get().withHandle(handle -> handle.createUpdate(sql)
                .bind("productId", productImage.getProductId())
                .bind("imageUrl", productImage.getImageUrl())
                .bind("altText", productImage.getAltText())
                .bind("isThumbnail", productImage.isThumbnail())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class).one());
    }
    //transaction
    public int insert(Handle handle, ProductImage productImage){
        String sql = "INSERT INTO product_images(product_id,image_url, alt_text, is_thumbnail) VALUES (:productId, :imageUrl, :altText, :isThumbnail)";
        return handle.createUpdate(sql)
                .bind("productId", productImage.getProductId())
                .bind("imageUrl", productImage.getImageUrl())
                .bind("altText", productImage.getAltText())
                .bind("isThumbnail", productImage.isThumbnail())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class).one();
    }
}
