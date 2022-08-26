<%@page import="vo.CustomerVO"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

Object obj = session.getAttribute("cvo");
CustomerVO cvo = (CustomerVO) obj;

String bookNo = request.getParameter("inputBno");
String accomoNo = request.getParameter("inputAno");
String title = request.getParameter("inputTitle");
String contents = request.getParameter("inputContents");
String rate = request.getParameter("inputRate");

int bno = 0;
int ano = 0;
int star = 0;

if (bookNo != null) {
	bno = Integer.parseInt(bookNo);
}
if (accomoNo != null) {
	ano = Integer.parseInt(accomoNo);
}
if (rate != null) {
	star = Integer.parseInt(rate);
}

ReviewDAO rdao = new ReviewDAO();
rdao.insertOne(bno, ano, title, contents, star);
rdao.close();

response.sendRedirect("customerBookingCheck.jsp?cno=" + cvo.getCno() + "&cp=1");
%>