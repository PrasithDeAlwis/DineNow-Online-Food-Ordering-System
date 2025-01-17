<%@ page import="cart.UserManager" %>
<%
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (UserManager.registerUser(firstName, lastName, email, password)) {
        session.setAttribute("user", email);
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("SignUp.jsp?error=1");
    }
%>
