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
			String userid = (String)session.getAttribute("userid");
			String bookName=request.getParameter("bookname");
			String bookLocation=request.getParameter("location");
			String bookLanguage=request.getParameter("language");
						
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
	</div>
	<div style="background-color: green; height: 10px"><p></p></div>
	<div class="topnav"> <jsp:include page="Menu.jsp"/></div>
	
	<form name="loginScreen" action="AddNewBook.jsp" >
	
	<br/><br/>
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
	    <legend>New Book Entry Status</legend>

	<%		
		if(rs.next())
			{
				String usertype = rs.getString("usertype");
				if((usertype!=null) && (usertype.equals("Admin")))
				{
					int res = stmt.executeUpdate("insert into book_inventory(bookname,Location,Language,status,creation_date) values ('"+bookName+"','"+bookLocation+"','"+bookLanguage+"','Available',sysdate())");

	%>
                   <center><b>Book Details has been entered Successfully</b></center><br><br>
	<%
			   }
		     else
			  {
				
	%>
				<center><b>You do not have access to this functionality. Only user with Administartive Access can make a entry for New Book.</b></center><br><br>		
	<%
			 }
		}
		else
		{
	%>
		</br><b> User ID "<%=userid%>" does NOT exists in the System.</b></br></br>
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