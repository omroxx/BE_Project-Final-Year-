package Donor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.protocol.Resultset;

import Blockchain.ptop;

//import com.mysql.cj.xdevapi.Statement;
@WebServlet("/donate")
public class Donate extends HttpServlet{
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
		HttpSession hs=req.getSession();
		String id=hs.getAttribute("nid").toString();
		int nid=Integer.parseInt(id);
		String fullname=req.getParameter("name");
		String email=req.getParameter("email");
		
		hs.setAttribute("un",fullname);
		String gender=req.getParameter("gender");
		
		int amt=Integer.parseInt(req.getParameter("amt"));
		String ngoname=getname( nid);
		String q="insert into paymentdata (ngo_name,full_name,email,gender,amt) values(?,?,?,?,?)";
		PreparedStatement ps=null;
		try {

			ps=con.prepareStatement(q);
			ps.setString(1, ngoname);
			ps.setString(2, fullname);
			ps.setString(3,email);
			ps.setString(4,gender);
			ps.setInt(5, amt);
			int c=ps.executeUpdate();
			if(c>0)
			{
				int noofnode=4;
				String datainfo=ngoname+ fullname+email+gender+amt;
				ptop.ptopverify(noofnode,datainfo);
			}
			PrintWriter pw=resp.getWriter();
			pw.print(amt+" donate  successfully");
			RequestDispatcher rd=req.getRequestDispatcher("/DisplayforDonor.jsp");
			
			rd.forward(req, resp);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
	
	
	
	private String getname(int id) {
		String q="select * from ngos where nid='"+id+"'";
		Statement s=null;
		ResultSet rs=null;
		String name=null;
		try {
			s=con.createStatement();
			rs=s.executeQuery(q);
			while(rs.next())
			{
				name=rs.getString("nname");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return name;
	}

}
