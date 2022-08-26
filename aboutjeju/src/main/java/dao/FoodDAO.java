package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.FoodVO;

public class FoodDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public FoodDAO() {
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

	// 데이터 가져오기
	public ArrayList<FoodVO> selectAll(int startNo, String category) {
		ArrayList<FoodVO> list = new ArrayList<FoodVO>();

		// int fno, String fname, String faddress, String fdetail, String fphone, String
		// fimage)
		sb.setLength(0);
		sb.append("SELECT fno, fname, faddress, fdetail, fphone, fimage ");
		sb.append("FROM food WHERE faddress REGEXP ? ORDER BY fno ");
		sb.append("LIMIT ?, 10 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, category);
			pstmt.setInt(2, startNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int fno = rs.getInt("fno");
				String fname = rs.getString("fname");
				String faddress = rs.getString("faddress");
				String fdetail = rs.getString("fdetail");
				String fphone = rs.getString("fphone");
				String fimage = rs.getString("fimage");

				FoodVO vo = new FoodVO(fno, fname, faddress, fdetail, fphone, fimage);

				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// selectAll() end

	// 데이터 갯수 찾기
	public int getTotalCount(String category) {
		int ttl = 0;

		sb.setLength(0);
		sb.append("SELECT count(fno) FROM food WHERE faddress REGEXP ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, category);

			rs = pstmt.executeQuery();

			rs.next();

			ttl = rs.getInt("count(fno)");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ttl;
	}// getTotalCount() end

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
