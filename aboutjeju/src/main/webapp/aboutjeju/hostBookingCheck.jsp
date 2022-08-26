<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="vo.BookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.OwnerVO"%>
<%@page import="dao.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ABOUT JEJU</title>

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

<body class="mypage hostBookingCheck">
	<jsp:include page="mypageHeader.jsp" />

	<div class="container-fluid">
		<div class="row">
			<jsp:include page="mypageSidebarH.jsp" />

			<div class="col-md-9 contents p-5">

				<%
				request.setCharacterEncoding("UTF-8");
				String cp = request.getParameter("cp");

				int currentPage = 1;

				if (cp != null) {
					currentPage = Integer.parseInt(cp);
				}

				int startNo = (currentPage - 1) * 10;

				Object obj = session.getAttribute("ovo");
				OwnerVO ovo = (OwnerVO) obj;
				String ono = ovo.getOno();
				int ownerno = Integer.parseInt(ono);

				DecimalFormat dfprice = new DecimalFormat("###,###");
				DecimalFormat dfbno = new DecimalFormat("000000000");

				BookDAO bdao = new BookDAO();
				ArrayList<BookVO> list = bdao.select(ono, startNo);

				RoomDAO rdao = new RoomDAO();
				RoomVO rvo = null;

				String bookStatus = null;

				if (list.size() == 0) {
				%>

				<h3 class="pb-5 h-50 d-flex justify-content-center align-items-end">예약
					내역이 없습니다.</h3>

				<%
				} else {
				%>

				<div class="table-responsive">
					<table class="table table-sm table-striped table-hover text-center">
						<thead class="table-secondary">
							<tr>
								<th scope="col"></th>
								<th scope="col">예약번호</th>
								<th scope="col">이름</th>
								<th scope="col">전화번호</th>
								<th scope="col">체크인</th>
								<th scope="col">체크아웃</th>
								<th scope="col">방타입</th>
								<th scope="col">이동방법</th>
								<th scope="col">결제금액</th>
								<th scope="col">결제구분</th>
								<th scope="col">예약상태</th>
							</tr>
						</thead>
						<tbody>

							<%
							for (BookVO bvo : list) {

								rvo = rdao.select(bvo.getRno());

								if (bvo.getBookok() == 1) {
									bookStatus = "예약중";
								} else if (bvo.getBookok() == 2) {
									bookStatus = "투숙 완료";
								} else {
									bookStatus = "취소 완료";
								}
							%>

							<tr>
								<td><input class="form-check-input" type="radio"
									name="bookCancelRadio" id="<%=bvo.getBno()%>"
									<%=bvo.getBookok() == 1 ? "" : "disabled"%>></td>
								<th scope="row"><%=dfbno.format(bvo.getBno())%></th>
								<td><%=bvo.getBname()%></td>
								<td><%=bvo.getBphone()%></td>
								<td><%=bvo.getBsdate()%></td>
								<td><%=bvo.getBedate()%></td>
								<td><%=rvo.getRtype()%></td>
								<td><%=bvo.getWay()%></td>
								<td><%=dfprice.format(bvo.getBprice())%></td>
								<td><%=bvo.getPay()%></td>
								<td><%=bookStatus%></td>
							</tr>

							<%
							}
							%>

						</tbody>
					</table>
				</div>
				<button type="button" class="btn btn-outline-secondary mt-3"
					data-bs-toggle="modal" data-bs-target="#hostBookCancel" disabled>예약취소</button>

				<!-- Modal -->
				<div class="modal fade" id="hostBookCancel" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">확인</h5>
							</div>
							<div class="modal-body">예약을 취소하시겠습니까?</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-primary submit">확인</button>
							</div>
						</div>
					</div>
				</div>

				<%
				int totalCount = bdao.getTotalCount2(ownerno);
				System.out.println("totlaCount : " + totalCount);

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

				<!-- 페이지 -->
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center mt-3">
						<%
						if (currentPage > 1) {
						%>

						<li class="page-item"><a class="page-link"
							href="hostBookingCheck.jsp?ono=<%=ono%>&cp=<%=(currentPage - 5 < 1) ? 1 : (currentPage - 5)%>"
							aria-label="Previous" title="5페이지 앞으로"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>

						<%
						}

						for (int i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
						%>

						<li class="page-item"><a
							class="page-link bg-primary text-white"
							href="hostBookingCheck.jsp?ono=<%=ono%>&cp=<%=i%>"><%=i%></a></li>

						<%
						} else {
						%>

						<li class="page-item"><a class="page-link"
							href="hostBookingCheck.jsp?ono=<%=ono%>&cp=<%=i%>"><%=i%></a></li>

						<%
						}
						}

						if (currentPage + 2 < totalPage) {
						%>
						<li class="page-item"><a class="page-link"
							href="hostBookingCheck.jsp?ono=<%=ono%>&cp=<%=(currentPage + 5 > totalPage) ? (totalPage) : (currentPage + 5)%>"
							aria-label="Next" title="5페이지 뒤로"> <span aria-hidden="true">&raquo;</span>
						</a></li>
						<%
						}

						}
						%>
					</ul>
				</nav>

			</div>
			<!-- contents end -->
		</div>
		<!-- row end -->
	</div>
	<!-- container-fluid end -->

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