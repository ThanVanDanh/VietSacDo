package dao;

import model.product.Product;
import model.product.ProductImage;
import model.product.ProductListDTO;
import model.product.ProductVariant;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.util.List;

public class ProductDao extends BaseDao {
    public List<ProductListDTO> getListProduct() {
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
    public List<ProductListDTO> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p " +
                "WHERE p.category_id = :categoryId";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .mapToBean(ProductListDTO.class)
                        .list()
        );
    }

    public int insert(Product product) {
        return get().withHandle(handle -> insert(handle, product));
    }

    public int insert(Handle handle, Product product) {
        String sql = "INSERT INTO Products (name_product, product_code, description, status_product, category_id) " +
                "VALUES (:nameProduct, :productCode, :description, :statusProduct, :categoryId)";

        Integer catId = product.getCategoryId() == 0 ? null : product.getCategoryId();

        return handle.createUpdate(sql)
                .bind("nameProduct", product.getNameProduct())
                .bind("productCode", product.getProductCode())
                .bind("description", product.getDescription())
                .bind("statusProduct", product.getStatusProduct() == null ? "active" : product.getStatusProduct())
                .bind("categoryId", catId)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }


}
