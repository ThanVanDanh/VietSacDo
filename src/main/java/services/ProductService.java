package services;

import dao.ProductDao;
import dao.ProductImageDao;
import dao.ProductVariantDao;
import model.product.Product;
import model.product.ProductImage;
import model.product.ProductVariant;
import org.jdbi.v3.core.Jdbi;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;


public class ProductService {
    private final Jdbi jdbi;
    private final CloudinaryService cloudinary;
    private final ProductDao  productDao;
    private final ProductVariantDao variantDao;
    private final ProductImageDao imageDao;

    public ProductService(Jdbi jdbi, CloudinaryService cloudinary) {
        this.jdbi = jdbi;
        this.cloudinary = cloudinary;
        this.productDao = new ProductDao();
        this.variantDao = new ProductVariantDao();
        this.imageDao = new ProductImageDao();
    }
    public static class ImageUpload {
        private final File file;                // optional
        private final InputStream inputStream;  // optional
        private final String filename;          // bắt buộc (để public_id / hiển thị alt nếu cần)
        private final String altText;
        private final Boolean isThumbnail;

        // constructor từ File
        public ImageUpload(File file, String altText, Boolean isThumbnail) {
            this.file = file;
            this.inputStream = null;
            this.filename = file != null ? file.getName() : null;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }

        // constructor từ InputStream (ví dụ Servlet Part.getInputStream())
        public ImageUpload(InputStream inputStream, String filename, String altText, Boolean isThumbnail) {
            this.file = null;
            this.inputStream = inputStream;
            this.filename = filename;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }

        public File getFile() { return file; }
        public InputStream getInputStream() { return inputStream; }
        public String getFilename() { return filename; }
        public String getAltText() { return altText; }
        public Boolean getIsThumbnail() { return isThumbnail; }
    }

    /**
     * Kết quả upload nội bộ để dùng khi insert vào DB và để cleanup khi cần
     */
    private static class UploadedImageResult {
        final String secureUrl;
        final String publicId;
        final String altText;
        final Boolean isThumbnail;

        UploadedImageResult(String secureUrl, String publicId, String altText, Boolean isThumbnail) {
            this.secureUrl = secureUrl;
            this.publicId = publicId;
            this.altText = altText;
            this.isThumbnail = isThumbnail;
        }
    }
    public int createProduct(Product product, List<ProductVariant> variants,
                             List<ImageUpload> imageUploads,
                             boolean uploadBeforeTransaction) {

        // Danh sách đã upload (để dùng insert vào DB hoặc cleanup khi lỗi)
        List<UploadedImageResult> uploaded = new ArrayList<>();

        try {
            // 1) Nếu chọn upload trước transaction -> upload tất cả ảnh lên Cloudinary
            if (uploadBeforeTransaction && imageUploads != null && !imageUploads.isEmpty()) {
                for (ImageUpload iu : imageUploads) {
                    CloudinaryService.UploadedImage u;
                    if (iu.getInputStream() != null) {
                        u = cloudinary.upload(iu.getInputStream(), iu.getFilename());
                    } else if (iu.getFile() != null) {
                        u = cloudinary.upload(iu.getFile());
                    } else {
                        throw new IllegalArgumentException("ImageUpload không có nội dung: " + iu.getFilename());
                    }

                    if (u == null || u.getSecureUrl() == null) {
                        // upload thất bại -> hủy tất cả đã upload trước đó
                        cleanupUploaded(uploaded);
                        throw new RuntimeException("Upload ảnh lên Cloudinary thất bại: " + iu.getFilename());
                    }

                    uploaded.add(new UploadedImageResult(u.getSecureUrl(), u.getPublicId(), iu.getAltText(), iu.getIsThumbnail()));
                }
            }

            // 2) Thực hiện insert vào DB trong 1 transaction
            int productId = jdbi.inTransaction(handle -> {
                // insert product -> lấy id
                int pid = productDao.insert(handle, product);

                // insert variants
                if (variants != null) {
                    for (ProductVariant v : variants) {
                        v.setProductId(pid);
                        variantDao.insert(handle, v);
                    }
                }

                // insert images: nếu đã upload trước, sử dụng uploaded list; ngược lại upload trong transaction
                if (imageUploads != null && !imageUploads.isEmpty()) {
                    if (!uploaded.isEmpty()) {
                        // dùng danh sách đã upload trước
                        for (UploadedImageResult r : uploaded) {
                            ProductImage pi = new ProductImage();
                            pi.setProductId(pid);
                            pi.setImageUrl(r.secureUrl);
                            pi.setAltText(r.altText);
                            pi.setThumbnail(r.isThumbnail != null ? r.isThumbnail : false);
                            imageDao.insert(handle, pi);
                        }
                    } else {
                        // upload trong transaction (không khuyến nghị, nhưng vẫn hỗ trợ)
                        for (ImageUpload iu : imageUploads) {
                            CloudinaryService.UploadedImage u;
                            if (iu.getInputStream() != null) {
                                u = cloudinary.upload(iu.getInputStream(), iu.getFilename());
                            } else if (iu.getFile() != null) {
                                u = cloudinary.upload(iu.getFile());
                            } else {
                                throw new IllegalArgumentException("ImageUpload không có nội dung: " + iu.getFilename());
                            }

                            if (u == null || u.getSecureUrl() == null) {
                                throw new RuntimeException("Upload ảnh trong transaction thất bại: " + iu.getFilename());
                            }

                            // lưu vào DB
                            ProductImage pi = new ProductImage();
                            pi.setProductId(pid);
                            pi.setImageUrl(u.getSecureUrl());
                            pi.setAltText(iu.getAltText());
                            pi.setThumbnail(iu.getIsThumbnail() != null ? iu.getIsThumbnail() : false);
                            imageDao.insert(handle, pi);

                            // đồng thời lưu publicId vào uploaded để cleanup nếu transaction sau này lỗi
                            uploaded.add(new UploadedImageResult(u.getSecureUrl(), u.getPublicId(), iu.getAltText(), iu.getIsThumbnail()));
                        }
                    }
                }

                return pid;
            });

            // Nếu tới đây không lỗi, trả về productId
            return productId;

        } catch (RuntimeException ex) {
            // Nếu có lỗi (ở upload trước hoặc trong transaction), cố gắng xóa các ảnh đã upload để tránh rác
            cleanupUploaded(uploaded);
            throw ex;
        }
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
