<%@page import="dao.ReviewDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashSet"%>
<%@page import="dao.RoomDAO"%>
<%@page import="dao.BookDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ABOUT JEJU</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous" />

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- Jquery Ui CSS -->
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css" />

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>

<script type="text/javascript">
	
</script>
</head>
<body class="productList">

	<jsp:include page="header.jsp" />
	<jsp:include page="nav.jsp" />


	<%!// nextPage method에서 endPage가 totalPage를 넘지 않기 위한 변수
	int checkEndPage = 0;

	public int beforePage(int startPage) {
		if (startPage == 1) {
			return 1;
		}
		return startPage - 1;
	}

	public int nextPage(int endPage) {
		if (endPage == checkEndPage) {
			return checkEndPage;
		}
		return endPage + 1;
	}%>
	<%
	// URL에 검색어를 search로 넘겨받음(기본값이 ""이어야 sql 에러안남)
	String search = request.getParameter("search");
	if (request.getParameter("search") == null) {
		search = "";
	}

	// URL에 체크인날짜를 checkin으로 넘겨받음(기본값이 null이어야 sql 에러안남)
	String checkin = request.getParameter("checkin");
	
	// URL에 체크아웃날짜를 checkout으로 넘겨받음(기본값이 null이어야 sql 에러안남)
	String checkout = request.getParameter("checkout");

	// URL에 숙소 타입을 atype으로 넘겨받음
	String atype = request.getParameter("atype");

	// 현재 페이지 번호
	String cp = request.getParameter("cp");

	int currentPage = 1;
	if (cp != null) {
		currentPage = Integer.parseInt(cp);
	}

	// 한페이지당 게시물 건수
	int recordPerPage = 8;

	// 페이지당 게시물 시작번호
	// mysql limit 이용
	// 페이지가 1이면 0 , 2 이면 8, 3이면 16
	int startNo = (currentPage - 1) * recordPerPage;

	// dao 객체 생성
	AccomodationDAO dao = new AccomodationDAO();
	ArrayList<AccomodationVO> list = dao.selectType(atype, startNo);

	// 검색어, 체크인, 체크아웃 파라미터로 리스트 불러올 객체들 생성
	BookDAO bdao = new BookDAO();
	ArrayList<int[]> blist = bdao.soldOut(checkin, checkout); // 체크인,아웃 원하는 날짜에 예약 된 방 번호와 예약된 방 갯수 가져옴

	RoomDAO rdao = new RoomDAO();
	ArrayList<Integer> soldOutRnoList = new ArrayList<Integer>();

	for (int i = 0; i < blist.size(); i++) { // 체크인,아웃 원하는 날짜에 예약된 방번호가 있을 경우
		if (rdao.soldOutRoom(blist.get(i)[0], blist.get(i)[1]) != 0) { // 리턴값이 0이 아닐때만 ArrayList soldOutRnoList에 담음
			int rno = rdao.soldOutRoom(blist.get(i)[0], blist.get(i)[1]); // intArr[0] : rno, intArr[1] : count

			soldOutRnoList.add(rno);
		}
	}

	// 예약불가능한 방번호가 있을 경우 예약 가능한 방이 있는 숙소번호만 가져옴 
	ArrayList<Integer> remainAlist = new ArrayList<Integer>();
	if (soldOutRnoList.size() != 0) {
		remainAlist = rdao.getAnoofRemainingRoom(soldOutRnoList);
	}

	// 검색어와 체크인,아웃 날짜를 모두 만족하는 숙소 가져옴
	ArrayList<AccomodationVO> searchedList = dao.getSearchedAccomodation(search, remainAlist, startNo);

	// URL에 정렬방법을 sortType으로 넘겨받음
	String sortType = request.getParameter("sorttype");
	// 카테고리별 정렬을 위한 빈 문자열
	String typeCheck = "";
	if (sortType != null) {
		list = dao.selectSort(atype, startNo, sortType);
		typeCheck = "sorttype=" + sortType + "&";
	}
	// 총 게시물 수 
	int totalCount = 0;

	if (atype != null) { // 메인에서 카테고리 버튼을 눌러서 productList로 이동한 경우
		totalCount = dao.getTotalCount(atype);
		System.out.println("totalCountType : " + totalCount);
	} else if (search=="") { // 메인에서 검색을 통해 productList로 이동한경우
		totalCount = dao.getSearchedAccomodationTotalCount(search, remainAlist);
		System.out.println("totalCountSearch : " + totalCount);
	}
	// 총 페이지 수
	int totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;

	checkEndPage = totalPage;

	// 시작페이지 번호
	int startPage = 1;
	// 끝페이지 번호
	int endPage = 4;

	// 페이지 미세조정
	for (int i = 0; i <= endPage; i++) {
		if (currentPage >= 1 + (i * 4)) {
			startPage = 1 + (i * 4);
			endPage = startPage + 3;
			if (endPage >= totalPage) {
		endPage = totalPage;
			}
		}
	}
	%>

	<div class="d-flex justify-content-center mt-4 mx-sm-5">
		<a href="productList.jsp?sorttype=starsort&cp=<%=currentPage%>&atype=<%=atype%>" type="button" class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">별점순</a>
		<a href="productList.jsp?sorttype=reviewsort&cp=<%=currentPage%>&atype=<%=atype%>" type="button" class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">후기
			많은 순</a> <a href="productList.jsp?sorttype=pricesort&cp=<%=currentPage%>&atype=<%=atype%>" type="button"
			class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">가격순</a>
	</div>

	<div class="row mt-4 mx-auto pt-1 w-75">

		<%
		DecimalFormat df = new DecimalFormat("###,###");

		if (atype != null) { // 메인에서 카테고리 버튼을 눌러서 productList로 이동한 경우	
			for (int i = 0; i < list.size(); i++) {
		%>

		<div class="col-lg-4 col-md-6 col-xl-3 my-3">
			<a href="productDetail.jsp?ano=<%=list.get(i).getAno()%>" class="card mx-auto text-reset" > <img
				src="<%=list.get(i).getAimage() != null ? list.get(i).getAimage() : "../images/noimage.png"%>" style="height: 150px" class="card-img-top"
				alt="<%=list.get(i).getAname()%>" />
				<div class="card-body">
					<p class="card-text">
					<div class="fs-5 fw-bold" style="height: 3.8rem"><%=list.get(i).getAname()%></div>

					<%
					int star = (int) Math.floor(dao.selectAvgStar(atype, list.get(i).getAno()));
					float remainder = dao.selectAvgStar(atype, list.get(i).getAno()) % 1;

					for (int j = 1; j <= star; j++) {
					%>

					<i class="bi bi-star-fill text-warning"></i>

					<%
					}
					if (remainder != 0) {
					%>

					<i class="bi bi-star-half text-warning"></i>

					<%
					}
					%>
					<span><%=Math.round(dao.selectAvgStar(atype, list.get(i).getAno()) * 100) / 100.0%></span><br />
					<p class="text-end fw-bold">
						￦
						<%=df.format(dao.selectMinPrice(atype, list.get(i).getAno()))%>/박
					</p>

					<%-- <%=list.get(i).getAdetail()%> --%>
					<!-- adetail 추가되면 살려보기  -->
					</p>
				</div>
			</a>
		</div>

		<%
			}
		} else if (search != null) { // 메인에서 검색을 통해 productList로 이동한경우
		ReviewDAO rvdao = new ReviewDAO();

		if (searchedList.size() == 0) {
		out.println("<h4 class='text-center py-5 mt-5'>검색 조건에 맞는 숙소가 없습니다.</h4>");
		}

		for (AccomodationVO avo : searchedList) {
		RoomVO rvo = rdao.selectOne(avo.getAno());
		%>

		<div class="col-lg-4 col-md-6 col-xl-3 my-3">
			<a href="productDetail.jsp?ano=<%=avo.getAno()%>" class="card mx-auto text-reset" > <img
				src="<%=avo.getAimage() != null ? avo.getAimage() : "../images/noimage.png"%>" style="height: 150px" class="card-img-top"
				alt="<%=avo.getAname()%>" />
				<div class="card-body">
					<p class="card-text">
					<div class="fs-5 fw-bold" style="height: 3.8rem"><%=avo.getAname()%></div>

					<%
					int star = (int) Math.floor(rvdao.getAvgStar(avo.getAno()));
					float remainder = rvdao.getAvgStar(avo.getAno()) % 1;

					for (int j = 1; j <= star; j++) {
					%>

					<i class="bi bi-star-fill text-warning"></i>

					<%
					}
					if (remainder != 0) {
					%>

					<i class="bi bi-star-half text-warning"></i>

					<%
					}
					%>
					<span><%=Math.round(rvdao.getAvgStar(avo.getAno()) * 100) / 100.0%></span><br />
					<p class="text-end fw-bold">
						￦
						<%=df.format(rvo.getPrice())%>/박
					</p>

					<%-- <%=avo.getAdetail()%> --%>
					<!-- adetail 추가되면 살려보기  -->
					</p>
				</div>
			</a>
		</div>

		<%
		}
		rvdao.close();
		}
		dao.close();
		bdao.close();
		rdao.close();
		%>
	</div>

	<%
	if (atype != null) { // 메인에서 카테고리 버튼을 눌러서 productList로 이동한 경우
	%>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center mt-5">
			<%
			//if(sortType)
			%>

			<li class="page-item"><a class="page-link" href="productList.jsp?<%=typeCheck%>cp=<%=beforePage(startPage)%>&atype=<%=atype%>"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>

			<%
			for (int i = startPage; i <= endPage; i++) {
			%>

			<li class="page-item"><a class="page-link" href="productList.jsp?<%=typeCheck%>cp=<%=i%>&atype=<%=atype%>"><%=i%></a></li>

			<%
			}
			%>
			<li class="page-item"><a class="page-link" href="productList.jsp?<%=typeCheck%>cp=<%=nextPage(endPage)%>&atype=<%=atype%>" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>

	<%
	} else if (search != null) { // 메인에서 검색을 통해 productList로 이동한경우
	%>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center mt-5">
			<li class="page-item"><a class="page-link"
				href="productList.jsp?search=<%=search%>&checkin=<%=checkin%>&checkout=<%=checkout%>&cp=<%=beforePage(startPage)%>" aria-label="Previous"> <span
					aria-hidden="true">&laquo;</span>
			</a></li>

			<%
			for (int i = startPage; i <= endPage; i++) {
			%>

			<li class="page-item"><a class="page-link" href="productList.jsp?search=<%=search%>&checkin=<%=checkin%>&checkout=<%=checkout%>&cp=<%=i%>"><%=i%></a></li>

			<%
			}
			%>

			<li class="page-item"><a class="page-link"
				href="productList.jsp?search=<%=search%>&checkin=<%=checkin%>&checkout=<%=checkout%>&cp=<%=nextPage(endPage)%>" aria-label="Next"> <span
					aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>
	</nav>

	<%
	}
	%>

	<jsp:include page="footer.jsp" />

	<!-- Bootstrap Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>
</html>