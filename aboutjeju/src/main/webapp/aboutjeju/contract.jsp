<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- Bootstrap icon CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.2/font/bootstrap-icons.css" />

<!-- My CSS -->
<link rel="stylesheet" href="../css/style.css">
<title>ABOUT JEJU</title>

<!-- JQUERY -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
</head>

<body class="contract">
	<jsp:include page="loginHeader.jsp" />

	<%
	request.setCharacterEncoding("UTF-8");

	String who = request.getParameter("who");
	%>

	<div class="container-fluid mt-5">
		<div class="row">
			<div class="col-sm-1 col-md-2 col-lg-3"></div>
			<div class="col-sm-10 col-md-8 col-lg-6">
				<div class="mb-2 mx-auto">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="agreeAll"> <label
							class="form-check-label fs-5 fw-bold" for="agreeAll">이용약관,
							개인정보 수집 및 이용, <br />위치정보 이용약관(선택)에 모두 동의합니다.
						</label>
					</div>
				</div>
				<div class="mb-4 mx-auto">
					<div class="form-check py-3">
						<input type="hidden" value="<%=who%>"> <input
							class="form-check-input checkSub" type="checkbox" value=""
							id="contract1"> <label class="form-check-label"
							for="contract1">어바웃제주 이용약관 동의(필수)</label>
					</div>
					<textarea class="form-control noresize" rows="6" disabled>
여러분을 환영합니다.
ABOUT JEJU 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 ABOUT JEJU 서비스의 이용과 관련하여 ABOUT JEJU 서비스를 제공하는 ABOUT JEJU 주식회사(이하 ‘ABOUT JEJU’)와 이를 이용하는 ABOUT JEJU 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 ABOUT JEJU 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.

ABOUT JEJU 서비스를 이용하시거나 ABOUT JEJU 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.

다양한 ABOUT JEJU 서비스를 즐겨보세요.
ABOUT JEJU는 www.naver.com을 비롯한 ABOUT JEJU 도메인의 웹사이트 및 응용프로그램(어플리케이션, 앱)을 통해 정보 검색, 다른 이용자와의 커뮤니케이션, 콘텐츠 제공, 상품 쇼핑 등 여러분의 생활에 편리함을 더할 수 있는 다양한 서비스를 제공하고 있습니다.
여러분은 PC, 휴대폰 등 인터넷 이용이 가능한 각종 단말기를 통해 각양각색의 ABOUT JEJU 서비스를 자유롭게 이용하실 수 있으며, 개별 서비스들의 구체적인 내용은 각 서비스 상의 안내, 공지사항, ABOUT JEJU 웹고객센터(이하 ‘고객센터’) 도움말 등에서 쉽게 확인하실 수 있습니다.

ABOUT JEJU는 기본적으로 여러분 모두에게 동일한 내용의 서비스를 제공합니다. 다만, '청소년보호법' 등 관련 법령이나 기타 개별 서비스 제공에서의 특별한 필요에 의해서 연령 또는 일정한 등급을 기준으로 이용자를 구분하여 제공하는 서비스의 내용, 이용 시간, 이용 횟수 등을 다르게 하는 등 일부 이용을 제한하는 경우가 있습니다. 자세한 내용은 역시 각 서비스 상의 안내, 공지사항, 고객센터 도움말 등에서 확인하실 수 있습니다.

ABOUT JEJU 서비스에는 기본적으로 본 약관이 적용됩니다만 ABOUT JEJU가 다양한 서비스를 제공하는 과정에서 부득이 본 약관 외 별도의 약관, 운영정책 등을 적용하는 경우(예, ABOUT JEJU페이, V LIVE 등)가 있습니다. 그리고 ABOUT JEJU 계열사가 제공하는 특정 서비스의 경우에도(예, LINE, SNOW등) 해당 운영 회사가 정한 고유의 약관, 운영정책 등이 적용될 수 있습니다. 이러한 내용은 각각의 해당 서비스 초기 화면에서 확인해 주시기 바랍니다.

회원으로 가입하시면 ABOUT JEJU 서비스를 보다 편리하게 이용할 수 있습니다.
여러분은 본 약관을 읽고 동의하신 후 회원 가입을 신청하실 수 있으며, ABOUT JEJU는 이에 대한 승낙을 통해 회원 가입 절차를 완료하고 여러분께 ABOUT JEJU 서비스 이용 계정(이하 ‘계정’)을 부여합니다. 계정이란 회원이 ABOUT JEJU 서비스에 로그인한 이후 이용하는 각종 서비스 이용 이력을 회원 별로 관리하기 위해 설정한 회원 식별 단위를 말합니다. 회원은 자신의 계정을 통해 좀더 다양한 ABOUT JEJU 서비스를 보다 편리하게 이용할 수 있습니다. 이와 관련한 상세한 내용은 계정 운영정책 및 고객센터 내 ABOUT JEJU 회원가입 방법 등에서 확인해 주세요.

ABOUT JEJU는 단체에 속한 여러 구성원들이 공동의 계정으로 ABOUT JEJU 서비스를 함께 이용할 수 있도록 단체회원 계정도 부여하고 있습니다. 단체회원 구성원들은 하나의 계정 및 아이디(ID)를 공유하되 각자 개별적으로 설정한 비밀번호를 입력하여 계정에 로그인하고 각종 서비스를 이용하게 됩니다. 단체회원은 관리자와 멤버로 구성되며, 관리자는 구성원 전부로부터 권한을 위임 받아 단체회원을 대표하고 단체회원 계정을 운용합니다.
			</textarea>
				</div>
				<div class="mb-4 mx-auto">
					<div class="form-check py-3">
						<input class="form-check-input checkSub" type="checkbox" value=""
							id="contract2"> <label class="form-check-label"
							for="contract2">개인정보 수집 및 이용 동의(필수)</label>
					</div>
					<textarea class="form-control noresize" rows="6" disabled>
개인정보보호법에 따라 ABOUT JEJU에 회원가입 신청하시는 분께 수집하는 개인정보의 항목, 개인정보의 수집 및 이용목적, 개인정보의 보유 및 이용기간, 동의 거부권 및 동의 거부 시 불이익에 관한 사항을 안내 드리오니 자세히 읽은 후 동의하여 주시기 바랍니다.

1. 수집하는 개인정보
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 ABOUT JEJU 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, ABOUT JEJU는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 ABOUT JEJU가 이용자로부터 수집하는 개인정보는 아래와 같습니다.
- 회원 가입 시에 ‘아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호’를 필수항목으로 수집합니다. 만약 이용자가 입력하는 생년월일이 만14세 미만 아동일 경우에는 법정대리인 정보(법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다. 그리고 선택항목으로 이메일 주소를 수집합니다.
- 단체아이디로 회원가입 시 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를 필수항목으로 수집합니다. 그리고 단체 대표자명을 선택항목으로 수집합니다.
			</textarea>
				</div>
				<div class="mb-4 mx-auto">
					<div class="form-check py-3">
						<input class="form-check-input checkSub" type="checkbox" value=""
							id="contract3"> <label class="form-check-label"
							for="contract3">위치기반서비스 이용약관 동의(선택)</label>
					</div>
					<textarea class="form-control noresize" rows="6" disabled>
위치기반서비스 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 ABOUT JEJU 위치기반 서비스를 이용할 수 있습니다.

제 1 조 (목적)
이 약관은 ABOUT JEJU 주식회사 (이하 “회사”)가 제공하는 위치기반서비스와 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

제 2 조 (약관 외 준칙)
이 약관에 명시되지 않은 사항은 위치정보의 보호 및 이용 등에 관한 법률, 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법 등 관계법령과 회사의 이용약관 및 개인정보처리방침, 회사가 별도로 정한 지침 등에 의합니다.

제 3 조 (서비스 내용 및 요금)
① 회사는 위치정보사업자로부터 위치정보를 전달받아 아래와 같은 위치기반서비스를 제공합니다.

1. GeoTagging 서비스: 게시물 또는 이용자가 저장하는 콘텐츠에 포함된 개인위치정보주체 또는 이동성 있는 기기의 위치정보가 게시물과 함께 저장됩니다. 저장된 위치정보는 별도의 활용없이 보관되거나, 또는 장소를 기반으로 콘텐츠를 분류하거나 검색할 수 있는 기능이 제공될 수도 있습니다.
2. 위치정보를 활용한 검색결과 및 콘텐츠 제공 : 정보 검색을 요청하거나 개인위치정보주체 또는 이동성 있는 기기의 위치정보를 제공 시 본 위치정보를 이용한 검색결과, 주변결과(맛집, 주변업체, 교통수단 등), 번역결과를 제시합니다.
3. 이용자 위치를 활용한 광고정보 제공: 검색결과 또는 기타 서비스 이용 과정에서 개인위치정보주체 또는 이동성 있는 기기의 위치를 이용하여 광고소재를 제시합니다.
			</textarea>
				</div>
				<div class="mb-5 mx-auto text-center">
					<a href="login.jsp" type="button"
						class="btn btn-secondary btn-lg px-5 mx-4 my-2">취소</a> <a
						type="button" class="btn btn-primary btn-lg px-5 mx-4 my-2 submit">확인</a>
				</div>
			</div>
			<div class="col-sm-1 col-md-2 col-lg-3"></div>
		</div>
	</div>
	<!-- Bootstrap Bundle with Popper -->
	<script
		src=" https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
		
	</script>

	<!-- My JS -->
	<script src="../js/script.js"></script>
</body>

</html>