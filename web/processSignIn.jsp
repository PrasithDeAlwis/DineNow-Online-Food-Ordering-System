<%@ page import="cart.UserManager" %>
<%
    // Retrieve email and password from request parameters
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Validate user credentials using the UserManager class
    String role = UserManager.validateUser(email, password);

    if (role != null) {
        // If user is valid, set session attributes for the user and role
        session.setAttribute("user", email);
        session.setAttribute("role", role);

        // Redirect the user based on their role
        if (role.equals("user")) {
            response.sendRedirect("index.jsp");
        } else if (role.equals("admin")) {
            response.sendRedirect("Admin.jsp");
        } else if (role.equals("agent")) {
            response.sendRedirect("Agent.jsp");
        }
    } else {
        // If user is invalid, redirect back to SignIn page with an error message
        response.sendRedirect("SignIn.jsp?error=1");
    }
%>