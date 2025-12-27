package controller.admin.contact;

import dao.ContactDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteContactController", value = "/DeleteContactController")
public class DeleteContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id")); // Lấy ID từ Form
            ContactDao dao = new ContactDao();
            dao.delete(id);

            // LƯU Ý: Dùng Session để thông báo sau khi chuyển trang
            request.getSession().setAttribute("message", "Đã xóa thành công!");
            request.getSession().setAttribute("messageType", "success");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Xóa thất bại!");
            request.getSession().setAttribute("messageType", "error");
        }

        // QUAN TRỌNG: Chuyển hướng quay lại trang danh sách
        response.sendRedirect(request.getContextPath() + "/admin/contact-list");

    }
}