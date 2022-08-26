$(function() {
	$("#checkin").datepicker({ minDate: 0, dateFormat: "yy-mm-dd" });
	$("#checkout").datepicker({ minDate: 0, dateFormat: "yy-mm-dd" });
	$("#checkin").on("change", onCheckin);
	
	$("#headerfrm>.submit, .login .submit").on("click", onSubmit);

	$(".mypage .header #menu-btn").on("click", showOffCanvasMenu);
	$(".mypage .sidebar .btn-close").on("click", closeOffCanvasMenu)
	$(".mypage .sidebar a").on("click", selected);

	$("#idFindSubmit").on("click", function() {
		if ($("#inputName").val() == "") {
			alert("이름을 입력해주세요");
			$("#inputName").focus();
			return;
		} else if ($("#inputPhone").val() == "") {
			alert("전화번호를 입력해주세요");
			$("#inputPhone").focus();
			return;
		}
		$("#idfrm").submit();
	});

	$("#pwFindSubmit").on("click", function() {
		if ($("#inputId").val() == "") {
			alert("아이디를 입력해주세요");
			$("#inputId").focus();
			return;
		} else if ($("#inputAnswer").val() == "") {
			alert("비밀번호 찾기 답을 입력해주세요");
			$("#inputAnswer").focus();
			return;
		}
		$("#pwfrm").submit();
	});

	$("#inputRePw, #inputPw").on("keyup", checkPw);
	$(".changePw .submit").on("click", changePw);

	$(".contract #agreeAll").on("click", checkAll);
	$(".contract .submit").on("click", essentialCheck);

	$(".signUp #inputId").on("keyup", checkId);
	$(".signUp #inputOno").on("keyup", checkOno);
	$(".customerSignUp .submit").on("click", customerSignUp);
	$(".hostSignUp .submit").on("click", hostSignUp);

	fillZero();
	$(".write .submit").on("click", writeReview);

	$(".bookCancel .submit").on("click", checkCheckBox);

	$(".hostBookingCheck #hostBookCancel .submit").on("click", bookCancel);

});

function onCheckin() {
	if ($("#checkin").val() !== "") {
		var dateMin = $("#checkin").datepicker("getDate");
		var rMin = new Date(
			dateMin.getFullYear(),
			dateMin.getMonth(),
			dateMin.getDate() + 1
		);
		$("#checkout").datepicker("option", "minDate", new Date(rMin));
	}
}

function onSubmit() {
	$("form").submit();
}

function showOffCanvasMenu() {
	$(".mypage .sidebar, .mypage .sidebar .btn-close").removeClass("d-none").addClass("position-absolute");
	$(".mypage").addClass("fixedscreen");
}

function closeOffCanvasMenu() {
	$(".mypage .sidebar, .mypage .sidebar>.btn-close").addClass("d-none").removeClass("position-absolute");
	$(".mypage").removeClass("fixedscreen");
}

function selected() {
	$(".mypage .sidebar a").removeClass("selected");
	$(this).addClass("selected");
}

function checkAll() {
	if ($("#agreeAll").prop("checked")) {
		$(".contract .checkSub").prop("checked", true);
	} else {
		$(".contract .checkSub").prop("checked", false);
	}
}

function essentialCheck() {
	if ($("#contract1").is(":checked") == false) {
		alert("이용약관은 필수 동의 항목입니다.");
		$("#contract1").focus();
		return;
	} else if ($("#contract2").is(":checked") == false) {
		alert("개인정보 수집 및 이용약관은 필수 동의 항목입니다.");
		$("#contract2").focus();
		return;
	}

	var who = $("input[type='hidden']").val();

	if (who == "host") {
		location.href = "hostSignUp.jsp";
	}
	else {
		location.href = "customerSignUp.jsp";
	}
}

var msg = $(".checkPwMsg");
var pw = $("#inputPw");
var repw = $("#inputRePw");

function checkPw() {
	if (pw.val() != repw.val()) {
		msg.html("동일한 암호를 입력하세요.").css("color", "red");
	} else {
		msg.html("암호가 확인되었습니다.").css("color", "green");
	}
}

function changePw() {
	if (pw.val().length < 8 || pw.val().length > 20) {
		alert("비밀번호의 길이는 8~20자 이어야 합니다.");
		pw.focus();
		return;
	} else if (pw.val() != repw.val()) {
		alert("동일한 암호를 입력하세요.");
		repw.focus();
		return;
	}

	$(".changePw #changePwfrm").submit();
}

function checkId() {
	var id = $(".signUp #inputId").val().trim();
	var params = "id=" + id;

	sendRequest("idCheck.jsp", params, callback, "GET");
}

function checkOno() {
	var ono = $(".signUp #inputOno").val();
	var params = "ono=" + ono;

	sendRequest("onoCheck.jsp", params, callback, "GET");
}

function callback() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var msg = xhr.responseText.trim();

		if (msg == "이미 존재하는 아이디입니다.") {
			$(".checkIdMsg").html(msg).css("color", "red");
		} else if (msg == "사용 가능한 아이디입니다.") {
			$(".checkIdMsg").html(msg).css("color", "green");
		} else if (msg == "이미 가입된 사업자번호입니다.") {
			$(".checkOnoMsg").html(msg).css("color", "red");
		} else if (msg == "사용 가능한 사업자번호입니다.") {
			$(".checkOnoMsg").html(msg).css("color", "green");
		}
	}
}

var id = $("#inputId");
var ono = $("#inputOno");
var pw = $("#inputPw");
var repw = $("#inputRePw");
var pwa = $("#inputAnswer");
var inputname = $("#inputName");
var phone = $("#inputPhone");

function customerSignUp() {
	if (id.val() == "" || id.val().length < 5 || id.val().length > 20) {
		alert("아이디를 형식에 맞게 입력해주세요.");
		id.focus();
		return;
	} else if (pw.val() == "" || pw.val().length < 8 || pw.val().length > 20) {
		alert("비밀번호를 형식에 맞게 입력해주세요.");
		pw.focus();
		return;
	} else if (repw.val() == "" || repw.val() != pw.val()) {
		alert("비밀번호가 일치하지 않습니다.");
		repw.focus();
		return;
	} else if (pwa.val() == "") {
		alert("비밀번호 찾기 답을 입력해주세요");
		pwa.focus();
		return;
	} else if (inputname.val() == "") {
		alert("이름을 입력해주세요.");
		inputname.focus();
		return;
	} else if (phone.val() == "" || phone.val().length < 9 || phone.val().length > 11) {
		alert("전화번호를 입력해주세요.");
		phone.focus();
		return;
	}

	$("#signUpfrm").submit();
}

function hostSignUp() {
	if (id.val() == "" || id.val().length < 5 || id.val().length > 20) {
		alert("아이디를 형식에 맞게 입력해주세요.");
		id.focus();
		return;
	} else if (ono.val() == "" || ono.val().length != 10) {
		alert("사업자번호를 형식에 맞게 입력해주세요.");
		ono.focus();
		return;
	} else if (pw.val() == "" || pw.val().length < 8 || pw.val().length > 20) {
		alert("비밀번호를 형식에 맞게 입력해주세요.");
		pw.focus();
		return;
	} else if (repw.val() == "" || repw.val() != pw.val()) {
		alert("비밀번호가 일치하지 않습니다.");
		repw.focus();
		return;
	} else if (pwa.val() == "") {
		alert("비밀번호 찾기 답을 입력해주세요");
		pwa.focus();
		return;
	} else if (inputname.val() == "") {
		alert("이름을 입력해주세요.");
		inputname.focus();
		return;
	} else if (phone.val() == "" || phone.val().length < 9 || phone.val().length > 11) {
		alert("전화번호를 입력해주세요.");
		phone.focus();
		return;
	}

	$("#signUpfrm").submit();
}

function fillZero() {
	var bno = $(".write .bno").text();
	var zero = "";

	for (var i = 1; i <= 9 - bno.length; i++) {
		zero += 0;
	}

	$(".write .bno").text(zero + bno);
}

function writeReview() {
	if ($("#inputTitle").val().length < 5) {
		alert("제목은 5자 이상 입력하여야 합니다");
		$("#inputTitle").focus();
		return;
	} else if ($("#inputContents").val().length < 20) {
		alert("내용은 20자 이상 입력하여야 합니다");
		$("#inputContents").focus();
		return;
	}

	$("#writefrm").submit();
}

function checkCheckBox() {
	var bno = $(".bookCancel #getBno").val();
	console.log(bno);
	if ($("#cancelContract").is(":checked") == false) {
		alert("취소, 환불 및 보상 약관은 필수 동의 항목입니다.");
		$("#cancelContract").focus();
		return;
	}

	location.href = "bookCancelOk.jsp?who=host&bno=" + bno;
}

function bookCancel() {
	var bno = $("input[type='radio']:checked").attr("id");
	location.href = "bookCancelOk.jsp?who=host&bno=" + bno;
}