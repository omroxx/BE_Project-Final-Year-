package Admin;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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

@WebServlet("/addEventServlet")
@MultipartConfig
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database connection parameters
    private final String jdbcURL = "jdbc:mysql://localhost:3306/ngo1";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "sql@123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String title = request.getParameter("eventTitle");
        String description = request.getParameter("eventDescription");
        Part imagePart = request.getPart("eventImage");
        
        // Establish database connection
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
            // Prepare SQL statement
            String sql = "INSERT INTO events (title, description, image) VALUES (?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, title);
                statement.setString(2, description);
                
                // Set image parameter
                if (imagePart != null) {
                    InputStream imageStream = imagePart.getInputStream();
                    statement.setBlob(3, imageStream);
                }
                
                // Execute SQL statement
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    // Event added successfully
                    PrintWriter out = response.getWriter();
                    out.println("<html><body><h1>Event added successfully</h1></body></html>");
                    response.sendRedirect("addevents.jsp");
                } else {
                    // Error occurred while adding event
                    PrintWriter out = response.getWriter();
                    out.println("<html><body><h1>Error adding event</h1></body></html>");
                    response.sendRedirect("addevents.jsp");
                }
            }
        } catch (SQLException e) {
            // Handle database connection errors
            throw new ServletException("Database connection error", e);
        }
    }
}
