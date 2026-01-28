package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.user.User;
import java.io.IOException;

@WebFilter(filterName = "AdminAuthenticationFilter", urlPatterns = { "/admin/*" })
public class AdminAuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("account") != null);
        boolean isAdmin = false;

        if (isLoggedIn) {
            User user = (User) session.getAttribute("account");
            if ("admin".equals(user.getRole())) {
                isAdmin = true;
            }
        }

        if (isLoggedIn && isAdmin) {
            // User is logged in and is an admin, allow request to proceed
            chain.doFilter(request, response);
        } else {
            // User is not authorized, redirect to login page
            // Save the requested URL to redirect back after login (optional, but good UX)
            // For security, just redirect to login for now
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
