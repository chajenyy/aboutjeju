<%@page import="dao.CustomerDAO"%>
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

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>
<script>
	window.onload=function(){
		
		var btn1 = document.getElementById("btn1");
		btn1.onclick=test3;
		
	}
	
	function test3(){
		console.log("test");
		var pw = $("#inputPw").val();
		var repw = $("#inputRePw").val()
		var num = pw.search(/[0-9]/g);
		var frm = document.frm;
		var phoneNum = $("#inputPhone").val(); 
		var patternPhone = /01[016789][^0][0-9]{2,3}[0-9]{3,4}/;
		var str = $("#inputName").val();
		// var eng = pw.search(/[a-z]/ig);
		// console.log("test");
		// console.log(pw);
		
		// name 유효성검사
		for(var i=0; i<$("#inputName").val().length; i++){
			var chk = $("#inputName").val().substring(i,i+1);     
			if(chk.match(/[0-9]|[a-z]|[A-Z]/i)) {     	
				alert("이름을 정확히 입력해주세요");        
				return;    
			}    
			if(chk.match(/([^가-힣\x20])/i)){    
				alert("이름을 정확히 입력해주세요");       
				return;    
			}    
			if(str.search(/\s/) != -1){    	
				alert("이름을 정확히 입력해주세요");        
				return;   
			}
		}
		
		if(pw.length < 8 || pw.length > 20){
			alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요.");
			return false;
		}else if(pw!=repw){
			alert("비밀번호가 동일하지 않습니다. 다시 입력해주세요.");
			return;
		}else if(pw.search(/\s/) != -1){		
		 	alert("비밀번호는 공백 없이 입력해주세요.");
		 	return false;
		}else if(!patternPhone.test(phoneNum)){
			alert('핸드폰 번호를 확인 해주세요');
			return;
		}else if( !((pw.length < 8 || pw.length > 20) && (pw.search(/\s/) != -1) && (!patternPhone.test(phoneNum))) ) {
			alert("수정되었습니다.");
			frm.action="customerModifyOk.jsp";
			frm.method = "get";
			frm.submit();
			// console.log("통과"); 
		    //return true;
		}else{
			alert("양식에 맞게 입력해주세요.");
		}		
	}		
		// console.log($("#inputName").val());
	</script>

<body class="mypage">

	<jsp:include page="mypageHeader.jsp" />
	<div class="container-fluid mt-4">
		<div class="row">
			<jsp:include page="mypageSidebarC.jsp" />
			<!--제원님은 이부분만 mypageSidebarH.jsp 로 변경해서 연결하시면 됩니다  -->

			<div class="col-md-9">
				<%
				Object obj = session.getAttribute("cvo");
				CustomerVO cvo = (CustomerVO) obj;

				CustomerDAO dao = new CustomerDAO();
				CustomerVO vo = dao.selectOne(cvo.getCid());
				System.out.println(vo);

				//println("obj : " + obj);
				//out.println("id : " + id);
				%>
				<form name="frm" class="col-12 col-sm-8 col-lg-6 mx-auto" id="signUpfrm">
					<h4 class="mb-4 mt-5 fw-bold text-center">내 정보 수정</h4>
					<div class="mb-3 row">
						<label for="inputId" class="col-form-label col-4">아이디</label>
						<div class="col-8">
							<!-- readonly는 disabled처럼 입력은 비활성화 되지만 폼으로 전송 가능 -->
							<input type="text" class="form-control" id="inputId" placeholder="<%=cvo.getCid()%>" readonly>
							<input type="hidden" name="inputId" value="<%=cvo.getCid()%>" />
							<div class="checkIdMsg mt-2"></div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputPw" class="col-form-label col-4">비밀번호 입력</label>
						<div class="col-8">
							<input type="password" class="form-control" name="inputPw" id="inputPw" placeholder="비밀번호 길이 8~20자">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputRePw" class="col-form-label col-4">비밀번호 재입력</label>
						<div class="col-8">
							<input type="password" class="form-control" name="inputRePw" id="inputRePw">
							<div class="checkPwMsg mt-2"></div>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputQuestion" class="col-form-label col-4">비밀번호 찾기 질문</label>
						<div class="col-8">
							<select class="form-select" name="inputQuestion" id="inputQuestion">
								<option value="아버지의 성함은?" <%="아버지의 성함은?".equals(cvo.getCfindpw()) ? "selected" : ""%>>아버지의 성함은?</option>
								<option value="어머니의 성함은?" <%="어머니의 성함은?".equals(cvo.getCfindpw()) ? "selected" : ""%>>어머니의 성함은?</option>
								<option value="부모님의 고향은?" <%="부모님의 고향은?".equals(cvo.getCfindpw()) ? "selected" : ""%>>부모님의 고향은?</option>
								<option value="출신 초등학교는?" <%="출신 초등학교는?".equals(cvo.getCfindpw()) ? "selected" : ""%>>출신 초등학교는?</option>
								<option value="가장 기억에 남는 선생님 성함은?" <%="가장 기억에 남는 선생님 성함은?".equals(cvo.getCfindpw()) ? "selected" : ""%>>가장 기억에 남는 선생님 성함은?</option>
							</select>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputAnswer" class="col-form-label col-4">비밀번호 찾기 답</label>
						<div class="col-8">
							<input type="text" class="form-control" name="inputAnswer" id="inputAnswer" value="<%=vo.getCfindpwa()%>">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputName" class="col-form-label col-4">이름</label>
						<div class="col-8">
							<input type="text" class="form-control" name="inputName" id="inputName" value="<%=vo.getCname()%>">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputPhone" class="col-form-label col-4">휴대전화</label>
						<div class="col-5">
							<input type="number" name="inputPhone" class="form-control w-100" id="inputPhone" value="<%=vo.getCphone()%>">
						</div>
						<div class="col-3 text-end">
							<button type="button" class="btn btn-outline-primary w-100">인증하기</button>
						</div>
					</div>
					<div class="mt-4 text-center">
						<a href="drop.jsp" class="btn btn-secondary m-3 px-4" role="button">회원탈퇴</a>
						<!-- <a class="btn btn-primary m-3 px-4 submit"><i class="bi bi-check-lg"></i> -->
						<input type="button" class="btn btn-primary m-3 px-4" value=" 수 정 " id="btn1" />
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap Bundle with Popper -->
	<script src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>

</html>