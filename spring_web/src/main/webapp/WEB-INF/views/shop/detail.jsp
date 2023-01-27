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
</head>
<body>
	<c:if test="${sessionScope.user_check == null}">
		<%@ include file="../include/menu.jsp"%>
	</c:if>
	<c:if test="${sessionScope.user_check >= 0}">
		<%@ include file="../include/menu.jsp"%>
	</c:if>

	<!-- <div class="columns">

		<div class="column">
			<div class="thumbnail-container">
				<img class="drift-demo-trigger"
					data-zoom="https://awik.io/demo/webshop-zoom/shoe-large.jpg"
					src="https://awik.io/demo/webshop-zoom/shoe-small.jpg">
			</div>
		</div>

		<div class="column">
			<div class="details">
				<h1>Air Jordan 1 Retro</h1>
				<p class="price">$95.99</p>
				<p class="description">A remarkable shoe that's naturally soft,
					cozy all over, and fits your every move.</p>



				<div class="columns">

					<div class="column" id="wishlist-container">

						<button class="button">
							<span class="icon is-small"> <i class="fas fa-heart"></i>
							</span> <span>ADD TO WISHLIST</span>
						</button>

					</div>

					<div class="column" id="buy-container">

						<button class="button buy-button">
							<span class="icon is-small"> <i
								class="fas fa-shopping-bag"></i>
							</span> <span>ADD TO BAG</span>
						</button>

					</div>

				</div>

				<p class="small-text">
					<span>Standard delivery</span> 2-5 working days
				</p>
				<p class="small-text">
					<span>Next day delivery</span> order before 2pm ($5.79)
				</p>

			</div>
		</div>

	</div>

	<p class="small-text"
		style="text-align: center; padding-top: 30px; padding-bottom: 15px;">
		Zoom plugin: <a href="" target="_blank">Drift</a>
	</p> -->
	<form name="form1" method="post">
		<table>
			<tr>
				<td><img src="/resources/images/${dto.filename}" width="300px"
					height="300px"></td>
				<td align="center">
					<table>
						<tr>
							<td>등록일자</td>
							<td><fmt:formatDate pattern="yyyy년 MM월 dd일"
									value="${dto.product_date}" /></td>
						</tr>
						<tr>
							<td>상품명</td>
							<td>${dto.product_name}</td>
						</tr>
						<tr>
							<td>상품종류</td>
							<td>${dto.product_cate}</td>
						</tr>
						<tr>
							<td>상품브랜드</td>
							<td>${dto.product_brand}</td>
						</tr>
						
						<tr>
							<c:if test="${dto.product_price eq dto.product_saleprice}">	
								<td>가격</td>
								<td><fmt:formatNumber value="${dto.product_price}"
										pattern="#,###원" />	</td>
							</c:if>
							<c:if test="${dto.product_price ne dto.product_saleprice}">	
								<td>가격</td>
								<td><fmt:formatNumber value="${dto.product_saleprice}"
										pattern="#,###원" />
									<p align="center" style="color: red; display:inline;">
									(SALE: <c:set var="sale" value="${((dto.product_price-dto.product_saleprice)/dto.product_price)*100}"/>
									<c:out value="${sale}"/>%</p>
									,정상가 <p style="text-decoration:line-through; display:inline;" align="center">
									<fmt:formatNumber value="${dto.product_price}"
										pattern="#,###원" /></p>)
									
							</c:if>				
						</tr>
					

						<tr>
							<td>상세설명</td>
							<td>${dto.product_detail}</td>
						</tr>
						<td>상품검수</td>
						<c:if test="${dto.product_check eq 2}">
							<td>상</td>
						</c:if>
						<c:if test="${dto.product_check eq 1}">
							<td>중</td>
						</c:if>
						<c:if test="${dto.product_check eq 0}">
							<td>하</td>

						</c:if>
						<tr>
							<td>위시</td>
							<td><button type="button" id="btnRecommend">추천하기</button></td>
						</tr>
						<tr>
							<td><button type="button" id="btnBuy">구매하기</button></td>
							<td><button type="button" id="btnSell">판매하기</button></td>
						</tr>
						<tr>
							<td colspan="4"><input type="hidden" name="product_code"
								value="${dto.product_code}"> <a href="/shop/list.do">상품목록</a>
								<c:if test="${sessionScope.user_check == '1'}">
									<a href="/shop/edit/${dto.product_code}">상품수정</a>
								</c:if></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
	<%-- 	
	<script src="${path}/resources/js/detail.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/detail.css?ver=2" /> --%>
</body>
</html>