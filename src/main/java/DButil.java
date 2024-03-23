import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class DButil {
    private static Properties props = new Properties();

    static {
        try {
            // Load the properties from the db.properties file
            FileInputStream in = new FileInputStream("C:\\Users\\Shashikant\\eclipse-workspace\\GroceryStore\\db.properties");
            props.load(in);
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getDBUrl() {
        return props.getProperty("db.url");
    }

    public static String getDBUser() {
        return props.getProperty("db.user");
    }

    public static String getDBPassword() {
        return props.getProperty("db.password");
    }
}
