package controller.Cart;

import dao.ProductDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.cart.Cart;
import model.product.Product;
import model.product.ProductVariant;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartController", value = "/cart")
public class CartController extends HttpServlet {
    private ProductService productService;
    public void init() throws ServletException {
        super.init();
        try {
            ProductDao pd = new ProductDao();
            org.jdbi.v3.core.Jdbi jdbi = pd.get();
            CloudinaryService cloudinary = new CloudinaryService();
            this.productService = new ProductService(jdbi, cloudinary);
        } catch (Exception ex) {
            throw new ServletException(" " + ex.getMessage(), ex);
        }
    }

        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            String action = request.getParameter("action");

            if (action != null && action.equals("remove")) {
                removeFromCart(request, response);
            } else {
                request.getRequestDispatcher("/cart.jsp").forward(request, response);
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action != null && action.equals("add")) {
            addToCart(request, response);
        } else if (action != null && action.equals("update")) {
            updateCart(request, response);
        } else if (action != null && action.equals("remove")) {
            removeFromCart(request, response);
        }

    }
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            Product product = productService.getProduct(productId);

            if (product != null) {
                String sku = request.getParameter("sku");
                if (sku == null) sku = "";
                String size = request.getParameter("size");
                if (size == null) size = "";
                double price =0;
                if (price == 0) {
                    List<ProductVariant> variants = product.getVariants();
                    if (variants != null) {
                        for (ProductVariant v : variants) {

                            if ((!sku.isEmpty() && sku.equals(v.getSku())) ||
                                    (!size.isEmpty() && size.equals(v.getSize()))) {
                                price = v.getCurrentPrice();
                                break;
                            }
                        }
                        if (price == 0 && !variants.isEmpty()) price = variants.get(0).getCurrentPrice();
                    }
                }

                cart.addItem(product, quantity, price, sku, size);
            }

            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String sku = request.getParameter("sku");

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null) {
                cart.updateQuantity(productId, sku, quantity);
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idParam = request.getParameter("id");
            String sku = request.getParameter("sku");



            if (sku == null) sku = "";

            if (idParam != null) {
                int productId = Integer.parseInt(idParam);
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");

                if (cart != null) {

                    cart.remove(productId, sku);
                    session.setAttribute("cart", cart);
                    System.out.println(" Called cart.remove()");
                } else {
                    System.out.println(" Cart is NULL in Session");
                }
            }

            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : (request.getContextPath() + "/cart"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }



}