package classes;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;

public class Test
{
	public static void main(String[] args)
	{
//		try
//		{
//			URL url = new URL("http://api.openweathermap.org/data/2.5/weather?id=2172797&APPID=cbe1e2646d0c5436c0e8a24f808617a7");
//			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
//			connection.setRequestMethod("GET");
//			connection.connect();
//			InputStream inputStream = connection.getInputStream();
//			BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream ));
//			StringBuffer sb = new StringBuffer();
//			String line = null;
//		    while ((line = reader.readLine()) != null) {
//		        sb.append(line + "\n");
//		    }
//
//		    String r = sb.toString();
//		    Gson gson = new Gson();
//	    	Response response = gson.fromJson(r,Response.class);
//	    	System.out.println(response.name);
//		}catch(Exception e)
//		{
//			
//		}
//		Gson gson = new Gson();
//    	City c = gson.fromJson("{\r\n" + 
//    			"    \"id\": 707860,\r\n" + 
//    			"    \"name\": \"Hurzuf\",\r\n" + 
//    			"    \"country\": \"UA\",\r\n" + 
//    			"    \"coord\": {\r\n" + 
//    			"      \"lon\": 34.283333,\r\n" + 
//    			"      \"lat\": 44.549999\r\n" + 
//    			"    }\r\n" + 
//    			"  }",City.class);
//    	System.out.println(c.country);
		FileReader reader = null;
		try
		{
			reader = new FileReader("C:\\Users\\sheng\\Documents\\GitHub\\201hw3\\hw3\\WebContent\\city.list.json");
		} catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
		JsonReader jsonReader = new JsonReader(reader);
		ArrayList<City> cityList = new ArrayList<City>();
		try
		{
//			InputStream inStream = openFileInput(FILE_NAME);
//			JsonReader reader = new JsonReader(new InputStreamReader(br, "UTF-8"));
			Gson gson = new GsonBuilder().create();
			
			// Read file in stream mode
			jsonReader.beginArray();
			while (jsonReader.hasNext())
			{
				// Read data into object model
				City c = gson.fromJson(jsonReader, City.class);
				cityList.add(c);
				
			}
			reader.close();
			for(int i = 0;i < cityList.size();++i)
			{
				System.out.println(cityList.get(i).name);
			}
			
		} catch (UnsupportedEncodingException ex)
		{
			
		} catch (IOException ex)
		{
			
		}
		
	}
}
