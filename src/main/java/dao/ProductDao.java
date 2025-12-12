package dao;

import model.product.Product;
import model.product.ProductImage;
import model.product.ProductListDTO;
import model.product.ProductVariant;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.util.List;

public class ProductDao extends BaseDao {
    public List<ProductListDTO> getListProduct() {
        // SQL lấy id, tên, và sub-query cho giá, ảnh, sku
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(ProductListDTO.class)
                        .list()
        );
    }
    public Product getProduct(int id) {
        return get().withHandle(handle -> {
            Product product = handle.createQuery("SELECT * FROM Products WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(Product.class)
                    .findFirst()
                    .orElse(null);

            if (product != null) {
                // Lấy variants
                product.setVariants(handle.createQuery("SELECT * FROM Product_variants WHERE product_id = :id")
                        .bind("id", id)
                        .mapToBean(ProductVariant.class)
                        .list());

                // Lấy images
                product.setImages(handle.createQuery("SELECT * FROM Product_images WHERE product_id = :id")
                        .bind("id", id)
                        .mapToBean(ProductImage.class)
                        .list());
            }
            return product;
        });
    }



}
