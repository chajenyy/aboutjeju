<%@page import="vo.OwnerVO"%>
<%@page import="dao.OwnerDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="vo.CustomerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

/* 1.customerModify.jsp or hostModify.jsp - drop.jsp에서 
	 넘겨 받은 정보와 일치하는 정보
   2.db 손님 / 호스트 테이블에서 삭제 후 
   3.session 종료 & 
   4.main.jsp 로 redirect */
   
Object obj = session.getAttribute("ovo");
OwnerVO ovo = (OwnerVO) obj;


String id = ovo.getOid();
String pw = ovo.getOpw();

OwnerDAO dao = new OwnerDAO();

// 체크해제 실행
dao.deleteCheckCancel();
// 회원 테이블 로우 삭제
dao.deleteOne(id);
// 다시 체크설정
dao.deleteReCheck();

dao.close(); 

// 세션 종료(로그아웃)
session.invalidate();
%>
 
<script>
alert('회원탈퇴가 완료되었습니다.');
document.location.href="main.jsp";
</script>
