<%-- 
    Document   : update
    Created on : 29 Dec, 2017, 8:13:01 AM
    Author     : jaspal
--%>
<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%
    String uid=request.getParameter("id");
    String cat=request.getParameter("cat");
    String fname=request.getParameter("fname");
    String lname=request.getParameter("lname");
    String email=request.getParameter("email");
    String number=request.getParameter("number");
    String password=request.getParameter("pass");
    String age=request.getParameter("age");
    
     try{  
             Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  

            if(cat.equalsIgnoreCase("player"))
            {
                PreparedStatement ps=con.prepareStatement("update users set fname=?,lname=?,email=?,password=?,age=?,number=?,country=?,state=?,city=?,street_address=?  where uid=?");
            ps.setString(1,fname);
            ps.setString(2,lname);
            ps.setString(3,email);
            ps.setString(4,password);
            ps.setString(5,age);
            ps.setString(6,number);
            
                String country=request.getParameter("country");
                String state=request.getParameter("state");
                String city=request.getParameter("city");
                String address=request.getParameter("address");
                ps.setString(7,country);
                ps.setString(8,state);
                ps.setString(9,city);
                ps.setString(10,address);
                ps.setInt(11,Integer.parseInt(uid));
                ps.executeUpdate();
                //out.print(cat+" "+name+" "+email+" "+number+" "+password+" "+age+" "+country+" "+state+" "+city+" "+address);
            }else
            {
                PreparedStatement ps=con.prepareStatement("update users set fname=?,lname=?,email=?,password=?,age=?,number=? where uid=?");
            ps.setString(1,fname);
            ps.setString(2,lname);
            ps.setString(3,email);
            ps.setString(4,password);
            ps.setString(5,age);
            ps.setString(6,number);
            ps.setInt(7,Integer.parseInt(uid));
                
                ps.executeUpdate();
                
            }
            con.close();  

    }catch(Exception e)
    {out.println(e);}
    
    //out.print(cat+name);
%>