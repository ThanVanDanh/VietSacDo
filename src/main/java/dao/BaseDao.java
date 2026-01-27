package dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;

/**
 * BaseDao - FIX: Connection closed issue
 *
 * VẤN ĐỀ CŨ:
 * - Mỗi lần gọi get() tạo DataSource mới
 * - Connection bị close ngay sau khi dùng
 *
 * GIẢI PHÁP:
 * - Dùng static JDBI để tái sử dụng
 * - Cấu hình connection properties đúng
 */
public abstract class BaseDao {
    private static Jdbi jdbi; // ✅ Static - tái sử dụng cho tất cả requests

    public Jdbi get() {
        if (jdbi == null) {
            synchronized (BaseDao.class) {
                if (jdbi == null) {
                    connect();
                }
            }
        }
        return jdbi;
    }

    private void connect() {
        try {
            System.out.println("=== Creating Database Connection ===");

            MysqlDataSource ds = new MysqlDataSource();

            // Build connection URL với parameters quan trọng
            String url = String.format(
                    "jdbc:mysql://%s:%s/%s?" +
                            "useSSL=false&" + // Tắt SSL để đơn giản
                            "serverTimezone=Asia/Ho_Chi_Minh&" + // Set timezone to Vietnam
                            "allowPublicKeyRetrieval=true&" + // Cho phép authentication
                            "autoReconnect=true&" + // Tự động reconnect
                            "maxReconnects=3&" + // Số lần retry
                            "initialTimeout=10&" + // Timeout cho reconnect
                            "connectTimeout=30000", // 30s timeout khi connect
                    DBProperties.host,
                    DBProperties.port,
                    DBProperties.dbname);

            System.out.println("Connection URL: " + url);

            ds.setURL(url);
            ds.setUser(DBProperties.username);
            ds.setPassword(DBProperties.password);

            // ✅ Các settings quan trọng
            ds.setUseCompression(true);

            // ✅ Tạo JDBI instance
            jdbi = Jdbi.create(ds);

            System.out.println("✅ JDBI created: " + jdbi);

            // ✅ Test connection ngay
            jdbi.useHandle(handle -> {
                Integer result = handle.createQuery("SELECT 1 as test")
                        .mapTo(Integer.class)
                        .one();
                System.out.println("✅ Connection test result: " + result);
            });

            System.out.println("✅ Database connection ready!");

        } catch (SQLException e) {
            System.err.println("❌ SQL Exception: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database connection failed: " + e.getMessage(), e);
        } catch (Exception e) {
            System.err.println("❌ Exception: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Cannot initialize database: " + e.getMessage(), e);
        }
    }
}