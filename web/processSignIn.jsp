<%@ page import="cart.UserManager" %>
<%@ page import="java.util.Map" %>
<%
    // Retrieve email and password from request parameters
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Validate user credentials using the UserManager class
    Map<String, String> userDetails = UserManager.validateUser(email, password);

    if (userDetails != null) {
        // If user is valid, set session attributes for the user, role, and userId
        session.setAttribute("user", email);
        session.setAttribute("role", userDetails.get("role"));

        // Convert userId to Integer and store it in the session
        int userId = Integer.parseInt(userDetails.get("userId"));
        session.setAttribute("userId", userId);

        // Redirect the user based on their role
        String role = userDetails.get("role");
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