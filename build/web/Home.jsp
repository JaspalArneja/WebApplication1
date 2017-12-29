<%-- 
    Document   : Home.jsp
    Created on : 28 Dec, 2017, 4:34:26 PM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<%! String uid="",cat="",fname="",lname="",email="",pass="",number="",age="",country="",state="",city="",address="",countryname="",statename="",cityname="";%>
<!DOCTYPE html >
<html>
<head>
    <title>Gaming Adda</title>
         <meta name="viewport" content="width=device-width, initial-scale=1">
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<style>
    body{
        margin: 0;
        
    }
    .heading
    {
        background-color:   #6dd3d2;
        margin-left: 0;
        margin-right: 0;
        margin-top: 20px;
        height: auto;
        width: available;
        color: white;
        padding-top: 20px;
        padding-bottom: 40px;
    }
    .player-profile{
        border:  solid;
        border-top-color: #8ce9de;
        border-left-color: #8ce9de;
        border-right-color: #8ce9de;
        border-bottom-color:   #8ce9de;
        width: available;
        height: auto;
        padding-bottom: 20px;
        
    }
    .content{
        margin-top: 20px;
    }
    .option{
        height: 50px;
        width: 200px;
    }
</style>
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
        $("#playerlist").click(function(){
            $(".profile-div").hide(); 
            $(".list-div").show(); 
            $("#playerlist").addClass("btn-primary");
            $("#profile").removeClass("btn-primary");
            $("#profile").addClass("btn-default");
           
            $.ajax({
			url : 'getPlayerList.jsp',
                        
                        success : function(responseText) {
                            //alert(responseText);
				$('.showiit').html(responseText);
			}
		});
            
        });
        $(".viewplayerprofile").click(function(){
            alert("clicked");
        });
            $("#profile").click(function(){
                $(".profile-div").show();
                $(".list-div").hide(); 
                 $("#profile").addClass("btn-primary");
            $("#playerlist").removeClass("btn-primary");
            $("#playerlist").addClass("btn-default");
           
            });
          $("#countryId").change(function(){
                $.ajax({
			url : 'getState.jsp',
                        data : {
				ccode : $("#countryId").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#stateId').html(responseText);
			}
		});
            
        });
        $("#stateId").change(function(){
                $.ajax({
			url : 'getCity.jsp',
                        data : {
				scode : $("#stateId").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#cityId').html(responseText);
			}
		});
            
        });
         
        	$("#editform").on('submit',(function(e){
            e.preventDefault();
           
           $.ajax({
			url : 'update.jsp',
                        data : {
                                id : $("#idd").val(),                            
                                cat : $("#cat").val(),                            
                                fname : $("#fname").val(),
                                lname : $("#lname").val(),
                                email : $("#emailid").val(),
                                age : $("#age").val(),
                                pass : $("#pass").val(),
                                number : $("#number").val(),
                                country : $("#countryId").val(),
				state : $("#stateId").val(),
                                city : $("#cityId").val(),
                                address : $("#address").val()
                                
			},success : function(responseText) {
                            //alert(responseText);
                            alert("Update Successfull!!!");
			}
		});
        
           
        }));
	
        
        
        $.ajax({
			url : 'getCountry.jsp',
			
			success : function(responseText) {
                            //alert(responseText);
				$('#countryId').append(responseText);
			}
		});
                $.ajax({
			url : 'getState.jsp',
                        data : {
				ccode : $("#countryId").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#stateId').append(responseText);
			}
		});
                $.ajax({
			url : 'getCity.jsp',
                        data : {
				scode : $("#stateId").val()
			},success : function(responseText) {
                            //alert(responseText+country_id);
				$('#cityId').append(responseText);
			}
		});
            
                
    });
</script>
</head>
    <%
        
        try{
            if(session.getAttribute("uid")!=null)
            {
                
            uid=(String)session.getAttribute("uid");
            }
            else
            {
                response.sendRedirect("index.html");
            }
             
        }catch(Exception e)
        {
            //e.printStackTrace();
            response.sendRedirect("index.html");
        }
     
    try{  
    Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  
Statement stmt=con.createStatement();  
ResultSet rs=stmt.executeQuery("select * from users where uid="+uid);  
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

}
if(cat.equalsIgnoreCase("player"))
{
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

}
con.close();  

    }catch(Exception e)
    {out.println(e);}    
    %>
<body>
    <div class="container">
            <div class="heading text-center">
                <h1><b>The Gaming Adda</b></h1>
                <h5><b>The ultimate gaming destination :)</b></h5>
                <form action="logout.jsp"><input type="submit" class="btn btn-warning" style="float:right; margin-right: 10px;" value="Logout"/></form>
            </div>
        <div class="player-profile">
             <center><h2>Welcome <% out.print(cat);%></h2></center>
        
             <input type="hidden" value="<%=uid%>" id="idd"/>
            <div class="text-center">
                <button type="button" class="btn btn-primary option" id="profile">My Profile</button>
                <% if(cat.equalsIgnoreCase("officer"))
                {
                    out.println("<button type='button' class='btn btn-default option' id='playerlist'>Check Players List</button>");
                }
                %>
            </div>
            
           
        <div class="row content profile-div">
            <div class="col-sm-8 col-sm-offset-2">
                <div class='well'>
                    <div class="alert alert-info text-center"><strong>Your Profile</strong></div>
                    
                    
                    
                    
                    
                    
                                                  <form method="post" id="editform">
                                                      <input type="hidden" name="category" id="cat" value="<%=cat%>"/>
  <div class="form-group ">
    <label for="first-name">First Name:</label>
    <input type="text" class="form-control" onkeyup="ValidateFName(this)" placeholder="Enter First Name here" id="fname" name="fname" required value="<%=fname%>">
  </div>
  <div class="form-group ">
    <label for="last-name">Last Name:</label>
    <input type="text" class="form-control" onkeyup="ValidateFName(this)" placeholder="Enter Last Name here" id="lname" name="lname" required value="<%=lname%>">
  </div>
  <div class="form-group ">
    <label for="email">Email address:</label>
    <input type="email" class="form-control" placeholder="Enter Email id here" id="emailid" required value="<%=email%>">
   
  </div>
  <div class="form-group">
    <label for="pwd">Password:</label>
    <input type="text" class="form-control" placeholder="Enter password here" id="pass" required value="<%=pass%>">
  </div>
  <div class="form-group ">
    <label for="age">Age:</label>
    <input type="text" class="form-control" onkeypress='return isNumber(event,this.value)' placeholder="Enter Age here" id="age" required value="<%=age%>">
  </div>
  <div class="form-group ">
    <label for="phone">Mobile Number:</label>
    <input type="text" class="form-control" onkeypress='return isNumber(event,this.value)' placeholder="Enter Mobile Number here" id="number" required value="<%=number%>">
  </div>
  <%
      if(cat.equalsIgnoreCase("Player"))
      {
          
      
      out.print("<div id='player-special' >");
      out.print("<div class='form-group'>");
      out.print("<label for='Address'>Select Country:</label>");
      out.print("<select name='country' class='form-control countries' id='countryId' required='required'>");
      out.print("<option  value="+country+">"+countryname+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group'>");
      out.print("<label for='Address'>Select State:</label>");
      out.print("<select name='state' class='form-control states' id='stateId' required='required'>");
      out.print("<option value="+state+">"+statename+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group'> ");
      out.print("<label for='Address'>Select City:</label>");
      out.print(" <select name='city' class='form-control cities' id='cityId' required='required'>");
      out.print("<option value="+city+">"+cityname+"</option>");
      out.print("</select>");
      out.print("</div>");
      out.print("<div class='form-group '>");
      out.print("<label for='Address'>Enter Street Address:</label>");
      out.print("<textarea required type='text' class='form-control' placeholder='Enter Address here' id='address' height='3'>"+address+"</textarea>");
      out.print("</div>");
      out.print("</div>");
      }       
      %>
                                 
                                  
                                 
                                 
                                <center> <input type="submit" value="Update" class="btn btn-info"></center>
</form>
  
                    
                    
                    
                    
                    
                    
                </div>
            </div>
          </div>
      
      <div class="row content list-div" style="display:none">
            <div class="col-sm-8 col-sm-offset-2 showiit">
                player list will come here
            </div>
          
      </div>
      
      
        </div>
        
          
    </div>
 
</body>
</html>
