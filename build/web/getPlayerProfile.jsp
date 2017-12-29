<%-- 
    Document   : getPlayerProfile
    Created on : 29 Dec, 2017, 9:34:26 AM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%! String uid="",cat,fname,lname,email,pass,number,age,country,state,city,address,authentic,countryname,statename,cityname;%>
<!DOCTYPE html >
<html>
<head>
    <title>Gaming Adda</title>
         <meta name="viewport" content="width=device-width, initial-scale=1">
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  

<script type="text/javascript">
     function ValidateFName(txt) {
    txt.value = txt.value.replace(/[^a-zA-Z- '\n\r.]+/g, '');
    document.getElementById("fchkname").style.borderColor="green";   
    
}
    function isNumber(evt,num) {
        
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    var str = num + String.fromCharCode(charCode);
    
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    else
    return true;
    }
    $(document).ready(function(){
    $.ajax({
			url : 'getCountry.jsp',
			
			success : function(responseText) {
                            //alert(responseText);
				$('#countryIdd').append(responseText);
			}
		});
                $.ajax({
			url : 'getState.jsp',
                        async : false,
                        data : {
				ccode : $("#countryIdd").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#stateIdd').append(responseText);
			}
		});
                $.ajax({
			url : 'getCity.jsp',
                        async : false,
                        data : {
				scode : $("#stateIdd").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#cityIdd').append(responseText);
			}
		});
           
            
          $("#countryIdd").change(function(){
                $.ajax({
			url : 'getState.jsp',
                        data : {
				ccode : $("#countryIdd").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#stateIdd').html(responseText);
			}
		});
            
        });
        $("#stateIdd").change(function(){
                $.ajax({
			url : 'getCity.jsp',
                        data : {
				scode : $("#stateIdd").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#cityIdd').html(responseText);
			}
		});
            
        });
          
        $(".restrict").click(function(){
            if($(".restrict").hasClass("btn-success"))
            {
              var mode="no"; 
              $(".restrict").removeClass("btn-success");
              $(".restrict").addClass("btn-danger");
              $(".restrict").text("The user is Restriced fro Login Now");
            }
            else
            {
                var mode="yes";
                $(".restrict").removeClass("btn-danger");
                $(".restrict").addClass("btn-success");
                $(".restrict").text("Click to Restrict Account");
            }
            $.ajax({
			url : 'changeMode.jsp',
                        data :{
                            id: $("#iddd").val(),
                            mode : mode
                        },
                         async : false,
                        success : function(responseText) {
                            //alert(responseText);
				
			}
		});
        });
        
        });
                
    
</script>
</head>


<%
   try{
             uid=request.getParameter("id");
             
        }catch(Exception e)
        {
            
        }
    try{  
    Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  
    Statement stmt=con.createStatement();
ResultSet rs=stmt.executeQuery("select * from users where  uid="+uid);  
while(rs.next())
{
    cat=rs.getString(8);
fname=rs.getString(2);
lname=rs.getString(3);
email=rs.getString(4);
pass=rs.getString(5);
number=rs.getString(7);
age=rs.getString(6);
country=rs.getString(9);
state=rs.getString(10);
city=rs.getString(11);
address=rs.getString(12);
authentic=rs.getString(13);
}
PreparedStatement ps=con.prepareStatement("SELECT countries.name,states.name,cities.name from countries,states,cities where states.country_id=countries.id and states.id=cities.state_id and countries.id=? and states.id=? and cities.id=?");
ps.setInt(1,Integer.parseInt(country));
ps.setInt(2,Integer.parseInt(state));
ps.setInt(3,Integer.parseInt(city));
ResultSet rs1=ps.executeQuery();
while(rs1.next())
{
    countryname=rs1.getString(1);
    statename=rs1.getString(2);
    cityname=rs1.getString(3);
    
}
con.close();  

    }catch(Exception e)
    {out.println(e);}    
    %>
    
         <!-- Trigger the modal with a button -->

<!-- Modal -->
<input type="hidden" id="iddd" value="<%=uid%>"/>
               <div class="form-group">
    <label for="regulate">Restrict Account : </label>
    <%
        if(authentic.equalsIgnoreCase("no"))
        {
            out.print("<button class='btn btn-danger restrict'>The user is Restriced fro Login Now</button>");
        }
        else
        {
            out.print("<button class='btn btn-success restrict'>Click to Restrict Account</button>");
        }
    %>
    
  </div>
    
        
      <div class="form-group ">
    <label for="first-name">First Name:</label>
    <input type="text" class="form-control" onkeyup="ValidateFName(this)" placeholder="Enter First Name here" id="fnamee" name="fname" required value="<%=fname%>">
  </div>
  <div class="form-group ">
    <label for="last-name">Last Name:</label>
    <input type="text" class="form-control" onkeyup="ValidateFName(this)" placeholder="Enter Last Name here" id="lnamee" name="lname" required value="<%=lname%>">
  </div>
  <div class="form-group ">
    <label for="email">Email address:</label>
    <input type="email" class="form-control" placeholder="Enter Email id here" id="emailidd" required value="<%=email%>">
   
  </div>
  <div class="form-group">
    <label for="pwd">Password:</label>
    <input type="text" class="form-control" placeholder="Enter password here" id="passs" required value="<%=pass%>">
  </div>
  <div class="form-group ">
    <label for="age">Age:</label>
    <input type="text" class="form-control" onkeypress='return isNumber(event,this.value)' placeholder="Enter Age here" id="agee" required value="<%=age%>">
  </div>
  <div class="form-group ">
    <label for="phone">Mobile Number:</label>
    <input type="text" class="form-control" placeholder="Enter Mobile Number here" onkeypress='return isNumber(event,this.value)' id="numberr" required value="<%=number%>">
  </div>
    <%
        out.print("<div id='player-special' >");
      out.print("<div class='form-group'>");
      out.print("<label for='Address'>Select Country:</label>");
      out.print("<select name='country' class='form-control countries' id='countryIdd' required='required'>");
      out.print("<option  value="+country+">"+countryname+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group'>");
      out.print("<label for='Address'>Select State:</label>");
      out.print("<select name='state' class='form-control states' id='stateIdd' required='required'>");
      out.print("<option value="+state+">"+statename+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group'> ");
      out.print("<label for='Address'>Select City:</label>");
      out.print(" <select name='city' class='form-control cities' id='cityIdd' required='required'>");
      out.print("<option value="+city+">"+cityname+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group '>");
      out.print("<label for='Address'>Enter Street Address:</label>");
      out.print("<textarea required type='text' class='form-control' placeholder='Enter Address here' id='addresss' height='3'>"+address+"</textarea>");
      out.print("</div>");
      out.print("</div>");
      
        %>
        
      