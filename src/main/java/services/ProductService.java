package services;

import dao.ProductDao;
import dao.ProductImageDao;
import dao.ProductVariantDao;
import model.product.Product;
import model.product.ProductImage;
import model.product.ProductListDTO;
import model.product.ProductVariant;
import org.jdbi.v3.core.Jdbi;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


public class ProductService {

    private final Jdbi jdbi;
    private final CloudinaryService cloudinary;
    private final ProductDao productDao;
    private final ProductVariantDao variantDao;
    private final ProductImageDao imageDao;



    public ProductService(Jdbi jdbi, CloudinaryService cloudinary) {
        this.jdbi = Objects.requireNonNull(jdbi);
        this.cloudinary = Objects.requireNonNull(cloudinary);
        this.productDao = new ProductDao();
        this.variantDao = new ProductVariantDao();
        this.imageDao = new ProductImageDao();
    }

    public static class ImageUpload {
        private final InputStream inputStream; // ưu tiên
        private final File file; // optional
        private final String filename;
        private final String altText;
        private final boolean isThumbnail;

        public ImageUpload(InputStream inputStream, String filename, String altText, boolean isThumbnail) {
            this.inputStream = inputStream;
            this.file = null;
            this.filename = filename;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }

        public ImageUpload(File file, String altText, boolean isThumbnail) {
            this.inputStream = null;
            this.file = file;
            this.filename = file != null ? file.getName() : null;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }

        public InputStream getInputStream() { return inputStream; }
        public File getFile() { return file; }
        public String getFilename() { return filename; }
        public String getAltText() { return altText; }
        public boolean isThumbnail() { return isThumbnail; }
    }

    // internal holder
    private static class UploadedImage {
        final String secureUrl;
        final String publicId;
        final String altText;
        final boolean isThumbnail;
        UploadedImage(String secureUrl, String publicId, String altText, boolean isThumbnail) {
            this.secureUrl = secureUrl;
            this.publicId = publicId;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }
    }

    public List<ProductListDTO> getListProduct() {
        return productDao.getListProduct();
    }

//    // Xóa danh sách ảnh đã upload (dùng publicId)
//    private void cleanupUploaded(List<UploadedImageResult> uploaded) {
//        if (uploaded == null || uploaded.isEmpty()) return;
//        for (UploadedImageResult r : uploaded) {
//            if (r.publicId != null) {
//                try {
//                    cloudinary.deleteByPublicId(r.publicId);
//                } catch (Exception ignored) {
//                    // nếu xóa fail, ghi log hoặc bỏ qua (không ném tiếp)
//                    ignored.printStackTrace();
//                }
//            }
//        }
//    }

    public Product getProduct(int id) {
        return productDao.getProduct(id);
    }
    public int createProduct(Product product, List<ProductVariant> variants, List<ImageUpload> uploads) {
        List<UploadedImage> uploaded = new ArrayList<>();

        try {
            // 1) upload ảnh trước
            if (uploads != null) {
                for (ImageUpload iu : uploads) {
                    CloudinaryService.UploadedImage u;
                    if (iu.getInputStream() != null) {
                        u = cloudinary.upload(iu.getInputStream(), iu.getFilename());
                    } else {
                        u = cloudinary.upload(iu.getFile());
                    }
                    if (u == null || u.getSecureUrl() == null) {
                        // nếu upload thất bại -> xóa đã upload trước đó rồi ném
                        cleanupUploaded(uploaded);
                        throw new RuntimeException("Upload ảnh thất bại: " + iu.getFilename());
                    }
                    uploaded.add(new UploadedImage(u.getSecureUrl(), u.getPublicId(), iu.getAltText(), iu.isThumbnail()));
                }
            }

            // 2) Insert vào DB trong 1 transaction
            int newProductId = jdbi.inTransaction(handle -> {
                int pid = productDao.insert(handle, product);

                if (variants != null) {
                    for (ProductVariant v : variants) {
                        v.setProductId(pid);
                        variantDao.insert(handle, v);
                    }
                }

                if (!uploaded.isEmpty()) {
                    for (UploadedImage r : uploaded) {
                        ProductImage pi = new ProductImage(0);
                        pi.setProductId(pid);
                        pi.setImageUrl(r.secureUrl);
                        pi.setAltText(r.altText);
                        pi.setThumbnail(r.isThumbnail);
                        imageDao.insert(handle, pi);
                    }
                }

                return pid;
            });

            return newProductId;

        } catch (RuntimeException ex) {
            // error -> cleanup cloudinary uploads
            cleanupUploaded(uploaded);
            throw ex;
        }
    }

    private void cleanupUploaded(List<UploadedImage> uploaded) {
        if (uploaded == null) return;
        for (UploadedImage u : uploaded) {
            if (u.publicId != null) {
                try { cloudinary.deleteByPublicId(u.publicId); } catch (Exception ignore) {}
            }
        }
    }
}
