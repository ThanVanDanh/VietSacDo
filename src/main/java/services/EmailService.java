package services;

import model.user.User;

import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailService {
    public String sendEmail(User user) {
        String to = user.getEmail();
        String from = "minhthu12575@gmail.com";
        String password = "vaqq ffcq regn hgpb";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        String otp = String.format("%06d", number);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Việt Sắc Đỏ - Mã xác nhận khôi phục mật khẩu");
            message.setText("Mã OTP của bạn là: " + otp + "\nMã này sẽ hết hạn trong 5 phút.");

            Transport.send(message);
            return otp;
        } catch (MessagingException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void sendVerifyLink(String toEmail, String token, String domain) {
        String from = "minhthu12575@gmail.com";
        String password = "vaqq ffcq regn hgpb";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Việt Sắc Đỏ - Kích hoạt tài khoản");

            // Tạo link: ví dụ http://localhost:8080/VietSacDo/verify-account?token=xyz...
            String link = domain + "/verify-account?token=" + token;

            String htmlContent = "<h3>Chào mừng đến với Việt Sắc Đỏ!</h3>"
                    + "<p>Vui lòng nhấn vào đường dẫn bên dưới để kích hoạt tài khoản của bạn:</p>"
                    + "<a href='" + link + "'>Kích hoạt tài khoản ngay</a>"
                    + "<p>Link này chỉ có hiệu lực một lần.</p>";

            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}