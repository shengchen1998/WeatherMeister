<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.ArrayList" 
	import="classes.Response" import="classes.Weather" 
	import="classes.Clouds"
	import="classes.Coord"
	import="classes.Main"
	import="classes.Sys"
	import="classes.Wind"
	import="java.util.List"
	import="com.google.gson.Gson"
	%>
<!DOCTYPE html>
<html>
<head>
<script>

</script>
<meta charset="ISO-8859-1">
<title>Index</title>
<script>
		
		</script>
</head>
<body>

	<%Gson gson = new Gson();
	Response res = gson.fromJson("{\"coord\":{\"lon\":145.77,\"lat\":-16.92},\"weather\":[{\"id\":802,\"main\":\"Clouds\",\"description\":\"scattered clouds\",\"icon\":\"03n\"}],\"base\":\"stations\",\"main\":{\"temp\":300.15,\"pressure\":1007,\"humidity\":74,\"temp_min\":300.15,\"temp_max\":300.15},\"visibility\":10000,\"wind\":{\"speed\":3.6,\"deg\":160},\"clouds\":{\"all\":40},\"dt\":1485790200,\"sys\":{\"type\":1,\"id\":8166,\"message\":0.2064,\"country\":\"AU\",\"sunrise\":1485720272,\"sunset\":1485766550},\"id\":2172797,\"name\":\"Cairns\",\"cod\":200}",Response.class);
	String str = res.weather.get(0).main; %>
	<%=str %>
</body>
</html>