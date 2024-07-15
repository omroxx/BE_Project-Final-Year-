package NGOS;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.print.DocFlavor.INPUT_STREAM;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@WebServlet("/nsignupn")
@MultipartConfig
public class signup extends HttpServlet{
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
		String nname=req.getParameter("nname");
		String ncon=req.getParameter("ncon");
		String naddr=req.getParameter("naddr");
		String nemail=req.getParameter("nemail");
		String npass=req.getParameter("npass");
		String nwork=req.getParameter("nwork");
		String ndesc=req.getParameter("ndesc");
		Part filep=req.getPart("nimg");
		InputStream fileis=filep.getInputStream();
		PreparedStatement ps=null;
		String q="insert into ngos (nname,ncon,naddr,nemail,npass,nwork,ndesc,nimg) values (?,?,?,?,?,?,?,?)";
		PrintWriter pw=resp.getWriter();
//		RequestDispatcher rd=req.getRequestDispatcher("");
		try {
			ps=con.prepareStatement(q);
			ps.setString(1,nname);
			ps.setString(2,ncon);
			ps.setString(3,naddr);
			ps.setString(4,nemail);
			ps.setString(5,npass);
			ps.setString(6,nwork);
			ps.setString(7,ndesc);
			ps.setBlob(8, fileis);
			int c=ps.executeUpdate();
			pw.print("<script>");
			pw.print("alert('NGO registration successful! Please login.')");
			pw.print("</script>");
			resp.sendRedirect("ngologreg.html");
			} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
