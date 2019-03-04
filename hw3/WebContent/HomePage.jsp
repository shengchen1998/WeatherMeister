<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="initial-scale=1.0">
    <meta charset="utf-8">
    
	<script>
   	 	function show(index1,index2)
   	 	{
   	 		document.getElementById(index1).style.display = "";
      	  	document.getElementById(index2).style.display = "none";
      	  	if(index1==1)
      	  	{
      	  		document.getElementById("g").style.display = "";
      	  	}
      	  	else
      	  	{
      	  	document.getElementById("g").style.display = "none";
      	  	}
 		}
   	 	function showmap()
   	 	{
   	 		document.getElementById("map").style.display = "";
   	 		document.getElementById("shadow").style.display = "";
   	 	}
   	 
	</script>
	
	<style>
		#father{
		position:absolute;
		width:100%;
		height:100%;
		}
		 #map 
		{
		
		left:25%;
		right:25%;
		top:25%;
		bottom:25%;
		position:absolute;
		margin-top:0%;
		z-index: 3;
		width:50%;
        height: 50%;
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
		 #shadow
		{
			background-color: rgba(0,0,0,0.7);

		position:absolute;
		z-index: 2;
		width:100%;
        height: 100%;
		} 
        #bar
        {
        	position:absolute;
        	background-color: rgba(0,0,0,0.7);
        	color: white;
        	font-family: "Savoye";
        	font-size: 25px;
        	
        	top:0%;
        	z-index: 2;
        	width:100%;
        	height:10%;
        }
        #logo
        {
        	position: absolute;
        	z-index:0;
        }
        #searchway
        {
        position:absolute;
        width:100%;
        color:white;
        text-align:center;
        top:65%;
        z-index:1;
        }
        #g
        {
        position:absolute;
		width:30px;
		height:30px;
        top:66%;
        left:66%;
        z-index:2;
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

<div id="father">
<div id="shadow" style="display:none" ></div>
<div id="bar">
	<p> <a href="HomePage.jsp"> WeatherMeister </a> </p>
</div>
<div id= "logo" style="top:20%;width:100%;height:40%;text-align:center;">
	<img src="logo.png" style="width:30%;height:100%;">
</div>
<div id="map" style="display:none"></div>
<div id="g" style="display:none"><input type="image" onclick="showmap()" src="MapIcon_.png" style="position:absolute;z-index:2" ></div>
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
			
		</div>
		
		<input type="radio" name="search" value="name" onclick="show(0,1);" checked><font style="font-size: 20px;">City</font>
  		<input type="radio" name="search" value="location" onclick="show(1,0)"><font style="font-size: 20px;">Location(Lat./Long.)</font><br><br>
	</form>

	
</div>
</div>
<script>
function initMap() {
    var chicago = new google.maps.LatLng(41.850, -87.650);
 
    var map = new google.maps.Map(document.getElementById('map'), {
      center: chicago,
      zoom: 3
    });
    
    var coordInfoWindow = new google.maps.InfoWindow();
    coordInfoWindow.setContent(createInfoWindowContent(chicago, map.getZoom()));
    coordInfoWindow.setPosition(chicago);
    coordInfoWindow.open(map);
    
    google.maps.event.addListener(map, 'click', function(event) {
        var marker = addMarker(event.latLng, map);
        coordInfoWindow.setContent(createInfoWindowContent(marker.getPosition(), map.getZoom()));
        coordInfoWindow.setPosition(marker.getPosition());
        coordInfoWindow.open(map);
      });
  }
		var TILE_SIZE = 256;
		function addMarker(location, map) {
       var marker = new google.maps.Marker({
         position: location,
         map: map
       });
       return marker;
     }
		function createInfoWindowContent(latLng, zoom) {
	        var scale = 1 << zoom;

	        var worldCoordinate = project(latLng);

	        var pixelCoordinate = new google.maps.Point(
	            Math.floor(worldCoordinate.x * scale),
	            Math.floor(worldCoordinate.y * scale));

	        var tileCoordinate = new google.maps.Point(
	            Math.floor(worldCoordinate.x * scale / TILE_SIZE),
	            Math.floor(worldCoordinate.y * scale / TILE_SIZE));

	        return [
	          'Chicago, IL',
	          'LatLng: ' + latLng,
	          'Zoom level: ' + zoom,
	          'World Coordinate: ' + worldCoordinate,
	          'Pixel Coordinate: ' + pixelCoordinate,
	          'Tile Coordinate: ' + tileCoordinate
	        ].join('<br>');
	      }
		function project(latLng) {
	        var siny = Math.sin(latLng.lat() * Math.PI / 180);

	        siny = Math.min(Math.max(siny, -0.9999), 0.9999);

	        return new google.maps.Point(
	                TILE_SIZE * (0.5 + latLng.lng() / 360),
	                TILE_SIZE * (0.5 - Math.log((1 + siny) / (1 - siny)) / (4 * Math.PI)));
	      }
</script>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCBvMZojeC8Sg3TpMpzOI2kMLAosMnVqN0&callback=initMap">
    </script>

</body>
</html>