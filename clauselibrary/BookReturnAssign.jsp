
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
	<form method="post" name="loginScreen" action="Home.jsp" >
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
	<%
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");

			}
	%>
    <legend><center>Welcome <%=firstName %> <%=lastName %> : Book Return/Assign </center></legend>
	
	<%	String [] bookReturned = request.getParameterValues("bookreturn");
		if( (bookReturned != null) )
			for(String bookid :bookReturned)
				{
					eventsHappened = true;
					 stmt.executeUpdate("update book_inventory set status='Available',issued_date=null,Return_date=null,issued_to=null  where inventory_id='"+bookid+"';");

				}
		if( bookAssign != null)
			{
				eventsHappened = true;
				stmt.executeUpdate("update book_inventory set status='Not Available',issued_date=sysdate(),Return_date=DATE_ADD(sysdate(), INTERVAL 30 DAY),issued_to='"+userid+"'  where inventory_id='"+bookAssign+"';");
			}
		
	
		if(eventsHappened)
			{
	%>	   
			</br><b>Book return/assignment activities have been completed successfully.</b></br>
	<%
			}
		else
			{
	%>
		   </br><b> NO book selected for either assignment or removal.</b></br>
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