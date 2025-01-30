<%-- 
    Document   : Logout
    Created on : Jan 29, 2025, 3:52:03 PM
    Author     : Geethaka
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("SignIn.jsp");
%>
