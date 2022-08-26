<%@page import="vo.AccomodationVO"%>
<%@page import="dao.AccomodationDAO"%>
<%@page import="vo.OwnerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- Bootstrap icon CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>
<style>
.mypage img {
	height: 30px;
	weight: 30px;
}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	window.onload = function() {
		var btn = document.getElementById("btn");
		btn.onclick = openKaKao;

		var btn2 = document.getElementById("btn2");
		btn2.onclick = function() {
			var title = document.getElementById("title").value;
			var detail = $("input:radio[name='detail']").is(':checked');
			var addrs1 = document.getElementById("addrs1").value;
			var addrs2 = document.getElementById("addrs2").value;
			var phone = document.getElementById("phone").value;
			var convenience = $("input:checkbox[name='convenience']").is(
					':checked');

			if (title == "") {
				alert("숙소이름을 입력해주시기 바랍니다");
				return;
			} else if (detail == false) {
				alert("숙소종류를 확인해주시기 바랍니다");
				return;
			} else if (addrs1 == "") {
				alert("주소를 입력해주시기 바랍니다");
				return;
			} else if (addrs2 == "") {
				alert("주소를 입력해주시기 바랍니다");
				return;
			} else if (phone == "") {
				alert("전화번호를 입력해주시기 바랍니다");
				return;
			} else if (convenience == false) {
				alert("편의사항을 확인해주시기 바랍니다");
				return;
			}

			alert("수정이 완료되었습니다");

			var frm = document.frm;
			frm.action = "productManageOk.jsp";
			frm.submit();
		}

	}

	function openKaKao() {
		new daum.Postcode({
			oncomplete : function(data) {
				console.dir(data);
				document.getElementById("addrs1").value = data.roadAddress;
				document.getElementById("addrs2").focus();
			}

		}).open();

	}

	function read(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('preview').src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
		} else {
			document.getElementById('preview').src = "";
		}
	}
</script>
</head>
<body class="productManage mypage">
		<jsp:include page="mypageHeader.jsp" />
	<div class="container-fluid mt-4">
		<div class="row">
			<jsp:include page="mypageSidebarH.jsp" />
			<div class="col-md-9 mb-3">
				<form name="frm" method="post" enctype="multipart/form-data" class="col-12 col-sm-8 col-lg-6 mx-auto">
					<h4 class="mt-2 mb-4 fw-bold text-center">숙소 정보 관리</h4>
					<div class="mb-3 row">
						<label for="title" class="col-form-label col-3">숙소 이름</label>
						<div class="col-9">
							<input type="text" class="form-control" name="title" id="title" />
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-form-label col-3">숙소 종류</label>
						<div class="col-9">
							<div class="d-flex justify-content-evenly">
								<div>
									<input type="radio" name="detail" id="" value="호텔" />
									호텔
								</div>
								<div>
									<input type="radio" name="detail" id="" value="모텔" />
									모텔
								</div>
								<div>
									<input type="radio" name="detail" id="" value="게스트하우스" />
									게스트 하우스
								</div>
								<div>
									<input type="radio" name="detail" id="" value="펜션" />
									펜션
								</div>
							</div>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="addrs1" class="col-form-label col-3">주소</label>
						<div class="col-7">
							<input type="text" class="form-control" name="addrs1" id="addrs1">
						</div>
						<div class="col-2 text-end">
							<button type="button" class="btn btn-outline-primary w-100" id="btn">검색</button>
						</div>
					</div>

					<div class="mb-3 row">
						<label for="addrs2" class="col-form-label col-3">상세 주소</label>
						<div class="col-9">
							<input type="text" class="form-control" name="addrs2" id="addrs2" placeholder="상세주소를 입력하세요">
						</div>
					</div>

					<div class="mb-3 row">
						<label for="phone" class="col-form-label col-3">전화번호</label>
						<div class="col-9">
							<input type="text" class="form-control" name="phone" id="phone">
						</div>
					</div>

					<div class="mb-3 row">
						<label class="col-form-label col-3">편의사항</label>
						<div class="col-9">
							<div class="d-flex justify-content-evenly mb-3">
								<div>
									<input type="checkbox" name="convenience" id="" value="주차가능" />
									주차가능
									<img src="../images/parking.png" alt="parking" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="수영장" />
									수영장
									<img src="../images/swim.png" alt="swim" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="냉장고" />
									냉장고
									<img src="../images/refrigerator.png" alt="refrigerator" />
								</div>
							</div>
							<div class="d-flex justify-content-evenly mb-3">
								<div>
									<input type="checkbox" name="convenience" id="" value="짐보관" />
									짐보관
									<img src="../images/baggage.png" alt="baggage" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="24H" />
									24H
									<img src="../images/24h.png" alt="24h" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="레스토랑" />
									레스토랑
									<img src="../images/restaurant.png" alt="restaurant" />
								</div>
							</div>
							<div class="d-flex justify-content-evenly mb-3">
								<div>
									<input type="checkbox" name="convenience" id="" value="WIFI" />
									WIFI
									<img src="../images/wifi.png" alt="wifi" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="금연객실" />
									금연객실
									<img src="../images/nosmoke.png" alt="nosmoke" />
								</div>
								<div>
									<input type="checkbox" name="convenience" id="" value="흡연구역" />
									흡연구역
									<img src="../images/smokingarea.png" alt="smokingarea" />
								</div>
							</div>
						</div>

						<div class="mb-3 row">
							<label for="filename" class="col-3 col-form-label">대표 사진</label>
							<div class="col-9">
								<input class="form-control mb-3" type="file" id="filename" name="filename" onchange="read(this);" multiple="multiple">
								<img src="" alt="" id="preview" style="width: 50px;" />
							</div>
						</div>

						<div class="mb-3 row">
							<label for="adetail" class="col-form-label col-3">숙소 소개</label>
							<div class="col-9">
								<textarea class="form-control" id="adetail" name="adetail" rows="5"></textarea>
							</div>
						</div>
						<div class="text-center">
							<button type="button" class="btn btn-primary px-3" id="btn2">수정</button>
						</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap Bundle with Popper -->
	<script src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>
</html>