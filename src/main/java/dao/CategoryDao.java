package dao;

import model.product.Category;
import model.product.ProductListDTO;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.List;

/**
 * CategoryDao - FIXED
 * <p>
 * VẤN ĐỀ CŨ: Gọi get() mỗi lần dùng -> tạo connection mới
 * GIẢI PHÁP: Lưu JDBI instance
 */
public class CategoryDao extends BaseDao {

    private final Jdbi jdbi;

    // ✅ Constructor lưu JDBI instance
    public CategoryDao() {
        this.jdbi = get();
        System.out.println("CategoryDao created with JDBI: " + this.jdbi);
    }

    // Insert đơn giản (ngoài transaction)
    public int insert(Category category) {
        return jdbi.withHandle(handle -> insert(handle, category));
    }

    // Insert sử dụng Handle (dùng trong transaction nếu cần)
    public int insert(Handle handle, Category category) {
        String sql = "INSERT INTO Categories (name_category, slug, description, parent_category_id) " +
                "VALUES (:nameCategory, :slug, :description, :parentId)";

        // Nếu parentId = 0 nghĩa là không có parent -> lưu NULL
        Integer parent = (category.getParentId() != null && category.getParentId() == 0) ? null : category.getParentId();

        return handle.createUpdate(sql)
                .bind("nameCategory", category.getNameCategory())
                .bind("slug", category.getSlug())
                .bind("description", category.getDescription())
                .bind("parentId", parent)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }

    // ✅ FIXED: Dùng jdbi instance thay vì gọi get()
    public List<Category> getAll() {
        System.out.println("CategoryDao.getAll() called");
        System.out.println("Using JDBI: " + this.jdbi);

        String sql = "SELECT id, name_category AS nameCategory, slug, description, " +
                "parent_category_id AS parentId FROM Categories ORDER BY name_category";

        try {
            List<Category> result = jdbi.withHandle(handle -> {
                System.out.println("Inside withHandle, executing query...");
                return handle.createQuery(sql)
                        .mapToBean(Category.class)
                        .list();
            });

            System.out.println("Query executed successfully, found " + result.size() + " categories");
            return result;

        } catch (Exception e) {
            System.err.println("❌ Error in getAll(): " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public Category getById(int id) {
        String sql = "SELECT id, name_category, slug, description, parent_category_id FROM Categories WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean existsBySlug(String slug) {
        if (slug == null || slug.isEmpty()) return false;

        Long count = jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM Categories WHERE slug = :slug")
                        .bind("slug", slug)
                        .mapTo(Long.class)
                        .one()
        );
        return count != null && count > 0;
    }

    public Category getCategoryBySlug(String slug) {
        return get().withHandle(handle ->
                handle.createQuery("SELECT * FROM Categories WHERE slug = :slug")
                        .bind("slug", slug)
                        .mapToBean(Category.class)
                        .findFirst()
                        .orElse(null)
        );
    }
    // 1. Đếm tổng số sản phẩm trong danh mục (Dùng để tính Total Pages)
    public int countProductsByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Products WHERE category_id = :categoryId";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<ProductListDTO> getProductsByCategoryPayload(int categoryId, int page, int pageSize) {
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p " +
                "WHERE p.category_id = :categoryId " +
                "LIMIT :limit OFFSET :offset";

        int offset = (page - 1) * pageSize;

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("categoryId", categoryId)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .mapToBean(ProductListDTO.class)
                        .list()
        );
    }

}
