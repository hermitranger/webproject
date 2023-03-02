<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user_deal_selllist</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	function list(page) {
		location.href = "/user/user_deal_selllist.do?curPage=" + page
				+ "&search_option=${sellmap.search_option}&keyword=${sellmap.keyword}";
	}
</script>
</head>
<body>
	<!-- 구매내역 검색창 -->
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
			<h4>구매목록</h4>
			<form name="form1" method="post" action="/user/user_deal_selllist.do">
				<select name="search_option">
					<option value="all"
						<c:out value="${sellmap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
					<option value="s_code"
						<c:out value="${sellmap.search_option == 's_code' ? 'selected' : '' }"/>>상품코드</option>
					<option value="s_name"
						<c:out value="${sellmap.search_option == 's_name' ? 'selected' : '' }"/>>상품명</option>
					<option value="s_cate"
						<c:out value="${sellmap.search_option == 's_cate' ? 'selected' : '' }"/>>상품카테고리</option>
					<option value="s_check"
						<c:out value="${sellmap.search_option == 's_check' ? 'selected' : '' }"/>>검수등급</option>
					<option value="s_price"
						<c:out value="${sellmap.search_option == 's_price' ? 'selected' : '' }"/>>상품가격</option>
				</select> <input name="keyword" value="${sellmap.keyword}"> <input
					type="submit" value="조회 ">
			</form>
			<br>
			<!-- 판매내역 나열 -->
			<section class="home-cards">
				<form name="userForm">
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
						<c:forEach var="row" items="${sellmap.list}">
							<tr>
								<td align="center">${row.s_code}</td>
								<td align="center"><a
									href="/user/user_deal_selldetail/${row.s_code}">${row.s_name}</a></td>
								<td align="center">${row.s_cate}</td>
								<c:if test="${row.s_check eq 3}">
									<td align="center">상</td>
								</c:if>
								<c:if test="${row.s_check eq 2}">
									<td align="center">중</td>
								</c:if>
								<c:if test="${row.s_check eq 1}">
									<td align="center">하</td>
								</c:if>
								<c:if test="${row.s_check eq 0}">
									<td align="center">미검수</td>
								</c:if>
								<td align="center"><fmt:formatNumber pattern="#,###원"
										value="${row.s_price}" /></td>
							</tr>
						</c:forEach>
					</tbody>
					<!-- 페이지 나눔 -->
					<tr>
						<td colspan="6" align="center">
							<div align="center">
							<c:if test="${sellmap.page_info_s.curPage > 1 }">
								<a href="javascript:list('1')">[처음]</a>
							</c:if> <c:if test="${sellmap.page_info_s.curPage > 1}">
								<a href="javascript:list('${sellmap.page_info_s.prevPage}')">[이전]</a>
							</c:if> <c:forEach var="num" begin="${sellmap.page_info_s.blockBegin}"
								end="${sellmap.page_info_s.blockEnd}">
								<c:choose>

									<c:when test="${num == sellmap.page_info_s.curPage}">
										<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
									</c:when>
									<c:otherwise>
										<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
								</c:choose>
							</c:forEach> 
							<c:if test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
								<a href="javascript:list('${sellmap.page_info_s.nextPage}')">[다음]</a>
							</c:if> 
							<c:if test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
									<a href="javascript:list('${sellmap.page_info_s.totPage}')">[끝]</a>
							</c:if>
							</div>
						</tr>
						</tbody>
					</table>
				</form>
			</section>
		</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>