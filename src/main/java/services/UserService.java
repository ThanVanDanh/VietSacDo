package services;

import dao.UserDao;
import model.user.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {
    private final UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserService() {
        this.userDao = new UserDao();
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public User login(String phone, String password) {
        User user = userDao.findByPhone(phone);
        if (user == null) {
            return null;
        }
        if (user.getPassword() != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public boolean register(String name, String phone, String email, String password) {
        if (userDao.findByEmail(email) != null || userDao.findByPhone(phone) != null) {
            return false;
        }
        User user = new User();
        user.setFullName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt(12)));
        user.setRole("user");
        user.setAuthProvider("local");
        return userDao.insert(user) > 0;
    }


}