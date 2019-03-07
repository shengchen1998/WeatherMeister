<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList" 
    import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Insert title here</title>
		<script>
		function signOut()
		{
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET","SignOut",true);
			xhttp.send();
		}
		</script>
		<style>
			table, td
			{
  				
  				background-color: 	rgba(115, 115, 115,0.5);
  				border-collapse: collapse;
  				text-align:center;
			}
			tr
			{
				border: 1px solid white;
			}
			td
			{
				border: 0px;
			}
			@font-face
			{
				font-family: Savoye;
				src: url('17357674296594851838.woff');
			}
			body
			{
  				background-image: url("background_filter.jpg");
  				background-repeat: no-repeat;
  				background-size:100%;
  				background-position: center top; 
			}
			#bar
        	{
	        	position:absolute;
    	    	background-color: rgba(0,0,0,0.7);
        		color: white;
        	
        		font-size: 25px;
        	
        		top:0%;
        		z-index: 2;
        		width:100%;
        		height:10%;
        	}
        	#wm
        	{
        		font-family: "Savoye";
        	}
        	a
        	{
        		text-decoration: none;
        		color:white;
       	 	}
        	a:hover
        	{
        		color:white;
     		   	text-decoration:none;
     		}
        	a:visited
        	{
        		color:white;
        		text-decoration:none;
        	}

		</style>
	</head>
	<body>
		<div id="bar">
			<div id="wm"><p> <a href="HomePage.jsp"> WeatherMeister </a> </p></div>
			<div><a href="Profile.jsp" style="position:absolute;top:25%;right:15%;">Profile</a></div>
			<div><a href="HomePage.jsp" style="position:absolute;top:25%;right:5%;" onclick="signOut()">Sign Out</a></div>
		</div>
		<div style="position:absolute;text-align:center;top:10%;width:50%;left:25%;right:25%;">
			<h1 style="color:white;"><%=((String)session.getAttribute("currentUser")).trim()%>'s Search Hisotry</h1>
		</div>
		<%ArrayList<String>history = new ArrayList<String>(); 
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String username = ((String)session.getAttribute("currentUser")).trim();
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/userData?user=root&password=root&useSSL=false");
			
			ps = conn.prepareStatement("SELECT h.input FROM histories h WHERE h.username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			while (rs.next())
			{
				history.add(rs.getString("input"));
			}
		} catch (SQLException sqle)
		{
			System.out.println(sqle.getMessage());
		} catch (ClassNotFoundException cnfe)
		{
			System.out.println(cnfe.getMessage());
		} finally
		{
			
			try
			{
				if (rs != null)
				{
					rs.close();
				}
				if (ps != null)
				{
					ps.close();
				}
				if (conn != null)
				{
					conn.close();
				}
			} catch (SQLException sqle)
			{
				System.out.println(sqle.getMessage());
			}
		}
		%>
		<div id="table" style="position:absolute;top:30%;color:white;width:40%;left:30%;right:30%;height:60%;">
  				<div style=" overflow:auto;height:90%;">
  				<table style="width:100%">
  				<%for(int i = history.size()-1;i >= 0;--i)
  				{%> 

  						<tr style="font-size: 30px;">
    						<td><%=history.get(i)%></td>
  						</tr>
  				<% }%>
				</table>
				</div>
		</div>
	</body>
</html>