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
		
		//checkSale();
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
	
/* 	function checkSale(){
		
		let price = ${dto.product_price};
		let saleprice = ${dto.product_saleprice};
		if(price != saleprice){
			//$('#salePrice').show();
			$('div[name="salePrice"]').show();
		}
		else{
			//$('#price').show();
			$('div[name="price"]').show();
		}
		
		
	} */
</script>
<style>
.container {
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
	gap: 10px;
}

.box {
	border: 3px solid #666;
	background-color: #ddd;
	width: 40%;
	height: 20%;
	padding: 10px;
}
</style>
</head>
<body>
	<c:if test="${sessionScope.user_check == null}">
		<%@ include file="../include/menu.jsp"%>
	</c:if>
	<c:if test="${sessionScope.user_check >= 0}">
		<%@ include file="../include/menu.jsp"%>
	</c:if>

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
					<br> <br> <input type="button" id="btnBuy" value="구매하기"
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
		<div class="card">
			<div class="center">
				<div class="container">
					<c:if test="${empty list}"><h5>추천상품이 없습니다</h5></c:if>
					<c:forEach var="row" items="${list }">
						<span> <a href="/shop/detail/${row.product_code}"> <img
								src="/resources/images/${row.filename}" width="50px"
								height="50px"></a><br> 등록일자<fmt:formatDate
								pattern="yyyy년 MM월 dd일" value="${row.product_date}" /><br>
							상품명:${row.product_name}<br> 상품종류:${row.product_cate}<br>
							상품브랜드:${row.product_brand}<br> 상품가격:<fmt:formatNumber
								value="${row.product_price}" pattern="#,###원" /><br> 상품검수:
								<c:if test="${row.product_check eq 2}">상	</c:if> 
								<c:if test="${row.product_check eq 1}">중</c:if> 
								<c:if test="${row.product_check eq 0}">하</c:if>
						</span>
					</c:forEach>
				</div>
			</div>
		</div>
		<input type="hidden" name="product_code" value="${dto.product_code}">
	</form>


<div class="box">
<div class="container">
<c:if test="${empty list}">추천상품이 없습니다</c:if>		
		<c:forEach var="row" items="${list }">
		<span>		
		<a href="/shop/detail/${row.product_code}">
		<img src="/resources/images/${row.filename}" width="50px" height="50px"></a><br>
		등록일자<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${row.product_date}" /><br>
		상품명:${row.product_name}<br>
		상품종류:${row.product_cate}<br>
		상품브랜드:${row.product_brand}<br>
		상품가격:<fmt:formatNumber value="${row.product_price}" pattern="#,###원" /><br>
		상품검수:<c:if test="${row.product_check eq 2}">상	</c:if>
		<c:if test="${row.product_check eq 1}">중</c:if>
		<c:if test="${row.product_check eq 0}">하</c:if>
		</span>
		</c:forEach>
</div></div>
	<%-- 	
	<script src="${path}/resources/js/detail.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" /> --%>


	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" />

</body>
</html>