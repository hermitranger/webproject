<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function list(page) {
		location.href = "/admin/admin_deal_buylist.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<!-- 구매내역 검색창 -->
<%@ include file="../include/menu.jsp"%>
	<h4>구매목록</h4>
	<form name="form1" method="post" action="/admin/admin_deal_buylist.do">
		<select name="search_option">
			<option value="all"
				<c:out value="${buymap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
			<option value="b_code"
				<c:out value="${buymap.search_option == 'b_code' ? 'selected' : '' }"/>>상품코드</option>
			<option value="buy_id"
				<c:out value="${buymap.search_option == 'buy_id' ? 'selected' : '' }"/>>유저아이디</option>
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

	<!-- 구매내역 나열 -->
	<form name="userForm">
		<table border="1" width="700px">
			<tr>
				<th>상품코드</th>
				<th>유저아이디</th>
				<th>상품명</th>
				<th>상품카테고리</th>
				<th>검수등급</th>
				<th>상품가격</th>
				<th>판매여부</th>
			</tr>

			<c:forEach var="row" items="${buymap.list}">
				<tr>
					<td align="center">${row.b_code}</td>
					<td align="center">${row.buy_id}</td>
					<td align="center"><a
						href="/admin/admin_deal_buydetail/${row.b_code}">${row.b_name}</a></td>
					<td align="center">${row.b_cate}</td>
					<c:if test="${row.b_check eq 4}">
						<td align="center">미검수</td>
					</c:if>
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
					<td align="center"><a href="/shop/write/${row.b_code}">[편집]</a></td>

				</tr>
			</c:forEach>

			<!-- 페이지 나눔 -->
			<tr>
				<td colspan="7" align="center">
				<c:if test="${buymap.page_info_b.curPage > 1 }">
						<a href="javascript:list('1')">[처음]</a>
					</c:if> 
					<c:if test="${buymap.page_info_b.curPage > 1}">
						<a href="javascript:list('${buymap.page_info_b.prevPage}')">[이전]</a>
					</c:if> 
					<c:forEach var="num" begin="${buymap.page_info_b.blockBegin}" end="${buymap.page_info_b.blockEnd}">
						<c:choose>

							<c:when test="${num == buymap.page_info_b.curPage}">
								<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
						</c:choose>
					</c:forEach> <c:if
						test="${buymap.page_info_b.curPage < buymap.page_info_b.totPage}">
						<a href="javascript:list('${buymap.page_info_b.nextPage}')">[다음]</a>
					</c:if> <c:if
						test="${buymap.page_info_b.curPage < buymap.page_info_b.totPage}">
						<a href="javascript:list('${buymap.page_info_b.totPage}')">[끝]</a>
					</c:if></td>
			</tr>
		</table>
	</form>
</body>
</html>