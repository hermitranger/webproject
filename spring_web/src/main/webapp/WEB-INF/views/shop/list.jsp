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
	});

	function list(page) {
		location.href = "/shop/list.do?curPage=" + page
				+ "&search_option=${map.search_option}&keyword=${map.keyword}";
	}
</script>
</head>
<body>
	<div class="container">
		<%@ include file="../include/menu.jsp"%>

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
					<c:if test="${sessionScope.user_id == 'admin'}">
						<a href="/shop/edit/${row.product_code}">[편집]</a>
					</c:if>
					<p align="center">
						<fmt:formatNumber value="${row.product_price}" pattern="#,###원" />
					</p>
				</div>
			</c:forEach>
		</section>
		<br>
		<section class="home-cards">
			<div align="center">
				<c:if test="${map.page_info.curPage > 1 }">
					<a href="javascript:list('1')">[처음]</a>
				</c:if>
				<c:if test="${map.page_info.curPage > 1}">
					<a href="javascript:list('${map.page_info.prevPage}')">[이전]</a>
				</c:if>
				<c:forEach var="num" begin="${map.page_info.blockBegin}"
					end="${map.page_info.blockEnd}">
					<c:choose>

						<c:when test="${num == map.page_info.curPage}">
							<span style="color: red">${num}</span>&nbsp; <!--현재 페이지 빨간색으로  -->
						</c:when>
						<c:otherwise>
							<a href="javascript:list('${num}')">${num}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${map.page_info.curPage < map.page_info.totPage}">
					<a href="javascript:list('${map.page_info.nextPage}')">[다음]</a>
				</c:if>
				<c:if test="${map.page_info.curPage < map.page_info.totPage}">
					<a href="javascript:list('${map.page_info.totPage}')">[끝]</a>
				</c:if>
			</div>
		</section>
		<!-- Links -->
		<section class="links">
			<div class="links-inner">
				<ul>
					<li><h3>What's New</h3></li>
					<li><a href="#">Surface Pro X</a></li>
					<li><a href="#">Surface Laptop 3</a></li>
					<li><a href="#">Surface Pro 7</a></li>
					<li><a href="#">Windows 10 apps</a></li>
					<li><a href="#">Office apps</a></li>
				</ul>
				<ul>
					<li><h3>Microsoft Store</h3></li>
					<li><a href="#">Account Profile</a></li>
					<li><a href="#">Download Center</a></li>
					<li><a href="#">Microsoft Store support</a></li>
					<li><a href="#">Returns</a></li>
					<li><a href="#">Older tracking</a></li>
				</ul>
				<ul>
					<li><h3>Education</h3></li>
					<li><a href="#">Microsfot in education</a></li>
					<li><a href="#">Office for students</a></li>
					<li><a href="#">Office 365 for schools</a></li>
					<li><a href="#">Deals for studentss</a></li>
					<li><a href="#">Microsfot Azure</a></li>
				</ul>
				<ul>
					<li><h3>Enterprise</h3></li>
					<li><a href="#">Azure</a></li>
					<li><a href="#">AppSource</a></li>
					<li><a href="#">Automotive</a></li>
					<li><a href="#">Government</a></li>
					<li><a href="#">Healthcare</a></li>
				</ul>
				<ul>
					<li><h3>Developer</h3></li>
					<li><a href="#">Visual Studio</a></li>
					<li><a href="#">Windowszs Dev Center</a></li>
					<li><a href="#">Developer Network</a></li>
					<li><a href="#">TechNet</a></li>
					<li><a href="#">Microsoft Developer</a></li>
				</ul>
				<ul>
					<li><h3>Company</h3></li>
					<li><a href="#">Careers</a></li>
					<li><a href="#">About Microsoft</a></li>
					<li><a href="#">Company news</a></li>
					<li><a href="#">Privacy at Microsoft</a></li>
					<li><a href="#">Inverstors</a></li>
				</ul>
			</div>
		</section>

		<!-- Footer -->
		<footer class="footer">
			<div class="footer-inner">
				<div>
					<i class="fas fa-globe fa-2x"></i> English (United States)
				</div>
				<ul>
					<li><a href="#">Sitemap</a></li>
					<li><a href="#">Contact Microsoft</a></li>
					<li><a href="#">Privacy & cookies</a></li>
					<li><a href="#">Terms of use</a></li>
					<li><a href="#">Trademarks</a></li>
					<li><a href="#">Safety & eco</a></li>
					<li><a href="#">About our ads</a></li>
					<li><a href="#">&copy; Microsoft 2020</a></li>
				</ul>
			</div>
		</footer>
		<c:set var="path" value="${pageContext.request.contextPath}" />
		<script src="${path}/resources/js/main.js?ver=2"></script>
		<link rel="stylesheet" href="${path}/resources/css/search.css?ver=2" />
		<link rel="stylesheet" href="${path}/resources/css/main.css?ver=2" />
</body>
</html>