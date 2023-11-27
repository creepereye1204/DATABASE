package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DatabaseUtill;

public class EvaluationDAO {
	public int write(EvaluationDTO elEvaluationDTO) {
		String SQL="INSERT INTO evaluation VALUES (NULL,?,?,?,?,?,?,?,?,?,?,?,?,0)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			
			conn = DatabaseUtill.getConnection();
			pstmt = conn.prepareStatement (SQL);
			pstmt.setString(1, elEvaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, elEvaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3,elEvaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, elEvaluationDTO.getLectureYear());
			pstmt.setString(5,elEvaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, elEvaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7,elEvaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8,elEvaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, elEvaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, elEvaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11,elEvaluationDTO.getComfortableScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(12, elEvaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try{if(conn!=null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt!=null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(rs!=null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -2;//로그인 실패
	}
	
	public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search, int pageNumber){
		if(lectureDivide.equals("전체")) {
			lectureDivide="";
		}
		ArrayList<EvaluationDTO> evaluationList=null;
		String SQL="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			if(searchType.equals("최신순")) {
				SQL="SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent) LIKE "+
						"? ORDER BY evaluationID DESC LIMIT "+pageNumber*5+", "+pageNumber*5+6;
			}
			else if(searchType.equals("추천순")) {
				SQL="SELECT * FROM evaluation WHERE lectureDivide LIKE ? AND CONCAT(lectureName,professorName,evaluationTitle,evaluationContent) LIKE "+
						"? ORDER BY likeCount DESC LIMIT "+pageNumber*5+", "+pageNumber*5+6;
			}
			conn=DatabaseUtill.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, "%"+lectureDivide+"%");
			pstmt.setString(2, "%"+search+"%");
			rs=pstmt.executeQuery();
			evaluationList= new ArrayList<>();
			while (rs.next()) {
				EvaluationDTO evaluationDTO = new EvaluationDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getInt(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11),
						rs.getString(12),
						rs.getString(13),
						rs.getInt(14)
						
						);
				evaluationList.add(evaluationDTO);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try{if(conn!=null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt!=null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(rs!=null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList;
		
	}
	public int like(String evaluationID) {
		String SQL="UPDATE evaluation SET likeCount = likeCount+1 WHERE evaluationID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=DatabaseUtill.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,evaluationID);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try{if(conn!=null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt!=null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(rs!=null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	public int delete(String evaluationID) {
		String SQL="DELETE FROM evaluation WHERE evaluationID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=DatabaseUtill.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,evaluationID);
			
			return pstmt.executeUpdate();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try{if(conn!=null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt!=null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(rs!=null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	public String getUserID(String evaluationID) {
		String SQL="SELECT userID FROM evaluation WHERE evaluationID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		System.out.println("sfew,,fweweg~~");
		try {
			conn=DatabaseUtill.getConnection();
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,evaluationID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}
		catch (Exception e) {
			
			e.printStackTrace();
		}
		finally {
			try{if(conn!=null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(pstmt!=null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try{if(rs!=null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		
		return null;
	}
}
