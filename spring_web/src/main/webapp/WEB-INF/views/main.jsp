<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="https://image.ibb.co/fOur3b/favicon.png" />
<meta name="theme-color" content="#1885ed">
<title>중고상점 :: 당신을 위한 중고거래 사이트</title>
<!-- <script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
</head>
<div class="menu-btn">
	<i class="fas fa-bars fa-2x"></i>
</div>

<div class="container">
	<!-- 상단부 메뉴란 -->
	<%@ include file="include/menu.jsp"%>

	<!-- 상단부 광고창 -->
	<header class="showcase">
		<img src="https://i.ibb.co/zVqhWn2/card5.png" alt="" />
		<h2>당신만을 위한 중고거래</h2>
		<p>중고거래를 원한다면 지금 바로 중고장터의 가족이 되어주세요!</p>
		<a href="/controller/join.page" class="btn"> 회원가입 <i
			class="fas fa-chevron-right"></i>
		</a>
	</header>

	<!-- 상단부 카테고리 영역 -->
	<section class="home-cards">
		<div>
			<a href="/shop/list.do"> <img
				src="https://i.ibb.co/KjGFHVJ/card2.png" alt="" />
			</a>
			<h3 align="center">계절가전</h3>
		</div>
		<div>
			<a href="/shop/list.do"> <img
				src="https://i.ibb.co/KjGFHVJ/card2.png" alt="" />
			</a>
			<h3 align="center">음향기기</h3>
		</div>
		<div>
			<a href="/shop/list.do"> <img
				src="https://i.ibb.co/KjGFHVJ/card2.png" alt="" />
			</a>
			<h3 align="center">주방가전</h3>
		</div>
		<div>
			<a href="/shop/list.do"> <img
				src="https://i.ibb.co/KjGFHVJ/card2.png" alt="" />
			</a>
			<h3 align="center">컴퓨터 및 기타</h3>
		</div>
	</section>

	<hr>
	<br> <br>
	<h2>신규 등록</h2>
	<!-- 신규등록 상품 -->
	<section class="home-cards">
		<c:forEach var="row" items="${list}">
			<div>
				<img src="https://i.ibb.co/zVqhWn2/card5.png" alt="" />
				<h3>${row.product_name}</h3>
				<h4>${row.product_cate}</h4>
				<h4>${row.product_price}</h4>
				<a href="/shop/detail/${row.product_code}">더보기<i
					class="fas fa-chevron-right"></i></a>
			</div>

		</c:forEach>
	</section>

	<!-- 광고창 -->
	<section class="carbon dark">
		<div class="content">
			<h2>Commiting To Carbon Negative</h2>
			<p>Microsoft will be carbon negative by 2030 and by 2050 we will
				remove all carbon the company has emitted since it was founded in
				1975</p>
			<a href="#" class="btn"> Learn More <i
				class="fas fa-chevron-right"></i>
			</a>
		</div>
	</section>

</div>
<!-- Links -->
<section class="links">
	<div class="links-inner">
		<ul>
			<li><h3>이용안내</h3></li>
			<li>Account Profile</li>
			<li>Download Center</li>
			<li>Microsoft Store support</li>
			<li>Returns</li>
			<li>Older tracking</li>
		</ul>
		<ul>
			<li><h3>이용안내</h3></li>
			<li>Account Profile</li>
			<li>Download Center</li>
			<li>Microsoft Store support</li>
			<li>Returns</li>
			<li>Older tracking</li>
		</ul>
		<ul></ul>
		<ul></ul>
		<ul></ul>
		<ul>
			<li><h3>이용안내</h3></li>
			<li>Account Profile</li>
			<li>Download Center</li>
			<li>Microsoft Store support</li>
			<li>Returns</li>
			<li>Older tracking</li>
		</ul>
	</div>
</section>

<!-- Footer -->
<footer class="footer">
	<div class="footer-inner">
		<ul>
			<li>사이트 소개</li>
			<li>Download Center</li>
			<li>Microsoft Store support</li>
			<li>Returns</li>
		</ul>
	</div>
</footer>

<c:set var="path" value="${pageContext.request.contextPath}" />
<script src="${path}/resources/js/main.js?ver=2"></script>
<link rel="stylesheet" href="${path}/resources/css/main.css?ver=2" />
</body>
</html>