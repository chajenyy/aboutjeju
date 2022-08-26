<%@page import="vo.OwnerVO"%>
<%@page import="vo.CustomerVO"%>
<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 
String id = request.getParameter("inputId");
String pw = request.getParameter("inputPw");
// System.out.println("id : " + id);

CustomerDAO cdao = new CustomerDAO();
CustomerVO cvo = cdao.login(id, pw);
// System.out.println("cloginOk : " + cloginOk);

OwnerDAO odao = new OwnerDAO();
OwnerVO ovo = odao.login(id, pw);
// System.out.println("ologinOk : " + ologinOk);

if (cvo != null) {
	session.setAttribute("cvo", cvo);
	response.sendRedirect("main.jsp");
} else if (ovo != null) {
	session.setAttribute("ovo", ovo);
	response.sendRedirect("main.jsp");
} else {

%>

<!-- object obj =session.getAttribute("ovo") 
	OwnerVo ovo = (OwnerVo)obj
-->

<script>
	alert('입력하신 내용과 일치하는 정보가 없습니다.');
	location.href = "login.jsp";
</script>

<%
}

cdao.close();
odao.close();
%>