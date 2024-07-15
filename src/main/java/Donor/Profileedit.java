package Donor;

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
@WebServlet("/editd")
public class Profileedit extends HttpServlet {
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
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session=req.getSession();
		String data=(String)session.getAttribute("fname");
	     	
		String fname=req.getParameter("fn");
		String lname=req.getParameter("ln");
		String email=req.getParameter("email");
		String phone=req.getParameter("tel");
		String pass=req.getParameter("pass");
		PreparedStatement ps=null;
		PrintWriter pw=resp.getWriter();
		String q="update donor set fname=?,lname=?,email=?,phone=?,pass=? where fname=?";
		try {
			ps=con.prepareStatement(q);
			ps.setString(1,fname);
			ps.setString(2,lname);
			ps.setString(3,email);
			ps.setString(4,phone);
			ps.setString(5,pass);
			ps.setString(6, data);
			int c=ps.executeUpdate();
			String status="profile upadtes";
			session.setAttribute("msg", status);
			session.setAttribute("fname", fname);
			resp.sendRedirect("DonorProfile.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
