<%-- 
    Document   : Redirect
    Created on : 29 Dec, 2017, 11:28:11 AM
    Author     : jaspal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String uid="";
                    uid=request.getParameter("id");
                     session.setAttribute("uid",uid);  
    response.sendRedirect("Home.jsp");
                
    %>