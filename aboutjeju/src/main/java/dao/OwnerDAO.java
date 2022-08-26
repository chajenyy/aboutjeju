package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.OwnerVO;

public class OwnerDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public OwnerDAO() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("conn : " + conn);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB 연결 실패");
			e.printStackTrace();
		}
	}
	
	//id로 회원정보 가져오기
	public OwnerVO selectOne(String oid) {
		sb.setLength(0);
		sb.append("SELECT ofindpw, ofindpwa, oname, ophone FROM owner where oid = ? " );
		OwnerVO vo = null;
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, oid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String ofindpw = rs.getString("ofindpw");
				String ofindpwa = rs.getString("ofindpwa");
				String oname = rs.getString("oname");
				String ophone = rs.getString("ophone");
				
				vo = new OwnerVO(ofindpw, ofindpwa, oname, ophone);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vo;
		
	}
		
	// id 찾기
	public String findId(String oname, String ophone) {
		String oid = null;
		sb.setLength(0);
		sb.append("SELECT oid FROM owner WHERE oname = ? AND ophone = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, oname);
			pstmt.setString(2, ophone);

			rs = pstmt.executeQuery();

			rs.next();
			oid = rs.getString("oid");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return oid;
	}// findId() end

	// pw 찾기(회원 정보 입력값 일치 확인)
	public String findPw(String oid, String ofindpw, String ofindpwa) {
		String who = null;
		sb.setLength(0);
		sb.append("SELECT opw FROM owner WHERE oid = ? AND ofindpw = ? AND ofindpwa = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, oid);
			pstmt.setString(2, ofindpw);
			pstmt.setString(3, ofindpwa);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				who = "owner";
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return who;
	}// findPw() end

	// pw 변경
	public void changePw(String opw, String oid) {
		sb.setLength(0);
		sb.append("UPDATE owner SET opw = ? WHERE oid = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, opw);
			pstmt.setString(2, oid);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// changePw() end

	// 전체 사업자수 조회
	public int getOwnerCount() {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT count(ono) FROM owner ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("count(ono)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}// getOwnerCount() end

	// 로그인하기
	public OwnerVO login(String oid, String opw) {
		OwnerVO vo = null;

		sb.setLength(0);
		sb.append("SELECT ono, oid, opw, ofindpw, ofindpwa, oname, ophone FROM owner WHERE oid = ? AND opw = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, oid);
			pstmt.setString(2, opw);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				String ono = rs.getString("ono");
				String ofindpw = rs.getString("ofindpw");
				String ofindpwa = rs.getString("ofindpwa");
				String oname = rs.getString("oname");
				String ophone = rs.getString("ophone");
				
				vo = new OwnerVO(ono, oid, opw, ofindpw, ofindpwa, oname, ophone);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// login() end

	// id 중복체크
	public boolean idCheck(String id) {
		boolean isExist = false;

		sb.setLength(0);
		sb.append("SELECT oid FROM owner WHERE oid = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				isExist = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isExist;
	}// idCheck() end

	// 사업자번호 중복체크
	public boolean onoCheck(String ono) {
		boolean isExist = false;

		sb.setLength(0);
		sb.append("SELECT ono FROM owner WHERE ono = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, ono);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				isExist = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isExist;
	}// idCheck() end

	// 회원가입
	public void insertOne(String ono, String id, String pw, String pwq, String pwa, String name, String phone) {
		sb.setLength(0);
		sb.append("INSERT INTO owner VALUES(?, ?, ?, ?, ?, ?, ? ) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, ono);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			pstmt.setString(4, pwq);
			pstmt.setString(5, pwa);
			pstmt.setString(6, name);
			pstmt.setString(7, phone);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// insertOne() end
	
	public void updateOne(String pw, String pwq, String pwqa, String name, String phone, String oid) {
		sb.setLength(0);
		sb.append("UPDATE owner SET opw = ?, ofindpw = ?, ofindpwa=?, oname=?, ophone=? where oid=? ");
		
		try {
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, pw);
			pstmt.setString(2, pwq);
			pstmt.setString(3, pwqa);
			pstmt.setString(4, name);
			pstmt.setString(5, phone);
			pstmt.setString(6, oid);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}//updateOne() end
		
	
	// 회원탈퇴(foreign key 체크해제)
	public void deleteCheckCancel() {
		sb.setLength(0);
		sb.append("SET foreign_key_checks = 0 ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.executeUpdate();
			System.out.println("회원탈퇴 성공");
		} catch (SQLException e) {
			System.out.println("회원탈퇴 실패");
			e.printStackTrace();
		}
	}	
	// 회원탈퇴
	public void deleteOne(String oid) {
		sb.setLength(0);
		sb.append("DELETE FROM owner WHERE oid = ? ");
			
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1,  oid);
				
			pstmt.executeUpdate();
			System.out.println("회원탈퇴 성공");
		} catch (SQLException e) {
			System.out.println("회원탈퇴 실패");
			e.printStackTrace();
		}
	}	
	// 회원탈퇴(foregin key 다시 체크설정)
	public void deleteReCheck() {
		sb.setLength(0);
		sb.append("SET foreign_key_checks = 1; ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.executeUpdate();
			System.out.println("회원탈퇴 성공");
		} catch (SQLException e) {
			System.out.println("회원탈퇴 실패");
			e.printStackTrace();
		}
	}
	
	// 자원반납
	public void close() {

		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// close() end

}
