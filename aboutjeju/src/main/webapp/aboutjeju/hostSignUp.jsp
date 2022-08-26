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

<!-- ajax -->
<script src="../js/httpRequest.js"></script>
</head>

<body class="hostSignUp signUp">
	<jsp:include page="loginHeader.jsp" />

	<div class="row my-5">
		<div class="col-1 col-sm-2 col-lg-3 col-xl-4"></div>
		<form action="hostSignUpOk.jsp"
			class="col-10 col-sm-8 col-lg-6 col-xl-4" id="signUpfrm">
			<h4 class="mb-4 fw-bold text-center">회원가입</h4>
			<div class="mb-3 row">
				<label for="inputId" class="col-form-label col-4">아이디</label>
				<div class="col-8">
					<input type="text" class="form-control" name="inputId" id="inputId"
						placeholder="아이디 길이 5~20자">
					<div class="checkIdMsg mt-2"></div>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputOno" class="col-form-label col-4">사업자번호</label>
				<div class="col-8">
					<input type="number" class="form-control" name="inputOno"
						id="inputOno" placeholder="- 제외한 숫자만 입력">
					<div class="checkOnoMsg mt-2"></div>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPw" class="col-form-label col-4">비밀번호 입력</label>
				<div class="col-8">
					<input type="password" class="form-control" name="inputPw"
						id="inputPw" placeholder="비밀번호 길이 8~20자">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputRePw" class="col-form-label col-4">비밀번호 재입력</label>
				<div class="col-8">
					<input type="password" class="form-control" name="inputRePw"
						id="inputRePw">
					<div class="checkPwMsg mt-2"></div>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputQuestion" class="col-form-label col-4">비밀번호
					찾기 질문</label>
				<div class="col-8">
					<select class="form-select" name="inputQuestion" id="inputQuestion">
						<option value="아버지의 성함은?">아버지의 성함은?</option>
						<option value="어머니의 성함은?">어머니의 성함은?</option>
						<option value="부모님의 고향은?">부모님의 고향은?</option>
						<option value="출신 초등학교는?">출신 초등학교는?</option>
						<option value="가장 기억에 남는 선생님 성함은?">가장 기억에 남는 선생님 성함은?</option>
					</select>
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputAnswer" class="col-form-label col-4">비밀번호
					찾기 답</label>
				<div class="col-8">
					<input type="text" class="form-control" name="inputAnswer"
						id="inputAnswer">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputName" class="col-form-label col-4">이름</label>
				<div class="col-8">
					<input type="text" class="form-control" name="inputName"
						id="inputName">
				</div>
			</div>
			<div class="mb-3 row">
				<label for="inputPhone" class="col-form-label col-4">휴대전화</label>
				<div class="col-5">
					<input type="number" name="inputPhone" class="form-control w-100"
						id="inputPhone" placeholder="- 제외한 숫자만 입력">
				</div>
				<div class="col-3 text-end">
					<button type="button" class="btn btn-outline-primary w-100">인증하기</button>
				</div>
			</div>
			<div class="mt-4 text-center">
				<a href="login.jsp" class="btn btn-secondary m-3 px-4" role="button"><i
					class="bi bi-x-lg"></i> 취소</a> <a
					class="btn btn-primary m-3 px-4 submit"><i
					class="bi bi-check-lg"></i> 확인</a>
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