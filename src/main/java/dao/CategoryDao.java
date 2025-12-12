package dao;

import model.product.Category;
import org.jdbi.v3.core.Handle;

/**
 * CategoryDao - thao tác trên bảng Categories
 * - Trả về id (generated key) sau khi insert
 */
public class CategoryDao extends BaseDao {

    // Insert đơn giản (ngoài transaction)
    public int insert(Category category) {
        return get().withHandle(handle -> insert(handle, category));
    }

    // Insert sử dụng Handle (dùng trong transaction nếu cần)
    public int insert(Handle handle, Category category) {
        String sql = "INSERT INTO Categories (name_category, slug, description, parent_category_id) " +
                "VALUES (:nameCategory, :slug, :description, :parentId)";

        // Nếu parentId = 0 nghĩa là không có parent -> lưu NULL
        Integer parent = category.getParentId() == 0 ? null : category.getParentId();

        return handle.createUpdate(sql)
                .bind("nameCategory", category.getNameCategory())
                .bind("slug", category.getSlug())
                .bind("description", category.getDescription())
                .bind("parentId", parent)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }
}
