<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 호스트 마이페이지 사이드바 -->
<%
request.setCharacterEncoding("UTF-8");
String cp = request.getParameter("cp");
String loc = request.getParameter("loc");
System.out.println("loc : " + loc);

Object obj = session.getAttribute("ovo");
OwnerVO ovo = (OwnerVO) obj;
%>

<div class="col-md-3">
	<div class="d-none d-md-block sidebar fixedsidebar">
		<button type="button" class="btn-close btn-close-white d-none" aria-label="Close"></button>
		<h3 class="text-white">마이페이지</h3>
		<nav class="nav flex-column h-75">
			<a class="nav-link text-white ps-0 <%=loc == null && cp == null ? "selected" : ""%>" href="hostModify.jsp">내 정보</a>
			<a class="nav-link text-white mt-2 ps-0 <%=cp != null ? "selected" : ""%>" href="hostBookingCheck.jsp?cno=<%=ovo.getOno()%>&cp=1">예약 관리</a>

			<div class="nav-link text-white mt-2 ps-0">
				숙소 관리
				<a class="nav-link text-white mt-2 <%="pmanage".equals(loc) ? "selected" : ""%>" href="productManage.jsp?loc=pmanage">숙소 정보 관리</a>
				<a class="nav-link text-white <%="rmanage".equals(loc) ? "selected" : ""%>" href="roomManage.jsp?loc=rmanage">방 정보 관리</a>
			</div>
		</nav>
	</div>
</div>