<%@page import="vo.CustomerVO"%>
<%@page import="vo.OwnerVO"%>
<%@page import="vo.RoomVO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.OwnerDAO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.AccomodationDAO"%>
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
</head>

<body class="main">
	<jsp:include page="header.jsp" />
	<jsp:include page="nav.jsp" />
	<!-- modal -->
	
	
<!--    ----------     -->
	<!-- ## 콘텐츠 - sm 에서는 한개씩 표시됨 -->
	<h5 class="mt-5 pt-4 text-center fw-bold">- 추천 숙소 -</h5>
	<div class="row w-75 mx-auto mt-4 px-5">

		<%
		AccomodationDAO adao = new AccomodationDAO();
		ArrayList<AccomodationVO> list = adao.selectAll(0, 3);

		RoomDAO rdao = new RoomDAO();
		DecimalFormat df = new DecimalFormat("###,###");

		for (AccomodationVO vo : list) {
			RoomVO rvo = rdao.selectOne(vo.getAno());
		%>

		<div class="col-md-6 col-sm-6 col-lg-4 my-2">
			<a href="productDetail.jsp?ano=<%=vo.getAno()%>" class="card mx-auto text-reset" >
				<img src="<%=vo.getAimage() != null ? vo.getAimage() : "../images/noimage.png"%>" class="card-img-top" alt="<%=vo.getAname()%>"
					style="height: 150px;" />
				<div class="card-body">
					<div class="fs-5 fw-bold" style="height: 3.8rem"><%=vo.getAname()%></div>

					<%
					int star = (int) Math.floor(vo.getStar());
					float remainder = vo.getStar() % 1;

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

					<span> <%=Math.round(vo.getStar() * 100) / 100.0%></span><br />
					<p class="fw-bold text-end">
						￦
						<%=df.format(Math.round(rvo.getPrice() * (1 - rvo.getDiscount() * 0.01)))%>/박
					</p>
					</p>
				</div>
			</a>
		</div>

		<%
		}
		%>

	</div>

	<!-- 오늘의 특가 -->
	<h5 class="mt-5 pt-4 text-center fw-bold">- 오늘의 특가 -</h5>
	<div class="row w-75 mt-4 mx-auto px-5">

		<%
		ArrayList<AccomodationVO> list2 = adao.selectBargain();

		for (int i = 0; i < 2; i++) {
			AccomodationVO vo = list2.get(i);

			int price = vo.getPrice();
			int discount = vo.getDiscount();
		%>

		<div class="col-md-6 my-2 px-3 position-relative">
			<a href="productDetail.jsp?ano=<%=vo.getAno()%>" class="card mx-auto text-reset">
				<img src="<%=vo.getAimage() != null ? vo.getAimage() : "../images/noimage.png"%>" class="card-img-top" alt="<%=vo.getAname()%>" style="height: 220px;" />
				<div class="card-body">
					<p class="card-text">
					<div class="fs-4 fw-bold" style="height: 3.8rem"><%=vo.getAname()%></div>
					<div>
						<span class="text-decoration-line-through fst-italic">￦ <%=df.format(price)%></span> &nbsp;<span class="fw-bold fs-3 text-danger">￦ <%=df.format(Math.round(price * (discount * 0.01)))%></span><span
							class="fw-bold"> /박</span>
					</div>
					</p>
				</div>
			</a>
			<div class="ribbon">
				<span class="ribbon3"><%=vo.getDiscount()%>% 할인!</span>
			</div>
		</div>

		<%
		}
		%>

	</div>

	<!-- 사이트 자랑(?) -->
	<%
	RoomDAO rmdao = new RoomDAO();
	int dealCount = rmdao.getDealCount();

	CustomerDAO cdao = new CustomerDAO();
	int customerCount = cdao.getCustomerCount();

	OwnerDAO odao = new OwnerDAO();
	int ownerCount = odao.getOwnerCount();

	int accomodationCount = adao.getAccomodationCount();

	ReviewDAO rvdao = new ReviewDAO();
	int reviewCount = rvdao.getReviewCount();
	%>
	<div class="container-fluid goodThing text-white text-center">
		<i class="bi bi-quote fs-2"></i>
		<h2>WHY ABOUT JEJU</h2>
		<div class="row">
			<div class="col-lg-3 col-sm-6">
				<div class="divider"><%=dealCount%></div>
				<div>AMAZING DEALS</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="divider"><%=customerCount + ownerCount%></div>
				<div>CUSTOMERS</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="divider"><%=accomodationCount%></div>
				<div>ACCOMODATIONS</div>
			</div>
			<div class="col-lg-3 col-sm-6">
				<div class="divider"><%=reviewCount%></div>
				<div>REVIEWS</div>
			</div>
		</div>
	</div>

	<!-- 랜덤 숙소 -->
	<div class="row w-75 mx-auto px-5">

		<%
		int startNo = (int) Math.round((Math.random() * 50));

		ArrayList<AccomodationVO> list3 = adao.selectAll(startNo, 6);

		for (AccomodationVO vo : list3) {
			RoomVO rvo = rdao.selectOne(vo.getAno());
		%>

		<div class="col-md-6 col-sm-6 col-lg-4 my-3">
			<a href="productDetail.jsp?ano=<%=vo.getAno()%>" class="card mx-auto mb-3 text-reset">
				<img src="<%=vo.getAimage() != null ? vo.getAimage() : "../images/noimage.png"%>" class="card-img-top" alt="<%=vo.getAname()%>"
					style="height: 150px;" />
				<div class="card-body">
					<p class="card-text">
					<div class="fs-5 fw-bold" style="height: 3.8rem"><%=vo.getAname()%></div>

					<%
					int star = (int) Math.floor(vo.getStar());
					float remainder = vo.getStar() % 1;

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

					<span> <%=Math.round(vo.getStar() * 100) / 100.0%></span><br />
					<p class="fw-bold text-end">
						￦
						<%=df.format(Math.round(rvo.getPrice() * (1 - rvo.getDiscount() * 0.01)))%>/박
					</p>
					</p>
				</div>
			</a>
		</div>

		<%
		}

		rmdao.close();
		cdao.close();
		odao.close();
		adao.close();
		rvdao.close();
		%>

	</div>


	<jsp:include page="footer.jsp" />

	<!-- Bootstrap Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>

	<!-- My JS -->
	<script src="../js/script.js"></script>


</body>
</html>