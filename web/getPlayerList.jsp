<%-- 
    Document   : getPlayerList
    Created on : 29 Dec, 2017, 8:40:38 AM
    Author     : jaspal
--%>

<%@page import="java.sql.*;" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
    <title>Gaming Adda</title>
         <meta name="viewport" content="width=device-width, initial-scale=1">
         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  

<script type="text/javascript">
    $(document).ready(function(){
        var btn=$(".viewplayerprofile");
        $(".viewplayerprofile").click(function(){
            //alert(this.id);
            var id=this.id;
            $("#uid").val(id);
            $.ajax({
			url : 'getPlayerProfile.jsp',
                        data :{
                            id: id
                        },
                         async : false,
                        success : function(responseText) {
                            //alert(responseText);
				$('#putinhere').html(responseText);
                                $("#myModal").modal();
			}
		});
            });
        $(".update").click(function(){
            $.ajax({
			url : 'update.jsp',
                        data : {
                                id : $("#uid").val(),                            
                                cat : $("#cate").val(),                            
                                fname : $("#fnamee").val(),
                                lname : $("#lnamee").val(),
                                email : $("#emailidd").val(),
                                age : $("#agee").val(),
                                pass : $("#passs").val(),
                                number : $("#numberr").val(),
                                country : $("#countryIdd").val(),
				state : $("#stateIdd").val(),
                                city : $("#cityIdd").val(),
                                address : $("#addresss").val()
                                
			},success : function(responseText) {
                            //alert(responseText);
                            alert("Update Successfull!!!\n Click on Player-List again to see changes!!!");
                            
			}
		});
        
        });

        
    });
</script>
</head>


<%
      try{  
    Class.forName("com.mysql.jdbc.Driver");  
        Connection con=DriverManager.getConnection(  
"jdbc:mysql://localhost:3306/gamer","root","jaspal");  
    Statement stmt=con.createStatement();
out.print("<table class='table table-hover'>");
out.print(" <thead><tr><th>S.No.</th><th>Name</th><th>Email</th><th>Click to View</th></tr></thead>");
out.print("<tbody>");
int i=0;
ResultSet rs=stmt.executeQuery("select * from users where  profile='Player'");  
while(rs.next())
{
i++;
out.print("<tr><td>"+i+"</td><td>"+rs.getString(2)+" "+rs.getString(3) +"</td><td>"+rs.getString(4)+"</td><td><button class='viewplayerprofile btn btn-primary' id='"+rs.getInt(1)+"'>View</button></td>");
}


    }catch(Exception e)
    {out.println(e);}    
    %>
    
         <!-- Trigger the modal with a button -->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <center><h4 class="modal-title">Player Profile</h4></center>
      </div>
      <div class="modal-body">
          
          <input type="hidden" name="id" id="uid"/>
          <input type="hidden" name="cat" id="cate" value="Player"/>
   
          <div id="putinhere"></div>
        
      </div>
      <div class="modal-footer">
          <center><button type="button" class="btn btn-primary update" >Update Details</button></center>
      </div>
    </div>

  </div>
</div>