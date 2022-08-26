<%@page import="vo.ReviewVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productReview.jsp</title>

</head>
<body>
	<%!// nextPage method에서 endPage가 totalPage를 넘지 않기 위한 변수
	int checkEndPage = 0;

	public int beforePage(int startPage) {
		if (startPage == 1) {
			return 1;
		}
		return startPage - 1;
	}

	public int nextPage(int endPage) {
		if (endPage == checkEndPage) {
			return checkEndPage;
		}
		return endPage + 1;
	}%>
	<%
	Object oobj = session.getAttribute("ovo");
	Object cobj = session.getAttribute("cvo");

	String str = request.getParameter("ano");
	//System.out.println("str : "+str);
	int ano = Integer.parseInt(str);

	// review다오 객체 생성
	ReviewDAO rDao = new ReviewDAO();

	// 현재 페이지 번호
	String cp = request.getParameter("cp");

	int currentPage = 1;
	if (cp != null) {
		currentPage = Integer.parseInt(cp);
	}

	// 한페이지당 게시물 건수
	int recordPerPage = 7;

	// 페이지당 게시물 시작번호
	// mysql limit 이용
	// 페이지가 1이면 0 , 2 이면 7, 3이면 14
	int startNo = (currentPage - 1) * recordPerPage;

	// 총 게시물 수 
	int totalCount = rDao.getCountOne(ano);
	System.out.println(totalCount);

	// 총 페이지 수
	int totalPage = (totalCount % recordPerPage == 0) ? totalCount / recordPerPage : totalCount / recordPerPage + 1;

	checkEndPage = totalPage;

	// 시작페이지 번호
	int startPage = 1;
	// 끝페이지 번호
	int endPage = 4;

	// 페이지 미세조정
	for (int i = 0; i <= endPage; i++) {
		if (currentPage >= 1 + (i * 4)) {
			startPage = 1 + (i * 4);
			endPage = startPage + 3;
			if (endPage >= totalPage) {
		endPage = totalPage;
			}
		}
	}

	// totalpage가 4보다 작을경우
	if (totalPage < 4) {
		endPage = totalPage;
		if (totalPage == 0) {
			endPage = 1;
		}
	}
	%>

	<h4 class="border-bottom border-3 m-3 pb-3 ps-3 fw-bold">후기</h4>
	<ul class="list-group list-group-flush m-3" id="reviewindex">

		<%
		if (totalCount == 0) {
		%>

		<li class="reviewwrap">
			<h5 class="text-center">후기가 없습니다.</h5>
		</li>

		<%
		} else {
		ArrayList<ReviewVO> list = rDao.selectPaging(ano, startNo);
		for (int i = 0; i < list.size(); i++) {
		%>

		<li class="list-group-item">
			<h6 class="fw-bold"><%=list.get(i).getTitle()%></h6>
			<div>
				<%
				for (int j = 0; j < list.get(i).getStar(); j++) {
				%>

				<i class="bi bi-star-fill text-warning"></i>

				<%
				}
				%>

				<%=list.get(i).getStar()%>

			</div>
			<p class="review"><%=list.get(i).getContents()%></p>
		</li>

		<%
		}
		}
		%>
	</ul>
	
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center mt-5">
			<li class="page-item">
				<a class="page-link" href="productDetail.jsp?ano=<%=ano%>&cp=<%=beforePage(startPage)%>#reviewindex" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
			</li>

			<%
			for (int i = startPage; i <= endPage; i++) {
			%>

			<li class="page-item">
				<a class="page-link" href="productDetail.jsp?ano=<%=ano%>&cp=<%=i%>#reviewindex"><%=i%></a>
			</li>

			<%
			}
			%>

			<li class="page-item">
				<a class="page-link" href="productDetail.jsp?ano=<%=ano%>&cp=<%=nextPage(endPage)%>#reviewindex" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</ul>
	</nav>


</body>
</html>