package model.product;

public class ProductImage {
    private int id;
    private int productId;
    private String imageUrl;
    private String altText;
    private boolean isThumbnail;

    public ProductImage() {}

    public ProductImage(int id, int productId, String imageUrl, String altText, boolean isThumbnail) {
        this.id = id;
        this.productId = productId;
        this.imageUrl = imageUrl;
        this.altText = altText;
        this.isThumbnail = isThumbnail;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAltText() {
        return altText;
    }

    public void setAltText(String altText) {
        this.altText = altText;
    }

    public boolean isThumbnail() {
        return isThumbnail;
    }

    public void setThumbnail(boolean thumbnail) {
        isThumbnail = thumbnail;
    }
}
