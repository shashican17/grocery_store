import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Register")

public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	private static Properties getConnectionData() {

        Properties props = new Properties();

        String fileName = "C:\\Users\\Shashikant\\eclipse-workspace\\GroceryStore\\db.properties";

        try (FileInputStream in = new FileInputStream(fileName)) {
            props.load(in);
        } catch (IOException ex) {
            Logger lgr = Logger.getLogger(LoginServlet.class.getName());
            lgr.log(Level.SEVERE, ex.getMessage(), ex);
        }

        return props;
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String userType = request.getParameter("userType");
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch(ClassNotFoundException e){
			System.out.println(e);
		}
		 Properties props = getConnectionData();

	     String url = props.getProperty("db.url");
	     String user = props.getProperty("db.user");
	     String passwd = props.getProperty("db.passwd");
	     response.setContentType("text/html");
	     PrintWriter out = response.getWriter();
	     out.println("<h1>hi</h1>");
	     try {
	    	 Connection con = DriverManager.getConnection(url, user, passwd);
	    	 String maxIdQuery = "SELECT MAX(id) FROM users";
	    	 PreparedStatement getMaxIdStatement = con.prepareStatement(maxIdQuery);
	    	 ResultSet resultSet = getMaxIdStatement.executeQuery();

	    	 int maxId = 0; 

	    	 if (resultSet.next()) {
	    	     maxId = resultSet.getInt(1); 
	    	 }
	    	 int newId = maxId + 1;
	    	 

	    	 String sql = "INSERT INTO users (id,username,password,email,user_type) VALUES (?,?,?,?,?)";
	         PreparedStatement stmt = con.prepareStatement(sql);
	         stmt.setInt(1, newId);
	         stmt.setString(2, username);
	         stmt.setString(3, password);
	         stmt.setString(4, email);
	         stmt.setString(5, userType);
	         int rowsAffected = stmt.executeUpdate();
	         
	         if (rowsAffected > 0) {
	        	 response.sendRedirect("success.html");
	         }
	     }
	     catch (Exception e) {
	            e.printStackTrace();
	        }
	}

}
