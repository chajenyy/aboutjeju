<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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

<script>
/* 	window.onload = function() {
		/* 	var cancle = document.getElementById("cancle");
		 cancle.onclick =function(){
		
			var frm = document.frm;
			frm.action="roomManage.jsp";
			frm.submit();
		}
	 */
 	
	/* var cancle1 = document.getElementById("cancle");
	cancle1.onclick=cancleRoom;
		
	
	}  */ 
	
	function addRoom(x){
		
		var frm2 = x.form;
		frm2.action="addRoomOk.jsp";
		frm2.method="post";
		frm2.submit();  
	}

	function cancleRoom() {
		console.log("te");
		var frm = document.frm;
		frm.action="roomManage.jsp?loc=rmanage";
		frm.method="post";
		frm.submit();
	}

	function read(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			/* document.getElementById('preview').src=""; */
		}
	}
	function read2(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview2').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			/* document.getElementById('preview2').src=""; */
		}
	}
</script>
</head>
<body class="mypage">
	<jsp:include page="mypageHeader.jsp" />
	<div class="container-fluid mt-4">
		<div class="row">
			<jsp:include page="mypageSidebarH.jsp" />
		
			<div class="col-md-9">
				<form name="frm" class="col-12 col-sm-8 col-lg-6 mx-auto" method="post" enctype="multipart/form-data">
					<h4 class="mt-2 mb-4 fw-bold text-center">방 추가</h4>
					<div class="mb-3 row">
						<label for="type" class="col-3 col-form-label">방 종류</label>
						<div class="col-9">
							<input type="text" class="form-control" id="type" name="type" value="">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="count" class="col-3 col-form-label">방 갯수</label>
						<div class="col-9">
							<input type="text" class="form-control" id="count" name="count" value="">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="price" class="col-3 col-form-label">방 가격</label>
						<div class="col-4">
							<input type="text" class="form-control" id="price" name="price" value="">
						</div>
						<label for="discount" class="col-2 col-form-label ps-3">할인율</label>
						<div class="col-3">
							<input type="text" class="form-control" id="discount" name="discount" value="">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="people" class="col-3 col-form-label">최대 인원</label>
						<div class="col-9">
							<input type="text" class="form-control" id="people" name="people" value="">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="filename" class="col-3 col-form-label">방 사진</label>
						<div class="col-9">
							<input class="form-control" type="file" id="filename" name="filename" onchange="read(this)">
							<span><img src="" alt="" id="preview" style="width: 40px; height: 30px;" class="my-3" /></span>
						</div>
					</div>
					<div class="d-flex justify-content-center">
						<button type="button" id="cancel" class="btn btn-primary m-2 px-4" role="button" onclick="cancleRoom();" >취소</button>
						<button type="button" id="add" class="btn btn-secondary m-2 px-4" role="button" onclick="addRoom(this);">추가</button>
					</div>
				</form>
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