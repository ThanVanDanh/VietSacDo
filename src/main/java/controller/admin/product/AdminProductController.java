package controller.admin.product;

import com.google.gson.Gson;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.product.Product;
import model.product.ProductListDTO;
import model.product.ProductVariant;
import services.CloudinaryService;
import services.ProductService;
import services.ProductService.ImageUpload;
import org.jdbi.v3.core.Jdbi;
import util.GsonUtil;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

/**
 * AdminProductController - LIST, ADD, DELETE
 * <p>
 * GET  /admin/product/add    -> Trả về JSON danh sách products (list)
 * POST /admin/product/add    -> Thêm product mới
 * POST /admin/product/delete -> Xóa product (hoặc dùng query param ?action=delete)
 */
@WebServlet(name = "AdminProductController", urlPatterns = {
        "/admin/product/add",
        "/admin/product/delete",
        "/admin/product/update",
        "/admin/product/get"
})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminProductController extends HttpServlet {

    private ProductService productService;
    private ProductDao productDao;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            System.out.println("=== Initializing AdminProductController ===");

            productDao = new ProductDao();
            Jdbi jdbi = productDao.get();
            System.out.println("✅ Jdbi: " + jdbi);

            CloudinaryService cloudinary = new CloudinaryService();
            System.out.println("✅ CloudinaryService created");

            productService = new ProductService(jdbi, cloudinary);
            System.out.println("✅ ProductService initialized");
            gson = GsonUtil.getGson();
        } catch (Exception ex) {
            System.err.println("❌ Init failed: " + ex.getMessage());
            ex.printStackTrace();
            throw new ServletException("Init failed: " + ex.getMessage(), ex);
        }
    }

    /**
     * CORS headers
     */
    private void addCorsHeaders(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
        resp.setHeader("Access-Control-Max-Age", "3600");
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCorsHeaders(resp);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    /**
     * GET -> Trả về JSON danh sách products
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== doGet AdminProductController (LIST) ===");

        addCorsHeaders(resp);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        try {
            if (productService == null) {
                throw new IllegalStateException("ProductService chưa được khởi tạo");
            }

            // Lấy danh sách products
            List<ProductListDTO> products = productService.getListProduct();
            System.out.println("✅ Loaded " + products.size() + " products");

            // Convert to JSON
            String json = gson.toJson(products);
            resp.getWriter().write(json);
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception ex) {
            System.err.println("❌ Error in doGet: " + ex.getMessage());
            ex.printStackTrace();

            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    /**
     * POST -> Thêm product mới HOẶC xóa product
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        addCorsHeaders(resp);
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // ✅ Kiểm tra URI để phân biệt ADD vs DELETE
        String uri = req.getRequestURI();
        if (uri != null && uri.contains("/delete")) {
            handleDelete(req, resp);
            return;
        }

        // ✅ Kiểm tra query param action=delete
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            handleDelete(req, resp);
            return;
        }

        // ✅ Nếu không phải delete → Xử lý ADD
        handleAdd(req, resp);
    }

    /**
     * DELETE method
     */
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        handleDelete(req, resp);
    }

    /**
     * ✅ MỚI: Xử lý DELETE product
     */
    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== handleDelete AdminProductController ===");

        resp.setContentType("application/json;charset=UTF-8");

        try {
            String idStr = req.getParameter("id");

            if (idStr == null || idStr.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false, \"error\":\"ID sản phẩm là bắt buộc\"}");
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(idStr.trim());
            } catch (NumberFormatException e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false, \"error\":\"ID không hợp lệ\"}");
                return;
            }

            System.out.println("Deleting product ID: " + productId);

            // Kiểm tra product tồn tại
            if (!productDao.exists(productId)) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"success\":false, \"error\":\"Sản phẩm không tồn tại\"}");
                return;
            }

            // Xóa product (cascade delete variants & images)
            boolean success = productDao.delete(productId);

            if (success) {
                System.out.println("✅ Deleted product ID: " + productId);
                resp.setStatus(HttpServletResponse.SC_OK);
                resp.getWriter().write("{\"success\":true, \"message\":\"Xóa sản phẩm thành công\"}");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"success\":false, \"error\":\"Không thể xóa sản phẩm\"}");
            }

        } catch (Exception ex) {
            System.err.println("❌ Error deleting product: " + ex.getMessage());
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false, \"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    /**
     * ✅ Xử lý ADD product
     */
    private void handleAdd(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("=== handleAdd AdminProductController ===");

        String contentType = req.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu multipart/form-data");
            return;
        }

        try {
            // 1) Đọc parameters
            String name = safe(req.getParameter("product-name"));
            String code = safe(req.getParameter("product-code"));
            String description = safe(req.getParameter("product-description"));
            String status = safe(req.getParameter("product-status"));
            String cat = safe(req.getParameter("product-category"));

            System.out.println("Params: name=" + name + ", code=" + code + ", cat=" + cat);

            if (name.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false,\"error\":\"Tên sản phẩm bắt buộc\"}");
                return;
            }

            int categoryId = 0;
            if (!cat.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(cat);
                } catch (Exception e) {
                }
            }

            Product product = new Product(0);
            product.setNameProduct(name);
            product.setProductCode(code);
            product.setDescription(description);
            product.setStatusProduct(status.isEmpty() ? "active" : status);
            product.setCategoryId(categoryId);

            // 2) Variants
            List<ProductVariant> variants = new ArrayList<>();
            String[] skus = optional(req.getParameterValues("variant-sku[]"), req.getParameterValues("variant-sku"));

            if (skus != null) {
                String[] sizes = optional(req.getParameterValues("variant-size[]"), req.getParameterValues("variant-size"));
                String[] colors = optional(req.getParameterValues("variant-color[]"), req.getParameterValues("variant-color"));
                String[] prices = optional(req.getParameterValues("variant-price[]"), req.getParameterValues("variant-price"));
                String[] stocks = optional(req.getParameterValues("variant-quantity[]"), req.getParameterValues("variant-quantity"));

                for (int i = 0; i < skus.length; i++) {
                    String sku = get(skus, i);
                    if (sku == null || sku.isEmpty()) continue;

                    ProductVariant v = new ProductVariant(0);
                    v.setSku(sku);
                    v.setSize(get(sizes, i));
                    v.setColor(get(colors, i));

                    double price = 0;
                    try {
                        price = Double.parseDouble(get(prices, i));
                    } catch (Exception e) {
                    }
                    v.setCurrentPrice(price);

                    int stock = 0;
                    try {
                        stock = Integer.parseInt(get(stocks, i));
                    } catch (Exception e) {
                    }
                    v.setStockQuantity(stock);

                    variants.add(v);
                }
            }
            System.out.println("Variants: " + variants.size());

            // 3) Images
            List<ImageUpload> uploads = new ArrayList<>();
            String[] alts = optional(req.getParameterValues("productImageAlt[]"), req.getParameterValues("productImageAlt"));
            String[] thumbs = optional(req.getParameterValues("productImageIsThumb[]"), req.getParameterValues("productImageIsThumb"));

            int idx = 0;
            for (Part part : req.getParts()) {
                if (!"productImages".equals(part.getName())) continue;
                if (part.getSize() == 0) continue;

                String filename = getFilename(part);
                InputStream is = part.getInputStream();
                String alt = get(alts, idx);
                boolean thumb = "1".equals(get(thumbs, idx));

                uploads.add(new ImageUpload(is, filename, alt, thumb));
                idx++;
            }
            System.out.println("Images: " + uploads.size());

            // 4) Create product
            int newId = productService.createProduct(product, variants, uploads);
            System.out.println("✅ Created product ID: " + newId);

            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":true,\"id\":" + newId + "}");
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception ex) {
            System.err.println("❌ Error: " + ex.getMessage());
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    /* ---------- helpers ---------- */
    private String safe(String s) {
        return s == null ? "" : s.trim();
    }

    private String[] optional(String[] a, String[] b) {
        return a != null ? a : b;
    }

    private String get(String[] arr, int i) {
        return (arr != null && i >= 0 && i < arr.length) ? arr[i] : null;
    }

    private String getFilename(Part part) {
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String t : cd.split(";")) {
            t = t.trim();
            if (t.startsWith("filename")) {
                String fn = t.substring(t.indexOf('=') + 1).trim().replace("\"", "");
                return fn.substring(Math.max(fn.lastIndexOf('/'), fn.lastIndexOf('\\')) + 1);
            }
        }
        return null;
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}