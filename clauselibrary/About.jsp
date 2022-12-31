
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

<%
	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;
	String firstName="";
	String lastName="";
	String userType="";
	String userid= (String)session.getAttribute("userid");
	MySQLConnection mysql = new MySQLConnection();
	try 
		{
			conn = mysql.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select FirstName, LastName, userType, failureattemptcount from user where userid='"+userid+"';");
	%>
	<html>
	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" type="text/css" href="Styles.css" /> 
	</head>
	<body>
	<div style="background-color: lightgreen">
		<br/>
			<center><b> Welcome to the Library Management System</b></center>
		<br/>
		<div style="background-color: green; height: 10px"><p></p></div>
	</div>
	<div class="topnav"> <jsp:include page="Menu.jsp"/></div>
	<!--<div style="padding-left:50px; padding-right:50px;">-->
	<div>
    <p>
	<form method="post" name="loginInterface" action="CreateUserStatus.jsp" >
	<%
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");
			} 
	%>
				<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
				<legend><center>Welcome <%=firstName %> <%=lastName %> : About the Library Management System </center></legend>
   				</br><b>This Library Management System is designed by Aditya Anand to demonstrate the basic User and Admin functionality in Library system. To respect the project time line, number of use cases have been limited to a certain number, that can be further enhanced and integrated later on as and when asked. </b></br></br>
				
				<b>Home Interface :</b> </br>1) This Interface will display the books assigned to the logged in user and the books that can be requested.</br>2) At a time, user can have only 02 books assigned. </br>3) User would be able to request only available books. If a book is assigned to someone or if user already has 02 books assigned, the selection option will remain disabled.</br>4) By default Books will be assigned for 30 days.</br>
				<b>In interest of time, following features are not implemented</b></br>
				1) Extension feature (exteneding return date beyond 30 days.)</br>2) Location based contraint, like user from certain city/state/location can request for book available in certain city/state/location only.</br></br>

				<b>List Users Interface :</b> </br>1) This will list down all users available in the system.</br>2) Only user with Administrator rights can access the page.</br>
				<b>In interest of time, following features are not implemented</b></br>
				1) Adding an additional feature to enable Administrator to Delete or Modify or Block user from accssing the application. </br></br>

				<b>Create User Interface :</b> </br>1) This Interface is RESTRICTED and only user with Admin access can create a New User in the System.</br></br>

				<b>Add New Book User Interface :</b> </br>1) This Interface is RESTRICTED and only user with Admin access can add a New Book in the System.</br>
				<b>In interest of time, following features are not implemented</b></br>
				1) Delete or Modify any existing book information.</br></br>

				<b>Unlock Account Interface :</b> </br>1) This Interface is RESTRICTED and only user with Admin access can create a New User in the System.</br>2) This Interface will display all such users (if any), who had tried to access system with 03 consecutive wrong passwords and as a result, their account is locked.</br>3) Admin can select any number of users to unlock the acounts. </br></br>
				
				<b>Login Interface :</b> </br>1) User can use this Interface to Access system by provising User ID and valid password.</br>2) This Interface can also be used to switch the new login user and presented to the user, when then they try to access system by accessing the URL http://localhost:8080/clauselibrary/ </br>
				<b>In interest of time, following features are not implemented</b></br>
				1) Password reset or Forgot password feature is not implemented.</br></br>

				<b>Contact Interface :</b> 
				This shared information on whom to contact for any existing or additional information.</b> </br></br>

				<b>About Interface :</b> 
				This will explain the features related to this Library System.</b> </br></br>
				<p></p>

				</fieldset>
		 </p>
	<%   
		}
	catch(SQLException e) 
		{

		} 
	finally
	{
		mysql.closeConnection(conn, rs, stmt );
		
	}
%>

  </div>

</form></table></body></html>