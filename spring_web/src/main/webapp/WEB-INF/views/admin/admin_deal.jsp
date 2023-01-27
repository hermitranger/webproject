<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 전용 :: 거래내역</title>
</head>
<body>
	<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
	<script>
		$(function() {
			$("#btnBuy").click(function() {
				location.href = "/admin/admin_deal_buylist.do";
			});

			$("#btnSell").click(function() {
				location.href = "/admin/admin_deal_selllist.do";
			});
		});
	</script>
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper">
			<h4>구매목록</h4>
			<input type="button" id="btnBuy" value="더보기">
			<form name="userForm">
				<table id="keywords" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th><span>상품코드</span></th>
							<th><span>유저아이디</span></th>
							<th><span>상품명</span></th>
							<th><span>상품카테고리</span></th>
							<th><span>상품가격</span></th>
						</tr>
					</thead>
					<c:forEach var="row" items="${buylist}">
						<tr>
							<td align="center">${row.b_code}</td>
							<td align="center">${row.buy_id}</td>
							<td align="center"><a
								href="/admin/admin_deal_buydetail/${row.b_code}"
								style="color: black;">${row.b_name}</a></td>
							<td align="center">${row.b_cate}</td>
							<td align="center"><fmt:formatNumber pattern="#,###원"
									value="${row.b_price}" /></td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<br> <br>

			<h4>판매목록</h4>
			<input type="button" id="btnSell" value="더보기">
			<form name="userForm1">
				<table id="keywords" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th><span>상품코드</span></th>
							<th><span>유저아이디</span></th>
							<th><span>상품명</span></th>
							<th><span>상품카테고리</span></th>
							<th><span>상품가격</span></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${selllist}">
							<tr>
								<td align="center">${row.s_code}</td>
								<td align="center">${row.sell_id}</td>
								<td align="center"><a
									href="/admin/admin_deal_selldetail/${row.s_code}"
									style="color: black;">${row.s_name}</a></td>
								<td align="center">${row.s_cate}</td>
								<td align="center"><fmt:formatNumber pattern="#,###원"
										value="${row.s_price}" /></td>
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