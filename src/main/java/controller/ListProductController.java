package controller;

import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.product.ProductListDTO;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ListProductController", value = "/list-product")
public class ListProductController extends HttpServlet {

    private ProductDao productDao;
    // Không cần ProductService cho việc get list đơn thuần nếu đã gọi DAO trực tiếp như CategoryController

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.productDao = new ProductDao();
        } catch (Exception ex) {
            throw new ServletException("Lỗi khởi tạo: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. XỬ LÝ THAM SỐ
            int page = 1;
            int pageSize = 10; // Số lượng sản phẩm 1 trang
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            String sortBy = request.getParameter("sort-by");
            
            // LẤY TỪ KHÓA TÌM KIẾM
            String searchKeyword = request.getParameter("search");
            boolean isSearchMode = (searchKeyword != null && !searchKeyword.trim().isEmpty());
            
            // Nếu đang search và không có sortBy từ user -> để null để dùng relevance score
            // Nếu không search và không có sortBy -> dùng mặc định alpha-asc
            if (!isSearchMode && (sortBy == null || sortBy.isEmpty())) {
                sortBy = "alpha-asc";
            }

            // 2. TÍNH TOÁN PHÂN TRANG
            int totalProducts;
            int totalPages;
            List<ProductListDTO> list;

            if (isSearchMode) {
                // Chế độ tìm kiếm
                totalProducts = productDao.countSearchResults(searchKeyword);
                totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
                
                list = productDao.searchProducts(searchKeyword, page, pageSize, sortBy);
                request.setAttribute("searchKeyword", searchKeyword);
                request.setAttribute("pageTitle", "Kết quả tìm kiếm: \"" + searchKeyword + "\"");
            } else {
                // Chế độ hiển thị tất cả
                totalProducts = productDao.countActiveProducts();
                totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                
                if (page < 1) page = 1;
                if (page > totalPages && totalPages > 0) page = totalPages;
                
                list = productDao.getAllActiveProductsPayload(page, pageSize, sortBy);
                request.setAttribute("pageTitle", "Tất cả sản phẩm");
            }

            // 3. LẤY DỮ LIỆU

            request.setAttribute("list", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("totalProducts", totalProducts);

            // 4. XỬ LÝ SẢN PHẨM ĐÃ XEM (Copy y nguyên từ CategoryController)
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

            List<Integer> listIds = new ArrayList<>();
            if (!txt.isEmpty()) {
                try {
                    for (String s : txt.split(",")) {
                        if(!s.trim().isEmpty()) listIds.add(Integer.parseInt(s.trim()));
                    }
                } catch (Exception e) {}
            }

            if (!listIds.isEmpty()) {
                // Đảo ngược để sản phẩm mới xem lên đầu (Optional)
                java.util.Collections.reverse(listIds);
                List<ProductListDTO> viewedList = productDao.getViewedProducts(listIds);
                request.setAttribute("viewedProducts", viewedList);
            }

            request.getRequestDispatcher("all-product.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}