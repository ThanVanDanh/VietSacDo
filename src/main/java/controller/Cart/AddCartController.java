package controller.Cart;

import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.cart.Cart;
import model.product.Product;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;

@WebServlet(name = "AddCartController", value = "/add-cart")
public class AddCartController extends HttpServlet {
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
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");
        if (productId == null || quantity == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        try {
            int proId = Integer.parseInt(productId);
            int quantityInt = Integer.parseInt(quantity);
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
            }
            Product product = productService.getProduct(proId);
            if (product != null) {

                double price = productService.getPriceById(proId);

                cart.addItem(product, quantityInt, price);
                session.setAttribute("cart", cart);
            }
            response.sendRedirect("cart.jsp");


        }catch (Exception e){}



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}