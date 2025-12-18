package services;

import dao.CategoryDao;
import model.product.Category;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.Objects;

public class CategoryService {
    private final CategoryDao categoryDao;
    private final Jdbi jdbi;

    public CategoryService(Jdbi jdbi) {
        this.jdbi = Objects.requireNonNull(jdbi);
        ;
        this.categoryDao = new CategoryDao();
    }

    public List<Category> getAllCategories() {
        return categoryDao.getAll();
    }

    public int createCategory(Category cat) {
        // validation cơ bản
        if (cat == null) return -1;
        if (cat.getNameCategory() == null || cat.getNameCategory().trim().isEmpty()) return -1;

        // nếu slug null/empty => tạo tự động
        String slug = cat.getSlug();
        if (slug == null || slug.trim().isEmpty()) {
            slug = slugify(cat.getNameCategory());
            cat.setSlug(slug);
        }

        // nếu slug đã tồn tại, cố gắng thêm hậu tố để tránh duplicate
        int attempt = 0;
        String baseSlug = slug;
        while (categoryDao.existsBySlug(cat.getSlug()) && attempt < 10) {
            attempt++;
            cat.setSlug(baseSlug + "-" + attempt);
        }
        if (categoryDao.existsBySlug(cat.getSlug())) {
            // vẫn trùng sau nhiều lần
            return -2; // mã lỗi slug duplicate
        }
        return categoryDao.insert(cat);
    }

    private String slugify(String text) {
        if (text == null) return "";
        String s = text.toLowerCase().trim();
        // Loại bỏ dấu (basic)
        s = java.text.Normalizer.normalize(s, java.text.Normalizer.Form.NFD)
                .replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        s = s.replaceAll("đ", "d");
        s = s.replaceAll("[^a-z0-9\\s-]", "");
        s = s.replaceAll("\\s+", "-");
        s = s.replaceAll("-{2,}", "-");
        return s;
    }

    public Category getCategoryById(int id) {
        return categoryDao.getById(id);
    }

    public boolean updateCategory(Category category) {
        return categoryDao.update(category);
    }

    public boolean deleteCategory(int id) {
        return categoryDao.delete(id);
    }


    public int countChildCategories(int categoryId) {
        return categoryDao.countChildCategories(categoryId);
    }

    public int countProducts(int categoryId) {
        return categoryDao.countProducts(categoryId);
    }
}

