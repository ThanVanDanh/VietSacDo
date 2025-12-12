package model.product;

import model.AId;

public class Category extends AId {
    private String name_category;
    private String slug;
    private String description;
    private int parentId;

    public Category(int id) {
        super(id);
    }
    public Category() {}

    public Category(int id, String name_category, String slug, String description, int parentId) {
        super(id);
        this.name_category = name_category;
        this.slug = slug;
        this.description = description;
        this.parentId = parentId;
    }

    public String getName_category() {
        return name_category;
    }

    public void setName_category(String name_category) {
        this.name_category = name_category;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
}
