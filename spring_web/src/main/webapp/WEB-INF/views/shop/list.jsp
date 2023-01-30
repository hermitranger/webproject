<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상점-상품목록</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnAdd").click(function() {
			location.href = "/shop/write.do";
		});
		
		sale();
		
		
		
	});

	function list(page) {
		location.href = "/shop/list.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
var totalprice=0;

	
</script>


</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<div class="container_list">

		<div class="main">
			<div class="input-group">
				<%-- 			<span class="fa fa-search form-control-feedback"></span>
			<form name="form1" method="post" action="/shop/list.do">
				<select name="search_option">
					<option value="all"
						<c:out value="${map.search_option == 'all' ? 'selected' : '' }"/>>전체</option>
					<option value="product_name"
						<c:out value="${map.search_option == 'product_name' ? 'selected' : '' }"/>>상품명</option>
					<option value="product_cate"
						<c:out value="${map.search_option == 'product_cate' ? 'selected' : '' }"/>>상품카테고리</option>
					<option value="product_brand"
						<c:out value="${map.search_option == 'product_brand' ? 'selected' : '' }"/>>상품가격</option>
				</select>
					<input type="text" name="keyword" class="form-control"
						value="${map.keyword}"> <input type="submit" value="조회 ">
			</form> --%>
			</div>
		</div>


		<br>
		<section class="home-cards">
			<c:forEach var="row" items="${map.list}">
				<div align="left">
					<img src="https://i.ibb.co/KjGFHVJ/card2.png" alt="" />
					<h4 align="center">
					
						<a href="/shop/detail/${row.product_code}">${row.product_name}</a>
						
					</h4>
					<c:if test="${sessionScope.user_check == '1'}">
						<a href="/shop/edit/${row.product_code}">[편집]</a>
					</c:if>
					<p align="center">
					
					<c:if test="${row.product_price ne row.product_saleprice}">						
						<p style="text-decoration:line-through" align="center">
						정상가<fmt:formatNumber value="${row.product_price}" pattern="#,###원" /></p>
						<p align="center" style="color: red">
						할인가<fmt:formatNumber value="${row.product_saleprice}" pattern="#,###원"/><br>
						sale : <c:set var="sale" value="${((row.product_price-row.product_saleprice)/row.product_price)*100}"/>
						<c:out value="${sale}"/>%
						</p>		
					</c:if>
					
					<c:if test="${row.product_price eq row.product_saleprice}">
						정상가<fmt:formatNumber value="${row.product_price}" pattern="#,###원" />
					</c:if>
					</p>
				</div>
			</c:forEach>
		</section>
		<br>
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
		<br> <br> <br>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/main.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/search.css?ver=2" />
	<link rel="stylesheet" href="${path}/resources/css/main.css?ver=2" />
</body>
</html>