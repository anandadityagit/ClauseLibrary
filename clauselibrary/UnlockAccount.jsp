
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
	<form method="post" name="loginScreen" action="UnlockAccountStatus.jsp" >
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
	<%
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");

			}
	%>
    <legend><center>Welcome <%=firstName %> <%=lastName %> : Unlock Accounts </center></legend>
	<%
	if(userid != null)
	  {
		if(userType.equals("Admin"))
		{
	%>
		</br> <b> Select User ID to unlock. </b></br> 
		<table border=1><tr><td><b>Select</b></td><td><b>User ID</b></td><td><b>First Name</b></td><td><b>Last Name</b></td><td><b>Email Address</td><td><b>Phone Number</b></td><td><b>User State</b></td><td><b>User Type</b></td></tr>
		
		<%
			rs = stmt.executeQuery("select * from user where failureattemptcount >=3;");
			while(rs.next())
				{
		%>
					
					<tr><td><input type="checkbox" name="userids" value="<%=rs.getString("userid")%>"/></td><td><%=rs.getString("userid")%></td><td><%=rs.getString("FirstName")%></td><td><%=rs.getString("LastName")%></td><td><%=rs.getString("EmailAddress")%></td><td><%=rs.getString("PhoneNumber")%></td><td><%=rs.getString("State")%></td><td><%=rs.getString("usertype")%></td></tr>
		<%		}

	 }
	 else
	  {
	%>
		<br/><b>You are not Authorized to access this information. Only person with Adminitsrative Access can access this information.<b><br/>
	<%
	    }
	  }
	  else
			{
		%>
				</br><b> Please <a href="Login.jsp"> Click Here </a> to Login First. </b></br></br>
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

  </p>
</table>
<p></p>
  </fieldset>
 	<br><br><center><button type="submit">Submit</button></center>
</form>
  </div>


</body></html>