package classes;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		WeatherReader w = new WeatherReader();
		String path = getServletContext().getRealPath("weather.txt");
		String errorMess = "";
		errorMess += w.parseFile(path);
		if(errorMess==null||errorMess.trim().length()==0)
		{
			HttpSession session = request.getSession();
			session.setAttribute("cities", w.cities);
			session.setMaxInactiveInterval(3600);
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/HomePage.jsp");
			dispatch.forward(request, response);
		}
		else
		{
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println(errorMess);
		}
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
