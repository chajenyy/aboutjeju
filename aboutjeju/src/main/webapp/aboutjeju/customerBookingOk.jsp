<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="vo.CustomerVO"%>
<%@page import="vo.BookVO"%>
<%@page import="dao.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

Object obj = session.getAttribute("cvo");
CustomerVO cvo = (CustomerVO) obj;

AccomodationDAO adao = new AccomodationDAO();
BookDAO bdao = new BookDAO();
RoomDAO rdao = new RoomDAO();

AccomodationVO avo = adao.selectOne(Integer.parseInt(request.getParameter("ano")));

String ono = avo.getOno();
int rno = Integer.parseInt(request.getParameter("rno"));
int cno = cvo.getCno();
String pay = request.getParameter("payment");

RoomVO rvo = rdao.select(rno);

// 날짜
String bsdate = request.getParameter("checkin");
String bedate = request.getParameter("checkout");

String price = request.getParameter("price");
int bprice = Integer.parseInt(price);
String bname = request.getParameter("bname");
String bphone = request.getParameter("bphone");
String way = request.getParameter("way");
int bookok = 1;

out.println(bprice);
out.println(bname);
out.println(bphone);
out.println(pay);
out.println(way);

BookVO bvo = new BookVO(0, ono, rno, cno, bsdate, bedate, pay, bprice, bname, bphone, way, bookok);
bdao.insertOne(bvo);

adao.close();
rdao.close();
bdao.close();

response.sendRedirect("customerBookingCheck.jsp");
%>

