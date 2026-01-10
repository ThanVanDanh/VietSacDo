package model.voucher;

import model.AId;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Voucher extends AId implements Serializable {
    @ColumnName("voucher_code")
    private String voucherCode;
    @ColumnName("discount_type")
    private String discountType; // "percentage" hoặc "fixed"
    @ColumnName("discount_value")
    private double discountValue;
    @ColumnName("min_order_amount")
    private double minOrderAmount;
    @ColumnName("max_usage")
    private int maxUsage;
    @ColumnName("current_usage")
    private int currentUsage;
    @ColumnName("valid_from")
    private LocalDateTime validFrom;
    @ColumnName("valid_to")
    private LocalDateTime validTo;
    @ColumnName("is_active")
    private boolean isActive;
    @ColumnName("created_at")
    private LocalDateTime createdAt;

    public Voucher() {
    }

    public Voucher(int id) {
        super(id);
    }

    public Voucher(int id, LocalDateTime createdAt, boolean isActive, LocalDateTime validTo, LocalDateTime validFrom, int currentUsage, int maxUsage, double minOrderAmount, double discountValue, String discountType, String voucherCode) {
        super(id);
        this.createdAt = createdAt;
        this.isActive = isActive;
        this.validTo = validTo;
        this.validFrom = validFrom;
        this.currentUsage = currentUsage;
        this.maxUsage = maxUsage;
        this.minOrderAmount = minOrderAmount;
        this.discountValue = discountValue;
        this.discountType = discountType;
        this.voucherCode = voucherCode;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public double getMinOrderAmount() {
        return minOrderAmount;
    }

    public void setMinOrderAmount(double minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
    }

    public int getMaxUsage() {
        return maxUsage;
    }

    public void setMaxUsage(int maxUsage) {
        this.maxUsage = maxUsage;
    }

    public int getCurrentUsage() {
        return currentUsage;
    }

    public void setCurrentUsage(int currentUsage) {
        this.currentUsage = currentUsage;
    }

    public LocalDateTime getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(LocalDateTime validFrom) {
        this.validFrom = validFrom;
    }

    public LocalDateTime getValidTo() {
        return validTo;
    }

    public void setValidTo(LocalDateTime validTo) {
        this.validTo = validTo;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + id +
                ", voucherCode='" + voucherCode + '\'' +
                ", discountType='" + discountType + '\'' +
                ", discountValue=" + discountValue +
                ", validFrom=" + validFrom +
                ", validTo=" + validTo +
                ", isActive=" + isActive +
                '}';
    }
}