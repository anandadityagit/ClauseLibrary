
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.SQLException,java.sql.Statement,java.sql.ResultSet,abhijith.librarysystem.MySQLConnection" %>

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
	<form method="post" name="loginScreen" action="LoginStatus.jsp" >
	
	<fieldset style="background: #f6f8ff; border: 2px solid #4238ca;">
		<legend>Login : Provide User Name & Password (Case Sensitive)</legend><br/>

		<input type="text" name="userid" required="true" placeholder="User Name"><br /><br />
		<input type="password" name="password" required="true" placeholder="Password"><br/><br/>
	  </fieldset>
	  </p>
	  </div>
	<br><br><center><button type="submit">Login</button></center>
</form></body></html>