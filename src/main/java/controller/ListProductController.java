package controller;

import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.product.Product;
import model.product.ProductListDTO;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProductController", value = "/list-product")
public class ListProductController extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Tận dụng ProductDao (BaseDao) để lấy Jdbi cấu hình sẵn
            ProductDao pd = new ProductDao();
            org.jdbi.v3.core.Jdbi jdbi = pd.get();

            // Khởi tạo CloudinaryService (nếu ProductService cần)
            CloudinaryService cloudinary = new CloudinaryService();

            // Khởi tạo ProductService với các dependency
            this.productService = new ProductService(jdbi, cloudinary);

        } catch (Exception ex) {
            // Nếu khởi tạo thất bại thì ném ServletException (Tomcat sẽ log)
            throw new ServletException("Khởi tạo ListProductController thất bại: " + ex.getMessage(), ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<ProductListDTO> list = productService.getListProduct();
        request.setAttribute("list", list);
        request.getRequestDispatcher("aodailinen.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}