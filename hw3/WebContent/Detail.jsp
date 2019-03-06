<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList" import="classes.Response"%>
<!DOCTYPE html>
<%
int index = Integer.parseInt(request.getParameter("index"));
ArrayList<Response> r = (ArrayList<Response>)session.getAttribute("result");
Response res = r.get(index);

%>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title><%=res.name%></title>
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
        	#searchway
        	{
        		position:fixed;
       		 	width:60%;
        		color:white;
        		right:0%;
        		text-align:left;
        		z-index:100;
        	}
        	input[type=text] 
        	{
  				background-color: 	rgb(256, 256, 256);
  				color: rgb(115, 115, 115);
  				padding: 12px 20px;
  				border: 2px solid white;
			}
        	#radiobuttons
			{
				position:fixed;
				top:3%;
				right:3%;
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
			<p> <a href="HomePage.jsp"> WeatherMeister </a> </p>
		</div>
		<div id="searchway">
			<form action="Display.jsp" method="GET">
				<div id ="0">
					<input style="width:50%" type="text" name="cityname" value="Los Angeles">
					<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:5%;"> 
				</div>
				<div id ="1" style="display:none">
					<input style="width:25%" type="text" name="lat" value="Latitude">
					<input style="width:25%" type="text" name="long" value="Longitude">
					<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:5%;">  
				</div>
				<div id="radiobuttons">
					<input type="radio" name="search" value="name" onclick="show(0,1);" checked><font style="font-size: 20px;">City</font>
  					<input type="radio" name="search" value="location" onclick="show(1,0);"><font style="font-size: 20px;">Location(Lat./Long.)</font><br>
  				</div>
			</form>
		</div>
		<div style="position:fixed;height:10%;">
			<font style="color:white;position:fixed;top:10%;font-size:50px;"><%=res.name%></font>
		</div>
		<div id="buttons" style="position:fixed;top:20%;width:100%;height:80%;">
			<div id="location" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="2" onclick="show(3,2);" type="image" src="planet-earth.png" style="height:80%;">
				<button id="3" onclick="show(2,3);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;"><%=res.sys.country%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Location</font>
			</div>
			<div id="tempLow" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="4" onclick="show(5,4);" type="image" src="snowflake.png" style="height:80%;">
				<button id="5" onclick="show(4,5);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;"><%=res.main.tempMin%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Temp Low</font>
			</div>
			<div id="tempHigh" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="6" onclick="show(7,6);" type="image" src="sun.png" style="height:80%;">
				<button id="7" onclick="show(6,7);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;"><%=res.main.tempMax%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Temp High</font>
			</div>
			<div id="wind" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="8" onclick="show(9,8);" type="image" src="wind.png" style="height:80%;">
				<button id="9" onclick="show(8,9);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;">Speed:<%=res.wind.speed%><br>Direction:<%=res.wind.deg%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Wind</font>
			</div>
			<div id="humidity" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="10" onclick="show(11,10);" type="image" src="drop.png" style="height:80%;">
				<button id="11" onclick="show(10,11);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;"><%=res.main.humidity%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Humidity</font>
			</div>
			<div id="coordinate" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="12" onclick="show(13,12);" type="image" src="LocationIcon.png" style="height:80%;">
				<button id="13" onclick="show(12,13);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;">Longitude:<%=res.coord.lon%><br>Latitude:<%=res.coord.lat%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Coordinate</font>
			</div>
			<div id="currenttemp" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="14" onclick="show(15,14);" type="image" src="thermometer.png" style="height:80%;">
				<button id="15" onclick="show(14,15);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;"><%=res.main.temp%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Current Temp</font>
			</div>
			<div id="sun" style="text-align:center;width:25%;height:50%;float:left;">
				<input id="16" onclick="show(17,16);" type="image" src="sunrise-icon.png" style="height:80%;">
				<button id="17" onclick="show(16,17);" type="button" style="border:0px;background: transparent;display:none;height:80%;">
				<font style="color:white;font-size:30px;">Sunrise:<%=res.sys.sunrise%><br>Sunset:<%=res.sys.sunset%></font>
				</button><br>
				<font style="color:white;font-size:40px;">Sunrise/set</font>
			</div>
		</div>
	</body>
</html>