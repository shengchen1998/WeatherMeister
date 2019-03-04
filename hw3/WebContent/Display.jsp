<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList" import="classes.Response" 
    import="classes.City" import="java.lang.Integer"
    import="java.io.BufferedReader,java.io.FileNotFoundException,java.io.FileReader"
    import="java.io.IOException,java.io.InputStream,java.io.InputStreamReader"
    import="java.io.UnsupportedEncodingException,java.net.HttpURLConnection,java.net.URL"
    import="com.google.gson.Gson,com.google.gson.GsonBuilder,com.google.gson.stream.JsonReader"
%>
<!DOCTYPE html>
<%
	String searchWay = request.getParameter("search");
String order = request.getParameter("order");
ArrayList<City> c = (ArrayList<City>)session.getAttribute("cityList");
ArrayList<Response> result = new ArrayList<Response>();
if(searchWay.equals("name"))
{
	String cityName = request.getParameter("cityname").trim();
	
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
		System.out.println("lat"+lat);
		t = lng*100;
		lng = ((int)t)/100.00;
		System.out.println("lng"+lng);
		System.out.println("lat"+c.get(0).coord.lat);
		System.out.println("lng"+c.get(0).coord.lon);
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
			function show(index1,index2)
			{
				document.getElementById(index1).style.display = "";
		  		document.getElementById(index2).style.display = "none";
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
			#table
			{
			}
			
		</style>
		<meta charset="ISO-8859-1">
		<title>Display</title>
	</head>
	<body onload="options();">
	<%
		ArrayList<Response> r = (ArrayList<Response>)session.getAttribute("result");
	%>
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
	</body>
</html>