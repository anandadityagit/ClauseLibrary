
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
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");
			}
	%>
				<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
				<legend><center>Welcome <%=firstName %> <%=lastName %> : Questions ?</center></legend>
   				</br><b>This Library Management System is designed by Aditya Anand to demonstrate the basic User and Admin functionality in Library system. </b></br></br>
				
				<b>Please contact Aditya Anand for Questions related to any existing functionalities or you have any suggestion. Please drop an email at sharanyug@gmail.com </b></br>
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