<%@ page import="java.sql.*, classes.DbConnector" %>
<%
    String role = request.getParameter("role");
%>

<form action="addUserAction.jsp" method="post">
    <input type="text" name="firstName" placeholder="First Name">
    <input type="text" name="lastName" placeholder="Last Name">
    <input type="email" name="email" placeholder="Email">
    <input type="password" name="password" placeholder="Password">
    <select name="role">
        <option value="Customer">Customer</option>
        <option value="Agent">Agent</option>
        <option value="Admin">Admin</option>
    </select>
    <button type="submit">Add User</button>
</form>