package dao;

import model.user.User;
import org.jdbi.v3.core.Handle;
import java.util.Optional;

public class UserDao extends BaseDao {
    public User findByPhone(String phone) {
        String sql = "SELECT id, full_name, phone_number, email, password_hash, created_at, account_status, role_user, auth_provider, firebase_uid " +
                "FROM Users WHERE phone_number = :phone";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("phone", phone)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }
    public int insert(User user) {
        String sql = "INSERT INTO Users (full_name, phone_number, email, password_hash, role_user, auth_provider, firebase_uid) " +
                "VALUES (:fullName, :phone, :email, :password, :role, :authProvider, :firebaseUID)";
        return get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(user)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(int.class)
                        .one()
        );
    }
    public User findByEmail(String email) {
        String sql = "SELECT id, full_name, phone_number, email, password_hash, created_at, account_status, role_user, auth_provider, firebase_uid " +
                "FROM Users WHERE email = :email";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }
}

