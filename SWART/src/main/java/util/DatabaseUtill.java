package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtill {
	public static Connection getConnection() {
		try {
			System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");
			String dbURL="jdbc:mysql://localhost:3307/LectureEvaluation";
			String dbID="YourId";
			String dbPassword="YourPassword";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

}
