<%@page import="vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 일반회원 마이페이지 사이드바 -->
<%
request.setCharacterEncoding("UTF-8");
String cp = request.getParameter("cp");

Object obj = session.getAttribute("cvo");
CustomerVO cvo = (CustomerVO) obj;
%>

<div class="col-md-3">
	<div class="d-none d-md-block sidebar fixedsidebar" style="width:263px;">
		<button type="button" class="btn-close btn-close-white d-none" aria-label="Close"></button>
		<h3 class="text-white">마이페이지</h3>
		<nav class="nav flex-column h-75">
			<a class="nav-link text-white ps-0 <%=cp == null ? "selected" : ""%>" href="customerModify.jsp">내 정보</a>
			<a class="nav-link text-white mt-2 ps-0 <%=cp != null ? "selected" : ""%>" href="customerBookingCheck.jsp?cp=1">예약 관리</a>
		</nav>
	</div>
</div>
