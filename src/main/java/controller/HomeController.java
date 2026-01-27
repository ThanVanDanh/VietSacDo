package controller;

import dao.BannerDao;
import dao.CategoryDao;
import dao.HomeConfigDao;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.banner.Banner;
import model.home.Home;
import model.home.SectionDTO;
import model.home.TabDTO;
import model.product.Category;
import model.product.ProductListDTO;
import services.CloudinaryService;
import services.ProductService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    private ProductService productService;
    private CategoryDao categoryDao;
    private HomeConfigDao homeConfigDao;
    private BannerDao bannerDao;

    @Override
    public void init() throws ServletException {
        try {
            this.productService = new ProductService(new ProductDao().get(), new CloudinaryService());
            this.categoryDao = new CategoryDao();
            this.homeConfigDao = new HomeConfigDao();
            this.bannerDao = new BannerDao();
        } catch (Exception ex) {
            System.err.println(" Failed to initialize HomeController: " + ex.getMessage());
            ex.printStackTrace();
            throw new ServletException("Cannot initialize HomeController", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            List<Banner> banners = bannerDao.getActiveBanners();
            req.setAttribute("banners", banners);

            // Load các section động từ database
            List<SectionDTO> dynamicSections = loadDynamicSections();
            req.setAttribute("dynamicSections", dynamicSections);

            req.getRequestDispatcher("/index.jsp").forward(req, resp);

        } catch (Exception e) {
            System.err.println(" Error in HomeController: " + e.getMessage());
            e.printStackTrace();
            
            // Set empty data để tránh lỗi JSP
            req.setAttribute("banners", new ArrayList<Banner>());
            req.setAttribute("dynamicSections", new ArrayList<SectionDTO>());
            
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }

    private List<SectionDTO> loadDynamicSections() {
        // Danh sách các section key cần hiển thị
        String[] sectionKeys = {"section_1", "section_2", "summer_collection"};
        List<SectionDTO> sections = new ArrayList<>();

        for (String key : sectionKeys) {
            try {
                SectionDTO section = loadSection(key);
                if (section != null && section.title != null && !section.tabs.isEmpty()) {
                    sections.add(section);
                    System.out.println(" Loaded section: " + key + " with " + section.tabs.size() + " tabs");
                } else {
                    System.out.println(" Skipped section: " + key + " (no data)");
                }
            } catch (Exception e) {
                System.err.println("Error loading section " + key + ": " + e.getMessage());
            }
        }

        return sections;
    }

    private SectionDTO loadSection(String sectionKey) {
        // Lấy title và tabs từ database
        String title = homeConfigDao.getSectionTitle(sectionKey);
        List<Home> dbTabs = homeConfigDao.getSectionTabs(sectionKey);

        if (title == null || dbTabs == null || dbTabs.isEmpty()) {
            return null;
        }

        // Tạo DTO
        SectionDTO section = new SectionDTO();
        section.key = sectionKey;
        section.title = title;

        // Load products cho từng tab
        for (Home homeTab : dbTabs) {
            Category category = categoryDao.getById(homeTab.getCategoryId());
            if (category == null) {
                System.err.println("Category not found: " + homeTab.getCategoryId());
                continue;
            }

            TabDTO tab = new TabDTO();
            tab.index = homeTab.getPosition();
            tab.title = category.getNameCategory();
            
            // Lấy products theo category
            List<ProductListDTO> products = productService.getProductsByCategory(category.getId());
            
            // Limit 5 sản phẩm mỗi tab
            tab.products = products.size() > 5 ? products.subList(0, 5) : products;
            
            section.tabs.add(tab);
            System.out.println(" Tab " + tab.index + ": " + tab.title + " (" + tab.products.size() + " products)");
        }

        return section;
    }
}
