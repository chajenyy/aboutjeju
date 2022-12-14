<%@page import="dao.ReviewDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="vo.RoomdetailVO"%>
<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomdetailDAO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.BookVO"%>
<%@page import="vo.CustomerVO"%>
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

<body class="mypage">
	<jsp:include page="mypageHeader.jsp" />

	<div class="container-fluid">
		<div class="row">
			<jsp:include page="mypageSidebarC.jsp" />

			<div class="col-md-9 contents">

				<%
				request.setCharacterEncoding("UTF-8");
				String cp = request.getParameter("cp");
				int currentPage = 1;
				if (cp != null) {
					currentPage = Integer.parseInt(cp);
				}

				int startNo = (currentPage - 1) * 4;

				Object obj = session.getAttribute("cvo");
				CustomerVO cvo = (CustomerVO) obj;
				int cno = cvo.getCno();

				BookDAO bdao = new BookDAO();
				ArrayList<BookVO> list = bdao.customerBookingData(cno, startNo);
				System.out.println(list.size());
				DecimalFormat dfprice = new DecimalFormat("###,###");
				if (list.size() == 0) {
				%>

				<h3 class="pb-5 h-50 d-flex justify-content-center align-items-end">??????
					????????? ????????????.</h3>

				<%
				} else {
				for (BookVO bvo : list) {
				%>

				<div class="card mb-3 mx-auto" style="max-width: 650px;">
					<div class="row g-0 border-1 border-bottom">
						<div class="col-md-4">
							<img src="<%=bvo.getAimage()%>" class="img-fluid rounded-start"
								alt="<%=bvo.getAname()%>">
						</div>
						<div class="col-md-8">
							<div class="card-body row pb-0">
								<div class="col-6">
									<h5 class="card-title"><%=bvo.getAname()%></h5>
									<p><%=bvo.getRtype()%></p>
								</div>
								<div class="col-6">
									<div class="row">
										<div class="col-6 text-center border-1 border-end">
											?????????<br />
											<%=bvo.getBsdate()%>
										</div>
										<div class="col-6 text-center">
											????????????<br />
											<%=bvo.getBedate()%>
										</div>
										<p class="fs-4 fw-bold text-end pt-4 mb-0">
											???
											<%=dfprice.format(bvo.getBprice())%></p>
									</div>
								</div>
							</div>
						</div>

						<%
						// BookDAO bdao = new BookDAO(); ????????? ?????? ?????????		
						RoomDAO rdao = new RoomDAO();
						RoomdetailDAO rddao = new RoomdetailDAO();
						AccomodationDAO adao = new AccomodationDAO();
						ReviewDAO rvdao = new ReviewDAO();

						BookVO bvo2 = bdao.selectOne(bvo.getBno());

						DecimalFormat dfbno = new DecimalFormat("000000000");

						String bsdate = bvo2.getBsdate(); //?????????
						String bedate = bvo2.getBedate(); //????????????

						Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(bsdate);
						Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(bedate);

						long diffDays = (format2.getTime() - format1.getTime()) / 1000 / (24 * 60 * 60); //????????? ??????

						String bookingStatus = null;
						String bookingStatusBgColor = "green";

						if (bvo2.getBookok() == 1) {
							bookingStatus = "?????????";
						} else if (bvo2.getBookok() == 2) {
							bookingStatus = "?????? ??????";
							bookingStatusBgColor = "black";
						} else if (bvo2.getBookok() == 3) {
							bookingStatus = "?????? ??????";
							bookingStatusBgColor = "red";
						}

						RoomVO rvo = rdao.select(bvo2.getRno()); // book ??????????????? rno ???????????? ??????

						ArrayList<RoomdetailVO> rdlist = rddao.select(bvo2.getRno()); // book ??????????????? rno ???????????? ??????
						RoomdetailVO rdvo = rdlist.get(0); // ??? ????????? ?????? ???????????? ????????? ??????

						AccomodationVO avo = adao.selectOne(rvo.getAno()); // room ??????????????? ano ???????????? ??????

						boolean isReviewExist = rvdao.selectOne(bvo.getBno());
						%>

						<div class="d-flex">
							<a
								<%=isReviewExist == false && bvo2.getBookok() == 2 ? "href='write.jsp?bno=" + bvo.getBno() + "'" : ""%>
								class="me-auto ps-3 pt-3 <%=isReviewExist == false && bvo2.getBookok() == 2 ? "" : "text-muted"%>">????????????
								????????????</a>
							<button type="button" class="btn btn-secondary m-2"
								data-bs-toggle="modal"
								data-bs-target="#customerBookingDetail<%=bvo.getBno()%>">???????????????</button>
							<div class="modal" tabindex="-1"
								id="customerBookingDetail<%=bvo.getBno()%>">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">?????? ?????? ??????</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="container-fluid">
												<p class="text-white p-2 text-center mb-0"
													style="background-color: <%=bookingStatusBgColor%>"><%=bookingStatus%></p>

												<div
													class="box1 border border-1 border-top-0 p-3 text-center">
													<p>
														???????????? :
														<%=dfbno.format(bvo.getBno())%></p>
													<a
														class="btn btn-primary d-block mb-3 <%=isReviewExist == false && bvo2.getBookok() == 2 ? "" : "disabled"%>"
														<%=isReviewExist == false ? "href='write.jsp?bno=" + bvo.getBno() + "'" : ""%>
														role="button">???????????? ????????????</a>
												</div>

												<div
													class="box2 border border-1 border-top-0 p-3 text-center w-100">
													<img class="w-100" src="<%=avo.getAimage()%>"
														alt="<%=avo.getAname()%>">
													<p class="fw-bold fs-5 mt-3"><%=avo.getAname()%></p>
													<p><%=avo.getAaddress()%></p>
													<a class="btn btn-outline-primary d-block mb-3" href="tel:<%=avo.getAphone()%>" role="button"> ??????(<%=avo.getAphone()%>)??? ????????????
													</a>
												</div>

												<div
													class="box3 border border-1 border-top-0 ps-3 pe-3 text-center">
													<div class="row position-relative">
														<div
															class="col-6 checkinout pt-3 border-end border-1 fw-bold">
															?????????
															<p class="pt-3 fw-normal"><%=bvo2.getBsdate()%></p>
														</div>
														<div class="col-6 checkinout pt-3 fw-bold">
															????????????
															<p class="pt-3 fw-normal"><%=bvo2.getBedate()%></p>
														</div>
														<a class="d-block border-top border-1 py-2"> <i class="bi bi-send-fill"></i> ?????? ????????? ??????
														</a> <a class="d-block border-top border-1 py-2"> <i class="bi bi-envelope-exclamation-fill"></i> ?????? ?????? ??????
														</a>
													</div>
												</div>

												<div class="box4 border border-1 border-top-0 p-3">
													<p class="fs-5">?????? ??????</p>
													<div class="row g-0">
														<div class="col-4">
															<img src="<%=rdvo.getRimage()%>"
																class="img-fluid rounded-start"
																alt="<%=rvo.getRtype()%>">
														</div>
														<div class="col-8">
															<div class="card-body">
																<p class="card-text">
																	?????? :
																	<%=rvo.getRtype()%></p>
																<p class="card-text">
																	?????? ?????? ?????? :
																	<%=rvo.getRpeople()%></p>
															</div>
														</div>
													</div>
												</div>

												<div class="box5 border border-1 border-top-0 p-3">
													<p class="fs-5">????????? ??????</p>
													<p>
														?????? ????????? :
														<%=bvo2.getBname()%></p>
													<p>
														???????????? :
														<%=bvo2.getBphone()%></p>
												</div>

												<div class="box6 border border-1 border-top-0 p-3">
													<p class="fs-5">?????? ??????</p>
													<p class="text-danger">????????? ????????? ??????????????? ????????? ?????? 7??? ??? ~ ??????
														?????? ?????? ??? ????????? ???????????? ????????????.</p>
													<a
														class="btn btn-outline-primary <%=bvo2.getBookok() == 1 ? "" : "disabled"%> d-block mb-3"
														<%=bvo2.getBookok() == 1 ? "href='bookCancel.jsp?bno=" + bvo.getBno() + "'" : ""%>
														role="button">?????? ??????</a>
												</div>

												<div class="box7 border border-1 border-top-0 p-3">
													<p class="fw-bold fs-5">?????? ??????</p>
													<div class="row">
														<div class="col-6">
															<p>
																?????? 1??? x
																<%=diffDays%>???
															</p>
															<p class="text-success">?????? ??????</p>
															<p class="fw-bold">??? ?????? ??????</p>
															<p>?????? ??????</p>
														</div>
														<div class="col-6 text-end">
															<p>
																???
																<%=dfprice.format(rvo.getPrice())%>
																*
																<%=diffDays%>
																=
																<%=dfprice.format(rvo.getPrice() * diffDays)%></p>
															<p class="text-success">
																???
																<%=dfprice.format(Math.round(rvo.getPrice() * rvo.getDiscount() * 0.01) * diffDays)%></p>
															<p class="fw-bold">
																???
																<%=dfprice
		.format((rvo.getPrice() * diffDays) - (Math.round(rvo.getPrice() * rvo.getDiscount() * 0.01) * diffDays))%></p>
															<p><%=bvo2.getPay()%></p>
														</div>
													</div>
												</div>
											</div>
											<!-- container-fluid end -->
										</div>
										<!-- modal-body -->
									</div>
									<!-- modal-content -->
								</div>
								<!-- modal-dialog -->
							</div>
							<!-- modal -->
						</div>
						<!-- d-flex end -->
					</div>
					<!-- row end -->
				</div>
				<!-- card -->

				<%
				}
				int totalCount = bdao.getTotalCount(cno);
				int totalPage = (totalCount % 4 == 0) ? (totalCount / 4) : (totalCount / 4 + 1);
				int startPage = currentPage;
				int endPage = startPage + 2;
				if (currentPage + 2 >= totalPage) {
				endPage = totalPage;
				}
				if (totalPage <= 3) {
				startPage = 1;
				}
				%>

				<!-- ????????? -->
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center mt-5">
						<%
						if (currentPage > 1) {
						%>

						<li class="page-item"><a class="page-link"
							href="customerBookingCheck.jsp?cp=<%=(currentPage - 5 < 1) ? 1 : (currentPage - 5)%>" aria-label="Previous" title="5????????? ?????????">
								<span aria-hidden="true">&laquo;</span>
						</a></li>

						<%
						}
						for (int i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
						%>

						<li class="page-item"><a class="page-link bg-primary text-white" href="customerBookingCheck.jsp?cp=<%=i%>"><%=i%></a></li>

						<%
						} else {
						%>

						<li class="page-item"><a class="page-link" href="customerBookingCheck.jsp?cp=<%=i%>"><%=i%></a></li>

						<%
						}
						}
						if (currentPage + 2 < totalPage) {
						%>
						<li class="page-item"><a class="page-link"
							href="costomerBookingCheck.jsp?cno=<%=cno%>&cp=<%=(currentPage + 5 > totalPage) ? (totalPage) : (currentPage + 5)%>" aria-label="Next"
							title="5????????? ??????"> <span aria-hidden="true">&raquo;</span>
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