package dao;

import model.contact.ContactUs;

public class ContactDao extends BaseDao {
    public int insert(ContactUs contact) {
        String sql = "INSERT INTO Contact_messages (full_name, email, message_body) VALUES (:fullName, :email, :messageBody)";

            return get().withHandle(handle ->
                    handle.createUpdate(sql)
                            .bindBean(contact)
                            .execute()
            );
        }
    }

