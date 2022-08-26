<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="vo.CustomerVO"%>
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
	
<%
request.setCharacterEncoding("UTF-8");
Object obj = session.getAttribute("cvo");
Object oobj = session.getAttribute("ovo");

String anoStr = request.getParameter("ano");
int ano = Integer.parseInt(anoStr);

if (obj == null) {
	if (oobj != null) {	// 호스트로 로그인시 숙소상세보기 페이지로 돌아감	
		response.sendRedirect("productDetail.jsp?ano=" + ano);
	} else { // 로그인 안했으면 로그인화면으로 이동
		response.sendRedirect("login.jsp");
	}
} else {

	DecimalFormat df = new DecimalFormat("###,###");

	CustomerVO cvo = (CustomerVO) obj;

	String rnoStr = request.getParameter("rno");
	int rno = Integer.parseInt(rnoStr);

	String checkin = request.getParameter("checkin");
	String checkout = request.getParameter("checkout");

	long diffDays = 0;

	if (!"".equals(checkin) && !"".equals(checkout)) {
		Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(checkin);
		Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(checkout);

		diffDays = (format2.getTime() - format1.getTime()) / 1000 / (24 * 60 * 60); //일자수 차이
	}

	// 날짜 체크하지 않고 방 클릭시 productDetail.jsp로 돌아감
	if ((checkin == "" || "".equals(checkin)) || checkout == "" || "".equals(checkout)) {
		response.sendRedirect("productDetail.jsp?ano=" + ano + "&bn=1");
	}

	AccomodationDAO aDao = new AccomodationDAO();
	AccomodationVO aVo = aDao.selectOne(ano);
	RoomDAO rDao = new RoomDAO();
	RoomVO rVo = rDao.select(rno);
%>
	
	window.onload = function() {
		var paybtn = document.getElementById("pay");
		var allcheck = document.getElementById("allcaution");

		paybtn.onclick = check;
		allcheck.onchange = cautioncheck;

	}

	function cautioncheck() {
		if ($("#allcaution").prop("checked")) {
			$("#mustcaution, #caution1, #caution2").prop("checked", true);
		} else {
			$("#mustcaution, #caution1, #caution2").prop("checked", false);
		}
	}

	function check() {
		var must = document.getElementById("mustcaution");

		console.dir(must);
		if (!must.checked) {
			alert("필수약관에 동의해주세요. ");
		} else {
			var frm = document.frm
			frm.submit();
		}
	}
</script>
</head>
<body class="customerBooking">

	<jsp:include page="header.jsp" />
	<jsp:include page="nav.jsp" />
	<div class="container-fluid mt-4">
		<div class="row">
			<div class="col-md-2"></div>

			<div class="col-md-8">

				<form action="customerBookingOk.jsp" name="frm">
					<input type="hidden" name="rno" value="<%=rno%>" />
					<input type="hidden" name="ano" value="<%=ano%>" />
					<input type="hidden" name="checkin" value="<%=checkin%>" />
					<input type="hidden" name="checkout" value="<%=checkout%>" />
					<input type="hidden" name="price" value="<%=Math.round(rVo.getPrice() * (1 - rVo.getDiscount() * 0.01) * diffDays)%>" />
					<div class="row border border-1 mt-3 p-4">
						<p class="fs-4"><%=aVo.getAname()%></p>
						<p class="fs-5"><%=rVo.getRtype()%></p>
						<p class="fs-5">
							<%=checkin%>
							~
							<%=checkout%>
							(<%=diffDays%>박)<br /> <span class="text-muted">체크인 14:00 &nbsp;|&nbsp; 체크아웃 11:00</span>
						</p>
						<div class="text-end fs-4 fw-bold pe-4">
							금액
							<%=df.format(Math.round(rVo.getPrice() * (1 - rVo.getDiscount() * 0.01) * diffDays))%>원
						</div>
					</div>

					<div class="row mb-3 p-4">
						<div class="d-grid col-6">
							<input type="radio" name="way" value="도보" class="btn-check" id="btn-onfoot" checked>
							<label class="btn btn-secondary" for="btn-onfoot">도보</label>
						</div>
						<div class="d-grid col-6">
							<input type="radio" name="way" value="차량" class="btn-check" id="btn-bycar">
							<label class="btn btn-secondary" for="btn-bycar">차량</label>
						</div>
					</div>

					<div class="border border-1 my-3 p-4">
						<h5>예약자 정보</h5>
						<div class="my-3">
							<label for="bname" class="form-label">이름</label>
							<input type="text" class="form-control" name="bname" id="bname" value="<%=cvo.getCname()%>" />
						</div>
						<div class="mb-3">
							<label for="bphone" class="form-label">전화번호</label>
							<input type="text" class="form-control" name="bphone" id="bphone" value="<%=cvo.getCphone()%>" />
						</div>
					</div>

					<div class="border border-1 my-3 p-4">
						<h5>금액 및 할인 정보</h5>
						<div class="pt-3">
							<span>총 예약금액</span> <span class="float-end">￦ <%=df.format(rVo.getPrice())%> * <%=diffDays%> = <%=df.format(rVo.getPrice() * diffDays)%></span>
						</div>
						<div class="border-bottom border-1 py-2 text-success">
							<span>할인 금액</span> <span class="float-end">￦ <%=df.format(Math.round(rVo.getPrice() * rVo.getDiscount() * 0.01))%> * <%=diffDays%> = <%=df.format(Math.round(rVo.getPrice() * rVo.getDiscount() * 0.01 * diffDays))%></span>
						</div>
						<div class="pt-2 fw-bold">
							<span>결제 금액</span> <span class="float-end">￦ <%=df.format(Math.round(rVo.getPrice() * (1 - rVo.getDiscount() * 0.01) * diffDays))%></span>
						</div>
					</div>

					<div class="border border-1 my-3 p-4">
						<h5>결제수단</h5>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio1" value="카카오페이" checked>
							<label class="form-check-label" for="inlineRadio1">카카오페이</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio2" value="네이버페이">
							<label class="form-check-label" for="inlineRadio2">네이버페이</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio3" value="신용카드">
							<label class="form-check-label" for="inlineRadio3">신용카드</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio4" value="휴대폰결제">
							<label class="form-check-label" for="inlineRadio4">휴대폰결제</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio5" value="토스">
							<label class="form-check-label" for="inlineRadio5">토스</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="payment" id="inlineRadio7" value="무통장입금">
							<label class="form-check-label" for="inlineRadio7">무통장입금</label>
						</div>
					</div>

					<div class="border border-1 my-3 p-3">
						<p>주의사항</p>
						<p>주의사항</p>
						<p>주의사항</p>
						<div class="form-check fs-4">
							<input class="form-check-input" type="checkbox" value="" id="allcaution">
							<label class="form-check-label fs-5" for="allcaution">전체동의</label>
						</div>
						<div class="form-check fs-5">
							<input class="form-check-input me-3" type="checkbox" id="mustcaution">
							<label class="form-check-label fs-6" for="mustcaution">[필수] 만 14세 이상 동의</label>
						</div>
						<div class="form-check fs-5">
							<input class="form-check-input me-3" type="checkbox" id="caution1">
							<label class="form-check-label fs-6" for="caution1">[선택] 혜택 정보 수신 동의</label>
						</div>
						<div class="form-check fs-5">
							<input class="form-check-input me-3" type="checkbox" id="caution2">
							<label class="form-check-label fs-6" for="caution2">[선택] 이벤트,광고성 정보 수신을 위한 개인정보 수집 동의</label>
						</div>
					</div>

					<div class="my-3 p-3 d-grid">
						<button class="btn btn-primary" type="button" id="pay">결제하기</button>
					</div>
				</form>

				<%
				}
				%>

			</div>
			<div class="col-md-2"></div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

	<!-- Bootstrap Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
		crossorigin="anonymous"></script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>
</html>
