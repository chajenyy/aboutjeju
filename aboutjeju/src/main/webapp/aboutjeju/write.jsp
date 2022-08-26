<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.BookVO"%>
<%@page import="dao.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>

<body>

	<jsp:include page="loginHeader.jsp" />

	<%
	request.setCharacterEncoding("UTF-8");
	String bookno = request.getParameter("bno");
	int bno = 0;

	if (bookno != null) {
		bno = Integer.parseInt(bookno);
	}

	BookDAO bdao = new BookDAO();
	BookVO bvo = bdao.selectOne(bno);

	AccomodationDAO adao = new AccomodationDAO();
	AccomodationVO avo = adao.selectOne(bvo.getOno());

	bdao.close();
	adao.close();
	%>

	<!-- ## 콘텐츠 -->
	<div class="row write">
		<div class="col-1 col-sm-2 col-lg-3 col-xl-4"></div>
		<form action="writeOk.jsp" class="col-10 col-sm-8 col-lg-6 col-xl-4" id="writefrm">
			<h4 class="mt-5 mb-4 fw-bold text-center">이용 후기</h4>
			<div class="card p-4 mb-1">
				<div class="row">
					<div class="col-4">
						<img src="<%=avo.getAimage()%>" class="rounded-start w-100 h-100" alt="<%=avo.getAname()%>">
					</div>
					<div class="col-8">
						<div class="card-body">
							<h5 class="card-title fw-bold"><%=avo.getAname()%></h5>
							<div class="card-text">
								예약번호 : <span class="bno"><%=bvo.getBno()%></span>
							</div>
							<div class="card-text">
								숙박기간 :
								<p><%=bvo.getBsdate()%>
									~
									<%=bvo.getBedate()%></p>
							</div>
							<input type="hidden" name="inputBno" value="<%=bvo.getBno()%>">
							<input type="hidden" name="inputAno" value="<%=avo.getAno()%>">
						</div>
					</div>
				</div>
			</div>
			<div class="card p-4 mb-4">
				<div class="mb-3 row">
					<label for="inputRate" class="col-form-label col-2 fw-bold">별점</label>
					<div class="col-10">
						<select class="form-select" name="inputRate" id="inputRate">
							<option value="5">5</option>
							<option value="4">4</option>
							<option value="3">3</option>
							<option value="2">2</option>
							<option value="1">1</option>
						</select>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputTitle" class="form-label col-2 fw-bold">제목</label>
					<div class="col-10">
						<input type="text" class="form-control" name="inputTitle" id="inputTitle">
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputContents" class="form-label col-2 fw-bold">내용</label>
					<div class="col-10">
						<textarea class="form-control" name="inputContents" id="inputContents" rows="10"></textarea>
					</div>
				</div>
				<div class="mt-2 text-center">
					<a class="btn btn-outline-primary shadow-sm mx-3 px-3 submit" role="button">
						<i class="bi bi-check-lg"></i> 작성하기
					</a>
				</div>
			</div>
		</form>
		<div class="col-1 col-sm-2 col-lg-3 col-xl-4"></div>
	</div>

	<!-- Bootstrap Bundle with Popper -->
	<script src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>

</html>