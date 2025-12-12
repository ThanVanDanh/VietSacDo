package services;

import dao.ProductDao;
import dao.ProductImageDao;
import dao.ProductVariantDao;
import model.product.Product;
import model.product.ProductListDTO;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;


public class ProductService {
    ProductDao productDao = new ProductDao();
    public List<ProductListDTO> getListProduct() {
        return productDao.getListProduct();
    }

    // Xóa danh sách ảnh đã upload (dùng publicId)
    private void cleanupUploaded(List<UploadedImageResult> uploaded) {
        if (uploaded == null || uploaded.isEmpty()) return;
        for (UploadedImageResult r : uploaded) {
            if (r.publicId != null) {
                try {
                    cloudinary.deleteByPublicId(r.publicId);
                } catch (Exception ignored) {
                    // nếu xóa fail, ghi log hoặc bỏ qua (không ném tiếp)
                    ignored.printStackTrace();
                }
            }
        }
    }
}
