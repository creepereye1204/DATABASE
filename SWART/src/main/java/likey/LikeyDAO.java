package likey;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.SQLException;

import util.DatabaseUtill;



public class LikeyDAO {



	

	public int like(String userID, String evaluationID, String userIP) {
		
		
		try {
			String SQL="SELECT * FROM likey WHERE userID=? AND evaluationID=?";
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			conn=DatabaseUtill.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			pstmt.setString(2,evaluationID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				System.out.print(rs.getString(3));
				return -1;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		
		
		
		
		String SQL = "INSERT INTO likey VALUES (?, ?, ?)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		
		
		
		
		
		
		try {

			conn=DatabaseUtill.getConnection();
			
			pstmt=conn.prepareStatement(SQL);
			
			pstmt.setString(1, userID);

			pstmt.setString(2, evaluationID);

			pstmt.setString(3, userIP);

			return pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return -1; // 추천 중복 오류

	}

	

}