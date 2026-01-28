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

        public InputStream getInputStream() {
            return inputStream;
        }

        public File getFile() {
            return file;
        }

        public String getFilename() {
            return filename;
        }

        public String getAltText() {
            return altText;
        }

        public boolean isThumbnail() {
            return isThumbnail;
        }
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

    public int countTotalProducts() {
        return productDao.countTotalProducts();
    }

    public List<ProductListDTO> getListProductWithPagination(int limit, int offset) {
        return productDao.getListProductWithPagination(limit, offset);
    }

    public List<ProductListDTO> getListProductWithPaginationAndSort(int limit, int offset, String sortBy) {
        return productDao.getListProductWithPaginationAndSort(limit, offset, sortBy);
    }

    public List<ProductListDTO> getListProduct() {
        return productDao.getListProduct();
    }

    public List<ProductListDTO> getProductsByCategory(int categoryId) {
        return productDao.getProductsByCategory(categoryId);
    }
    public List<ProductListDTO> getActiveListProduct() {
        return productDao.getActiveListProduct();
    }

    public Product getProduct(int id) {
        return productDao.getProduct(id);
    }

    public double getPriceById(int productId) {
        List<ProductVariant> variants = variantDao.getByProductId(productId);

        if (variants != null && !variants.isEmpty()) {
            return variants.get(0).getCurrentPrice();
        }
        return 0.0;
    }

    // // Xóa danh sách ảnh đã upload (dùng publicId)
    // private void cleanupUploaded(List<UploadedImageResult> uploaded) {
    // if (uploaded == null || uploaded.isEmpty()) return;
    // for (UploadedImageResult r : uploaded) {
    // if (r.publicId != null) {
    // try {
    // cloudinary.deleteByPublicId(r.publicId);
    // } catch (Exception ignored) {
    // // nếu xóa fail, ghi log hoặc bỏ qua (không ném tiếp)
    // ignored.printStackTrace();
    // }
    // }
    // }
    // }

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
                    uploaded.add(
                            new UploadedImage(u.getSecureUrl(), u.getPublicId(), iu.getAltText(), iu.isThumbnail()));
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

                // ✨ Đảm bảo chỉ có 1 thumbnail
                ensureOnlyOneThumbnail(handle, pid);

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
        if (uploaded == null)
            return;
        for (UploadedImage u : uploaded) {
            if (u.publicId != null) {
                try {
                    cloudinary.deleteByPublicId(u.publicId);
                } catch (Exception ignore) {
                }
            }
        }
    }

    public boolean updateProduct(Product product,
                                 List<ProductVariant> variants,
                                 List<ImageUpload> newImageUploads,
                                 List<Integer> keepImageIds,
                                 List<Boolean> keepImageThumbs) throws Exception {

        System.out.println("=== ProductService.updateProduct ===");
        System.out.println("Product ID: " + product.getId());
        System.out.println("New Variants: " + (variants != null ? variants.size() : 0));
        System.out.println("Keep Images: " + (keepImageIds != null ? keepImageIds.size() : 0));
        System.out.println("New Images: " + (newImageUploads != null ? newImageUploads.size() : 0));

        // 1. Upload new images to Cloudinary first
        List<UploadedImage> uploaded = new ArrayList<>();

        if (newImageUploads != null && !newImageUploads.isEmpty()) {
            for (ImageUpload iu : newImageUploads) {
                try {
                    CloudinaryService.UploadedImage u;
                    if (iu.getInputStream() != null) {
                        u = cloudinary.upload(iu.getInputStream(), iu.getFilename());
                    } else {
                        u = cloudinary.upload(iu.getFile());
                    }

                    if (u == null || u.getSecureUrl() == null) {
                        throw new RuntimeException("Upload failed: " + iu.getFilename());
                    }

                    uploaded.add(new UploadedImage(
                            u.getSecureUrl(),
                            u.getPublicId(),
                            iu.getAltText(),
                            iu.isThumbnail()));

                    System.out.println("✅ Uploaded new image: " + u.getSecureUrl());

                } catch (Exception e) {
                    System.err.println("❌ Upload failed: " + iu.getFilename() + " - " + e.getMessage());

                    // Cleanup uploaded images
                    cleanupUploaded(uploaded);
                    throw new Exception("Failed to upload image: " + iu.getFilename(), e);
                }
            }
        }

        // 2. Update database in transaction
        List<String> imagesToDelete = new ArrayList<>();

        try {
            boolean success = jdbi.inTransaction(handle -> {
                // 2.1. Update product basic info
                boolean updated = productDao.update(handle, product);
                if (!updated) {
                    throw new RuntimeException("Failed to update product");
                }
                System.out.println("✅ Product updated");

                // 2.2. & 2.3. Smart Update Variants (Preserve IDs)
                List<ProductVariant> currentVariants = variantDao.getByProductId(handle, product.getId());
                List<String> incomingSkus = new ArrayList<>();

                if (variants != null && !variants.isEmpty()) {
                    for (ProductVariant v : variants) {
                        incomingSkus.add(v.getSku());
                        boolean exists = false;

                        // Try to find existing variant by SKU
                        for (ProductVariant existing : currentVariants) {
                            if (existing.getSku().equalsIgnoreCase(v.getSku())) {
                                // Update existing
                                existing.setSize(v.getSize());
                                existing.setColor(v.getColor());
                                existing.setCurrentPrice(v.getCurrentPrice());
                                existing.setStockQuantity(v.getStockQuantity());
                                variantDao.update(handle, existing);
                                exists = true;
                                break;
                            }
                        }

                        if (!exists) {
                            // Insert new
                            v.setProductId(product.getId());
                            variantDao.insert(handle, v);
                        }
                    }
                }

                // Delete removed variants
                for (ProductVariant existing : currentVariants) {
                    if (!incomingSkus.contains(existing.getSku())) {
                        // Check if used in orders? Ideally yes, but for now simple delete
                        // Or better: soft delete. But sticking to current behavior (hard delete) only
                        // for removed ones.
                        variantDao.delete(handle, existing.getId());
                    }
                }
                System.out.println("✅ Variants synced (Smart Update)");

                // 2.4. Get existing images to determine which to delete
                List<ProductImage> existingImages = imageDao.getByProductId(handle, product.getId());

                for (ProductImage img : existingImages) {
                    boolean shouldKeep = keepImageIds != null && keepImageIds.contains(img.getId());
                    if (!shouldKeep) {
                        // Mark for deletion from Cloudinary
                        imagesToDelete.add(img.getImageUrl());
                    }
                }

                System.out.println("✅ Images to delete from Cloudinary: " + imagesToDelete.size());

                // 2.5. Delete images NOT in keepImageIds
                if (keepImageIds == null || keepImageIds.isEmpty()) {
                    imageDao.deleteByProductId(handle, product.getId());
                    System.out.println("✅ All images deleted");
                } else {
                    imageDao.deleteExcept(handle, product.getId(), keepImageIds);
                    System.out.println("✅ Images deleted except: " + keepImageIds);
                }

                // 2.6. ✨ Update thumbnail cho existing images
                if (keepImageIds != null && !keepImageIds.isEmpty()) {
                    for (int i = 0; i < keepImageIds.size(); i++) {
                        int imageId = keepImageIds.get(i);
                        boolean isThumb = keepImageThumbs != null && i < keepImageThumbs.size() && keepImageThumbs.get(i);
                        imageDao.updateThumbnail(handle, imageId, isThumb);
                    }
                    System.out.println("✅ Updated thumbnail for existing images");
                }

                // 2.7. Insert new images
                if (!uploaded.isEmpty()) {
                    for (UploadedImage u : uploaded) {
                        ProductImage img = new ProductImage(0);
                        img.setProductId(product.getId());
                        img.setImageUrl(u.secureUrl);
                        img.setAltText(u.altText);
                        img.setThumbnail(u.isThumbnail);

                        imageDao.insert(handle, img);
                    }
                    System.out.println("✅ New images inserted: " + uploaded.size());
                }

                // 2.8. ✨ Đảm bảo chỉ có 1 thumbnail - dùng data từ memory thay vì đọc lại DB
                Integer selectedThumbnailId = null;

                // Tìm thumbnail từ existing images
                if (keepImageThumbs != null) {
                    for (int i = 0; i < keepImageThumbs.size(); i++) {
                        if (keepImageThumbs.get(i)) {
                            selectedThumbnailId = keepImageIds.get(i);
                            break;
                        }
                    }
                }

                // Nếu không có existing thumbnail, tìm trong new images
                if (selectedThumbnailId == null && !uploaded.isEmpty()) {
                    for (UploadedImage u : uploaded) {
                        if (u.isThumbnail) {
                            // New image thumbnail - sẽ được handle bởi ensureOnlyOneThumbnail
                            break;
                        }
                    }
                }

                // Gọi enforce để đảm bảo chỉ có 1 thumbnail
                ensureOnlyOneThumbnail(handle, product.getId());

                return true;
            });

            if (!success) {
                throw new Exception("Transaction failed");
            }

        } catch (Exception e) {
            System.err.println("❌ Transaction failed: " + e.getMessage());
            e.printStackTrace();

            // Cleanup newly uploaded images from Cloudinary
            cleanupUploaded(uploaded);

            throw new Exception("Failed to update product", e);
        }

        // 3. Delete old images from Cloudinary (after successful transaction)
        if (!imagesToDelete.isEmpty()) {
            for (String url : imagesToDelete) {
                try {
                    String publicId = extractPublicId(url);
                    if (publicId != null) {
                        cloudinary.deleteByPublicId(publicId);
                        System.out.println("✅ Deleted from Cloudinary: " + publicId);
                    }
                } catch (Exception e) {
                    System.err.println("⚠️ Failed to delete from Cloudinary: " + url + " - " + e.getMessage());
                    // Don't throw, just log
                }
            }
        }

        return true;
    }

    private String extractPublicId(String url) {
        if (url == null || url.isEmpty())
            return null;

        try {
            // Find "/upload/" and extract everything after it
            int uploadIndex = url.indexOf("/upload/");
            if (uploadIndex == -1)
                return null;

            String afterUpload = url.substring(uploadIndex + 8); // "/upload/".length() = 8

            // Remove version (v1234567890/)
            int slashIndex = afterUpload.indexOf('/');
            if (slashIndex == -1)
                return null;

            String withExtension = afterUpload.substring(slashIndex + 1);

            // Remove file extension
            int dotIndex = withExtension.lastIndexOf('.');
            if (dotIndex == -1)
                return withExtension;

            return withExtension.substring(0, dotIndex);

        } catch (Exception e) {
            System.err.println("Failed to extract public_id from: " + url);
            return null;
        }
    }

    /**
     * Áp dụng giảm giá cho variant theo SKU
     */
    public boolean applyDiscountBySku(String sku, String discountType, double discountValue) {
        try {
            // Lấy variant theo SKU
            ProductVariant variant = variantDao.getVariantBySku(sku);
            if (variant == null) {
                throw new RuntimeException("Không tìm thấy sản phẩm với SKU: " + sku);
            }

            // Tính giá giảm
            double discountedPrice;
            if ("percentage".equals(discountType)) {
                discountedPrice = variant.getCurrentPrice() * (1 - discountValue / 100);
            } else {
                discountedPrice = variant.getCurrentPrice() - discountValue;
            }

            // Đảm bảo giá không âm
            if (discountedPrice < 0)
                discountedPrice = 0;

            // Cập nhật vào DB qua DAO
            return variantDao.updateDiscountedPrice(variant.getId(), discountedPrice);

        } catch (Exception e) {
            System.err.println("Error applying discount: " + e.getMessage());
            return false;
        }
    }

    /**
     * Áp dụng giảm giá hàng loạt theo danh mục
     */
    public int applyDiscountByCategories(List<Integer> categoryIds, String discountType, double discountValue) {
        try {
            // Lấy tất cả variants của các categories qua DAO
            List<ProductVariant> variants = jdbi.withHandle(handle -> {
                String selectSql = "SELECT pv.* FROM Product_variants pv " +
                        "INNER JOIN Products p ON pv.product_id = p.id " +
                        "WHERE p.category_id IN (<categoryIds>)";

                return handle.createQuery(selectSql)
                        .bindList("categoryIds", categoryIds)
                        .mapToBean(ProductVariant.class)
                        .list();
            });

            if (variants.isEmpty())
                return 0;

            // Cập nhật từng variant qua DAO
            int count = 0;
            for (ProductVariant v : variants) {
                double discountedPrice;
                if ("percentage".equals(discountType)) {
                    discountedPrice = v.getCurrentPrice() * (1 - discountValue / 100);
                } else {
                    discountedPrice = v.getCurrentPrice() - discountValue;
                }

                if (discountedPrice < 0)
                    discountedPrice = 0;

                // Gọi DAO để update
                boolean updated = variantDao.updateDiscountedPrice(v.getId(), discountedPrice);
                if (updated)
                    count++;
            }

            return count;

        } catch (Exception e) {
            System.err.println("Error applying batch discount: " + e.getMessage());
            return 0;
        }
    }

    private void ensureOnlyOneThumbnail(org.jdbi.v3.core.Handle handle, int productId) {
        // Đọc tất cả images của product này
        String selectSql = "SELECT * FROM Product_images WHERE product_id = :productId ORDER BY id";
        List<ProductImage> images = handle.createQuery(selectSql)
                .bind("productId", productId)
                .mapToBean(ProductImage.class)
                .list();

        // Tìm ảnh đầu tiên có is_thumbnail = 1
        ProductImage thumbnailImage = null;
        for (ProductImage img : images) {
            if (img.isThumbnail()) {
                thumbnailImage = img;
                break;
            }
        }

        // Reset tất cả về 0
        String resetSql = "UPDATE Product_images SET is_thumbnail = 0 WHERE product_id = :productId";
        handle.createUpdate(resetSql)
                .bind("productId", productId)
                .execute();

        // Set lại ảnh thumbnail được chọn (hoặc ảnh đầu tiên nếu không có)
        if (thumbnailImage != null) {
            String updateSql = "UPDATE Product_images SET is_thumbnail = 1 WHERE id = :id";
            handle.createUpdate(updateSql)
                    .bind("id", thumbnailImage.getId())
                    .execute();
        } else if (!images.isEmpty()) {
            String updateSql = "UPDATE Product_images SET is_thumbnail = 1 WHERE id = :id";
            handle.createUpdate(updateSql)
                    .bind("id", images.get(0).getId())
                    .execute();
        }
    }
}
