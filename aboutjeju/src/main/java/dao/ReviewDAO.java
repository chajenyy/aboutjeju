package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ReviewVO;

public class ReviewDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public ReviewDAO() {
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
	
	

	
	// ano로 해당숙소의 리뷰 가져오기
	public ArrayList<ReviewVO> selectAll(int ano){
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("SELECT reviewno,bno,title,contents,star,rdate"
				+ ",comment FROM review WHERE ano = ? ");
		try {
			pstmt= conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int reviewno = rs.getInt("reviewno");
				int bno = rs.getInt("bno");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				int star = rs.getInt("star");
				String rdate = rs.getString("rdate");
				String comment = rs.getString("comment");
				
				ReviewVO vo = new ReviewVO(reviewno, bno, ano, title, contents, star, rdate, comment);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	} // selectAll() end

	public ArrayList<ReviewVO> selectPaging(int ano, int startNo){
		ArrayList<ReviewVO> list = new ArrayList<ReviewVO>();
		sb.setLength(0);
		sb.append("SELECT reviewno,bno,title,contents,star,rdate,comment"
				+ " FROM review WHERE ano = ? ");
		sb.append("ORDER BY reviewno limit ? ,7 ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);
			pstmt.setInt(2, startNo);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int reviewno = rs.getInt("reviewno");
				int bno = rs.getInt("bno");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				int star = rs.getInt("star");
				String rdate = rs.getString("rdate");
				String comment = rs.getString("comment");
				
				ReviewVO vo = new ReviewVO(reviewno, bno, ano, title, contents, star, rdate, comment);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 데이터 1개 입력하기
	public void insertOne(int bno, int ano, String title, String contents, int star) {
		sb.setLength(0);
		sb.append("INSERT INTO review VALUES(null, ?, ?, ?, ?, ?, sysdate(), null) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, bno);
			pstmt.setInt(2, ano);
			pstmt.setString(3, title);
			pstmt.setString(4, contents);
			pstmt.setInt(5, star);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// insertOne() end

	// 전체 리뷰수 조회
	public int getReviewCount() {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT count(reviewno) FROM review ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("count(reviewno)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}// getReviewCount() end

	// ano로 숙소하나 리뷰 개수 조회
	public int getCountOne(int ano) {
		int num = 0;
		sb.setLength(0);
		sb.append("SELECT count(*) cnt FROM review WHERE ano = ? ");
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return num;
	}
	
	// bno로 리뷰 조회
	public boolean selectOne(int bno) {
		boolean isExist = false;

		sb.setLength(0);
		sb.append("SELECT reviewno FROM review WHERE bno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, bno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				isExist = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isExist;
	}// selectOne() end

	// 숙소별 평균별점구하기
	public float getAvgStar(int ano) {
		float star = 0f;
		
		sb.setLength(0);
		sb.append("SELECT avg(star) FROM review WHERE ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			rs = pstmt.executeQuery();

			rs.next();
			star = rs.getFloat("avg(star)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return star;
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
