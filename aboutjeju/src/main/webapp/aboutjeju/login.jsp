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

<body class="login">

	<jsp:include page="loginHeader.jsp" />

	<!-- 로그인하기 -->
	<div class="row">
		<div class="col-2 col-md-3 col-lg-4"></div>
		<form action="loginOk.jsp"
			class="col-8 col-md-6 col-lg-4 mx-auto px-5" id="loginfrm">
			<h3 class="mb-4 fw-bold text-center">로그인</h3>
			<div class="position-relative mt-2">
				<input type="text" class="form-control" name="inputId" id="inputId"
					placeholder="아이디"> <label for="inputId"><i
					class="bi bi-person-fill fs-2"></i></label>
			</div>
			<div class="position-relative">
				<input type="password" class="form-control" name="inputPw"
					id="inputPw" placeholder="비밀번호"> <label for="inputPw"><i
					class="bi bi-key-fill fs-2"></i></label>
			</div>
			<div class="mt-4 text-center">
				<a href="contract.jsp?who=customer"
					class="btn btn-primary shadow-sm mx-3 mb-3 px-4" role="button">회원가입</a>
				<a class="btn btn-primary shadow-sm mx-3 mb-3 px-4 submit" role="button">
					&nbsp;로그인&nbsp; </a>
			</div>
			<div class="text-center mt-1 lh-lg">
				<a href="findIdPw.jsp" class="">ID / PW 찾기</a> <br /> <a
					href="contract.jsp?who=host" class="">호스트 회원가입</a>
			</div>
		</form>

		<div class="col-2 col-md-3 col-lg-4"></div>
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