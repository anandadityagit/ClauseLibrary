
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

<%

	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;
	String firstName="";
	String lastName="";
	String userType="";
	String userid= (String)session.getAttribute("userid");
	String bookAssign = request.getParameter("bookassign");
	boolean eventsHappened = false;

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
	<form method="post" name="loginScreen" action="UnlockAccount.jsp" >
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
	<%
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");

			}
	%>
    <legend><center>Welcome <%=firstName %> <%=lastName %> : Account Unlock Status </center></legend>
	
	<%	String [] unlockUserRecds = request.getParameterValues("userids");
		if( (unlockUserRecds != null) )
			for(String useridss :unlockUserRecds)
				{
					eventsHappened = true;
					 stmt.executeUpdate("update user set failureattemptcount=0  where userid='"+useridss+"';");

				}
				
		if(eventsHappened)
			{
	%>	   
			</br><b>Account/s have been unlocked successfully.</b></br>
	<%
			}
		else
			{
	%>
		   </br><b> NO Account has been selected for unlock.</b></br>
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
  </fieldset>
 <br><center><button type="submit">Back</button></center>
</form>
  </div>


</body></html>