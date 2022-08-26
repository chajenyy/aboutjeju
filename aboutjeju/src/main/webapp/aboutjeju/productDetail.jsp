<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.OwnerVO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="vo.ConvenienceVO"%>
<%@page import="dao.ConvenienceDAO"%>
<%@page import="vo.RoomdetailVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.RoomdetailDAO"%>
<%@page import="dao.ReviewDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>ABOUT JEJU</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous" />

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- Jquery Ui CSS -->
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.min.css" rel="stylesheet" type="text/css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css" />

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>

<script>
	
<%// productList에서 파라미터로 값 받아오기
String anoNum = request.getParameter("ano");
int ano = 0;
if (anoNum != null) {
	ano = Integer.parseInt(anoNum);
}

String bNum = request.getParameter("bn");
int bn = 0;
if (bNum != null) {
	bn = Integer.parseInt(bNum);
}

// dao 객체 생성
RoomDAO roomDao = new RoomDAO();
RoomdetailDAO rdDao = new RoomdetailDAO();
AccomodationDAO accoDao = new AccomodationDAO();
ReviewDAO reviewDao = new ReviewDAO();
ConvenienceDAO conDao = new ConvenienceDAO();

AccomodationVO accoVo = accoDao.selectOne(ano);

ArrayList<RoomVO> roomList = roomDao.selectAllRoom(ano);
System.out.println(roomList);
ArrayList<ConvenienceVO> conList = conDao.selectAll(ano);%>
	window.onload = function() {
		var info = document.getElementsByClassName("infowrap")[0];
		var spanText = document.getElementById("infoheight");
		var infoOnBtn = document.getElementById("info-on");
		var infoOffBtn = document.getElementById("info-off");

		var submitbtn = document.getElementById("submitbtn");

		var test =
<%=bn%>
	;

		if (test == 1) {
			alert("날짜를 선택해주세요!");
		}
		// 숙소소개란 내용이 짦을 경우 div길이 조절 후 펼치기 버튼 display : none;
		if (spanText.offsetHeight < 100) {
			info.style.height = "auto";
			infoOnBtn.style.display = "none";
		}

		// 숙소소개란 펼치기, 접기 기능
		infoOnBtn.onclick = function() {
			info.style.height = "auto";
			infoOnBtn.style.display = "none";
			infoOffBtn.style.display = "inline";
		}

		infoOffBtn.onclick = function() {
			info.style.height = "300px";

			infoOnBtn.style.display = "inline";
			infoOffBtn.style.display = "none";
		}

	}

	function movepage(x) {
		var btn = document.getElementById("hiddenbtn");
		btn.click();
	}
</script>
</head>
<body class="productDetail">

	<jsp:include page="header.jsp" />
	<jsp:include page="nav.jsp" />
	<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-2"></div>

			<div class="col-md-8">

				<!-- 캐러셀 -->
				<div id="carouselExampleIndicators" class="carousel carousel-dark slide mt-5" data-bs-ride="carousel">
					<div class="carousel-inner" style="height: 400px;">
						<div class="carousel-item active">
							<img src="<%=accoVo.getAimage()%>" class="d-block w-100" alt="숙소이미지" height="400px">
						</div>

						<%
						for (RoomVO vo : roomList) {
							ArrayList<RoomdetailVO> rdList = rdDao.select(vo.getRno());

							for (int i = 0; i < rdList.size(); i++) {
						%>

						<div class="carousel-item">
							<img src="<%=rdList.get(i).getRimage()%>" class="d-block w-100" alt="숙소이미지" height="400px">
						</div>

						<%
						}
						}
						%>

					</div>
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="visually-hidden">Next</span>
					</button>
				</div>

				<!-- 숙소정보 -->
				<div class="row border border-1 my-3 p-3">
					<h4 class="fw-bold"><%=accoVo.getAname()%></h4>
					<p>
						<%
						int star = (int) Math.floor(accoDao.selectAvgStar(accoVo.getAtype(), ano));
						float remainder = accoDao.selectAvgStar(accoVo.getAtype(), ano) % 1;

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
						<span class="fw-bold fs-5"><%=accoDao.selectAvgStar(accoVo.getAtype(), ano)%></span>/5 <span class="text-primary">후기 <%=reviewDao.getCountOne(ano)%>개
						</span>
					</p>
					<p><%=accoVo.getAtype()%></p>
				</div>
				<form action="customerBooking.jsp">
					<div class="border border-1 my-3 p-3 text-center row px-3">
						<input type="text" id="checkin" name="checkin" placeholder="체크인 날짜 선택" class="col form-control me-3" />
						<input type="text" id="checkout" name="checkout" placeholder="체크아웃 날짜 선택" class="col form-control border border-1 ms-3" />
						<input type="submit" id="hiddenbtn" hidden="" />
					</div>

					<%
					DecimalFormat df = new DecimalFormat("###,###");
					for (RoomVO vo : roomList) {
						ArrayList<RoomdetailVO> rdList = rdDao.select(vo.getRno());
					%>
					<input type="hidden" name="rno" value="<%=vo.getRno()%>" />
					<input type="hidden" name="ano" value="<%=vo.getAno()%>" />
					<div class="card mb-3 mx-auto" style="max-width: 900px;">
						<a href="#" id="<%=vo.getRno()%>" onclick="movepage(this)">
							<div class=" row g-0 border-1 border-bottom">
								<div class="col-md-4">
									<img src="<%=rdList.get(0).getRimage()%>" class="img-fluid rounded-start rooming" alt="<%=vo.getRtype()%>이미지">
								</div>
								<div class="col-md-8">
									<div class="card-body row">
										<div class="col-6">
											<h5 class="card-title"><%=vo.getRtype()%></h5>
											<p>
												최대
												<%=vo.getRpeople()%>인
											</p>
										</div>
										<div class="col-6">
											<p class="text-decoration-line-through text-end text-muted">
												판매가
												<%=df.format(vo.getPrice())%>원
											</p>
											<p class="fw-bold text-danger text-end"><%=vo.getDiscount()%>% 할인가
											</p>
											<div class="d-flex justify-content-end">
												<span>남은객실 <%=vo.getRcount()%></span><span class="fs-5 fw-bold text-end ps-3"><%=df.format(Math.round(vo.getPrice() * (1 - vo.getDiscount() * 0.01)))%>원</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</a>
					</div>
				</form>
				<%
				}
				%>

				<div class="infobox border border-1">
					<div class="infowrap">
						<h5>숙소소개</h5>
						<span id="infoheight"><%=accoVo.getAdetail()%></span>
					</div>
					<div class="text-center pt-2">
						<button type="button" id="info-on" class="btn btn-outline-primary">더보기</button>
						<button type="button" id="info-off" class="btn btn-outline-primary">접기</button>
					</div>
				</div>

				<div class="conveniencebox my-3 d-flex justify-content-evenly my-3 py-3">
					<%
					for (ConvenienceVO vo : conList) {
						String src = "";
						if (vo.getCoption().equals("냉장고")) {
							src = "refrigerator";
						} else if (vo.getCoption().equals("흡연구역")) {
							src = "smokingarea";
						} else if (vo.getCoption().equals("WIFI")) {
							src = "wifi";
						} else if (vo.getCoption().equals("24H")) {
							src = "24h";
						} else if (vo.getCoption().equals("주차가능")) {
							src = "parking";
						} else if (vo.getCoption().equals("수영장")) {
							src = "swim";
						} else if (vo.getCoption().equals("짐보관")) {
							src = "baggage";
						} else if (vo.getCoption().equals("레스토랑")) {
							src = "restaurant";
						} else if (vo.getCoption().equals("금연객실")) {
							src = "nosmoke";
						}
						System.out.println(vo.getCoption());
					%>

					<div class="d-inline-block text-center px-0">
						<img src="../images/<%=src%>.png" alt="" style="max-width: 65px; max-height: 65px;" />
						<br /> <span><%=vo.getCoption()%></span>
					</div>

					<%
					}
					request.setCharacterEncoding("UTF-8");
					%>

				</div>

				<!-- include로 kakaoMap.jsp 불러오기 -->
				<div class="border border-1 my-3 p-3">
					<jsp:include page="kakaoMap.jsp">
						<jsp:param value="<%=accoVo.getAaddress()%>" name="aaddress" />
						<jsp:param value="<%=accoVo.getAname()%>" name="aname" />
					</jsp:include>
				</div>

				<!-- include로 productReview.jsp 불러오기 -->
				<div class="border border-1 my-3 p-3">
					<jsp:include page="productReview.jsp">
						<jsp:param value="<%=accoVo.getAno()%>" name="ano" />
					</jsp:include>
				</div>

			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<%
	roomDao.close();
	conDao.close();
	rdDao.close();
	reviewDao.close();
	accoDao.close();
	%>

	<jsp:include page="footer.jsp" />

	<!-- Bootstrap Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>

	<!-- My JS -->
	<script src="../js/script.js"></script>

</body>
</html>
