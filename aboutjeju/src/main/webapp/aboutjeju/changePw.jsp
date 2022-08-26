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
	String id = request.getParameter("inputId");
	String who = request.getParameter("who");
	%>

	<div class="row changePw">
		<div class="col-1 col-sm-2 col-lg-3 col-xl-4"></div>
		<form action="changePwOk.jsp"
			class="col-10 col-sm-8 col-lg-6 col-xl-4" id="changePwfrm">
			<h4 class="mb-5 fw-bold">비밀번호 재설정</h4>
			<div class="mb-3 row">
				<label for="inputPw" class="col-form-label col-4">비밀번호 입력</label>
				<div class="col-8">
					<input type="hidden" class="form-control" name="inputId"
						value="<%=id%>"> <input type="hidden" class="form-control"
						name="who" value="<%=who%>"> <input type="password"
						class="form-control" name="inputPw" id="inputPw">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputRePw" class="col-form-label col-4">비밀번호 재입력</label>
				<div class="col-8">
					<input type="password" class="form-control" name="inputRePw"
						id="inputRePw">
					<div class="checkPwMsg mt-2">비밀번호 길이 8~20자</div>
				</div>
			</div>
			<div class="mt-4 text-center">
				<a class="btn btn-outline-primary shadow-sm mx-3 px-3 submit"
					role="button"><i class="bi bi-check-lg"></i> 확인</a>
			</div>
		</form>
		<div class="col-1 col-sm-2 col-lg-3 col-xl-4"></div>
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