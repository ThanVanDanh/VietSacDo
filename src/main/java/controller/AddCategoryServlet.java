package controller;

import com.google.gson.Gson;
import dao.CategoryDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.product.Category;
import org.jdbi.v3.core.Jdbi;
import services.CategoryService;

import java.io.IOException;
import java.util.List;

/**
 * AddCategoryServlet với CORS support
 */
@WebServlet(name = "AddCategoryServlet", urlPatterns = {"/admin/category/add", "/admin/category/list"})
@MultipartConfig
public class AddCategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CategoryService categoryService;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            System.out.println("=== Initializing AddCategoryServlet ===");
            CategoryDao categoryDao = new CategoryDao();
            Jdbi jdbi = categoryDao.get();
            System.out.println("✅ CategoryDao created, JDBI: " + jdbi);

            this.categoryService = new CategoryService(jdbi);
            System.out.println("✅ CategoryService initialized");

            // Test load categories
            List<Category> testCats = categoryService.getAllCategories();
            System.out.println("✅ Test load: " + testCats.size() + " categories found");

        } catch (Throwable t) {
            System.err.println("❌ Init failed: " + t.getMessage());
            t.printStackTrace();
            throw new ServletException("Khởi tạo CategoryService thất bại: " + t.getMessage(), t);
        }
    }

    /**
     * ✅ THÊM: Xử lý CORS cho tất cả requests
     */
    private void addCorsHeaders(HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, Authorization");
        resp.setHeader("Access-Control-Max-Age", "3600");
    }

    /**
     * ✅ THÊM: Xử lý OPTIONS request (CORS preflight)
     */
    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        addCorsHeaders(resp);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    /**
     * GET -> trả JSON danh sách categories
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("=== doGet called ===");
        System.out.println("Request URI: " + req.getRequestURI());

        // ✅ Thêm CORS headers
        addCorsHeaders(resp);

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        try {
            if (categoryService == null) {
                throw new IllegalStateException("CategoryService chưa được khởi tạo");
            }

            List<Category> cats = categoryService.getAllCategories();
            System.out.println("✅ Loaded " + cats.size() + " categories");

            String json = gson.toJson(cats);
            System.out.println("JSON response: " + json);

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
     * POST -> thêm danh mục
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("=== doPost called ===");
        System.out.println("Request URI: " + req.getRequestURI());

        // ✅ Thêm CORS headers
        addCorsHeaders(resp);

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            String name = req.getParameter("category-name");
            String slug = req.getParameter("category-slug");
            String description = req.getParameter("category-description");
            String parent = req.getParameter("category-parent");

            System.out.println("Received params:");
            System.out.println("  - name: " + name);
            System.out.println("  - slug: " + slug);
            System.out.println("  - description: " + description);
            System.out.println("  - parent: " + parent);

            if (name == null || name.trim().isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false, \"error\":\"Tên danh mục là bắt buộc\"}");
                return;
            }

            Category cat = new Category();
            cat.setNameCategory(name.trim());
            cat.setSlug(slug != null && !slug.trim().isEmpty() ? slug.trim() : null);
            cat.setDescription(description != null ? description.trim() : null);

            if (parent != null && !parent.trim().isEmpty()) {
                try {
                    cat.setParentId(Integer.valueOf(parent.trim()));
                } catch (NumberFormatException ex) {
                    cat.setParentId(null);
                }
            } else {
                cat.setParentId(null);
            }

            int newId = categoryService.createCategory(cat);
            System.out.println("Created category with ID: " + newId);

            if (newId > 0) {
                resp.setContentType("application/json;charset=UTF-8");
                String json = "{\"success\":true, \"id\":" + newId + ", \"slug\":\"" + escapeJson(cat.getSlug()) + "\"}";
                resp.getWriter().write(json);
                resp.setStatus(HttpServletResponse.SC_OK);

            } else if (newId == -2) {
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false, \"error\":\"Slug đã tồn tại\"}");

            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false, \"error\":\"Không thể thêm danh mục\"}");
            }

        } catch (Exception ex) {
            System.err.println("❌ Error in doPost: " + ex.getMessage());
            ex.printStackTrace();

            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false, \"error\":\"" + escapeJson(ex.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}