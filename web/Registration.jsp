<%-- 
    Document   : Registration
    Created on : 28 Dec, 2017, 4:47:08 PM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%
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

      Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("select * from users where email='"+email+"'");
            if(rs.next())
            {
            out.print("User already Exists!!!\n Please choose a different Email-Id");
            }
            else
            {
                PreparedStatement ps=con.prepareStatement("insert into users(fname,lname,email,password,age,number,profile,country,state,city,street_address,authentic) values(?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1,fname);
            ps.setString(2,lname);
            ps.setString(3,email);
            ps.setString(4,password);
            ps.setString(5,age);
            ps.setString(6,number);
            ps.setString(7,cat);
            ps.setString(12,"yes");
            
            if(cat.equalsIgnoreCase("player"))
            {
                String country=request.getParameter("country");
                String state=request.getParameter("state");
                String city=request.getParameter("city");
                String address=request.getParameter("address");
                ps.setString(8,country);
                ps.setString(9,state);
                ps.setString(10,city);
                ps.setString(11,address);
                
                //out.print(cat+" "+name+" "+email+" "+number+" "+password+" "+age+" "+country+" "+state+" "+city+" "+address);
            }else
            {
                ps.setString(8,null);
                ps.setString(9,null);
                ps.setString(10,null);
                ps.setString(11,null);
                
            }
            ps.executeUpdate();
            out.print("Registration Successful!!!\nPlease Login to continue to your profile");
            }
            con.close();  

    }catch(Exception e)
    {out.println(e);}
    
    //out.print(cat+name);
%>