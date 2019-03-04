package classes;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.stream.JsonReader;

/**
 * Servlet implementation class Reader
 */
@WebServlet("/Reader")
public class Reader extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Reader()
	{
		super();
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String path = getServletContext().getRealPath("city.list.json");
		System.out.println(path);
		FileReader reader = null;
		try
		{
			reader = new FileReader(path);
		} catch (FileNotFoundException e)
		{
		}
		JsonReader jsonReader = new JsonReader(reader);
		ArrayList<City> cityList = new ArrayList<City>();
		System.out.println(path);
		try
		{
			Gson gson = new GsonBuilder().create();
			jsonReader.beginArray();
			while (jsonReader.hasNext())
			{
				City c = gson.fromJson(jsonReader, City.class);
				cityList.add(c);
			}
			reader.close();
			
			
		} catch (UnsupportedEncodingException ex)
		{
		} catch (IOException ex)
		{
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("cityList", cityList);
		session.setMaxInactiveInterval(3600);
//		ArrayList<City> c = (ArrayList<City>) session.getAttribute("cityList");
//		for (int i = 0; i < c.size(); ++i)
//			{
//				System.out.println(c.get(i).name);
//			}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
