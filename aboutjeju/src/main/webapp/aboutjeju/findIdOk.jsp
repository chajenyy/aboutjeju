<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
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

<body>

	<jsp:include page="loginHeader.jsp" />

	<%
	request.setCharacterEncoding("UTF-8");
	String inputName = request.getParameter("inputName");
	String inputPhone = request.getParameter("inputPhone");

	CustomerDAO cdao = new CustomerDAO();
	String cid = cdao.findId(inputName, inputPhone);

	OwnerDAO odao = new OwnerDAO();
	String oid = odao.findId(inputName, inputPhone);

	cdao.close();
	odao.close();
	%>

	<div class="container-fluid text-center findIdOk">
		<div>
			<h4 class="mb-4 fw-bold">아이디 찾기</h4>

			<%
			if (cid != null || oid != null) {
				out.println("<p>입력하신 정보와 일치하는 아이디는 아래와 같습니다.</p>");
				if (cid != null) {
					out.println("<h4>" + cid + "</h4>");
				}
				if (oid != null) {
					out.println("<h4>" + oid + "</h4>");
				}
			} else {
				out.println("<p>입력하신 정보와 일치하는 아이디가 없습니다.</p>");
			}
			%>

			<div class="mt-5">
				<a class="btn btn-outline-primary shadow-sm mx-3 px-3"
					href="findIdPw.jsp" role="button"><i
					class="bi bi-arrow-counterclockwise"></i> 이전으로</a> <a
					class="btn btn-outline-primary shadow-sm mx-3" href="login.jsp"
					role="button"><i class="bi bi-key"></i> 로그인하기</a>
			</div>

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
