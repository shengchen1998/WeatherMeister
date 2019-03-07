package classes;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register()
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
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try
		{
			String pw1 = request.getParameter("password").trim();
			String username = request.getParameter("username").trim();
			String pw2 = request.getParameter("confirmpassword").trim();
			if(pw1.length()==0||pw2.length()==0||username.length()==0)
			{
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("The information is incomplete.");
				return;
			}
			if(!pw1.equals(pw2))
			{
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("The passwords do not match.");
				return;
			}
			
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/userData?user=root&password=root&useSSL=false");
			
			ps = conn.prepareStatement("SELECT u.username FROM users u");
			/* ps.setString(1, name); */ // set first variable in prepared statement
			rs = ps.executeQuery();
			while (rs.next())
			{
				String un = rs.getString("username");
				if(un.equals(username))
				{
					response.setContentType("text/html");
					PrintWriter out = response.getWriter();
					out.println("This username is already taken.");
					return;
				}
			}
			ps = conn.prepareStatement("INSERT INTO users (username, pw) VALUES (?, ?)");
			ps.setString(1, username);
			ps.setString(2, pw1);
			ps.executeUpdate();
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", username);
			session.setMaxInactiveInterval(3600);
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
