package dao;

import model.product.Product;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.statement.PreparedBatch;

import java.util.ArrayList;
import java.util.List;

public class ProductDao extends BaseDao {
    //    static Map<Integer, Product> productMap = new HashMap<Integer, Product>();
//    static { productMap.put(1,new Product(1,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(2,new Product(2,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(3,new Product(3,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(4,new Product(4,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(5,new Product(5,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(6,new Product(6,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(7,new Product(7,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//            productMap.put(8,new Product(8,"Áo dài Linen Chi Lan",100000,"https://product.hstatic.net/1000136076/product/_mgl1681_a95390e03bdb4307b9a05a1a496e27cc_large.jpg"));
//    };
//    public List<Product> getListProduct() {
//        return  get().withHandle(handle -> handle.createQuery("select * from products").mapToBean(Product.class).list());
//    }
//    public Product getProduct(int id) {
//        return  get().withHandle(handle -> handle.createQuery("select * from products where id=:id ")).bind("id",id).mapToBean(Product.class).first();
//    }
//    public void insert(List<Product> products) {
//        Jdbi jdbi = get();
//        jdbi.useHandle(handle -> {
//            PreparedBatch preparedBatch = handle.prepareBatch("insert into products values(:id,:name,:price,:img)");
//            products.forEach(product -> {
//                preparedBatch.bindBean(product).add();
//            });
//            preparedBatch.execute();
//        });
//
//
//    }
    public List<Product> getListProduct() {
        return get().withHandle(handle -> handle.createQuery("select * from products").mapToBean(Product.class).list()
        );
    }

    public Product getProduct(int id) {
        return get().withHandle(handle -> handle.createQuery("select * from products where id = :id").bind("id", id).mapToBean(Product.class).findFirst().orElse(null)
        );
    }

    public void insert(List<Product> products) {
        Jdbi jdbi = get();
        jdbi.useHandle(handle -> {
            PreparedBatch preparedBatch = handle.prepareBatch("INSERT INTO products (name, price, img) VALUES (:name, :price, :img)");
            for (Product product : products) {
                preparedBatch.bindBean(product).add();
            }
            preparedBatch.execute();
        });
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();

        List<Product> list = new ArrayList<>();
        // Lưu ý: ID để là 0, vì vào DB nó sẽ tự tăng, không quan trọng số ở đây
//        list.add(new Product(0, "Áo Nhật Bình triều Nguyễn", 1200000, "img_link_1.jpg"));
//        list.add(new Product(0, "Áo Tấc phom rộng", 650000, "img_link_2.jpg"));
//        list.add(new Product(0, "Guốc mộc quai nhung", 150000, "img_link_3.jpg"));

        // Gọi hàm insert
        dao.insert(list);

        System.out.println("Đã thêm dữ liệu thành công!");
    }
}
