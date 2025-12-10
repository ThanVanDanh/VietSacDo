package services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.Map;

public class CloudinaryService {

    private Cloudinary cloudinary;

    public CloudinaryService() {
        Properties prop = new Properties();
        // Đọc file properties từ thư mục resources
        try (InputStream input = CloudinaryService.class.getClassLoader().getResourceAsStream("cloudinary.properties")) {

            if (input == null) {
                System.out.println("Xin lỗi, không tìm thấy file cloudinary.properties");
                return;
            }

            // Load dữ liệu từ file vào biến prop
            prop.load(input);

            // Lấy thông tin từ file properties
            String cloudName = prop.getProperty("cloud_name");
            String apiKey = prop.getProperty("api_key");
            String apiSecret = prop.getProperty("api_secret");

            // Khởi tạo Cloudinary với thông tin vừa đọc được
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", cloudName,
                    "api_key", apiKey,
                    "api_secret", apiSecret,
                    "secure", true));

        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public String uploadImage(String filePath) {
        if (cloudinary == null) return null; // Kiểm tra an toàn

        try {
            java.io.File file = new java.io.File(filePath);
            Map uploadResult = cloudinary.uploader().upload(file, ObjectUtils.emptyMap());
            return (String) uploadResult.get("secure_url");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}