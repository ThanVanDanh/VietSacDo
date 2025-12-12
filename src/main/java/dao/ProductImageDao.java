package dao;

import model.product.ProductImage;
import org.jdbi.v3.core.Handle;

/**
 * ProductImageDao - thao tác với bảng Product_images
 */
public class ProductImageDao extends BaseDao {

    public int insert(ProductImage img) {
        return get().withHandle(handle -> insert(handle, img));
    }

    public int insert(Handle handle, ProductImage img) {
        String sql = "INSERT INTO Product_images (product_id, image_url, alt_text, is_thumbnail) " +
                "VALUES (:productId, :imageUrl, :altText, :isThumbnail)";

        // is_thumbnail trong model là boolean; map sang 0/1
        int isThumb = img.isThumbnail() ? 1 : 0;

        return handle.createUpdate(sql)
                .bind("productId", img.getProductId())
                .bind("imageUrl", img.getImageUrl())
                .bind("altText", img.getAltText())
                .bind("isThumbnail", isThumb)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }
}
