<%@ page import="cart.UserManager" %>
<%
    // Get form input parameters
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    // Check for empty or null fields
    if (firstName == null || firstName.isEmpty() || 
        lastName == null || lastName.isEmpty() || 
        email == null || email.isEmpty() || 
        password == null || password.isEmpty() || 
        role == null || role.isEmpty()) {
        
        // Redirect with an error for missing fields
        response.sendRedirect("SignUp.jsp?error=missingFields");
        return;
    }

    // Validate email format based on role
    if (role.equals("admin") && !email.endsWith("@admin.com")) {
        response.sendRedirect("SignUp.jsp?error=invalidAdminEmail");
        return;
    } else if (role.equals("agent") && !email.endsWith("@agent.com")) {
        response.sendRedirect("SignUp.jsp?error=invalidAgentEmail");
        return;
    }

    // Optionally, you could add a password length or strength check here
    if (password.length() < 6) {  // Example of a minimum length validation
        response.sendRedirect("SignUp.jsp?error=weakPassword");
        return;
    }

    // Register user
    if (UserManager.registerUser(firstName, lastName, email, password, role)) {
        session.setAttribute("user", email);
        session.setAttribute("role", role);

        // Redirect based on user role after successful registration
        if (role.equals("user")) {
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("SignIn.jsp?success=1");
        }
    } else {
        // If registration fails due to some issue
        response.sendRedirect("SignUp.jsp?error=registrationFailed");
    }
%>
