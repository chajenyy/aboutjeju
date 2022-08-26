<%@page import="vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- Bootstrap icon CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>

<body class="bookCancel">
	<jsp:include page="loginHeader.jsp" />

	<%
	request.setCharacterEncoding("UTF-8");

	Object obj = session.getAttribute("cvo");
	CustomerVO cvo = (CustomerVO) obj;

	String bookno = request.getParameter("bno");
	int bno = 0;
	if (bookno != null) {
		bno = Integer.parseInt(bookno);
	}
	%>

	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-sm-1 col-md-2 col-lg-3"></div>

			<div class="col-sm-10 col-md-8 col-lg-6">
				<h3 class="text-center mb-4">예약 취소 약관</h3>
				<div class="mb-4 mx-auto">
					<textarea class="form-control noresize" rows="20" disabled>
어바웃제주 취소, 환불 및 보상 약관

제1장 약관의 적용

제1조 어바웃제주의 취소, 환불 및 보상 정책은 본 약관의 규정을 따릅니다.

제2조 본 약관은 특별약관으로서 어바웃제주 일반 약관 및 공정거래위원회 표준약관에 우선하여 적용됩니다.

제3조 본 특별약관은 공정거래위원회 표준약관과는 다를 수 있습니다.



제2장 예약의 취소, 환불

제1조 예약 취소에 따른 예약금 환불 여부는 각 숙소의 환불 규정을 따릅니다.

제2조 숙소의 환불 규정에 따라 환불이 가능한 경우라도, 예약금 결제 후 7일이 경과하여 예약을 취소할 경우, 총 예약금 중 10%의 금액이 Transaction fee로 공제됩니다.

제2-1조 모든 업무 처리는 한국 시간을 기준으로 운영됩니다.

제3조 어바웃제주 예약금 이외 숙소에 직접 결제하신 금액이 있는 경우, 어바웃제주은 해당 금액의 환불 여부에 대해 책임을 지지 않습니다.

제4조 천재지변, 전란, 정부의 명령, 운송기관 등의 파업·휴업 등으로 예약을 취소하는 경우, 국외여행표준약관 제9조 제1항 및 제15조 제2항에 의거 어바웃제주과 숙소는예약금 환불 의무를 지지 않습니다.



제3장 보상

제1조 숙소 이용 후, 숙소의 시설 또는 서비스를 이유로 보상을 요구할 수 없습니다.

제2조 숙소 이용 중 발생한 상해나 질병 또는 재산상의 손실에 대해 어바웃제주이 보상 의무를 지지 않습니다.

제3조 고객이 예약한 객실이 아닌 다른 객실이 숙소에 의해 제공된 경우, 고객이 숙소에 의해 제공된 객실을 이용하거나 숙소의 기타 보상 안을 수용한 경우, 어바웃제주는 별도의 보상 의무를 지지 않습니다.
					</textarea>
					<div class="form-check py-3">
						<input class="form-check-input" type="checkbox"
							id="cancelContract"> <label class="form-check-label"
							for="cancelContract">어바웃제주 취소, 환불 및 보상 약관 동의(필수)</label>
					</div>
				</div>

				<div class="mb-5 mx-auto text-center">
					<a href="customerBookingCheck.jsp?cno=<%=cvo.getCno()%>&cp=1"
						type="button" class="btn btn-secondary btn-lg px-5 mx-4 my-2">취소</a>
					<input type="hidden" value="<%=bno%>" id="getBno">
					<button type="button"
						class="btn btn-primary btn-lg px-5 mx-4 my-2 submit">확인</button>
				</div>
			</div>


			<div class="col-sm-1 col-md-2 col-lg-3"></div>
		</div>
	</div>
	<!-- Bootstrap Bundle with Popper -->
	<script
		src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>

</html>
