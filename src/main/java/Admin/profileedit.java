package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/aedit")
public class profileedit extends HttpServlet{
	public static	Connection con=null;
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
		
	}@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String data=(String)session.getAttribute("aemail");
	     	
		String email=req.getParameter("aemail");
		String pass=req.getParameter("apass");
		PreparedStatement ps=null;
		PrintWriter pw=resp.getWriter();
		
		String q="update admins set aemail=?,apass=? where aemail=?";
		try {
			ps=con.prepareStatement(q);
			ps.setString(1, email);
			ps.setString(2, pass);
			ps.setString(3, data);
			ps.executeUpdate();
//			pw.print("profile updated successfully");
			String status="profile upadtes";
			session.setAttribute("msg", status);
			session.setAttribute("aemail", email);
			resp.sendRedirect("AdminProfile.jsp");
//			session.removeAttribute("aemail");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	}
