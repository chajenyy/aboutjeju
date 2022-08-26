<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="vo.RoomdetailVO"%>
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
AccomodationDAO aDao = new AccomodationDAO();
AccomodationVO aVo = aDao.selectOne(ono);

RoomDAO rDao = new RoomDAO();
RoomVO rVo = new RoomVO();

RoomdetailDAO rdDao = new RoomdetailDAO();
RoomdetailVO rdVo = new RoomdetailVO();

String saveDir = request.getRealPath("../upload");

MultipartRequest mr = new MultipartRequest(request, saveDir, 1024 * 1024 * 10, "UTF-8", new DefaultFileRenamePolicy());

String rno2 = mr.getParameter("rno");

if (rno2 != null) {
	int rno = Integer.parseInt(rno2);

	String rtype = mr.getParameter("type");
	String rc = mr.getParameter("count");
	String p = mr.getParameter("price");
	String dis = mr.getParameter("discount");
	String people = mr.getParameter("people");

	int rcount = Integer.parseInt(rc);
	int price = Integer.parseInt(p);
	int discount = Integer.parseInt(dis);
	int rpeople = Integer.parseInt(people);

	rVo.setRtype(rtype);
	rVo.setRcount(rcount);
	rVo.setPrice(price);
	rVo.setDiscount(discount);
	rVo.setRpeople(rpeople);
	rVo.setRno(rno);

	rDao.modifyOne(rVo);

	System.out.println(rno);
	System.out.println(rtype);
	System.out.println(rcount);
	System.out.println(price);
	System.out.println(discount);
	System.out.println(rpeople);

	/* System.out.println(saveDir); 
	
	 File f = mr.getFile("filename");
	f.getAbsolutePath();//파일절대경로 */

	String f = mr.getOriginalFileName("filename");
	String f2 = mr.getOriginalFileName("filename2");
	System.out.println("f : " + f);
	System.out.println("f2 : " + f2);

	rdVo.setRdno(rdVo.getRno());
	rdVo.setRno(rno);
	rdVo.setRimage("../upload/" + f);

	rdDao.modifyImg(rdVo);

	response.sendRedirect("roomManage.jsp");
}
%>