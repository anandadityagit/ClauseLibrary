
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
	<form method="post" name="loginScreen" action="CreateUserStatus.jsp" >
	<%
		if(userid != null)
			{
			if(rs.next())
				{
					firstName = rs.getString("FirstName");
					lastName = rs.getString("lastName");
					userType = rs.getString("userType");
	%>
					<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
					<legend><center>Welcome <%=firstName %> <%=lastName %> : Create User </center></legend>
    <%
					if(userType.equals("Admin"))
					{
	%>
	
					

						<input type="text" required="true" name="userid" placeholder="User ID"><br /><br />
						<input type="text" required="true" name="firstname" placeholder="First Name"><br /><br />
						<input type="text" required="true" name="lastname" placeholder="Last Name"><br /><br />
						<input type="text" required="true" name="emailAddress" placeholder="Email Address"><br /><br />
						<input type="text" required="true" name="phoneNumber" placeholder="Phone Number"><br /><br />
						<select name="state" required="true" placeholder="State">
							<option value="">Select User State</option>
							<option value="Bihar">Bihar</option>
							<option value="Delhi">Delhi</option>
							<option value="Karnataka">Karnataka</option>
							<option value="Utter Pradesh">Utter Pradesh</option>
						</Select><br><br>
						<select name="usertype" required="true" placeholder="User Type">
							<option value="">Select User Type</option>
							<option value="Admin">Admin</option>
							<option value="User">User</option>
						</Select><br><br>
						<input type="password" required="true" name="password" placeholder="Password"><br/>

	<%
				}
				else
				{
	%>
					</br><b>You are not Authorized to Create User. Only person with Adminitsrative Access can create the User.<b></br></br>
	<%
				}
    %>
			</fieldset>
		 </p>
	<%		} 
		   }
		   else
			{
		%>
			<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
			<legend><center>Welcome <%=firstName %> <%=lastName %> : Create User </center></legend>
			</br><b> Please <a href="Login.jsp"> Click Here </a> to Login First. </b></br></br>
			</fieldset>
		 </p>
		<%
			}
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
<br><br><center><button type="submit">Submit</button></center>
</form></table></body></html>