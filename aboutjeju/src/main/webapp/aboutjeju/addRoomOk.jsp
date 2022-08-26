<%@page import="vo.RoomdetailVO"%>
<%@page import="dao.RoomdetailDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.RoomVO"%>
<%@page import="dao.RoomDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

Object obj = session.getAttribute("ovo");
OwnerVO ovo = (OwnerVO) obj;

AccomodationDAO aDao = new AccomodationDAO();
AccomodationVO aVo = aDao.selectOne(ovo.getOno());

RoomDAO rDao = new RoomDAO();
RoomVO rVo = new RoomVO();

RoomdetailDAO rdDao = new RoomdetailDAO();
RoomdetailVO rdVo = new RoomdetailVO();

String saveDir = request.getRealPath("/upload");
MultipartRequest mr = new MultipartRequest(request, saveDir, 1024 * 1024 * 10, "UTF-8", new DefaultFileRenamePolicy());

//int rno = rdVo.getRno();

/* 	String ano = mr.getParameter("ano");
	System.out.println(ano);
	if(ano !=null){
		int rno = Integer.parseInt(ano);
	
	
	/* 	if(rno2!=null){
	int rno = Integer.parseInt(rno2);
		 */

System.out.println("ano : " + aVo.getAno());

String rtype = mr.getParameter("type");
int rcount = Integer.parseInt(mr.getParameter("count"));
int price = Integer.parseInt(mr.getParameter("price"));
int discount = Integer.parseInt(mr.getParameter("discount"));
int rpeople = Integer.parseInt(mr.getParameter("people"));

String f = mr.getOriginalFileName("filename");
System.out.println(f);

rVo.setAno(aVo.getAno());
rVo.setRtype(rtype);
rVo.setRcount(rcount);
rVo.setPrice(price);
rVo.setDiscount(discount);
rVo.setRpeople(rpeople);

rDao.insertRoom(rVo);

int rno = rDao.getRno(aVo.getAno());

rdVo.setRno(rno);
System.out.println("rno : " + rno);
rdVo.setRimage("../upload/" + f);

rdDao.insertImage(rdVo);

response.sendRedirect("roomManage.jsp?loc=rmanage");  

//}
%>