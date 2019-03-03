package classes;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.Gson;

public class Test
{
	public static void main(String[]args)
    {
		try
		{
			URL url = new URL("http://api.openweathermap.org/data/2.5/weather?id=2172797&APPID=cbe1e2646d0c5436c0e8a24f808617a7");
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
	    	Response response = gson.fromJson(r,Response.class);
	    	System.out.println(response.name);
		}catch(Exception e)
		{
			
		}
		Gson gson = new Gson();
    	City c = gson.fromJson("{\r\n" + 
    			"    \"id\": 707860,\r\n" + 
    			"    \"name\": \"Hurzuf\",\r\n" + 
    			"    \"country\": \"UA\",\r\n" + 
    			"    \"coord\": {\r\n" + 
    			"      \"lon\": 34.283333,\r\n" + 
    			"      \"lat\": 44.549999\r\n" + 
    			"    }\r\n" + 
    			"  }",City.class);
    	System.out.println(c.country);
		
    }
}	


