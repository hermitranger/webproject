<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고상점-상품정보</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function() {
		$("#btnRecommend").click(function() {
			if (confirm("해당 글을 추천하시겠습니까?")) {
				document.form1.action = "/shop/rcheck.do";
				document.form1.submit();
			}
		});
	});

	$(function() {
		$("#btnBuy").click(function() {
			if (confirm("해당 제품을 구매하시겠습니까??")) {
				document.form1.action = "/OrderSell.do";
				document.form1.submit();
			}
		});
	});

	$(function() {
		$("#btnSell").click(function() {
			if (confirm("해당 제품을 판매하시겠습니까??")) {
				document.form1.action = "/OrderBuy.do";
				document.form1.submit();
			}
		});
	});
</script>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>


	<form name="form1" method="post">
		<div class="card">
			<div class="left">
				<img src="/resources/images/${dto.filename}" width="300px"
					height="300px" alt="shoe"> <i class="fa fa-long-arrow-left"></i>
				<i class="fa fa-long-arrow-right"></i>
			</div>
			<div class="right">
				<div class="product-info">
					<div class="product-name">
						<h1>${dto.product_cate}</h1>
						<i class="fa fa-search"></i> <i class="fa fa-user"></i> <i
							class="fa fa-shopping-cart"></i>
					</div>
					<div class="details">
						<h3>
							<fmt:formatNumber value="${dto.product_price}" pattern="#,###원" />
						</h3>
						<h2>${dto.product_name}</h2>
						<h4>
							<span class="fa fa-dollar"></span>${dto.product_brand}
						</h4>
					</div>
					<ul>
						<li><fmt:formatDate pattern="yyyy년 MM월 dd일"
								value="${dto.product_date}" /> 등록</li>
					</ul>
					<ul>
						<li>검수등급</li>
						<c:if test="${dto.product_check eq 2}">
							<li>상</li>
						</c:if>
						<c:if test="${dto.product_check eq 1}">
							<li>중</li>
						</c:if>
						<c:if test="${dto.product_check eq 0}">
							<li>하</li>
						</c:if>
					</ul>
					<br>
					<br> <input type="button" id="btnBuy" value="구매하기"
						style="color: black;"> <input type="button" id="btnSell"
						value="판매하기" style="color: black;">
					<c:if test="${sessionScope.user_check == '1'}">
						<input type="button"
							onclick="location.href='/shop/edit/${dto.product_code}'"
							value="상품수정" style="color: black;">
					</c:if>
				</div>
			</div>
		</div>
	</form>

	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" />
</body>
</html>