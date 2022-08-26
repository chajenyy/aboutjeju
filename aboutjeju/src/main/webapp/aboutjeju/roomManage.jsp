<%@page import="vo.RoomdetailVO"%>
<%@page import="dao.RoomdetailDAO"%>
<%@page import="vo.RoomVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.RoomDAO"%>
<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>roomManage</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>
<body class="mypage">
	<jsp:include page="mypageHeader.jsp" />
	<div class="container-fluid mt-2">
		<div class="row">
			<jsp:include page="mypageSidebarH.jsp" />

			<div class="col-md-9">

				<%
				// 세션으로 vo 가져오기
				Object obj = session.getAttribute("ovo");
				OwnerVO ovo = (OwnerVO) obj;
				// vo로 ono 가져오기
				String ono = ovo.getOno();

				// aDao 객체 생성
				AccomodationDAO aDao = new AccomodationDAO();
				AccomodationVO aVo = aDao.selectOne(ono);

				int ano = aVo.getAno();
				session.setAttribute("ano", ano);
				
				// rDao 객체 생성
				RoomDAO rDao = new RoomDAO();
				ArrayList<RoomVO> rList = rDao.selectAllRoom(ano);

				RoomdetailDAO rdDao = new RoomdetailDAO();
				
				%>
				
				<div class="mx-auto text-end py-2 pb-4" style="max-width: 650px;">
					<!-- <button type="submit" class="btn btn-outline-primary px-4 shadow-sm" id="add">+ 추가하기</button> -->
					<form name="frm2" enctype="multipart/form-data">
					<!-- <a type="button" class="btn btn-outline-primary px-4 shadow-sm" id="add" onclick="addRoom(this)">+ 추가하기</a> -->
					<input type="button" value="+추가하기"  class="btn btn-outline-primary px-4 shadow-sm" onclick="addRoom(this)"/>
					</form>
				</div>
				
				<%
				for (int i = 0; i < rList.size(); i++) {
				 %>	
				<form name="frm" enctype="multipart/form-data">
				 
				 <%
					int rno = rList.get(i).getRno();
					 //session.setAttribute("rno",rno);
					ArrayList<RoomdetailVO> rdList = rdDao.select(rno);
				%>
				
					<div class="card pt-4 pb-3 px-4 mb-3 mx-auto" style="max-width: 650px;">
						<div class="row g-0">
							<div class="col-md-4 pe-3">
							
								<%
								for (RoomdetailVO rdVo : rdList) {
								%>

								<img src="<%=rdVo.getRimage()%>" class="img-fluid rounded-start" alt="..." id="rimage">

								<%
								}
								
								
								%>

							</div>
							<div class="col-md-8">
								<div class="mb-3 row">
									 	<input type="hidden" name="rno" value="<%=rno %>" /> 
									<label for="type" class="col-3 col-form-label">방 종류</label>
									<div class="col-9">
										<input type="text" class="form-control" id="type" name="type" value="<%=rList.get(i).getRtype()%>">
									</div>
								</div>

								<div class="mb-3 row">
									<label for="count" class="col-3 col-form-label">방 갯수</label>
									<div class="col-9">
										<input type="text" class="form-control" id="count" name="count" value="<%=rList.get(i).getRcount()%>">
									</div>
								</div>

								<div class="mb-3 row">
									<label for="price" class="col-3 col-form-label">방 가격</label>
									<div class="col-4">
										<input type="text" class="form-control" id="price" name="price" value="<%=rList.get(i).getPrice()%>">
									</div>
									<label for="discount" class="col-2 col-form-label ps-3">할인율</label>
									<div class="col-3">
										<input type="text" class="form-control" id="discount" name="discount" value="<%=rList.get(i).getDiscount()%>">
									</div>
								</div>

								<div class="mb-3 row">
									<label for="people" class="col-3 col-form-label">최대 인원</label>
									<div class="col-9">
										<input type="text" class="form-control" id="people" name="people" value="<%=rList.get(i).getRpeople()%>">
									</div>
								</div>

								<div class="mb-3 row">
									<label for="filename" class="col-3 col-form-label">방 사진</label>
									<div class="col-9">
										<input class="form-control" type="file" id="filename" name="filename" onchange="read<%=rno %>(this)">
										<span><img src="" alt="" id="preview<%=rno %>" style="width: 40px; height: 30px;" class="mt-3" /></span>
									</div>
								</div>								
							</div>

						</div>
						<div class="d-flex justify-content-end">					
							<button type="button" class="btn btn-primary m-2" onclick="modifyRoom(this);" role="button">수정</button>
							<a href="roomDelete.jsp?rno=<%=rno %>" class="btn btn-secondary m-2" role="button">삭제</a>
						</div>
					</div>
				</form>

				<script>
			/* 	window.onload=function(){
					var btn = document.getElementById("add");
					btn.onclick = addRoom;
				}  */
				
			function addRoom(x){
			var frm2 = x.form;
			frm2.action="addRoom.jsp?loc=rmanage"; 
			frm2.method="post";
			frm2.submit();
		}
	
		
		function modifyRoom(x){
			<%-- var frm = document.frm;
			frm.action="roomModify.jsp?rno=<%=rno%>";
			frm.method="post";
			frm.submit(); --%>
			var frm = x.form;
				frm.action="roomModify.jsp"; 
				frm.method="post";
				frm.submit();
			console.dir(f);
			
		}
		
		function read<%=rno%>(input){
			if(input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview<%=rno%>').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			}else{
				/* document.getElementById('preview').src=""; */
			}
		}
		function read2<%=rno%>(input){
			if(input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e) {
					document.getElementById('preview2<%=rno%>').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			}else{
				/* document.getElementById('preview2').src=""; */
			}
		}
		</script>


				<%
				}
				%>



			</div>

		</div>
	</div>
	<!-- Bootstrap Bundle with Popper -->
	<script src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>
</html>