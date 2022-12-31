<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

<%
	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;
	MySQLConnection mysql = new MySQLConnection();
	try 
		{
			conn = mysql.getConnection();
			stmt = conn.createStatement();
			String userid=request.getParameter("userid");
			String firstname=request.getParameter("firstname");
			String lastname=request.getParameter("lastname");
			String emailAddress=request.getParameter("emailAddress");
			String phoneNumber=request.getParameter("phoneNumber");
			String state=request.getParameter("state");
			String usertype=request.getParameter("usertype");
			String password=request.getParameter("password");
			
			rs = stmt.executeQuery("select * from user where upper(userid) ='"+userid.toUpperCase()+"';");
			
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
	
	<form name="loginScreen" action="CreateUser.jsp" >
	
	<br/><br/>
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
	    <legend>User Creation Status</legend>

	<%		
		if(rs.next())
			{
	%>
				</br><b> User ID "<%=userid%>" already in use, please try with another User ID.</b></br></br>
	<%
			}
		else
			{
				int res = stmt.executeUpdate("insert into user(userid,FirstName,LastName,EmailAddress,PhoneNumber, State,usertype,password,failureattemptcount) values ('"+userid+"','"+firstname+"','"+lastname+"','"+emailAddress+"','"+phoneNumber+"','"+state+"','"+usertype+"','"+password+"',0)");
	%>
						<center><b>User has been created Successfully</b></center><br><br>
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

%>	</fieldset>
	<br><br><center><button type="submit">Back</button></center>
	</form></table></body></html>