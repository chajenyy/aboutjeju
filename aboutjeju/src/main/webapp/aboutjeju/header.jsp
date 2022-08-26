<%@page import="vo.OwnerVO"%>
<%@page import="vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- ## 헤더 -->
<div class="container-fluid py-4 headerWrap" id="headerWrap">
	<div class="row header">
		<div>
			<a href="main.jsp"> <img src="../images/logo.jpg" alt="ABOUT JEJU" class="ps-2">
			</a>
		</div>

		<%
		Object cobj = session.getAttribute("cvo");
		Object oobj = session.getAttribute("ovo");
		CustomerVO cvo = null;
		OwnerVO ovo = null;
		if (cobj != null) {
			cvo = (CustomerVO) cobj;
		}
		if (oobj != null) {
			ovo = (OwnerVO) oobj;
		}
		// 로그인 되어있지 않은 상태
		if (cvo == null && ovo == null) {
		%>

		<div class="dropdown text-end position-absolute mt-3">
			<a href="login.jsp" class="rounded-pill p-2 loginyet"> <i class="bi bi-key fs-5 fst-normal"> 로그인</i>
			</a>
		</div>

		<%
		// 로그인되어있는 상태
		} else {
		%>

		<div class="dropdown text-end position-absolute w-25">
			
				<%
		if(cvo != null){
			if(cvo.getCid().equals("admin")){
		%>
			<img src="../images/KakaoTalk.jpg" class="rounded-circle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false" alt="" style="width:100px"/>
		<% 
			}else { 
		%>
			<i class="bi bi-person-circle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i>			
		<% 
				} 
			}else{
		%>
			<i class="bi bi-person-circle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i>			
		<%
				}
		%>
		
		
			<!-- <i class="bi bi-person-circle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false"></i> -->
			<ul class="dropdown-menu shadow" aria-labelledby="dropdownMenuButton1">
				<li><a class="dropdown-item" href="<%=cvo != null ? "customerModify.jsp" : "hostModify.jsp"%>">마이페이지</a></li>
				<li><a class="dropdown-item" href="<%=cvo != null ? "customerBookingCheck.jsp?cp=1" : "hostBookingCheck.jsp?cp=1"%>">예약내역</a></li>
				<li>
					<hr class="dropdown-divider">
				</li>
				<li><a class="dropdown-item" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">로그아웃</a></li>
			</ul>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">확인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">로그아웃 하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">
							<a href="logout.jsp" class="text-white">확인</a>
						</button>
					</div>
				</div>
			</div>
		</div>

		<%
		}
		%>

		<div class="d-flex justify-content-center">
			<form action="productList.jsp" id="headerfrm" class="rounded-pill mt-3 h-75">
				<i class="bi bi-search rounded-pill float-end p-2 fs-5 submit"></i>
				<div id="headerinput" class="btn-group h-100" role="group" aria-label="Basic example">
					<input type="search" id="search" name="search" value="" class="w-50 ps-3" placeholder="검색어 입력"> <input type="text" id="checkin"
						name="checkin" placeholder="체크인" class="w-25" /> <input type="text" id="checkout" name="checkout" placeholder="체크아웃" class="w-25" />
				</div>
			</form>
		</div>
	</div> 
</div>
<div class="goingUp">
	<a href="#headerWrap"> <i class="bi bi-arrow-up-circle fs-1 text-center"></i>
	</a>

</div>