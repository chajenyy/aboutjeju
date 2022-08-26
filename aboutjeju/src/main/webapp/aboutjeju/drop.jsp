<%@page import="vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<script type="text/javascript">
	function agreeCheck(frm) {
		if (frm.checkButton.disabled == true)
			frm.checkButton.disabled = false;
		else
			frm.checkButton.disabled = true;
	}
</script>
<%
Object obj = session.getAttribute("cvo");
CustomerVO vo = (CustomerVO) obj;
%>
</head>
<body>
	<jsp:include page="loginHeader.jsp" />
	<div class="container-fluid my-4">
		<div class="col-md-6 mx-auto">
			<h3 class="my-5">탈퇴 안내</h3>
			<h4 style="color: gray;">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</h4>
			<br>

			<div>
				<p>
					<b style="color: black">사용하고 계신 아이디(<span style="color: green"><%=vo.getCid()%></span>)는 탈퇴할 경우 재사용 및 복구가 불가능 합니다.
					</b>
				</p>
				<p>
					<span style="color: orange"><b>탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구</b> </span><span style="color: gray"><b>가 불가하오니 신중하게 선택하시기 바랍니다.</b> </span>
				</p>
				<br>
			</div>

			<div>
				<p>
					<b>탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</b>
				</p>
				<p>
					<span style="color: gray"> <b>회원정보 및 숙소 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br> 삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.
					</b></span>
				</p>
				<br>
			</div>

			<div>
				<p>
					<b>탈퇴 후에도 작성한 후기는 그대로 남아 있습니다.</b>
				</p>
				<p>
					<span style="color: gray"> <b>삭제를 원하시면 탈퇴 전 미리 삭제해주시기 바랍니다.</b></span>
				</p>
				<br>
			</div>

			<div>
				<p>
					<span style="color: orange"> <b>탈퇴 후에는 아이디 <%=vo.getCid()%>로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다.<br>남아있는 후기는 탈퇴 후 삭제할 수 없습니다.
					</b></span>
				</p>
				<br>
			</div>
			<form name="form">
				<input type="checkbox" class="form-check-input" id="agree" name="agree" onclick="agreeCheck(this.form)" />
				<label class="form-check-label" for="agree"> 안내 사항을 모두 확인하였으며, 이에 동의합니다. </label>
				<div id="button" class="text-center">
					<input class="btn btn-secondary my-4" type="button" value="탈퇴하기" name="checkButton" onclick="location='dropOk.jsp'" disabled>
				</div>
			</form>
		</div>
	</div>

</body>
</html>