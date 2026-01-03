package controller;

import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.product.Product;
import model.product.ProductImage;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;

@WebServlet(name = "ProductController", value = "/product-detail")
public class ProductController extends HttpServlet {
    private ProductService productService;

    public void init() throws ServletException {
        super.init();
        try {
            ProductDao pd = new ProductDao();
            org.jdbi.v3.core.Jdbi jdbi = pd.get();

            CloudinaryService cloudinary = new CloudinaryService();

            this.productService = new ProductService(jdbi, cloudinary);
        } catch (Exception ex) {
            throw new ServletException("Khởi tạo ProductController thất bại: " + ex.getMessage(), ex);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productService.getProduct(id);
        request.setAttribute("p", product);
        request.getRequestDispatcher("product-information.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}