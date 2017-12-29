<%-- 
    Document   : logout.jsp
    Created on : 29 Dec, 2017, 11:19:22 AM
    Author     : jaspal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
     session.setAttribute("uid",null);  
            response.sendRedirect("index.html");
    %>