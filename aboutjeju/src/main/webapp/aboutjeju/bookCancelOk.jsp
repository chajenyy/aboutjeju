<%@page import="vo.OwnerVO"%>
<%@page import="vo.CustomerVO"%>
<%@page import="dao.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

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

String bookno = request.getParameter("bno");
int bno = 0;

if (bookno != null) {
	bno = Integer.parseInt(bookno);
}

BookDAO bdao = new BookDAO();
bdao.bookCancel(bno);
bdao.close();

if (ovo != null) {
	response.sendRedirect("hostBookingCheck.jsp?ono=" + ovo.getOno() + "&cp=1");
} else {
	response.sendRedirect("customerBookingCheck.jsp?cno=" + cvo.getCno() + "&cp=1");
}
%>