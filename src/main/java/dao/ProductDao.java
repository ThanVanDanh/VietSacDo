package dao;

import model.product.Product;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.util.ArrayList;
import java.util.List;

public class ProductDao extends BaseDao {
    public int insert(Product product) {
        String sql = "INSERT INTO products(name, product_code, description, status_product, category_id) VALUES (:nameProduct, :productCode, :description, :statusProduct, :categoryId)";
                return get().withHandle(handle -> handle.createUpdate(sql)
                        .bind("name", product.getNameProduct())
                        .bind("productCode", product.getProductCode())
                        .bind("description", product.getDescription())
                        .bind("statusProduct", product.getStatusProduct())
                        .bind("categoryId", product.getCategoryId())
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one());
    }
    //transaction
    public int insert(Handle handle,Product product) {
        String sql = "INSERT INTO products(name, product_code, description, status_product, category_id) VALUES (:nameProduct, :productCode, :description, :statusProduct, :categoryId)";
        return handle.createUpdate(sql)
                .bind("name", product.getNameProduct())
                .bind("productCode", product.getProductCode())
                .bind("description", product.getDescription())
                .bind("statusProduct", product.getStatusProduct())
                .bind("categoryId", product.getCategoryId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one();
    }
}
