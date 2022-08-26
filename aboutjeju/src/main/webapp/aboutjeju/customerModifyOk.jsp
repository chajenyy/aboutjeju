<%@page import="dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = request.getParameter("inputId");
String pw = request.getParameter("inputPw");
String repw = request.getParameter("inputRePw");
String pwq = request.getParameter("inputQuestion");
String pwqa = request.getParameter("inputAnswer");
String name = request.getParameter("inputName");
String phone = request.getParameter("inputPhone");
System.out.println("id:" + id);
System.out.println("pw:" + pw);
System.out.println("pwq:" + pwq);
System.out.println("pwqa:" + pwqa);
System.out.println("name:" + name);
System.out.println("phone:" + phone);

CustomerDAO dao = new CustomerDAO();
dao.updateOne(pw, pwq, pwqa, name, phone, id);
dao.close();

response.sendRedirect("customerModify.jsp");
%>