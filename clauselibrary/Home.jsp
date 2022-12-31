
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

<%

	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;
	String firstName="";
	String lastName="";
	String userType="";
	String userid= (String)session.getAttribute("userid");
	int assignedBKCnt=0;
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
	<form method="post" name="bookreturnassign" action="BookReturnAssign.jsp" >
	
	<%
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("lastName");
				userType = rs.getString("userType");

			}
	%>
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
    <legend><center>Welcome <%=firstName %> <%=lastName %> : Books Issued to you </center></legend>
	
	<%
		if(userid != null)
			{
	%>
		</br><b>** A user can have Maximum 02 books at a time </b></br></br>
		<table border=1><tr><td><b>Select</b></td><td><b>Book ID</b></td><td><b>Book Name</b></td><td><b>Language Name</b></td><td><b>Location</n></td><td><b>issued Date</b></td><td><b>Return date </b></td><td><b>Days to Return</b></td></tr>
		
		<%
			rs = stmt.executeQuery("select inventory_id,bookname ,Location,Language,issued_date,Return_date,DATEDIFF(Return_date,issued_date) daysleft from book_inventory where issued_to ='"+userid+"';");
			while(rs.next())
				{
				assignedBKCnt++;
		%>
					
					<tr><td><input type="checkbox" name="bookreturn" value="<%=rs.getString("inventory_id")%>"/><td><%=rs.getString("inventory_id")%></td><td><%=rs.getString("bookname")%></td><td><%=rs.getString("Language")%><td><%=rs.getString("Location")%></td></td><td><%=rs.getDate("issued_date")%></td><td><%=rs.getDate("Return_date")%></td><td><%=rs.getString("daysleft") %></td></tr>

		<%		}
		%>
			</table>
			<p></p>
			</fieldset>
		<%
			rs = stmt.executeQuery("select inventory_id,bookname ,Location,Language,nvl(Return_date,'Now') Availability , status from book_inventory where issued_to <>'"+userid+"' or issued_to is null;");
		%>
			<p></p><p></p><p></p>
			<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
				<legend><center>Books that can be Requested</center></legend>
		<%
			if(assignedBKCnt >= 2) 
			{
		%>
					</br><b>** You already have max. no. of allowed books ( 02 ) assigned. Plase return atleast one of them to request a new book.</b></br></br>
						
		<%
			}
		else
			{
		%>
				</br><b>** Please select a book. At a time, only one book can be Requested.</b></br></br>
				
		<%
			}
		%>
			<table border=1><tr><td><b>Select</b><td><b>Book ID</b></td><td><b>Book Name</b></td><td><b>Language Name</b></td><td><b>Location</n></td><td><b>Status</n></td><td><b>Can be Requested </b></td></tr>
		<%
			String disableOption="";
			
			while(rs.next())
				{
				  String stat=rs.getString("status");
				  if(assignedBKCnt >= 2) 
						disableOption = "disabled";
				  else if( (stat != null ) && !(stat.equals("Available")))
					  disableOption = "disabled";
				  else
					  disableOption="";

		%>
					
					<tr><td><input type="radio" name="bookassign" <%=disableOption%> value="<%=rs.getString("inventory_id")%>"/></td><td><%=rs.getString("inventory_id")%></td><td><%=rs.getString("bookname")%></td><td><%=rs.getString("Language")%><td><%=rs.getString("Location")%></td></td><td><%=rs.getString("status")%></td><td><%=rs.getString("Availability")%></td></tr>

		<%		}
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


	</table>
  </fieldset>
 <br><center><button type="submit">Submit</button></center>
</form>
</p>
  </div>


</body></html>