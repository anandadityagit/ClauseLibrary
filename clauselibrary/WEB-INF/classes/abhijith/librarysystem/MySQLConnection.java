package abhijith.librarysystem;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class MySQLConnection
{

	Connection conn = null;
	Statement stmt =null;
	ResultSet rs =null;

	public java.sql.Connection getConnection()
	{
		try 
		{

			String url       = "jdbc:mysql://localhost:3306/clauselibrary";
			String user      = "yug";
			String password  = "yug123";
			conn = DriverManager.getConnection(url, user, password);
			
		}
		catch(SQLException e) 
		{

		} 
	  return conn;
	}

	public void closeConnection(Connection conn, ResultSet rs, Statement stmt )
	{
		try 
		{
		   if(rs != null)
				   rs.close();
		   if(stmt != null)
				   stmt.close();
		   if(conn != null)
				 conn.close();
		}
		catch(SQLException ex)
		{

		}
	}
}