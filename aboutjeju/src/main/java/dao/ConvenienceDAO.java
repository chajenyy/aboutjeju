package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;

import vo.ConvenienceVO;

public class ConvenienceDAO {
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
		String user = "smith";
		String password = "tigertiger1";
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
	
	public ConvenienceDAO(){
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

	// 숙소번호로 편의사항 가져오기
	public ArrayList<ConvenienceVO> selectAll(int ano) {
		ArrayList<ConvenienceVO> list = new ArrayList<ConvenienceVO>();
		sb.setLength(0);
		sb.append("SELECT cvno, ano, coption FROM convenience WHERE ano = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int cvno = rs.getInt("cvno");
				String coption = rs.getString("coption");
				ConvenienceVO vo = new ConvenienceVO(cvno, ano, coption);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}// selectAll() end

	// 체크한 편의사항에 맞는 이미지 추가
	public void addImage(ConvenienceVO vo) {
		sb.setLength(0);
		sb.append("INSERT into convenience VALUES(null, ?, ?) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getAno());
			pstmt.setString(2, vo.getCoption());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}// addImage() end

	// 편의사항 삭제
	public void delete(int ano) {
		sb.setLength(0);
		sb.append("DELETE FROM convenience WHERE ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// delete() end

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
