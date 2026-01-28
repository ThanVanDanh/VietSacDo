package services;

import dao.PolicyDao;
import model.policy.Policy;
import org.jdbi.v3.core.Jdbi;

import java.util.List;
import java.util.Objects;

public class PolicyService {
    private final PolicyDao policyDao;
    private final Jdbi jdbi;

    public PolicyService(Jdbi jdbi) {
        this.jdbi = Objects.requireNonNull(jdbi);
        this.policyDao = new PolicyDao();
    }

    /**
     * Lấy tất cả policies
     */
    public List<Policy> getAllPolicies() {
        return policyDao.getAll();
    }

    /**
     * Lấy policy theo ID
     */
    public Policy getPolicyById(int id) {
        return policyDao.getById(id);
    }

    /**
     * Lấy policy theo category_id
     */
    public Policy getPolicyByCategoryId(int categoryId) {
        return policyDao.getByCategoryId(categoryId);
    }

    /**
     * Tạo policy mới
     * @return ID của policy mới, -1 nếu thất bại, -2 nếu category_id đã có policy
     */
    public int createPolicy(Policy policy) {
        if (policy == null) return -1;
        if (policy.getCategoryId() <= 0) return -1;
        if (policy.getPolicyText() == null || policy.getPolicyText().trim().isEmpty()) return -1;

        // Kiểm tra category_id đã có policy chưa (UNIQUE constraint)
        if (policyDao.existsByCategoryId(policy.getCategoryId())) {
            return -2; // category_id đã có policy
        }

        return policyDao.insert(policy);
    }

    /**
     * Cập nhật policy
     */
    public boolean updatePolicy(Policy policy) {
        if (policy == null || policy.getId() <= 0) return false;
        if (policy.getCategoryId() <= 0) return false;
        if (policy.getPolicyText() == null || policy.getPolicyText().trim().isEmpty()) return false;

        // Kiểm tra policy có tồn tại
        if (!policyDao.exists(policy.getId())) {
            return false;
        }

        // Kiểm tra nếu thay đổi category_id, category mới không được có policy khác
        Policy existing = policyDao.getById(policy.getId());
        if (existing.getCategoryId() != policy.getCategoryId()) {
            // Đang đổi category_id
            Policy conflictPolicy = policyDao.getByCategoryId(policy.getCategoryId());
            if (conflictPolicy != null && conflictPolicy.getId() != policy.getId()) {
                return false; // category_id mới đã có policy khác
            }
        }

        return policyDao.update(policy);
    }

    /**
     * Xóa policy theo ID
     */
    public boolean deletePolicy(int id) {
        if (id <= 0) return false;
        if (!policyDao.exists(id)) return false;
        return policyDao.delete(id);
    }

    /**
     * Xóa policy theo category_id
     */
    public boolean deletePolicyByCategoryId(int categoryId) {
        if (categoryId <= 0) return false;
        return policyDao.deleteByCategoryId(categoryId);
    }
}
