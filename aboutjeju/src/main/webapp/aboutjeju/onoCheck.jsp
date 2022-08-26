<%@page import="dao.OwnerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String ono = request.getParameter("ono");

String result = null;
boolean oisExist = false;

if (ono != null) {
	OwnerDAO odao = new OwnerDAO();

	oisExist = odao.onoCheck(ono);

	odao.close();
}

if (oisExist == true) {
	result = "이미 가입된 사업자번호입니다.";
} else {
	result = "사용 가능한 사업자번호입니다.";
}

out.println(result);
%>