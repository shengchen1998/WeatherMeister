<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	</body>
</html>