package dao;

import model.product.Category;
import org.jdbi.v3.core.Handle;


public class CategoryDao extends BaseDao{
    public int insert(Category category){
        String sql = "INSERT INTO categories(name_category, slug, description, parent_category_id) VALUES (:nameCategory, :slug, :description, :parentId)";
        return get().withHandle(handle ->handle.createUpdate(sql)
                .bind("nameCategory", category.getNameCategory())
                .bind("slug", category.getSlug())
                .bind("description",category.getDescription())
                .bind("parentId", category.getParentId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one());
    }
    //transaction
    public int insert(Handle handle, Category category){
        String sql = "INSERT INTO categories(name_category, slug, description, parent_category_id) VALUES (:nameCategory, :slug, :description, :parentId)";
        return handle.createUpdate(sql)
                .bind("nameCategory", category.getNameCategory())
                .bind("slug", category.getSlug())
                .bind("description",category.getDescription())
                .bind("parentId", category.getParentId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }

}
