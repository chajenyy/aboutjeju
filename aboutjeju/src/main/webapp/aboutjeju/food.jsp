<%@page import="vo.FoodVO"%>
<%@page import="dao.FoodDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ABOUT JEJU</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous" />

<!-- Bootstrap icon CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- Jquery Ui CSS -->
<link
	href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.min.css"
	rel="stylesheet" type="text/css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css" />

<!-- JQUERY -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>
<body class="food">
	<jsp:include page="header.jsp" />
	<jsp:include page="nav.jsp" />

	<!-- ## 지역 카테고리 버튼 -->
	<div class="d-flex justify-content-center mt-4 mx-sm-5">
		<a href="food.jsp?category=jeju&cp=1" type="button"
			class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">제 주 시</a> <a
			href="food.jsp?category=seoguipo&cp=1" type="button"
			class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">서귀포시</a> <a
			href="food.jsp?category=east&cp=1" type="button"
			class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">제주동부</a> <a
			href="food.jsp?category=west&cp=1" type="button"
			class="btn btn-secondary mx-lg-4 mx-2 px-md-5 px-4">제주서부</a>
	</div>

	<!-- ## 콘텐츠 - sm 에서는 한개씩 표시됨 -->
	<div class="row mt-5 justify-content-evenly">

		<%
		request.setCharacterEncoding("UTF-8");
		String cat = request.getParameter("category");
		String cp = request.getParameter("cp");

		String category = null;

		if (cat.equals("all")) {
			category = "제주시|서귀포시";
		} else if (cat.equals("jeju")) {
			category = "제주시";
		} else if (cat.equals("seoguipo")) {
			category = "서귀포시";
		} else if (cat.equals("east")) {
			category = "구좌읍|성산읍|표선면|우도|조천읍|남원읍";
		} else if (cat.equals("west")) {
			category = "한림읍|한경면|대정읍|안덕면|애월읍|중문";
		}

		int currentPage = 1;

		if (cp != null) {
			currentPage = Integer.parseInt(cp);
		}

		int startNo = (currentPage - 1) * 10;

		FoodDAO dao = new FoodDAO();
		ArrayList<FoodVO> list = dao.selectAll(startNo, category);

		for (FoodVO vo : list) {
		%>

		<div class="col-sm-6 col-lg-5">
			<div class="card mb-3" style="max-width: 540px;">
				<div class="row g-0">
					<div class="col-4 h-120">
						<img src="<%=vo.getFimage()%>" class="rounded-start w-100"
							alt="<%=vo.getFname()%>">
					</div>
					<div class="col-8">
						<div class="card-body">
							<h5 class="card-title"><%=vo.getFname()%></h5>
							<div class="card-text"><%=vo.getFphone()%></div>
							<div class="card-text"><%=vo.getFaddress()%></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<%
		}
		%>

	</div>

	<%
	int totalCount = dao.getTotalCount(category);
	int totalPage = (totalCount % 10 == 0) ? (totalCount / 10) : (totalCount / 10 + 1);
	int startPage = currentPage;
	int endPage = startPage + 2;

	if (currentPage + 2 >= totalPage) {
		endPage = totalPage;
	}

	if (totalPage <= 3) {
		startPage = 1;
	}
	%>

	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center mt-5">
			<%
			if (currentPage > 1) {
			%>

			<li class="page-item"><a class="page-link"
				href="food.jsp?category=<%=cat%>&cp=<%=(currentPage - 5 < 1) ? 1 : (currentPage - 5)%>"
				aria-label="Previous" title="5페이지 앞으로"><span aria-hidden="true">&laquo;</span></a></li>

			<%
			}

			for (int i = startPage; i <= endPage; i++) {
			if (i == currentPage) {
			%>

			<li class="page-item"><a class="page-link bg-primary text-white"
				href="food.jsp?category=<%=cat%>&cp=<%=i%>"><%=i%></a></li>

			<%
			} else {
			%>

			<li class="page-item"><a class="page-link"
				href="food.jsp?category=<%=cat%>&cp=<%=i%>"><%=i%></a></li>

			<%
			}
			}

			if (currentPage + 2 < totalPage) {
			%>
			<li class="page-item"><a class="page-link"
				href="food.jsp?category=<%=cat%>&cp=<%=(currentPage + 5 > totalPage) ? (totalPage) : (currentPage + 5)%>"
				aria-label="Next" title="5페이지 뒤로"> <span aria-hidden="true">&raquo;</span>
			</a></li>
			<%
			}
			%>
		</ul>
	</nav>

	<jsp:include page="footer.jsp" />

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>
</html>