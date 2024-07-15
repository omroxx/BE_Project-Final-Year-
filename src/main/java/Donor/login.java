package Donor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/login")
public class login  extends HttpServlet{
	static Connection con=null;
	@Override
	public void init() throws ServletException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ngo1","root","sql@123");
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email=req.getParameter("email");
		
		String pass=req.getParameter("pass");
		PreparedStatement ps=null;
		PrintWriter pw=resp.getWriter();
		String q="select * from donor where email=? and pass=?";
		
		ResultSet rs=null;
		try {
			ps=con.prepareStatement(q);
			
			ps.setString(1,email);
		
			ps.setString(2,pass);
			
			rs=ps.executeQuery();
			if(rs.next())
			{
				String name=rs.getString("fname");
				HttpSession session=req.getSession();
				session.setAttribute("un",name);
//				pw.print("<h1> welcome"+rs.getString(2)+"</h1>");
				RequestDispatcher rd=req.getRequestDispatcher("DisplayforDonor.jsp");
				rd.include(req, resp);
//				resp.sendRedirect(name)
			}
			else
			{
				pw.print("<h1> invalide email and password</h1>");
				RequestDispatcher rd=req.getRequestDispatcher("/donorloginreg.html");
				rd.include(req, resp);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
