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
}