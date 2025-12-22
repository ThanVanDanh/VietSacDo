package model.contact;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class ContactUs {
    @ColumnName("full_name")
    private String fullName;
    private String email;
    @ColumnName("message_body")
    private String messageBody;
    @ColumnName("received_at")
    private LocalDateTime receivedAt;
    @ColumnName("status_message")
    private String statusMessage;

    public ContactUs(String fullName, String email, String messageBody) {
        this.fullName = fullName;
        this.email = email;
        this.messageBody = messageBody;

    }

    public ContactUs() {
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessageBody() {
        return messageBody;
    }

    public void setMessageBody(String messageBody) {
        this.messageBody = messageBody;
    }
}
