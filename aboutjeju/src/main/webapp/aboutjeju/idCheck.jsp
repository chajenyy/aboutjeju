<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");

String result = null;
boolean cisExist = false;
boolean oisExist = false;

if (id != null) {
	CustomerDAO cdao = new CustomerDAO();
	OwnerDAO odao = new OwnerDAO();

	cisExist = cdao.idCheck(id);
	oisExist = odao.idCheck(id);

	cdao.close();
	odao.close();
}

if (cisExist == true || oisExist == true) {
	result = "이미 존재하는 아이디입니다.";
} else {
	result = "사용 가능한 아이디입니다.";
}

out.println(result);
%>