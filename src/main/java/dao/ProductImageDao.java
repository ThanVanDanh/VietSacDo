package dao;

import model.product.ProductImage;
import org.jdbi.v3.core.Handle;

import java.util.List;

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

    /**
     * ✅ MỚI: Lấy images theo product ID
     */
    public List<ProductImage> getByProductId(int productId) {
        return get().withHandle(handle -> getByProductId(handle, productId));
    }

    /**
     * ✅ MỚI: Lấy images với Handle
     */
    public List<ProductImage> getByProductId(Handle handle, int productId) {
        String sql = "SELECT * FROM Product_images WHERE product_id = :productId ORDER BY id";
        return handle.createQuery(sql)
                .bind("productId", productId)
                .mapToBean(ProductImage.class)
                .list();
    }

    /**
     * ✅ MỚI: Xóa một image theo ID
     */
    public boolean delete(int imageId) {
        return get().withHandle(handle -> delete(handle, imageId));
    }

    /**
     * ✅ MỚI: Xóa image với Handle
     */
    public boolean delete(Handle handle, int imageId) {
        String sql = "DELETE FROM Product_images WHERE id = :id";
        int affected = handle.createUpdate(sql)
                .bind("id", imageId)
                .execute();
        return affected > 0;
    }

    /**
     * ✅ MỚI: Xóa tất cả images của một product
     */
    public void deleteByProductId(int productId) {
        get().withHandle(handle -> {
            deleteByProductId(handle, productId);
            return null;
        });
    }

    /**
     * ✅ MỚI: Xóa images với Handle
     */
    public void deleteByProductId(Handle handle, int productId) {
        String sql = "DELETE FROM Product_images WHERE product_id = :productId";
        handle.createUpdate(sql)
                .bind("productId", productId)
                .execute();
    }

    /**
     * ✅ MỚI: Update thumbnail status
     */
    public boolean updateThumbnail(int imageId, boolean isThumbnail) {
        return get().withHandle(handle -> {
            String sql = "UPDATE Product_images SET is_thumbnail = :isThumbnail WHERE id = :id";
            int affected = handle.createUpdate(sql)
                    .bind("id", imageId)
                    .bind("isThumbnail", isThumbnail ? 1 : 0)
                    .execute();
            return affected > 0;
        });
    }

    /**
     * ✅ MỚI: Unset all thumbnails for a product
     */
    public void unsetAllThumbnails(int productId) {
        get().withHandle(handle -> {
            String sql = "UPDATE Product_images SET is_thumbnail = 0 WHERE product_id = :productId";
            handle.createUpdate(sql)
                    .bind("productId", productId)
                    .execute();
            return null;
        });
    }
}
