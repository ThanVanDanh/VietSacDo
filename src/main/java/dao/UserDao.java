package dao;

import java.util.List;

import model.user.User;

public class UserDao extends BaseDao {
    public User findByEmailOrPhone(String key) {
        return get().withHandle(handle -> handle
                .createQuery("SELECT * FROM Users WHERE email = :key OR phone_number = :key").bind("key", key)
                .mapToBean(User.class).stream().findFirst().orElse(null));
    }

    public User findByEmail(String email) {
        return get().withHandle(handle -> handle.createQuery("SELECT * FROM Users WHERE email = :email")
                .bind("email", email)
                .mapToBean(User.class)
                .findFirst()
                .orElse(null));
    }

    public User findByPhone(String phone) {
        return get().withHandle(handle -> handle.createQuery("SELECT * FROM Users WHERE phone_number = :phone")
                .bind("phone", phone)
                .mapToBean(User.class)
                .findFirst()
                .orElse(null));
    }

    public int insert(User user) {
        String sql = "INSERT INTO Users (full_name, phone_number, email, password_hash, role_user, auth_provider, firebase_uid, account_status, verify_token) "
                +
                "VALUES (:fullName, :phone, :email, :password, :role, :authProvider, :firebaseUID, :status, :verifyToken)";
        return get().withHandle(handle -> handle.createUpdate(sql)
                .bindBean(user)
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one());
    }

    public boolean updatePassword(String email, String newPasswordHash) {
        return get().withHandle(
                handle -> handle.createUpdate("UPDATE Users SET password_hash = :password WHERE email = :email")
                        .bind("password", newPasswordHash)
                        .bind("email", email)
                        .execute() > 0);
    }

    public boolean activateUser(String token) {
        return get().withHandle(handle -> handle
                .createUpdate(
                        "UPDATE Users SET account_status = 'active', verify_token = NULL WHERE verify_token = :token")
                .bind("token", token)
                .execute() > 0);
    }

    public List<User> findAll() {
        return get().withHandle(handle -> handle.createQuery("SELECT * FROM Users")
                .mapToBean(User.class)
                .list());
    }

    public void updateRole(int userId, String role) {
        get().useHandle(handle -> {
            handle.createUpdate("UPDATE Users SET role_user = :role WHERE id = :id")
                    .bind("role", role)
                    .bind("id", userId)
                    .execute();
        });
    }

    // Đếm tổng số khách hàng
    public int countAll() {
        return get().withHandle(handle -> handle.createQuery("SELECT COUNT(*) FROM Users")
                .mapTo(int.class)
                .one());
    }

    // Đếm số khách mới trong tuần
    public int countNewThisWeek() {
        return get().withHandle(handle -> handle
                .createQuery("SELECT COUNT(*) FROM Users WHERE YEARWEEK(created_at, 1) = YEARWEEK(CURDATE(), 1)")
                .mapTo(int.class)
                .one());
    }

    public boolean updateStatus(int userId, String status) {
        return get().withHandle(handle -> {
            return handle.createUpdate("UPDATE Users SET account_status = :status WHERE id = :id")
                    .bind("status", status)
                    .bind("id", userId)
                    .execute() > 0;
        });
    }

    public boolean delete(int userId) {
        return get().withHandle(handle -> handle.createUpdate("DELETE FROM Users WHERE id = :id")
                .bind("id", userId)
                .execute() > 0);
    }

    public List<User> getNewCustomers(int limit) {
        return get()
                .withHandle(handle -> handle.createQuery("SELECT * FROM Users ORDER BY created_at DESC LIMIT :limit")
                        .bind("limit", limit)
                        .mapToBean(User.class)
                        .list());
    }
}
