<%@page import="java.io.File"%>
<%@page import="vo.OwnerVO"%>
<%@page import="vo.ConvenienceVO"%>
<%@page import="dao.ConvenienceDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
String saveDir = request.getRealPath("/upload");
//System.out.println(saveDir);
int maxFileSize = 1024 * 1024 * 10;

File isDir = new File(saveDir);
if (!isDir.isDirectory()) {
	System.out.println("디렉토리가 없습니다. 디렉토리를 새로 생성합니다.");
	isDir.mkdir();
}

MultipartRequest mr = new MultipartRequest(request, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

String aname = mr.getParameter("title");
String addrs1 = mr.getParameter("addrs1");
String addrs2 = mr.getParameter("addrs2");

String aaddress = addrs1 + " " + addrs2;

String aimage = mr.getOriginalFileName("filename");
String atype = mr.getParameter("detail");
String adetail = mr.getParameter("adetail");
String aphone = mr.getParameter("phone");

String convenience[] = mr.getParameterValues("convenience");

AccomodationDAO aDao = new AccomodationDAO();
AccomodationVO aVo = new AccomodationVO();

ConvenienceDAO cDao = new ConvenienceDAO();
ConvenienceVO cVo = new ConvenienceVO();

/* AccomodationVO aVo = new AccomodationVO( 0, ono, aname, aaddrs, aimage, atype, adetail, phone  ); */

Object obj = session.getAttribute("ovo");
OwnerVO oVo = (OwnerVO) obj;
String ono = oVo.getOno();

aVo.setOno(ono);
aVo.setAname(aname);
aVo.setAaddress(aaddress);
aVo.setAimage(aimage);
aVo.setAtype(atype);
aVo.setAdetail(adetail);
aVo.setAphone(aphone);

System.out.println("image : " + aVo.getAimage());

AccomodationVO avo2 = aDao.selectOne(ono); // 사업자번호로 숙소가 이미 등록되어있는지 아닌지 확인

if (avo2 != null) { // 숙소가 이미 등록되어있다면 기존 데이터 수정
	aDao.updateOne(aVo); // 숙소테이블 데이터 수정
	cDao.delete(avo2.getAno()); // 편의사항 새로 등록하기 위해 기존 데이터 삭제
} else { // 숙소가 등록되어있지 않다면 새로 등록
	aDao.addOne(aVo);
}

aVo = aDao.selectOne(ono);

cVo.setAno(aVo.getAno());

for (int i = 0; i < convenience.length; i++) {
	cVo.setCoption(convenience[i]);

	cDao.addImage(cVo);

}
aDao.close();
cDao.close();

response.sendRedirect("productManage.jsp");
%>

