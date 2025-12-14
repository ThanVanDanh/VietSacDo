package dao;

import model.product.Category;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

/**
 * CategoryDao - FIXED
 *
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
}