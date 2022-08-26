<%@page import="dao.RoomdetailDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.RoomDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Object obj = session.getAttribute("ovo");
OwnerVO ovo = (OwnerVO) obj;
// vo로 ono 가져오기
String ono = ovo.getOno();

// aDao 객체 생성
RoomDAO rDao = new RoomDAO();
RoomdetailDAO rdDao = new RoomdetailDAO();

int rno = Integer.parseInt(request.getParameter("rno"));
System.out.println("rno : " + rno);

rdDao.deleteImg(rno);
rDao.deleteOne(rno);

response.sendRedirect("roomManage.jsp?loc=rmanage");
%>