package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import vo.RoomVO;

public class RoomDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public RoomDAO() {
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

	// 방 추가
	public void insertRoom(RoomVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO room VALUES(null,?,?,?,?,?,?) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());

			pstmt.setInt(1, vo.getAno());
			pstmt.setString(2, vo.getRtype());
			pstmt.setInt(3, vo.getRcount());
			pstmt.setInt(4, vo.getPrice());
			pstmt.setInt(5, vo.getDiscount());
			pstmt.setInt(6, vo.getRpeople());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} // insertRoom() end

	// 숙소번호로 해당 숙소에서 가장 최근에 추가한 방의 rno 가져오기
	public int getRno(int ano) {
		int rno = 0;

		sb.setLength(0);
		sb.append("SELECT rno FROM room WHERE ano = ? ORDER BY rno DESC LIMIT 1 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			rs = pstmt.executeQuery();

			rs.next();

			rno = rs.getInt("rno");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rno;
	}// getRno() end

	// 40%이상 할인하는 숙소수 조회
	public int getDealCount() {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT count(rno) FROM room where discount >= 40 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("count(rno)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}// getDealCount() end

	// rno로 데이터 한개 가져오기
	public RoomVO select(int rno) {
		RoomVO vo = null;

		sb.setLength(0);
		sb.append("SELECT rno, ano, rtype, rcount, price, discount, rpeople FROM room WHERE rno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int ano = rs.getInt("ano");
				String rtype = rs.getString("rtype");
				int rcount = rs.getInt("rcount");
				int price = rs.getInt("price");
				int discount = rs.getInt("discount");
				int rpeople = rs.getInt("rpeople");

				vo = new RoomVO(rno, ano, rtype, rcount, price, discount, rpeople);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// select() end

	// 숙소번호 이용해서 해당 숙소의 방 전부 가져오기
	public ArrayList<RoomVO> selectAllRoom(int ano) {
		ArrayList<RoomVO> list = new ArrayList<RoomVO>();
		sb.setLength(0);
		sb.append("SELECT rno, ano, rtype, rcount, price, discount, " + "rpeople FROM room WHERE ano = ? ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				int rno = rs.getInt("rno");
				String rtype = rs.getString("rtype");
				int rcount = rs.getInt("rcount");
				int price = rs.getInt("price");
				int discount = rs.getInt("discount");
				int rpeople = rs.getInt("rpeople");

				RoomVO vo = new RoomVO(rno, ano, rtype, rcount, price, discount, rpeople);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// ano로 데이터 가져오기
	public RoomVO selectOne(int ano) {
		RoomVO vo = null;

		sb.setLength(0);
		sb.append("SELECT rno, ano, rtype, rcount, min(price), discount, rpeople FROM room WHERE ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				int rno = rs.getInt("rno");
				String rtype = rs.getString("rtype");
				int rcount = rs.getInt("rcount");
				int price = rs.getInt("min(price)");
				int discount = rs.getInt("discount");
				int rpeople = rs.getInt("rpeople");

				vo = new RoomVO(rno, ano, rtype, rcount, price, discount, rpeople);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// selectOne() end

	// 방 삭제
	public void deleteOne(int rno) {
		sb.setLength(0);
		sb.append("DELETE FROM room WHERE rno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rno);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}// deleteOno() end

	public void modifyOne(RoomVO vo) {
		sb.setLength(0);
		sb.append("UPDATE room SET rtype=?, rcount=?, price=?, discount=?, rpeople=? where rno=? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getRtype());
			pstmt.setInt(2, vo.getRcount());
			pstmt.setInt(3, vo.getPrice());
			pstmt.setInt(4, vo.getDiscount());
			pstmt.setInt(5, vo.getRpeople());
			pstmt.setInt(6, vo.getRno());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}// modifyOne() end

	// rcount랑 예약된 방 갯수 비교하여 남은방이 없으면 방번호 리턴
	public int soldOutRoom(int rno, int count) {
		int roomno = 0;
		sb.setLength(0);
		sb.append("SELECT rno FROM room WHERE rno = ? AND rcount <= ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, rno);
			pstmt.setInt(2, count);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				roomno = rs.getInt("rno");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roomno;
	}// soldOutRoom() end

	// 매진된 방을 제외하고 남은 방이 있는 숙소 번호 가져오기
	public ArrayList<Integer> getAnoofRemainingRoom(ArrayList<Integer> soldOutRnoList) {
		ArrayList<Integer> list = new ArrayList<Integer>();

		sb.setLength(0);
		sb.append("SELECT ano FROM room WHERE rno NOT IN ( ");
		for (int i = 0; i < soldOutRnoList.size(); i++) {
			sb.append(soldOutRnoList.get(i));
			if (i < soldOutRnoList.size() - 1) {
				sb.append(",");
			}
		}
		sb.append(" ) GROUP BY ano ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			// System.out.println("sql : " + sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int ano = rs.getInt("ano");

				list.add(ano);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// getAnoofRemainingRoom();

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