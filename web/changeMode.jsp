<%-- 
    Document   : changeMode
    Created on : 29 Dec, 2017, 10:34:48 AM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%
       String mode=request.getParameter("mode");
    String uid=request.getParameter("id");
        //out.print(email+pass+cat);
    try{  
    Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  
    PreparedStatement ps=con.prepareStatement("update users set authentic='"+mode+"' where uid="+uid);
ps.executeUpdate();
con.close();  

    }catch(Exception e)
    {out.println(e);}    

    %>