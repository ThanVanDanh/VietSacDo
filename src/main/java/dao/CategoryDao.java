package dao;

import model.product.Category;
import model.product.ProductListDTO;
import org.jdbi.v3.core.Handle;

import java.util.List;

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
    public Category getCategoryById(int id) {
        return get().withHandle(handle ->
                handle.createQuery("SELECT * FROM Categories WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findFirst()
                        .orElse(null)
        );
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

    // 2. Lấy danh sách sản phẩm có phân trang (OFFSET và LIMIT)
    public List<ProductListDTO> getProductsByCategoryPayload(int categoryId, int page, int pageSize) {
        String sql = "SELECT p.id, p.name_product, " +
                "(SELECT current_price FROM Product_variants WHERE product_id = p.id LIMIT 1) AS price, " +
                "(SELECT image_url FROM Product_images WHERE product_id = p.id AND is_thumbnail = 1 LIMIT 1) AS thumbnail, " +
                "(SELECT sku FROM Product_variants WHERE product_id = p.id LIMIT 1) AS sku " +
                "FROM Products p " +
                "WHERE p.category_id = :categoryId " +
                "LIMIT :limit OFFSET :offset";

        // Tính vị trí bắt đầu lấy dữ liệu
        // Ví dụ: Trang 1 bắt đầu từ 0, Trang 2 bắt đầu từ 12 (nếu pageSize = 12)
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
