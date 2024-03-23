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
import javax.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
	private static Properties getConnectionData() {

        Properties props = new Properties();

        //String fileName = "src/main/resources/db.properties";
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
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("password", password);
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
	    	 String sql = "SELECT * FROM users";
	         PreparedStatement stmt = con.prepareStatement(sql);
	         ResultSet rs = stmt.executeQuery();
	         out.println("<h1>hi</h1>");
	         while(rs.next()) {
	        	 if (rs.getString("username").equals(username) && rs.getString("password").equals(password)) {
	        		 out.println("hi");
	                 if(rs.getString("user_type").equals("buyer"))
	                 { 
	                	response.sendRedirect("products.jsp"); 
	                 	break;
	                 }
	                 else if (rs.getString("user_type").equals("shopkeeper")) {
	                	 response.sendRedirect("shopkeeper.jsp"); 
	                	 break;
	                 }
	             } /*else {
	                 response.sendRedirect("login.jsp?error=1");
	                 break;
	             }*/
	         }
	     }
	     catch (Exception e) {
	            e.printStackTrace();
	            // Handle errors here
	        }
        
       
    }
}