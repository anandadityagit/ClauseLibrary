
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
	<form method="post" name="loginScreen" action="AddNewBookStatus.jsp" >
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
				<legend><center>Welcome <%=firstName %> <%=lastName %> : Add a New Book </center></legend>
				<p></p>
    <%
				if(userType.equals("Admin"))
				{
	%>
						<input type="text" name="bookname" required="true" placeholder="Book Name"><br /><br />
						<select name="location" required="true"  placeholder="location">
							<option value="">Select Book Location</option>
							<option value="Bihar">Bihar</option>
							<option value="Delhi">Delhi</option>
							<option value="Karnataka">Karnataka</option>
							<option value="Utter Pradesh">Utter Pradesh</option>
						</Select><br><br>
						<select name="language" required="true" placeholder="language">
							<option value="">Select Book Language</option>
							<option value="Hindi">Hindi</option>
							<option value="English">English</option>
						</Select><br><br>

			<%
				}
				else
				{
	%>
					</br><b>You are not Authorized to Add a new book in system. Only person with Adminitsrative Access can Add a new book in Library System.<b></br></br>
	<%
				}
    %>
			</fieldset>
		 </p>
	<%		 } 
			}
			else
			{
				%>
			<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
			<legend><center>Welcome <%=firstName %> <%=lastName %> : Add a New Book </center></legend>
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