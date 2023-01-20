<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
$(function(){
	$("#btnBuy").click(function(){
	location.href="/admin/admin_deal_buylist.do";
	});
	
	$("#btnSell").click(function(){
		location.href="/admin/admin_deal_selllist.do";
		});
});
</script>
</body>
<%@ include file="../include/menu.jsp"%>
<h4>구매목록</h4>
<button type = "button" id = "btnBuy">더보기</button>
<form name="userForm">
	<table border="1" width="700px">
		<tr>
			<th>상품코드</th>
			<th>유저아이디</th>
			<th>상품명</th>
			<th>상품카테고리</th>
			<th>상품가격</th>
		</tr>
		
		<c:forEach var="row" items="${buylist}">
			<tr>
				<td align="center">${row.b_code}</td>
				<td align="center">${row.buy_id}</td>
				<td align="center"><a href = "/admin/admin_deal_buydetail/${row.b_code}">${row.b_name}</a></td>
				<td align="center">${row.b_cate}</td>
				<td align="center"><fmt:formatNumber pattern="#,###원"
						value="${row.b_price}" /></td>
			</tr>
		</c:forEach>
	</table>
	</form>
	<br>
	<br>
	
<h4>판매목록</h4>
<button type = "button" id = "btnSell">더보기</button>
<form name="userForm1">
	<table border="1" width="700px">
		<tr>
			<th>상품코드</th>
			<th>유저아이디</th>
			<th>상품명</th>
			<th>상품카테고리</th>
			<th>상품가격</th>
		</tr>
		
		<c:forEach var="row" items="${selllist}">
			<tr>
				<td align="center">${row.s_code}</td>
				<td align="center">${row.sell_id}</td>
				<td align="center"><a href = "/admin/admin_deal_selldetail/${row.s_code}">${row.s_name}</a></td>
				<td align="center">${row.s_cate}</td>
				<td align="center"><fmt:formatNumber pattern="#,###원"
						value="${row.s_price}" /></td>
			</tr>
		</c:forEach>
	</table>
</form>
</html>