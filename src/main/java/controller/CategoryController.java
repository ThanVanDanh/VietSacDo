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
    private ProductDao productDao;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.productDao = new ProductDao();
            this.categoryDao = new CategoryDao();
            this.productService = new ProductService(productDao.get(), new CloudinaryService());
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
//            danh muc
            Category currentCategory = categoryDao.getCategoryBySlug(slug);
            if (currentCategory == null) {
                response.sendError(404, "Danh mục không tồn tại");
                return;
            }
//            phan trang
            int page = 1;
            int pageSize = 15;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalProducts = categoryDao.countProductsByCategory(currentCategory.getId());
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            if (page < 1) page = 1;
            if (page > totalPages && totalPages > 0) page = totalPages;

            List<ProductListDTO> list = categoryDao.getProductsByCategoryPayload(currentCategory.getId(), page, pageSize);

            request.setAttribute("currentCategory", currentCategory);
            request.setAttribute("list", list);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
//            cookie san pham da xem
            String txt = "";
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if (c.getName().equals("viewed_products")) {
                        txt = java.net.URLDecoder.decode(c.getValue(), java.nio.charset.StandardCharsets.UTF_8);
                        break;
                    }
                }
            }

            List<Integer> listIds = new java.util.ArrayList<>();
            if (!txt.isEmpty()) {
                try {
                    for (String s : txt.split(",")) {
                        if(!s.trim().isEmpty()) listIds.add(Integer.parseInt(s.trim()));
                    }
                } catch (Exception e) {}
            }

            if (!listIds.isEmpty()) {
                List<model.product.ProductListDTO> viewedList = productDao.getViewedProducts(listIds);
                request.setAttribute("viewedProducts", viewedList);
            }
            request.getRequestDispatcher("/list-product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}