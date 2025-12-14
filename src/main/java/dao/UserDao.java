package dao;

import model.user.User;
import org.jdbi.v3.core.Handle;
import java.util.Optional;

public class UserDao extends BaseDao {
    public User findByPhone(String phone) {
        return get().withHandle(handle -> handle.createQuery("SELECT * FROM Users WHERE phone_number = :phone").bind("phone", phone)
                    .mapToBean(User.class).stream().findFirst().orElse(null));
    }
    public User findByEmail(String email) {
        return get().withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE email = :email")
                        .bind("email", email)
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
    public boolean updatePassword(String email, String newPasswordHash) {
        return get().withHandle(handle ->
                handle.createUpdate("UPDATE Users SET password_hash = :password WHERE email = :email")
                        .bind("password", newPasswordHash)
                        .bind("email", email)
                        .execute() > 0
        );
    }

}

