<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Register</title>
		<script>
			function validate()
			{
	          	var xhttp = new XMLHttpRequest();
	          	xhttp.open("GET", "Register?username=" + document.myform.username.value + "&password=" + document.myform.password.value
	          		+ "&confirmpassword=" + document.myform.confirmpassword.value, false);
	          	xhttp.send();
	    	  	if (xhttp.responseText.trim().length > 0)
	    	  	{
	            	document.getElementById("formerror").innerHTML = xhttp.responseText;
	            	return false;
	          	}
	          	return true;
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
        
			#window
			{
				position:absolute;
				height:60%;
				top:20%;
				bottom:20%;
				width:40%;
				left:30%;
				right:30%;
				background-color: 	rgba(115, 115, 115, 0.7);
			}
		</style>
	</head>
	<body>
		<div id="bar">
			<div id="wm"><p> <a href="HomePage.jsp"> WeatherMeister </a> </p></div>
			<div id="l"><a href="Login.jsp" style="position:absolute;top:25%;right:15%;">Login</a></div>
			<div id="r"><a href="Register.jsp" style="position:absolute;top:25%;right:5%;">Register</a></div>
		</div>
		<div id="window">
			<div id="form"style="position:absolute;height:80%;top:20%;bottom:0%;width:100%;">
				<form name="myform" action="HomePage.jsp" method="POST" onsubmit="return validate();">
				<h1  style="color:white;">Username</h1>
				<input style="position:absolute;left:5%;right:5%;width:90%;font-size:25px;" type="text" name="username" value="">
				<br>
				<h1  style="color:white;">Password</h1>
				<input style="position:absolute;left:5%;right:5%;width:90%;font-size:25px;" type="text" name="password" value="">
				<br>
				<h1  style="color:white;">Confirm Password</h1>
				<input style="position:absolute;left:5%;right:5%;width:90%;font-size:25px;" type="text" name="confirmpassword" value="">
				<br>
				<div id="formerror" style="color: white;position:absolute;height:10%;width:80%;left:10%;right:10%;bottom:10%;"></div>
				<input type="submit" style="background-color:rgb(255, 153, 0);
  				color: white;position:absolute;height:10%;width:20%;left:40%;right:40%;bottom:5%;" value="Register">
				</form>
				
			</div>
			
		</div>

	</body>
</html>