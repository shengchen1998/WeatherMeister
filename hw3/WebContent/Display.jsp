<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList" import="classes.Response" 
    import="classes.City" import="java.lang.Integer"
    import="java.io.BufferedReader,java.io.FileNotFoundException,java.io.FileReader"
    import="java.io.IOException,java.io.InputStream,java.io.InputStreamReader"
    import="java.io.UnsupportedEncodingException,java.net.HttpURLConnection,java.net.URL"
    import="com.google.gson.Gson,com.google.gson.GsonBuilder,com.google.gson.stream.JsonReader"
    import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet,java.sql.SQLException"
%>
<!DOCTYPE html>
<%
	String searchWay = request.getParameter("search");
String order = request.getParameter("order");
ArrayList<City> c = (ArrayList<City>)session.getAttribute("cityList");
ArrayList<Response> result = new ArrayList<Response>();
if(searchWay.equals("name"))
{
	String cityName = request.getParameter("cityname");
	if(cityName == null)
	{
		cityName = "";
	}
	cityName = cityName.trim();
	if(cityName.length()!=0)
	{
		
		if((String)session.getAttribute("currentUser")!=null&&((String)session.getAttribute("currentUser")).trim().length()!=0)
		{
			String un = (String)session.getAttribute("currentUser");
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/userData?user=root&password=root&useSSL=false");
				ps = conn.prepareStatement("INSERT INTO histories (username, input) VALUES (?, ?)");
				ps.setString(1, un);
				ps.setString(2, cityName);
				ps.executeUpdate();
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
		}
		
		for(int i = 0;i<c.size();++i)
		{
			if(c.get(i).name.toLowerCase().equals(cityName.toLowerCase()))
			{
				try
				{
					int id = c.get(i).id;
					URL url = new URL("http://api.openweathermap.org/data/2.5/weather?id="+id+"&APPID=cbe1e2646d0c5436c0e8a24f808617a7");
					HttpURLConnection connection = (HttpURLConnection) url.openConnection();
					connection.setRequestMethod("GET");
					connection.connect();
					InputStream inputStream = connection.getInputStream();
					BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream ));
					StringBuffer sb = new StringBuffer();
					String line = null;
				    while ((line = reader.readLine()) != null) {
				        sb.append(line + "\n");
				    }
		
				    String r = sb.toString();
				    Gson gson = new Gson();
			    	Response res = gson.fromJson(r,Response.class);
			    	result.add(res);
				}catch(Exception e)
				{
					System.out.println(e.getMessage());
				}
			}
		}
	}
	
	
}
else 
{
	try
	{
		double lat = Double.parseDouble(request.getParameter("lat"))+0.005;
		System.out.println("lat"+lat);
		double lng = Double.parseDouble(request.getParameter("lng"))+0.005;
		System.out.println("lng"+lng);
		double t = lat*100;
		lat = ((int)t)/100.00;
		t = lng*100;
		lng = ((int)t)/100.00;
		if((String)session.getAttribute("currentUser")!=null&&((String)session.getAttribute("currentUser")).trim().length()!=0)
		{
			String un = (String)session.getAttribute("currentUser");
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try
			{
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost/userData?user=root&password=root&useSSL=false");
				ps = conn.prepareStatement("INSERT INTO histories (username, input) VALUES (?, ?)");
				ps.setString(1, un);
				ps.setString(2, "("+lat+","+lng+")");
				ps.executeUpdate();
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
		}
		for(int i = 0;i<c.size();++i)
		{
			double latitude = c.get(i).coord.lat+0.005;
			t = latitude*100;
			latitude = ((int)t)/100.00;
			if( latitude == lat)
			{
				double longitude = c.get(i).coord.lon+0.005;
				t = longitude*100;
				longitude = ((int)t)/100.00;
				if(longitude == lng)
				{
					try
					{
						int id = c.get(i).id;
						URL url = new URL("http://api.openweathermap.org/data/2.5/weather?id="+id+"&APPID=cbe1e2646d0c5436c0e8a24f808617a7");
						HttpURLConnection connection = (HttpURLConnection) url.openConnection();
						connection.setRequestMethod("GET");
						connection.connect();
						InputStream inputStream = connection.getInputStream();
						BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream ));
						StringBuffer sb = new StringBuffer();
						String line = null;
					    while ((line = reader.readLine()) != null) {
					        sb.append(line + "\n");
					    }
			
					    String r = sb.toString();
					    Gson gson = new Gson();
				    	Response res = gson.fromJson(r,Response.class);
				    	result.add(res);
					}catch(Exception e)
					{
						System.out.println(e.getMessage());
					}
				}
		
			}
		}
	}
	catch (Exception e)
	{
		System.out.println(e.getMessage());
	}
}
if(order!=null&&order.trim().length()!=0)
{
	if(order.equals("AZ"))
	{
		
		for(int i = 0;i < result.size();++i)
		{
	int min = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).name.compareTo(result.get(min).name)<0)
		{
			min = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(min));
	result.set(min,temp);
		}
	}
	else if(order.equals("ZA"))
	{
		for(int i = 0;i < result.size();++i)
		{
	int max = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).name.compareTo(result.get(max).name)>0)
		{
			max = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(max));
	result.set(max,temp);
		}
	}
	else if(order.equals("LASC"))
	{
		for(int i = 0;i < result.size();++i)
		{
	int min = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).main.tempMin<result.get(min).main.tempMin)
		{
			min = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(min));
	result.set(min,temp);
		}
	}
	else if(order.equals("LDESC"))
	{
		for(int i = 0;i < result.size();++i)
		{
	int max = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).main.tempMin>result.get(max).main.tempMin)
		{
			max = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(max));
	result.set(max,temp);
		}
	}
	else if(order.equals("HASC"))
	{
		for(int i = 0;i < result.size();++i)
		{
	int min = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).main.tempMax<result.get(min).main.tempMax)
		{
			min = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(min));
	result.set(min,temp);
		}
	}
	else
	{
		for(int i = 0;i < result.size();++i)
		{
	int max = i;
	for(int j = i+1;j < result.size();++j)
	{
		if(result.get(j).main.tempMax>result.get(max).main.tempMax)
		{
			max = j;
		}
	}
	Response temp = result.get(i);
	result.set(i,result.get(max));
	result.set(max,temp);
		}
	}
}	
session.setAttribute("result", result);
%>

<html>
	<head>
		<script>
		function showmap()
   	 	{
   	 		document.getElementById("map").style.display = "";
   	 		document.getElementById("shadow").style.display = "";
   	 	}
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
			function sorting()
			{
				var order = document.getElementById("order").value;
				var url = window.location.href; 
				if(url.indexOf("&order=")==-1)
				{
					url += "&order=";
					url += order;
				}
				else
				{
					url = url.replace("&order=AZ","&order="+order);
					url = url.replace("&order=ZA","&order="+order);
					url = url.replace("&order=LASC","&order="+order);
					url = url.replace("&order=LDESC","&order="+order);
					url = url.replace("&order=HASC","&order="+order);
					url = url.replace("&order=HDESC","&order="+order);
				}
				window.location.href = url;
			}
			function options()
			{
				var query = window.location.search.substring(1);
			   	var vars = query.split("&");
			   	for (var i=0;i<vars.length;i++) 
			  	{
			               	var pair = vars[i].split("=");
			               	if(pair[0] == "order")
			        		{
			               		document.getElementById("order").value = pair[1];
			            	}
			  	}
			}
		</script>
		<style>
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
			#father{
				position:absolute;
				width:100%;
				height:100%;
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
        		z-index:2;
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
        	input[type=text] 
        	{
  				background-color: 	rgb(256, 256, 256);
  				color: rgb(115, 115, 115);
  				padding: 12px 20px;
  				border: 2px solid white;
			}
			#sort
			{
				color:white;
				position:fixed;
				width:30%;
				right:0%;
			}
			table, th, td
			{
  				
  				background-color: 	rgba(115, 115, 115,0.5);
  				border-collapse: collapse;
  				text-align:center;
			}
			tr
			{
				border: 1px solid white;
			}
			td,th
			{
				border: 0px;
			}

			#shadow
			{
				background-color: rgba(0,0,0,0.7);
				position:absolute;
				z-index: 2;
				width:100%;
       		 	height: 100%;
			} 
			#g
        	{
        		position:absolute;
				width:30px;
				height:30px;
        		top:1%;
        		right:22.5%;
        		z-index:3;
        	}	
		</style>
		<meta charset="ISO-8859-1">
		<title>Display</title>
	</head>
	<body onload="options();">
	<%
		ArrayList<Response> r = (ArrayList<Response>)session.getAttribute("result");
	%>
	<div id="father">
		<div id="shadow" style="display:none" ></div>
		<div id="bar">
			<p> <a href="HomePage.jsp"> WeatherMeister </a> </p>
		</div>
		<div id="map" style="display:none"></div>
		<div id="g" style="display:none"><input type="image" onclick="showmap()" src="MapIcon_.png" style="position:absolute;z-index:3" ></div>
		<div id="searchway">
			<form name="myform" action="Display.jsp" method="GET">
				<div id ="0">
					<input style="width:50%" type="text" name="cityname" value="Los Angeles">
					<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:5%;"> 
				</div>
				<div id ="1" style="display:none">
					<input style="width:25%" type="text" name="lat" value="Latitude">
					<input style="width:25%" type="text" name="lng" value="Longitude">
					<input type="image" src="magnifying_glass.jpeg" width="25px" height="25px" style="position:relative;right:5%;">
					  
				</div>
				<div id="radiobuttons">
					<input type="radio" name="search" value="name" onclick="show(0,1);" checked><font style="font-size: 20px;">City</font>
  					<input type="radio" name="search" value="location" onclick="show(1,0);"><font style="font-size: 20px;">Location(Lat./Long.)</font><br>
  				</div>
			</form>
		</div>
		<%if(r.size()>0){ %>
		<font style="color:white;position:fixed;top:20%;font-size:50px;">All Cities</font>
			<%if(r.size()>1){ %>
		<div id="sort">
			<font style="color:white;position:fixed;top:20%;font-size:40px;">Sort by:</font>
			<select id="order" onchange="sorting()" style="position:fixed;top:30%;width:22.4%;">
  				<option value="AZ">City Name A-Z</option>
  				<option value="ZA">City Name Z-A</option>
 	 			<option value="LASC">Temp.Low ASC</option>
  				<option value="LDESC">Temp.Low Desc</option>
  				<option value="HASC">Temp.High ASC</option>
  				<option value="HDESC">Temp.High Desc</option>
			</select>
		</div>
			<%} %>
		<div id="table" style="position:fixed;top:30%;color:white;width:60%;height:60%;">
			<div>
			<table style="width:100%">
				<colgroup>
    			<col width="40%"/>
    			<col width="30%"/>
    			<col width="30%"/>
				</colgroup>
  				<tr style="font-size: 40px;">
    				<th>City Name</th>
    				<th>Temp.Low</th> 
    				<th>Temp.High</th>
  				</tr>
  				</table>
  			</div>
  				<div style=" overflow:auto;height:90%;">
  				<table style="width:100%">
  				<colgroup>
    			<col width="40%"/>
    			<col width="30%"/>
    			<col width="30%"/>
				</colgroup>
  				<%for(int i = 0;i < Math.max(r.size(),20);++i)
  				{ 
  					if(i<r.size())
  					{%>
  						<tr style="font-size: 30px;">
  							<%String url = "Detail.jsp?index="+i;%>
    						<td><a href=<%=url%>><%=r.get(i).name%></a></td>
    						<td><%=r.get(i).main.tempMin%></td> 
    						<td><%=r.get(i).main.tempMax%></td>
  						</tr>
  					<%}
  					else
  					{%>
  						<tr style="font-size: 30px;">
    						<td><br></td>
    						<td><br>    </td> 
    						<td><br>   </td>
  						</tr>
  					<%}
  				}%>
				</table>
				</div>
		</div>
		<%}else{%>
			 <h1 align="center" style="color:white;position:relative;top:500px;">No city matches the search.</h1> 
		<%} %>
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
        document.getElementById("map").style.display = "none";
	 	document.getElementById("shadow").style.display = "none";
        document.myform.lat.value = event.latLng.lat().toFixed(2);
        document.myform.lng.value = event.latLng.lng().toFixed(2);
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