<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원페이지 :: 거래내역</title>
</head>
<body>
	<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script>
		$(function() {
			$("#btnBuy").click(function() {
				location.href = "/user/user_deal_selllist.do";
			});

			$("#btnSell").click(function() {
				location.href = "/user/user_deal_buylist.do";
			});
		});
	</script>

	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
		<h4>구매목록</h4>
		<input type="button" id="btnBuy" value = "더보기">
		<form name="userForm">
			<table id="keywords" cellspacing="0" cellpadding="0">
				<thead>
					<tr>
						<th><span>상품코드</span></th>
						<th><span>상품명</span></th>
						<th><span>상품카테고리</span></th>
						<th><span>상품가격</span></th>
						<th><span>진행내역</span></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="row" items="${selllist}">
						<tr>
							<td align="center">${row.s_code}</td>
							<td align="center"><a
								href="/user/user_deal_selldetail/${row.s_code}" style="color:black;">${row.s_name}</a></td>
							<td align="center">${row.s_cate}</td>
							<td align="center"><fmt:formatNumber pattern="#,###원"
									value="${row.s_price}" /></td>
							<td align="center"><c:set var="row.s_progress" value="" />
								<c:choose>
									<c:when test="${row.s_progress eq  0}">입금확인</c:when>
									<c:when test="${row.s_progress eq  1}">배송중</c:when>
									<c:when test="${row.s_progress eq  2}">완료</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		<br>
		<h4>판매목록</h4>
		<input type="button" id="btnSell" value = "더보기">
			<table id="keywords" cellspacing="0" cellpadding="0">
				<thead>
					<tr>
						<th><span>상품코드</span></th>
						<th><span>상품명</span></th>
						<th><span>상품카테고리</span></th>
						<th><span>상품가격</span></th>
						<th><span>진행내역</span></th>
					</tr>
				</thead>
				<c:forEach var="row" items="${buylist}">
					<tr>
						<td align="center">${row.b_code}</td>
						<td align="center"><a
							href="/user/user_deal_buydetail/${row.b_code}" style="color:black;">${row.b_name}</a></td>
						<td align="center">${row.b_cate}</td>
						<td align="center"><fmt:formatNumber pattern="#,###원"
								value="${row.b_price}" /></td>
						<td align="center"><c:set var="row.b_progress" value="" />
								<c:choose>
									<c:when test="${row.b_progress eq  0}">미배송</c:when>
									<c:when test="${row.b_progress eq  1}">배송중</c:when>
									<c:when test="${row.b_progress eq  2}">검수중</c:when>
									<c:when test="${row.b_progress eq  3}">검수완</c:when>
									<c:when test="${row.b_progress eq  4}">완료</c:when>
								</c:choose>
						</td>
					</tr>			
				</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>