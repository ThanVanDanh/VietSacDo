package controller.admin.product;

import com.google.gson.Gson;
import dao.CategoryDao;
import dao.ProductDao;
import dao.ProductVariantDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product.Category;
import model.product.ProductVariant;
import org.jdbi.v3.core.Jdbi;
import services.CloudinaryService;
import services.ProductService;
import util.GsonUtil;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AdminDiscountController - Xử lý giảm giá marketing
 * 
 * POST /admin/discount/apply-single     -> Giảm giá theo mã sản phẩm
 * POST /admin/discount/apply-batch      -> Giảm giá hàng loạt theo danh mục
 * GET  /admin/discount/get-product      -> Lấy thông tin giá của product theo code
 */
@WebServlet(name = "AdminDiscountController", urlPatterns = {
        "/admin/discount/apply-single",
        "/admin/discount/apply-batch",
        "/admin/discount/get-product"
})
public class AdminDiscountController extends HttpServlet {

    private ProductService productService;
    private ProductVariantDao variantDao;
    private CategoryDao categoryDao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            System.out.println("=== Initializing AdminDiscountController ===");

            ProductDao productDao = new ProductDao();
            Jdbi jdbi = productDao.get();
            
            CloudinaryService cloudinary = new CloudinaryService();
            this.productService = new ProductService(jdbi, cloudinary);
            this.variantDao = new ProductVariantDao();
            this.categoryDao = new CategoryDao();
            this.gson = GsonUtil.getGson();

            System.out.println("✅ AdminDiscountController initialized");
        } catch (Exception ex) {
            System.err.println("❌ Init failed: " + ex.getMessage());
            ex.printStackTrace();
            throw new ServletException("Init failed: " + ex.getMessage(), ex);
        }
    }

    private void addCorsHeaders(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
    }

    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCorsHeaders(resp);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCorsHeaders(resp);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String uri = req.getRequestURI();

        if (uri.contains("/get-product")) {
            handleGetProduct(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCorsHeaders(resp);
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String uri = req.getRequestURI();

        if (uri.contains("/apply-single")) {
            handleApplySingleDiscount(req, resp);
        } else if (uri.contains("/apply-batch")) {
            handleApplyBatchDiscount(req, resp);
        }
    }

    /**
     * Lấy thông tin giá của variant theo SKU
     */
    private void handleGetProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== handleGetProduct ===");

        try {
            String sku = req.getParameter("sku");

            if (sku == null || sku.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"SKU là bắt buộc\"}");
                return;
            }

            ProductVariant variant = variantDao.getVariantBySku(sku.trim());

            if (variant == null) {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"success\":false,\"error\":\"Không tìm thấy sản phẩm với SKU: " + sku + "\"}");
                return;
            }

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("sku", sku);
            result.put("currentPrice", variant.getCurrentPrice());
            result.put("discountedPrice", variant.getDiscountedPrice());

            resp.getWriter().write(gson.toJson(result));
            resp.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception ex) {
            System.err.println("❌ Error getting product: " + ex.getMessage());
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    /**
     * Áp dụng giảm giá cho một variant theo SKU
     */
    private void handleApplySingleDiscount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== handleApplySingleDiscount ===");

        try {
            String sku = req.getParameter("sku");
            String discountType = req.getParameter("discountType"); // "percentage" or "fixed"
            String discountValueStr = req.getParameter("discountValue");

            System.out.println("Received parameters:");
            System.out.println("  sku: " + sku);
            System.out.println("  discountType: " + discountType);
            System.out.println("  discountValue: " + discountValueStr);

            if (sku == null || sku.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"SKU là bắt buộc\"}");
                return;
            }

            if (discountType == null || discountValueStr == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Loại giảm giá và giá trị giảm là bắt buộc\"}");
                return;
            }

            double discountValue;
            try {
                discountValue = Double.parseDouble(discountValueStr.trim());
            } catch (NumberFormatException e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Giá trị giảm không hợp lệ\"}");
                return;
            }

            boolean success = productService.applyDiscountBySku(
                    sku.trim(),
                    discountType.trim(),
                    discountValue
            );

            if (success) {
                System.out.println("✅ Applied discount to SKU: " + sku);
                resp.getWriter().write("{\"success\":true,\"message\":\"Áp dụng giảm giá thành công\"}");
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("{\"success\":false,\"error\":\"Không thể áp dụng giảm giá\"}");
            }

        } catch (Exception ex) {
            System.err.println("❌ Error applying discount: " + ex.getMessage());
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    /**
     * Áp dụng giảm giá hàng loạt theo danh mục
     */
    private void handleApplyBatchDiscount(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== handleApplyBatchDiscount ===");

        try {
            String[] categoryIdStrs = req.getParameterValues("categoryIds");
            String discountType = req.getParameter("discountType"); // "percentage" or "fixed"
            String discountValueStr = req.getParameter("discountValue");

            System.out.println("Received parameters:");
            System.out.println("  categoryIds: " + (categoryIdStrs != null ? String.join(", ", categoryIdStrs) : "null"));
            System.out.println("  discountType: " + discountType);
            System.out.println("  discountValue: " + discountValueStr);

            if (categoryIdStrs == null || categoryIdStrs.length == 0) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Vui lòng chọn ít nhất một danh mục\"}");
                return;
            }

            if (discountType == null || discountValueStr == null) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Loại giảm giá và giá trị giảm là bắt buộc\"}");
                return;
            }

            double discountValue;
            try {
                discountValue = Double.parseDouble(discountValueStr.trim());
            } catch (NumberFormatException e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Giá trị giảm không hợp lệ\"}");
                return;
            }

            // Parse category IDs
            List<Integer> categoryIds = new ArrayList<>();
            for (String idStr : categoryIdStrs) {
                try {
                    categoryIds.add(Integer.parseInt(idStr.trim()));
                } catch (NumberFormatException e) {
                    System.err.println("Invalid category ID: " + idStr);
                }
            }

            if (categoryIds.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.getWriter().write("{\"success\":false,\"error\":\"Không có danh mục hợp lệ\"}");
                return;
            }

            int affectedCount = productService.applyDiscountByCategories(
                    categoryIds,
                    discountType.trim(),
                    discountValue
            );

            if (affectedCount > 0) {
                System.out.println("✅ Applied discount to " + affectedCount + " variants");
                resp.getWriter().write("{\"success\":true,\"message\":\"Đã áp dụng giảm giá cho " + affectedCount + " biến thể sản phẩm\",\"count\":" + affectedCount + "}");
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"success\":false,\"error\":\"Không tìm thấy sản phẩm nào trong các danh mục đã chọn\"}");
            }

        } catch (Exception ex) {
            System.err.println("❌ Error applying batch discount: " + ex.getMessage());
            ex.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}
