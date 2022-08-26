package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.BookVO;

public class BookDAO {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public BookDAO() {
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

	// int bno, String ono, int rno, int cno, String bsdate, String bedate,
	// String pay, int bprice, String bname, String bphone, String way, int bookok

	// 데이터 1개 가져오기
	public BookVO selectOne(int bno) {
		BookVO vo = null;

		sb.setLength(0);
		sb.append("SELECT bno, ono, rno, cno, bsdate, bedate, pay, bprice, bname, bphone, way, bookok ");
		sb.append("FROM book WHERE bno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, bno);

			rs = pstmt.executeQuery();

			rs.next();
			String ono = rs.getString("ono");
			int rno = rs.getInt("rno");
			int cno = rs.getInt("cno");
			String bsdate = rs.getString("bsdate");
			String bedate = rs.getString("bedate");
			String pay = rs.getString("pay");
			int bprice = rs.getInt("bprice");
			String bname = rs.getString("bname");
			String bphone = rs.getString("bphone");
			String way = rs.getString("way");
			int bookok = rs.getInt("bookok");

			vo = new BookVO(bno, ono, rno, cno, bsdate, bedate, pay, bprice, bname, bphone, way, bookok);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// selectOne() end

	// 예약-방-숙소 연결된 데이터 가져오기
	public ArrayList<BookVO> customerBookingData(int cno, int startNo) {
		ArrayList<BookVO> list = new ArrayList<BookVO>();

		sb.setLength(0);
		sb.append("SELECT b.bno, b.bsdate, b.bedate, b.bprice, a.aname, r.rtype, a.aimage ");
		sb.append("FROM book b, accomodation a, room r ");
		sb.append("WHERE b.ono = a.ono AND b.rno = r.rno ");
		sb.append("AND b.cno = ? ");
		sb.append("LIMIT ?, 4 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, cno);
			pstmt.setInt(2, startNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int bno = rs.getInt("b.bno");
				String bsdate = rs.getString("b.bsdate");
				String bedate = rs.getString("b.bedate");
				int bprice = rs.getInt("b.bprice");
				String aname = rs.getString("a.aname");
				String rtype = rs.getString("r.rtype");
				String aimage = rs.getString("a.aimage");

				BookVO vo = new BookVO(bno, bsdate, bedate, bprice, aname, rtype, aimage);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 일반회원번호별 예약 갯수 구하기
	public int getTotalCount(int cno) {
		int ttl = 0;

		sb.setLength(0);
		sb.append("SELECT count(bno) FROM book WHERE cno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, cno);

			rs = pstmt.executeQuery();

			rs.next();

			ttl = rs.getInt("count(bno)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ttl;
	}// getTotalCount() end

	// 호스트번호별 예약 갯수 구하기
	public int getTotalCount2(int ownerno) {
		int ttl = 0;

		sb.setLength(0);
		sb.append("SELECT count(*) FROM book WHERE ono = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ownerno);

			rs = pstmt.executeQuery();

			rs.next();

			ttl = rs.getInt("count(*)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ttl;
	}// getTotalCount2() end

	// ono로 데이터 가져오기
	public ArrayList<BookVO> select(String ono, int startNo) {
		ArrayList<BookVO> list = new ArrayList<BookVO>();

		sb.setLength(0);
		sb.append("SELECT bno, ono, rno, cno, bsdate, bedate, pay, bprice, bname, bphone, way, bookok ");
		sb.append("FROM book WHERE ono = ? ORDER BY bno desc LIMIT ?, 10 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, ono);
			pstmt.setInt(2, startNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int bno = rs.getInt("bno");
				int rno = rs.getInt("rno");
				int cno = rs.getInt("cno");
				String bsdate = rs.getString("bsdate");
				String bedate = rs.getString("bedate");
				String pay = rs.getString("pay");
				int bprice = rs.getInt("bprice");
				String bname = rs.getString("bname");
				String bphone = rs.getString("bphone");
				String way = rs.getString("way");
				int bookok = rs.getInt("bookok");

				BookVO vo = new BookVO(bno, ono, rno, cno, bsdate, bedate, pay, bprice, bname, bphone, way, bookok);

				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// select() end

	// 예약 취소하기(bookok상태 3으로 변경)
	public void bookCancel(int bno) {
		sb.setLength(0);
		sb.append("UPDATE book SET bookok = 3 WHERE bno = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, bno);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// bookCancel() end

	// 예약 불가능한 방번호 가져오기
	public ArrayList<int[]> soldOut(String checkin, String checkout) {
		ArrayList<int[]> list = new ArrayList<int[]>();

		sb.setLength(0);
		sb.append("SELECT rno, count(*) FROM book WHERE (bedate > ? or bsdate <= ? ) AND bookok = 1 GROUP BY rno ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, checkin);
			pstmt.setString(2, checkout);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int rno = rs.getInt("rno");
				int count = rs.getInt("count(*)");

				int[] intArr = { rno, count };

				list.add(intArr);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// soldOut() end
	
//	int bno;
//	String ono;
//	int rno;
//	int cno;
//	String bsdate;
//	String bedate;
//	String pay;
//	int bprice;
//	String bname;
//	String bphone;
//	String way;
//	int bookok;
	
	// 예약하기
	public void insertOne(BookVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO book VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, 0);
			pstmt.setString(2,vo.getOno());
			pstmt.setInt(3, vo.getRno());
			pstmt.setInt(4, vo.getCno());
			pstmt.setString(5,vo.getBsdate());
			pstmt.setString(6,vo.getBedate());
			pstmt.setString(7,vo.getPay());
			pstmt.setInt(8, vo.getBprice());
			pstmt.setString(9, vo.getBname());
			pstmt.setString(10, vo.getBphone());
			pstmt.setString(11, vo.getWay());
			pstmt.setInt(12, vo.getBookok());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
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
