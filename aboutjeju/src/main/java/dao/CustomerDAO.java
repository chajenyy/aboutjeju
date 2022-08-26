package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.CustomerVO;

public class CustomerDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();
 
	public CustomerDAO() {
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
	

	// id로 회원정보 가져오기
	public CustomerVO selectOne(String cid) {
		sb.setLength(0);
		sb.append("SELECT cfindpw, cfindpwa, cname, cphone FROM customer where cid =? ");
		CustomerVO vo = null;

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, cid);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				String cfindpw = rs.getString("cfindpw");
				String cfindpwa = rs.getString("cfindpwa");
				String cname = rs.getString("cname");
				String cphone = rs.getString("cphone");
				vo = new CustomerVO(cfindpw, cfindpwa, cname, cphone);

				System.out.println("cifndpw: " + cfindpw);
				System.out.println("cifndpwa: " + cfindpwa);
				System.out.println("cname: " + cname);
				System.out.println("cphone: " + cphone);
			}
			;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("error 여기");
		}
		return vo;
	}// selectOne() end

	// id 찾기
	public String findId(String cname, String cphone) {
		String cid = null;
		sb.setLength(0);
		sb.append("SELECT cid FROM customer WHERE cname = ? AND cphone = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, cname);
			pstmt.setString(2, cphone);

			rs = pstmt.executeQuery();

			rs.next();
			cid = rs.getString("cid");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cid;
	}// findId() end

	// pw 찾기(회원 정보 입력값 일치 확인)
	public String findPw(String cid, String cfindpw, String cfindpwa) {
		String who = null;
		sb.setLength(0);
		sb.append("SELECT cpw FROM customer WHERE cid = ? AND cfindpw = ? AND cfindpwa = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, cid);
			pstmt.setString(2, cfindpw);
			pstmt.setString(3, cfindpwa);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				who = "customer";
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return who;
	}// findPw() end

	// pw 변경
	public void changePw(String cpw, String cid) {
		sb.setLength(0);
		sb.append("UPDATE customer SET cpw = ? WHERE cid = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, cpw);
			pstmt.setString(2, cid);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// changePw() end

	// 전체 회원수 조회
	public int getCustomerCount() {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT count(cno) FROM customer ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("count(cno)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}// getCustomerCount() end

	// 로그인하기
		public CustomerVO login(String cid, String cpw) {
			CustomerVO vo = null;

		sb.setLength(0);
		sb.append("SELECT cno, cid, cpw, cfindpw, cfindpwa, cname, cphone FROM customer WHERE cid = ? AND cpw = ? ");

			try {
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, cid);
				pstmt.setString(2, cpw);

				rs = pstmt.executeQuery();
			if (rs.next()) {
				int cno = rs.getInt("cno");
				String cfindpw = rs.getString("cfindpw");
				String cfindpwa = rs.getString("cfindpwa");
				String cname = rs.getString("cname");
				String cphone = rs.getString("cphone");

				vo = new CustomerVO(cno, cid, cpw, cfindpw, cfindpwa, cname, cphone);
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
		sb.append("SELECT cid FROM customer WHERE cid = ? ");

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

	// 회원가입
	public void insertOne(String id, String pw, String pwq, String pwa, String name, String phone) {
		sb.setLength(0);
		sb.append("INSERT INTO customer VALUES(null, ?, ?, ?, ?, ?, ?) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, pwq);
			pstmt.setString(4, pwa);
			pstmt.setString(5, name);
			pstmt.setString(6, phone);

			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// insertOne() end
	

	// update customer set cpw = 'aaa' where cid = 'ccc0';
	// update customer set cname = '고영희' where cid = 'ccc0';
	public void updateOne(String pw, String pwq, String pwqa, String name, String phone, String cid) {
		sb.setLength(0);
		sb.append("UPDATE customer SET cpw = ?, cfindpw = ?, cfindpwa = ?, cname = ?, cphone = ? WHERE cid = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, pw);
			pstmt.setString(2, pwq);
			pstmt.setString(3, pwqa);
			pstmt.setString(4, name);
			pstmt.setString(5, phone);
			pstmt.setString(6, cid);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// updateOne() end

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
	public void deleteOne(String cid) {
		sb.setLength(0);
		sb.append("DELETE FROM customer2 WHERE cid = ? ");
			
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1,  cid);
				
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

//	public static void main(String[] args) {
//		CustomerDAO dao = new CustomerDAO();
//		CustomerVO vo = dao.selectOne("ccc4");
//		
//		System.out.println(vo==null);
//		
//		System.out.println("cifndpw: " + vo.getCfindpw());
//		System.out.println("cname: " + vo.getCname());
//		System.out.println("cphone: " + vo.getCphone());
//	}
}