package controller.admin.contact;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ReplyContactController", value = "/ReplyContactController")
public class ReplyContactController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String toEmail = request.getParameter("email");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        System.out.println("Gửi email tới: " + toEmail);
        System.out.println("Nội dung: " + content);

        request.getSession().setAttribute("message", "Đã gửi email phản hồi!");
        request.getSession().setAttribute("messageType", "success");

        response.sendRedirect(request.getContextPath() + "/contactus-admin");

    }
}