package services;

import dao.ProductDao;
import model.product.Product;
import model.product.ProductListDTO;

import java.util.List;

public class ProductService {
    ProductDao productDao = new ProductDao();
    public List<ProductListDTO> getListProduct() {
        return productDao.getListProduct();
    }

    public Product getProduct(int id) {
        return  productDao.getProduct(id);
    }
}
