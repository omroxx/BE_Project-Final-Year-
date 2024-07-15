package Donor;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Blockchain.ptop;

@WebServlet("/donateot")
@MultipartConfig(maxFileSize = 16177215) // Max size for the uploaded file (in bytes)
public class DonateOtherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/ngo1";
        String dbUser = "root";
        String dbPassword = "sql@123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String donorEmail = request.getParameter("donorEmail");
            String donorName = request.getParameter("donorName");
            String donationCategory = request.getParameter("donationCategory");
            String description = request.getParameter("description");

            // Handling file upload (donation image)
            Part filePart = request.getPart("donationImage");
            InputStream inputStream = filePart.getInputStream();

            String ngoName = request.getParameter("ngoName");

            // SQL query to insert data into the donation_details table
            String sql = "INSERT INTO donation_details (donor_email, donor_name, donation_category, description, donation_image, ngo_name) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, donorEmail);
            preparedStatement.setString(2, donorName);
            preparedStatement.setString(3, donationCategory);
            preparedStatement.setString(4, description);
            preparedStatement.setBlob(5, inputStream);
            preparedStatement.setString(6, ngoName);

            // Execute the query
           int c= preparedStatement.executeUpdate();
           if(c>0)
           {
        	   int noofnode=4;
				String datainfo=donorEmail+ donorName+donationCategory+description+ngoName;
				ptop.ptopverify(noofnode,datainfo);
           }
            // Close resources
            preparedStatement.close();
           
            // Redirect to a success page
            response.sendRedirect("DisplayforDonor.jsp");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle errors or redirect to an error page
            response.sendRedirect("donationError.jsp");
        }
    }
}
