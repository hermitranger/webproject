<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매진상품관리</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	function list(page) {
		location.href = "/soldout.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</script>
</head>
<%@ include file="../include/menu.jsp"%>
<h2>매진 상품</h2>
<form name="product_soldout" method="post" enctype="multipart/form-data">
	<table border="1" width="500px">
		<tr>
			<th>등록일자</th>
			<th>상품코드</th>
			<th>&nbsp;</th>
			<th>상품명</th>
			<th>상품가격</th>
			<th>&nbsp;</th>
		</tr>
		<c:forEach var="row" items="${map.list}">
			<tr>
				<td><fmt:formatDate pattern="yyyy년 MM월 dd일"
						value="${row.product_date}" /></td>
				<td>${row.product_code}</td>
				<td align="center"><img src="/resources/images/${row.filename}"
					width="100px" height="100px"></td>
				<td>${row.product_name}</td>
				<td><fmt:formatNumber value="${row.product_price}"
						pattern="#,###원" /></td>
				<td>
				<a href="/shop/edit/${row.product_code}">[수량편집]</a>
				</td>

			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" align="center"><c:if
					test="${map.page_info.curPage > 1 }">
					<a href="javascript:list('1')">[처음]</a>
				</c:if> <c:if test="${map.page_info.curPage > 1}">
					<a href="javascript:list('${map.page_info.prevPage}')">[이전]</a>
				</c:if> <c:forEach var="num" begin="${map.page_info.blockBegin}"
					end="${map.page_info.blockEnd}">
					<c:choose>

						<c:when test="${num == map.page_info.curPage}">
							<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
				</c:otherwise>
					</c:choose>
				</c:forEach> <c:if test="${map.page_info.curPage < map.page_info.totPage}">
					<a href="javascript:list('${map.page_info.nextPage}')">[다음]</a>
				</c:if> <c:if test="${map.page_info.curPage < map.page_info.totPage}">
					<a href="javascript:list('${map.page_info.totPage}')">[끝]</a>
				</c:if></td>
		</tr>
	</table>
</form>
</body>
</html>