package controller;

import com.google.gson.reflect.TypeToken;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.product.Product;
import model.product.ProductVariant;
import services.CloudinaryService;
import services.ProductService;
import services.ProductService.ImageUpload;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.*;

/**
 * AddProductServlet
 *
 * Chức năng:
 *  - Nhận form multipart/form-data từ admin để thêm sản phẩm
 *  - Hỗ trợ trường "variants" gửi dạng JSON hoặc gửi arrays (sku[], size[], color[], current_price[], stock_quantity[])
 *  - Nhận files: input name = "productImages[]" (hỗ trợ cả "productImages")
 *  - Upload ảnh lên Cloudinary (bằng ProductService); uploadBeforeTransaction = true (upload ảnh trước, sau đó insert DB)
 *
 * Lưu ý:
 *  - Tận dụng BaseDao bằng cách lấy Jdbi từ ProductDao.get()
 *  - Tránh đọc InputStream nhiều lần (Part#getInputStream() chỉ đọc 1 lần)
 *  - Cloudinary credentials lấy từ resources/cloudinary.properties (CloudinaryService xử lý)
 */
@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/product/add"})
public class AddProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();

        try {
            // Lấy Jdbi bằng cách tận dụng BaseDao thông qua ProductDao
            ProductDao temp = new ProductDao();
            Jdbi jdbi = temp.get(); // BaseDao đã cấu hình kết nối dựa trên DBProperties

            // Khởi tạo CloudinaryService (đọc cloudinary.properties)
            CloudinaryService cloudinary = new CloudinaryService();

            // Khởi tạo ProductService dùng Jdbi và CloudinaryService
            productService = new ProductService(jdbi, cloudinary);

        } catch (Exception ex) {
            // Nếu lỗi khởi tạo, ném ServletException để app không start sai
            throw new ServletException("Khởi tạo AddProductServlet thất bại: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String contentType = req.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu multipart/form-data");
            return;
        }

        // 1) đọc fields chính
        String name = safe(req.getParameter("product-name"));
        String code = safe(req.getParameter("product-code"));
        String description = safe(req.getParameter("product-description"));
        String status = safe(req.getParameter("product-status"));
        String cat = safe(req.getParameter("product-category"));

        int categoryId = 0;
        if (!cat.isEmpty()) {
            try { categoryId = Integer.parseInt(cat); } catch (Exception ignored) {}
        }

        Product product = new Product(0);
        product.setNameProduct(name);
        product.setProductCode(code);
        product.setDescription(description);
        product.setStatusProduct(status.isEmpty() ? "active" : status);
        product.setCategoryId(categoryId);

        // 2) variants từ các array inputs
        List<ProductVariant> variants = new ArrayList<>();
        String[] skus = req.getParameterValues("sku[]");
        if (skus == null) skus = req.getParameterValues("sku");
        if (skus != null) {
            String[] sizes = optional(req.getParameterValues("size[]"), req.getParameterValues("size"));
            String[] colors = optional(req.getParameterValues("color[]"), req.getParameterValues("color"));
            String[] prices = optional(req.getParameterValues("current_price[]"), req.getParameterValues("current_price"));
            String[] stocks = optional(req.getParameterValues("stock_quantity[]"), req.getParameterValues("stock_quantity"));

            for (int i = 0; i < skus.length; i++) {
                String sku = safeArrayGet(skus, i);
                if (sku == null || sku.isEmpty()) continue;
                ProductVariant v = new ProductVariant(0);
                v.setSku(sku);
                v.setSize(safeArrayGet(sizes, i));
                v.setColor(safeArrayGet(colors, i));

                double price = 0;
                String pstr = safeArrayGet(prices, i);
                if (pstr != null && !pstr.isEmpty()) {
                    try { price = Double.parseDouble(pstr); } catch (Exception ignored) {}
                }
                v.setCurrentPrice(price);

                int stock = 0;
                String sstr = safeArrayGet(stocks, i);
                if (sstr != null && !sstr.isEmpty()) {
                    try { stock = Integer.parseInt(sstr); } catch (Exception ignored) {}
                }
                v.setStockQuantity(stock);

                variants.add(v);
            }
        }

        // 3) đọc file parts productImages[] và các hidden alt/thumb arrays
        List<ProductService.ImageUpload> uploads = new ArrayList<>();
        String[] alts = optional(req.getParameterValues("productImageAlt[]"), req.getParameterValues("productImageAlt"));
        String[] thumbs = optional(req.getParameterValues("productImageIsThumb[]"), req.getParameterValues("productImageIsThumb"));

        try {
            int fileIndex = 0;
            for (Part part : req.getParts()) {
                String namePart = part.getName();
                if (!("productImages[]".equals(namePart) || "productImages".equals(namePart))) continue;
                if (part.getSize() == 0) continue;

                String filename = getSubmittedFileName(part);
                InputStream is = part.getInputStream();

                String alt = safeArrayGet(alts, fileIndex);
                boolean isThumb = "1".equals(safeArrayGet(thumbs, fileIndex));

                // tạo ImageUpload từ InputStream (CloudinaryService sẽ xử lý)
                ProductService.ImageUpload iu = new ProductService.ImageUpload(is, filename, alt, isThumb);
                uploads.add(iu);
                fileIndex++;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đọc file: " + ex.getMessage());
            return;
        }

        // 4) Gọi service
        try {
            int newId = productService.createProduct(product, variants, uploads);
            // redirect về danh sách sau khi tạo thành công
            resp.sendRedirect(req.getContextPath() + "/admin/products.jsp?created=1&id=" + newId);
        } catch (Exception ex) {
            ex.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Thêm sản phẩm thất bại: " + ex.getMessage());
        }
    }

    /* ---------- helpers ---------- */
    private String safe(String s) { return s == null ? "" : s.trim(); }
    private String[] optional(String[] a, String[] b) { return a != null ? a : b; }
    private String safeArrayGet(String[] arr, int idx) { if (arr==null) return null; if (idx<0||idx>=arr.length) return null; return arr[idx]; }

    // Lấy filename từ header content-disposition
    private static String getSubmittedFileName(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename")) {
                String fn = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                fn = fn.substring(Math.max(fn.lastIndexOf('/'), fn.lastIndexOf('\\')) + 1);
                return fn;
            }
        }
        return null;
    }
}
