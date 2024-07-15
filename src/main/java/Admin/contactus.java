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
@WebServlet("/contact")
public class contactus extends HttpServlet{
	Connection con=null;
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
		String name=req.getParameter("cname");
		String email=req.getParameter("cemail");
		String query=req.getParameter("cquery");
		String q="insert into contactus(cname,cemail,cque) values(?,?,?)";
		PreparedStatement ps=null;
		try {
			ps=con.prepareStatement(q);
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, query);
			ps.executeUpdate();
			PrintWriter pw=resp.getWriter();
			pw.print("message send successfully");
			RequestDispatcher rs=req.getRequestDispatcher("/contactus.html");
			rs.include(req, resp);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
