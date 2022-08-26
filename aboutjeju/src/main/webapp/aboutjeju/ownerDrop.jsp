<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
	p{
	
	}
	div#drop_wrapper{
		position: absolute;
		top: 15%;
		left: 32%;
		/*
		margin-top: 100px;
		margin-left: 300px; */
	}
	#button{
		position: absolute;
		top: 105%;
		left: 10%;
		width:800px;
		padding-left: 200px;
		margin : center;
		margin-top: 50px
	}
</style>
<script type="text/javascript">
	function agreeCheck(frm){
    	if(frm.checkButton.disabled==true)
    		frm.checkButton.disabled=false;
    	else
    		frm.checkButton.disabled=true;
	}
</script>
</head>
<body>
<%
	Object obj = session.getAttribute("ovo");
	OwnerVO ovo = (OwnerVO)obj;
	
	
%>
	<jsp:include page="loginHeader.jsp" />
	<div id="drop_wrapper">
		<h3>탈퇴 안내</h3>
		<h4 style="color:gray;">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</h4>
		<br>
		
		<div>
			<p>
			<b style=color:black">사용하고 계신 아이디(<span style="color:green"><%=ovo.getOid() %></span>)는 탈퇴할 경우 재사용 및 복구가 불가능 합니다.</p>
			<p><span style="color:orange">
			탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구</span><span style="color:gray">가 불가하오니 신중하게 선택하시기 바랍니다.</span></b></p>
			<br>
		</div>
		  
		<div>
			<p>
			<b>탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.</p>
			<p><span style="color:gray">
			회원정보 및 숙소 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br>
			삭제되는 내용을 확인하시고 필요한 데이터는 미리 백업을 해주세요.</span></b></p>
			<br>
		</div>
		
		<div>
			<p>
			<b>탈퇴 후에도 작성한 후기는 그대로 남아 있습니다.</p>
			<p><span style="color:gray">
			삭제를 원하시면 탈퇴 전 미리 삭제해주시기 바랍니다.</span></b></p>
			<br>
		</div>
		 
		<div>
			<p><span style="color:orange">
			<b>탈퇴 후에는 아이디 <%=ovo.getOid() %>로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다.<br>
			남아있는 후기는 탈퇴 후 삭제할 수 없습니다.</span></b>
			</p>
			<br>
		</div>
		<form name="form">
		<input type="checkbox" name="agree" onclick="agreeCheck(this.form)" />안내 사항을 모두 확인하였으며, 이에 동의합니다. 
		
		<div id="button">
			<input type="button" value="탈퇴하기" name="checkButton" onclick="location='ownerDropOk.jsp'" disabled>
		</div>
		</form>
	</div>
	
</body>
</html>