<%@ page import="cart.UserManager" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    
    if (UserManager.validateUser(email, password)) {
        session.setAttribute("user", email);
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("SignIn.jsp?error=1");
    }
%>
