package classes;



import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.WeatherInfo;
import jdk.internal.org.objectweb.asm.tree.IntInsnNode;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String searchWay = request.getParameter("search");
		HttpSession session = request.getSession();
		ArrayList<WeatherInfo> w = (ArrayList<WeatherInfo>)session.getAttribute("cities");
		ArrayList<WeatherInfo> result = new ArrayList<WeatherInfo>();
		if(searchWay.equals("name"))
		{
			String cityName = request.getParameter("cityname");
			
			for(int i = 0;i<w.size();++i)
			{
				if(w.get(i).getCity().equals(cityName))
				{
					result.add(w.get(i));
				}
			}
		}
		else {

		}
		session.setAttribute("result", result);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/Display.jsp");
		dispatch.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
