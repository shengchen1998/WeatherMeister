<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<script>
   	 	function show(index1,index2)
   	 	{
   	 		document.getElementById(index1).style.display = "";
      	  	document.getElementById(index2).style.display = "none";
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
        	background-color: rgba(0,0,0,0.7);
        	color: white;
        	font-family: "Savoye";
        	font-size: 25px;
        	position: fixed;
        	top:0%;
        	z-index: 1;
        	width:100%;
        	height:10%;
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
        #searchway
        {
        position:fixed;
        width:100%;
        color:white;
        text-align:center;
        top:65%;
        }
        input[type=text] 
        {
  			background-color: 	rgb(115, 115, 115);
  			color: rgb(230, 230, 230);
  			padding: 10px 10px;
		}
		button
		{
			background-color: 	rgb(115, 115, 115);
  			color: rgb(230, 230, 230);
  			padding: 10px 10px;
		}
</style>
<meta charset="ISO-8859-1">
<title>Home Page</title>
</head>
<body>

<div id="bar">
	<p> <a href="HomePage.jsp"> WeatherMeister </a> </p>
</div>
<div class= "logo" style="margin-top:10%;width:100%;height:100%;text-align:center;">
	<img src="logo.png" style="width:30%;height:24%;">
</div>
<div id="searchway">
	<form action="Display.jsp" method="GET">
		<div id ="0">
			<input style="width:30%;opacity:0.8;border:1px solid white;font-size:25px;" type="text" name="cityname" value="Los Angeles">
			<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:2.5%;"> 
		</div>
		<div id ="1" style="display:none">
			<input style="width:15%;opacity:0.8;border:1px solid white;font-size:25px;" type="text" name="lat" value="Latitude">
			<input style="width:15%;opacity:0.8;border:1px solid white;font-size:25px;" type="text" name="long" value="Longitude">
			<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:2.5%;">
			<img src="MapIcon.png" width="25px" height="25px" style="position:relative;right:1%;">  
		</div>
		
		<input type="radio" name="search" value="name" onclick="show(0,1);" checked><font style="font-size: 20px;">City</font>
  		<input type="radio" name="search" value="location" onclick="show(1,0);"><font style="font-size: 20px;">Location(Lat./Long.)</font><br><br>

	</form>

	
</div>

</body>
</html>