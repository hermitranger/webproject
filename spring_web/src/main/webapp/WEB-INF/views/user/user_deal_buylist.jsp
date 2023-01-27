<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function list(page) {
		location.href = "/user/user_deal_buylist.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<!-- 판매내역 검색창 -->
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
			<h4>구매내역</h4>
			<div align="center">
				<form name="form1" method="post" action="/user/user_deal_buylist.do">
					<select name="search_option">
						<option value="all"
							<c:out value="${buymap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
						<option value="b_code"
							<c:out value="${buymap.search_option == 'b_code' ? 'selected' : '' }"/>>상품코드</option>
						<option value="b_name"
							<c:out value="${buymap.search_option == 'b_name' ? 'selected' : '' }"/>>상품명</option>
						<option value="b_cate"
							<c:out value="${buymap.search_option == 'b_cate' ? 'selected' : '' }"/>>상품카테고리</option>
						<option value="b_check"
							<c:out value="${buymap.search_option == 'b_check' ? 'selected' : '' }"/>>검수등급</option>
						<option value="b_price"
							<c:out value="${buymap.search_option == 'b_price' ? 'selected' : '' }"/>>상품가격</option>
					</select> <input name="keyword" value="${buymap.keyword}"> <input
						type="submit" value="조회 ">
				</form>
			</div>
			<br>

			<!-- 구매내역 나열 -->
			<section class="home-cards">
				<form name="userForm">
					<div id="wrapper">

						<table id="keywords" cellspacing="0" cellpadding="0">
							<thead>
								<tr>
									<th><span>상품코드</span></th>
									<th><span>상품명</span></th>
									<th><span>상품카테고리</span></th>
									<th><span>검수등급</span></th>
									<th><span>상품가격</span></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${buymap.list}">
									<tr>
										<td align="center">${row.b_code}</td>
										<td align="center" class="lalign"><a
											href="/user/user_deal_buydetail/${row.b_code}">${row.b_name}</a></td>
										<td align="center">${row.b_cate}</td>
										<c:if test="${row.b_check eq 2}">
											<td align="center">상</td>
										</c:if>
										<c:if test="${row.b_check eq 1}">
											<td align="center">중</td>
										</c:if>
										<c:if test="${row.b_check eq 0}">
											<td align="center">하</td>
										</c:if>
										<td align="center"><fmt:formatNumber pattern="#,###원"
												value="${row.b_price}" /></td>
									</tr>
								</c:forEach>
							</tbody>

							<!-- 페이지 나눔 -->
							<tr>
								<div align="center">
									<c:if test="${map.page_info.curPage > 1 }">
										<a href="javascript:list('1')" style="color: black;">[처음]</a>
									</c:if>
									<c:if test="${map.page_info.curPage > 1}">
										<a href="javascript:list('${map.page_info.prevPage}')"
											style="color: black;">[이전]</a>
									</c:if>
									<c:forEach var="num" begin="${map.page_info.blockBegin}"
										end="${map.page_info.blockEnd}">
										<c:choose>

											<c:when test="${num == map.page_info.curPage}">
												<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
											</c:when>
											<c:otherwise>
												<a href="javascript:list('${num}')" style="color: black;">${num}</a>&nbsp;
						</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${map.page_info.curPage < map.page_info.totPage}">
										<a href="javascript:list('${map.page_info.nextPage}')"
											style="color: black;">[다음]</a>
									</c:if>
									<c:if test="${map.page_info.curPage < map.page_info.totPage}">
										<a href="javascript:list('${map.page_info.totPage}')"
											style="color: black;">[끝]</a>
									</c:if>
								</div>
							</tr>
							</tbody>
						</table>
					</div>
				</form>
			</section>
		</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>