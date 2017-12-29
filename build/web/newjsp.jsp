<%-- 
    Document   : newjsp
    Created on : 27 Dec, 2017, 2:42:14 PM
    Author     : jaspal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   String name = request.getParameter("name");
   String age = request.getParameter("age");
   out.println(name + age);
 %>
 