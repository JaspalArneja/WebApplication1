<%-- 
    Document   : checkUser
    Created on : 28 Dec, 2017, 2:14:45 PM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email=request.getParameter("email");
    String pass=request.getParameter("pass");
    String cat=request.getParameter("cat");
    
        //out.print(email+pass+cat);
    try{
        Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  

Statement stmt=con.createStatement();  
ResultSet rs=stmt.executeQuery("select * from users where email='"+email+"' and password='"+pass+"' and profile='"+cat+"' and authentic='yes'");  
if(rs.next())  
out.print(rs.getInt(1));
else
out.print("not found");

con.close();  

    }catch(Exception e)
    {out.println(e);}    
%>