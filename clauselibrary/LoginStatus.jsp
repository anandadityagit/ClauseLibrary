
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

<%
	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;
	String userid="";
	MySQLConnection mysql = new MySQLConnection();
	try 
		{
			conn = mysql.getConnection();
			stmt = conn.createStatement();
			String firstName="";
			String lastName ="";
			userid=request.getParameter("userid");
			session.setAttribute("userid",userid);
			String password=request.getParameter("password");
			int failureattemptcount=0;
			rs = stmt.executeQuery("select FirstName,LastName , state , usertype  , password , failureattemptcount , failureattempttime from user where userid ="+"'"+userid+"';");

			//int res = stmt.executeUpdate("insert into user(userid,FirstName,LastName,Address,City,usertype,password) values ('"+userid+"','"+firstname+"','"+lastname+"','"+address+"','"+city+"','"+usertype+"','"+password+"')");
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
	<%	
		if(rs.next())
			{
				firstName = rs.getString("FirstName");
				lastName = rs.getString("LastName");
				failureattemptcount = Integer.parseInt(rs.getString("failureattemptcount"));
   
				if(failureattemptcount >= 3)
				{
	%>				<form name="loginScreen" action="Login.jsp" >	
					<br/><br/>
					<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
					<legend>Welcome : <b><%=firstName %>&nbsp;<%=lastName %> </b></legend>
					<center><br/><b>Your Account is locked, because of the 03 consecutive failure attempts. Administrator monitors accounts status periodically and will unlock the accounts in some time. </b></center><br><br>
	<%			}
				else if(password.equals(rs.getString("password"))) 
				{
	%>
					<form name="loginScreen" action="Home.jsp" >	
					<br/><br/>
					
					<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;"></br></br>
					<legend>Welcome : <b><%=firstName %>&nbsp;<%=lastName %> </b></legend>
					<center><b>Login Success.</b></center><br><br>
	<%
					int res = stmt.executeUpdate("update user set failureattemptcount=0 where userid='"+userid+"' and failureattemptcount <> 0 ;");
				}
				else
				{
	%>			
				<form name="loginScreen" action="Login.jsp" >	
				<br/><br/>
				
				<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;"></br></br>
				<legend>Welcome : <b><%=firstName %>&nbsp;<%=lastName %> </b></legend>
				<center><b>Login Failed. Invalid password, please try again.</b></center><br><br>
	<%   		int res = stmt.executeUpdate("update user set failureattemptcount=  failureattemptcount+1 where userid='"+userid+"';");

				}
			}
		 else
			{
    %>
				<form name="loginScreen" action="Login.jsp" >	
				<br/><br/>
				<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;"></br></br>
				<legend>Welcome : <b><%=firstName %>&nbsp;<%=lastName %> </b></legend>
				
				<legend> Login Status</legend>
				<center><b>Invalid User ID ( User "<%=userid%>" does not exists in the system. ) </b></center><br><br>
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
  
	</fieldset>
	<input type="hidden" name="userid" value="<%=userid%>"/>
	<br><br><center><button type="submit">OK</button></center>
</form></table></body></html>