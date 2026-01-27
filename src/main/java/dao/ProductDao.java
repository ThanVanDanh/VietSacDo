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
    private final Jdbi jdbi;

    public ProductDao() {
        this.jdbi = get();
    }

    public List<ProductListDTO> getListProduct() {
        String sql = "SELECT " +
                "p.id, " +
                "p.name_product, " +
                "p.product_code, " +
                "p.status_product, " +
                "p.created_at, " +
                "p.category_id, " +
                "c.name_category AS categoryName, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS price, " +
                "(SELECT discounted_price FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS discountedPrice, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS sku, " +
                "COALESCE((SELECT COUNT(*) FROM Product_variants WHERE product_id = p.id), 0) AS variantCount, " +
                "COALESCE((SELECT SUM(stock_quantity) FROM Product_variants WHERE product_id = p.id), 0) AS totalStock " +
                "FROM Products p " +
                "LEFT JOIN Categories c ON p.category_id = c.id " +
                "ORDER BY p.id DESC";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(ProductListDTO.class)
                        .list()
        );
    }
    public List<ProductListDTO> getActiveListProduct() {
        String sql = "SELECT " +
                "p.id, " +
                "p.name_product, " +
                "p.product_code, " +
                "p.status_product, " +
                "p.created_at, " +
                "p.category_id, " +
                "c.name_category AS categoryName, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS price, " +
                "(SELECT discounted_price FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS discountedPrice, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id ORDER BY id LIMIT 1) AS sku, " +
                "COALESCE((SELECT COUNT(*) FROM Product_variants WHERE product_id = p.id), 0) AS variantCount, " +
                "COALESCE((SELECT SUM(stock_quantity) FROM Product_variants WHERE product_id = p.id), 0) AS totalStock " +
                "FROM Products p " +
                "LEFT JOIN Categories c ON p.category_id = c.id " +
                "WHERE p.status_product = 'active' " + // CHỈ LẤY ACTIVE
                "ORDER BY p.id DESC";

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
                product.setVariants(handle.createQuery("SELECT * FROM Product_variants WHERE product_id = :id ORDER BY FIELD(size, 'S', 'M', 'L', 'XL', 'XXL');")
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

    // Thêm vào trong class ProductDao
    public List<ProductListDTO> getProductsByCategory(int categoryId) {
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT discounted_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS discountedPrice, " + // Thêm dòng này
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
    public List<ProductListDTO> getViewedProducts(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return new java.util.ArrayList<>();

        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT discounted_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS discountedPrice, " + // THÊM DÒNG NÀY
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p " +
                "WHERE p.id IN (<listId>)"+
                "AND p.status_product = 'active'";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bindList("listId", ids)
                        .mapToBean(ProductListDTO.class)
                        .list()
        );
    }
    public List<ProductListDTO> getRelatedProducts(int categoryId, int currentProductId, int limit) {
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT discounted_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS discountedPrice, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p " +
                "WHERE p.category_id = :categoryId " +
                "AND p.id != :currentProductId " +
                "AND p.status_product = 'active' " +
                "ORDER BY RAND() " +
                "LIMIT :limit";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .bind("currentProductId", currentProductId)
                        .bind("limit", limit)
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

    public boolean exists(int id) {
        String sql = "SELECT COUNT(*) FROM Products WHERE id = :id";
        return get().withHandle(handle -> {
            Integer count = handle.createQuery(sql).bind("id", id).mapTo(Integer.class).one();
            return count > 0;
        });
    }


    public boolean delete(int productId) {
        return get().withHandle(handle -> {
            // Delete trong transaction để đảm bảo consistency
            return handle.inTransaction(h -> {
                // 1. Xóa product images
                h.createUpdate("DELETE FROM Product_images WHERE product_id = :productId")
                        .bind("productId", productId)
                        .execute();

                // 2. Xóa product variants
                h.createUpdate("DELETE FROM Product_variants WHERE product_id = :productId")
                        .bind("productId", productId)
                        .execute();

                // 3. Xóa product
                int affected = h.createUpdate("DELETE FROM Products WHERE id = :productId")
                        .bind("productId", productId)
                        .execute();

                return affected > 0;
            });
        });
    }

    public int countVariants(int productId) {
        String sql = "SELECT COUNT(*) FROM Product_variants WHERE product_id = :productId";
        return get().withHandle(handle ->
                handle.createQuery(sql).bind("productId", productId).mapTo(Integer.class).one()
        );
    }

    /**
     * ✅ MỚI: Đếm số images của product
     */
    public int countImages(int productId) {
        String sql = "SELECT COUNT(*) FROM Product_images WHERE product_id = :productId";
        return get().withHandle(handle ->
                handle.createQuery(sql).bind("productId", productId).mapTo(Integer.class).one()
        );
    }

    public boolean update(Product product) {
        return get().withHandle(handle -> {
            return update(handle, product);
        });
    }

    public boolean update(Handle handle, Product product) {
        String sql = "UPDATE Products SET " +
                "name_product = ?, " +
                "product_code = ?, " +
                "description = ?, " +
                "status_product = ?, " +
                "category_id = ? " +
                "WHERE id = ?";

        int rows = handle.createUpdate(sql)
                .bind(0, product.getNameProduct())
                .bind(1, product.getProductCode())
                .bind(2, product.getDescription())
                .bind(3, product.getStatusProduct())
                .bind(4, product.getCategoryId() > 0 ? product.getCategoryId() : null)
                .bind(5, product.getId())
                .execute();

        return rows > 0;
    }
}
