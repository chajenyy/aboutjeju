package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.AccomodationVO;

public class AccomodationDAO {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://orcl.cjkvnymhq1dx.ap-northeast-2.rds.amazonaws.com:3306/mydb";
	String user = "smith";
	String password = "tigertiger1";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sb = new StringBuffer();

	public AccomodationDAO() {
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

	// 숙소 데이터 업데이트 -- db 데이터 잘못 건드린거 수정하려고 만든 메서드
	public void updateAlot(String aname, String aimage, int ano) {
		sb.setLength(0);
		sb.append("UPDATE accomodation SET aname = ? , aimage = ? WHERE ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, aname);
			pstmt.setString(2, aimage);
			pstmt.setInt(3, ano);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	// 숙소 타입별 페이징 처리 (메서드 오버로딩)
	public ArrayList<AccomodationVO> selectType(String atype, int startNo) {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();
		sb.setLength(0);
		sb.append("select ano ,ono,aname, aaddress, aimage, atype, adetail, aphone from accomodation ");
		sb.append("where atype = ? order by ano asc ");
		sb.append("limit ?, 8");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int ano = rs.getInt("ano");
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");
				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 숙소 타입별로 조회
	public ArrayList<AccomodationVO> selectType(String atype) {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();
		sb.setLength(0);
		sb.append("SELECT ano, ono, aname, aaddress, aimage, adetail, aphone FROM accomodation ");
		sb.append("WHERE atype = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int ano = rs.getInt("ano");
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");
				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// productList 페이지에서 버튼 클릭시 정렬(별점,후기많은순,가격순)
	public ArrayList<AccomodationVO> selectSort(String atype, int startNo, String sortType) {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();
		sb.setLength(0);
		sb.append("SELECT a.ano, a.ono, a.aname, a.aaddress, a.aimage, a.adetail, a.aphone ");
		sb.append("FROM accomodation a left outer join review r on a.ano = r.ano where a.atype =?");
		if (sortType.equals("starsort")) {
			sb.append("GROUP BY a.ano ORDER BY round(avg(r.star),1) desc, ");
			sb.append("count(r.ano) desc, ano asc ");
		} else if (sortType.equals("reviewsort")) {
			sb.append("GROUP BY a.ano ORDER BY count(r.ano) desc, ano asc ");
		} else if (sortType.equals("pricesort")) {
			sb.setLength(0);
			sb.append("SELECT a.ano, a.ono, a.aname, a.aaddress, a.aimage, a.adetail, a.aphone ");
			sb.append("FROM accomodation a left outer join room r ON a.ano = r.ano ");
			sb.append("WHERE a.atype = ? ");
			sb.append("GROUP by a.ano ");
			sb.append("ORDER by min(r.price) asc, a.ano asc ");
		}
		sb.append("limit ?, 8");
		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);
			pstmt.setInt(2, startNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int ano = rs.getInt("a.ano");
				String ono = rs.getString("a.ono");
				String aname = rs.getString("a.aname");
				String aaddress = rs.getString("a.aaddress");
				String aimage = rs.getString("a.aimage");
				String adetail = rs.getString("a.adetail");
				String aphone = rs.getString("a.aphone");
				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);
				list.add(vo);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	} // SelectStarSort() end

	// 숙소 가격 조회 (대표로 가장 저렴한 방 1개)
	public int selectMinPrice(String atype, int ano) {
		int num = 0;
		sb.setLength(0);
		sb.append("SELECT min(r.price) minPrice ");
		sb.append("FROM accomodation a right outer join room r ");
		sb.append("ON a.ano = r.ano ");
		sb.append("WHERE a.atype = ? AND a.ano = ? ");
//			sb.append("GROUP BY a.ano ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);
			pstmt.setInt(2, ano);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt("minPrice");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return num;
	} // selectMinPrice() end

	// 숙소 타입별 페이징 처리 end

	// 숙소별 평균별점 가져오기
	public float selectAvgStar(String atype, int ano) {
		float avgStar = 0;
		sb.setLength(0);
		sb.append("SELECT round(avg(r.star),1) staravg ");
		sb.append("FROM accomodation a LEFT OUTER JOIN review r ON a.ano = r.ano ");
		sb.append("WHERE a.atype = ? AND a.ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);
			pstmt.setInt(2, ano);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				avgStar = rs.getFloat("staravg");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return avgStar;
	}

	// 숙소 하나 추가하기
	public void addOne(AccomodationVO vo) {
		sb.setLength(0);
		sb.append("INSERT INTO accomodation VALUES (?,?,?,?,?,?,?,?) ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, vo.getAno());
			pstmt.setString(2, vo.getOno());
			pstmt.setString(3, vo.getAname());
			pstmt.setString(4, vo.getAaddress());
			pstmt.setString(5, vo.getAimage());
			pstmt.setString(6, vo.getAtype());
			pstmt.setString(7, vo.getAdetail());
			pstmt.setString(8, vo.getAphone());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// addOne() end

	// 숙소정보 수정하기
	public void updateOne(AccomodationVO vo) {
		sb.setLength(0);
		sb.append(
				"UPDATE accomodation SET aname = ?, aaddress = ?, aimage = ?, atype = ?, adetail = ?, aphone = ?  WHERE ono = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, vo.getAname());
			pstmt.setString(2, vo.getAaddress());
			pstmt.setString(3, vo.getAimage());
			pstmt.setString(4, vo.getAtype());
			pstmt.setString(5, vo.getAdetail());
			pstmt.setString(6, vo.getAphone());
			pstmt.setString(7, vo.getOno());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// updateOne() end

	// 숙소 타입별 개수
	public int getTotalCount(String atype) {
		int cnt = 0;
		sb.setLength(0);
		sb.append("select count(*) cnt from accomodation where atype = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, atype);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cnt;
	}

	// 별점순으로 숙소 조회(별점있는 숙소만)
	public ArrayList<AccomodationVO> selectAll(int startNo, int howMany) {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();
		sb.setLength(0);
		sb.append("SELECT r.ano, ono, aname, aaddress, aimage, atype, adetail, aphone, avg(star) ");
		sb.append("FROM accomodation NATURAL JOIN review r ");
		sb.append("GROUP BY r.ano ");
		sb.append("ORDER BY avg(star) DESC ");
		sb.append("LIMIT ?, ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, startNo);
			pstmt.setInt(2, howMany);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int ano = rs.getInt("r.ano");
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String atype = rs.getString("atype");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");
				float avgstar = rs.getFloat("avg(star)");

				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone,
						avgstar);

				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// selectAll() end

	// 숙소 하나 조회 (ano이용)
	public AccomodationVO selectOne(int ano) {
		AccomodationVO vo = null;
		sb.setLength(0);
		sb.append("SELECT ono, aname, aaddress, aimage, atype, adetail, aphone ");
		sb.append("FROM accomodation WHERE ano = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, ano);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String atype = rs.getString("atype");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");
				vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return vo;
	}

	// 사업자 번호로 숙소 데이터 1개 가져오기
	public AccomodationVO selectOne(String ono) {
		AccomodationVO vo = null;

		sb.setLength(0);
		sb.append("SELECT * ");
		sb.append("FROM accomodation WHERE ono = ? ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, ono);

			rs = pstmt.executeQuery();

			rs.next();

			int ano = rs.getInt("ano");
			String aname = rs.getString("aname");
			String aaddress = rs.getString("aaddress");
			String aimage = rs.getString("aimage");
			String atype = rs.getString("atype");
			String adetail = rs.getString("adetail");
			String aphone = rs.getString("aphone");

			vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}// selectOne() end

	// 할인율 높은 숙소 가져오기
	public ArrayList<AccomodationVO> selectBargain() {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();

		sb.setLength(0);
		sb.append(
				"SELECT a.ano, a.ono, a.aname, a.aaddress, a.aimage, a.atype, a.adetail, a.aphone, r.discount, r.price ");
		sb.append("FROM accomodation a natural join room r ");
		sb.append("ORDER BY r.discount DESC ");
		sb.append("LIMIT 0, 2 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int ano = rs.getInt("ano");
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String atype = rs.getString("atype");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");
				int discount = rs.getInt("discount");
				int price = rs.getInt("price");

				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone,
						discount, price);
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// selectBargain() end

	// 전체 숙소수 조회
	public int getAccomodationCount() {
		int count = 0;

		sb.setLength(0);
		sb.append("SELECT count(ano) FROM accomodation ");

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			count = rs.getInt("count(ano)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}// getAccomodationCount() end

	// 검색조건(검색어, 체크인아웃)에 맞는 숙소리스트 불러오기
	public ArrayList<AccomodationVO> getSearchedAccomodation(String search, ArrayList<Integer> remainAlist,
			int startNo) {
		ArrayList<AccomodationVO> list = new ArrayList<AccomodationVO>();

		sb.setLength(0);
		sb.append("SELECT ano, ono, aname, aaddress, aimage, atype, adetail, aphone FROM accomodation ");
		sb.append("WHERE (aname like '%");
		sb.append(search);
		sb.append("%' or atype like '%");
		sb.append(search);
		sb.append("%') ");

		if (remainAlist.size() != 0) {
			sb.append("AND ano IN ( ");

			for (int i = 0; i < remainAlist.size(); i++) {
				sb.append(remainAlist.get(i));
				if (i < remainAlist.size() - 1) {
					sb.append(",");
				}
			}
			sb.append(") ");
		}

		sb.append("LIMIT ?, 8 ");

		try {
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, startNo);
			System.out.println("sql : " + sb.toString());
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int ano = rs.getInt("ano");
				String ono = rs.getString("ono");
				String aname = rs.getString("aname");
				String aaddress = rs.getString("aaddress");
				String aimage = rs.getString("aimage");
				String atype = rs.getString("atype");
				String adetail = rs.getString("adetail");
				String aphone = rs.getString("aphone");

				AccomodationVO vo = new AccomodationVO(ano, ono, aname, aaddress, aimage, atype, adetail, aphone);

				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}// getSearchedAccomodation();

	// 검색조건에 맞는 리스트 갯수 구하기
	public int getSearchedAccomodationTotalCount(String search, ArrayList<Integer> remainAlist) {
		int ttl = 0;

		sb.setLength(0);
		sb.append("SELECT count(ano) FROM accomodation ");
		sb.append("WHERE aname like '%");
		sb.append(search);
		sb.append("%' or atype like '%");
		sb.append(search);
		sb.append("%' ");

		if (remainAlist.size() != 0) {
			sb.append("AND ano IN ( ");

			for (int i = 0; i < remainAlist.size(); i++) {
				sb.append(remainAlist.get(i));
				if (i < remainAlist.size() - 1) {
					sb.append(",");
				}
			}
			sb.append(") ");
		}

		try {
			pstmt = conn.prepareStatement(sb.toString());

			rs = pstmt.executeQuery();

			rs.next();
			ttl = rs.getInt("count(ano)");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ttl;
	}// getSearchedAccomodationTotalCount() end

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
