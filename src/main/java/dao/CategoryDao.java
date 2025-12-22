package dao;

import model.product.Category;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public boolean update(Category category) {
        String sql = "UPDATE Categories SET " +
                "name_category = :nameCategory, " +
                "slug = :slug, " +
                "description = :description, " +
                "parent_category_id = :parentCategoryId " +
                "WHERE id = :id";

        return jdbi.withHandle(handle -> {
            int affected = handle.createUpdate(sql)
                    .bind("id", category.getId())
                    .bind("nameCategory", category.getNameCategory())
                    .bind("slug", category.getSlug())
                    .bind("description", category.getDescription())
                    .bind("parentCategoryId", category.getParentId() == 0 ? null : category.getParentId())
                    .execute();
            return affected > 0;
        });
    }

    public int countChildCategories(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Categories WHERE parent_category_id = :categoryId";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).bind("categoryId", categoryId).mapTo(Integer.class).one()
        );
    }

    public int countProducts(int categoryId) {
        String sql = "SELECT COUNT(*) FROM Products WHERE category_id = :categoryId";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).bind("categoryId", categoryId).mapTo(Integer.class).one()
        );
    }

    public Map<Integer, Integer> getProductCountsForAllCategories() {
        String sql = "SELECT category_id, COUNT(*) as product_count " +
                "FROM Products " +
                "GROUP BY category_id";

        return jdbi.withHandle(handle -> {
            Map<Integer, Integer> counts = new HashMap<>();

            handle.createQuery(sql)
                    .map((rs, ctx) -> {
                        int categoryId = rs.getInt("category_id");
                        int count = rs.getInt("product_count");
                        counts.put(categoryId, count);
                        return null;
                    })
                    .list();

            return counts;
        });
    }
    /**
     * Xóa category (có validation)
     * @throws IllegalStateException nếu không thể xóa
     */
    public boolean delete(int id) {
        int childCount = countChildCategories(id);
        int productCount = countProducts(id);

        // Validation
        if (childCount > 0 || productCount > 0) {
            StringBuilder msg = new StringBuilder("Không thể xóa danh mục này vì:\n");
            if (childCount > 0) {
                msg.append("- Còn ").append(childCount).append(" danh mục con\n");
            }
            if (productCount > 0) {
                msg.append("- Còn ").append(productCount).append(" sản phẩm\n");
            }
            msg.append("\nVui lòng xóa ");
            if (childCount > 0 && productCount > 0) {
                msg.append("các danh mục con và sản phẩm");
            } else if (childCount > 0) {
                msg.append("các danh mục con");
            } else {
                msg.append("các sản phẩm");
            }
            msg.append(" trước.");

            throw new IllegalStateException(msg.toString());
        }

        // Thực hiện xóa
        String sql = "DELETE FROM Categories WHERE id = :id";
        return jdbi.withHandle(handle -> {
            int affected = handle.createUpdate(sql).bind("id", id).execute();
            return affected > 0;
        });
    }

    public boolean exists(int id) {
        String sql = "SELECT COUNT(*) FROM Categories WHERE id = :id";
        return jdbi.withHandle(handle -> {
            Integer count = handle.createQuery(sql).bind("id", id).mapTo(Integer.class).one();
            return count > 0;
        });
    }
}