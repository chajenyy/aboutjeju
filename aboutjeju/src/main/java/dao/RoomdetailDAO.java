package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.RoomdetailVO;

public class RoomdetailDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public RoomdetailDAO() {
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

	// int rdno, int rno, String rimage

	public void insertImage(RoomdetailVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO roomdetail VALUES(null,?,?) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getRno());
			pstmt.setString(2, vo.getRimage());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// rno로 데이터가져오기
	public ArrayList<RoomdetailVO> select(int rno) {
		ArrayList<RoomdetailVO> list = new ArrayList<RoomdetailVO>();

		sb.setLength(0);
		sb.append("SELECT rdno, rno, rimage FROM roomdetail WHERE rno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int rdno = rs.getInt("rdno");
				String rimage = rs.getString("rimage");

				RoomdetailVO vo = new RoomdetailVO(rdno, rno, rimage);

				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// select() end
	
	public void deleteImg(int rno) {
		sb.setLength(0);
		sb.append("DELETE from roomdetail where rno = ? " );
		
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rno);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}//delete() end
	
	public void modifyImg(RoomdetailVO vo) {
		sb.setLength(0);
		sb.append("UPDATE roomdetail SET rimage=? where rno = ? " );
		
		try {
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1,vo.getRimage());
			pstmt.setInt(2, vo.getRno());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
