package controller;

import dao.CategoryDao;
import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.product.ProductListDTO;
import model.product.Category;
import services.CloudinaryService;
import services.ProductService;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryController", urlPatterns = {"/danh-muc/*"})
public class CategoryController extends HttpServlet {

    private ProductService productService;
    private CategoryDao categoryDao;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            ProductDao pd = new ProductDao();
            this.productService = new ProductService(pd.get(), new CloudinaryService());
            this.categoryDao = new CategoryDao();
        } catch (Exception ex) {
            throw new ServletException("Lỗi khởi tạo CategoryController: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        String slug = pathInfo.substring(1);
        try {
            Category currentCategory = categoryDao.getCategoryBySlug(slug);
            if (currentCategory == null) {
                response.sendError(404, "Danh mục không tồn tại");
                return;
            }
            List<ProductListDTO> list = productService.getProductsByCategory(currentCategory.getId());

            request.setAttribute("currentCategory", currentCategory);
            request.setAttribute("list", list);
            request.getRequestDispatcher("/list-product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}