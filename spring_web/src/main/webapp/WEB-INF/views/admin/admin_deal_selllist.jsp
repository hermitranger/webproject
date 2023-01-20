<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	function list(page) {
		location.href = "/admin/admin_deal_selllist.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<!-- 판매내역 검색창 -->
<%@ include file="../include/menu.jsp"%>
	<h4>판매목록</h4>
	<form name="form1" method="post" action="/admin/admin_deal_selllist.do">
		<select name="search_option">
			<option value="all"
				<c:out value="${sellmap.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
			<option value="s_code"
				<c:out value="${sellmap.search_option == 's_code' ? 'selected' : '' }"/>>상품코드</option>
			<option value="sell_id"
				<c:out value="${sellmap.search_option == 'sell_id' ? 'selected' : '' }"/>>유저아이디</option>
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

	<!-- 판매내역 나열 -->
	<form name="userForm">
		<table border="1" width="700px">
			<tr>
				<th>상품코드</th>
				<th>유저아이디</th>
				<th>상품명</th>
				<th>상품카테고리</th>
				<th>검수등급</th>
				<th>상품가격</th>
			</tr>

			<c:forEach var="row" items="${sellmap.list}">
				<tr>
					<td align="center">${row.s_code}</td>
					<td align="center">${row.sell_id}</td>
					<td align="center"><a
						href="/admin/admin_deal_selldetail/${row.s_code}">${row.s_name}</a></td>
					<td align="center">${row.s_cate}</td>
					<c:if test="${row.s_check eq 2}">
						<td align="center">상</td>
					</c:if>
					<c:if test="${row.s_check eq 1}">
						<td align="center">중</td>
					</c:if>
					<c:if test="${row.s_check eq 0}">
						<td align="center">하</td>
					</c:if>
					<td align="center"><fmt:formatNumber pattern="#,###원"
							value="${row.s_price}" /></td>
				</tr>
			</c:forEach>
			<!-- 페이지 나눔 -->
			<tr>
				<td colspan="8" align="center"><c:if
						test="${sellmap.page_info_s.curPage > 1 }">
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
					</c:forEach> <c:if
						test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
						<a href="javascript:list('${sellmap.page_info_s.nextPage}')">[다음]</a>
					</c:if> <c:if
						test="${sellmap.page_info_s.curPage < sellmap.page_info_s.totPage}">
						<a href="javascript:list('${sellmap.page_info_s.totPage}')">[끝]</a>
					</c:if></td>
			</tr>
		</table>
</body>
</html>