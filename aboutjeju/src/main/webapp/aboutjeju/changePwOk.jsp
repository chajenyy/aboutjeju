<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String pw = request.getParameter("inputPw");
String id = request.getParameter("inputId");
String who = request.getParameter("who");

if (who.equals("customer")) {
	CustomerDAO cdao = new CustomerDAO();
	cdao.changePw(pw, id);
	cdao.close();
} else if (who.equals("owner")) {
	OwnerDAO odao = new OwnerDAO();
	odao.changePw(pw, id);
	odao.close();
}

response.sendRedirect("login.jsp");
%>