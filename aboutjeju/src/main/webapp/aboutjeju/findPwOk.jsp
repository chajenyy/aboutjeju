<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String inputId = request.getParameter("inputId");
String inputQuestion = request.getParameter("inputQuestion");
String inputAnswer = request.getParameter("inputAnswer");

CustomerDAO cdao = new CustomerDAO();
String cwho = cdao.findPw(inputId, inputQuestion, inputAnswer);

OwnerDAO odao = new OwnerDAO();
String owho = odao.findPw(inputId, inputQuestion, inputAnswer);

if (cwho != null) {
	response.sendRedirect("changePw.jsp?inputId=" + inputId + "&who=" + cwho);
} else if (owho != null) {
	response.sendRedirect("changePw.jsp?inputId=" + inputId + "&who=" + owho);
} else {
%>

<script>
	alert('입력하신 내용과 일치하는 정보가 없습니다.');
	location.href = "findIdPw.jsp";
</script>

<%
}

cdao.close();
odao.close();
%>