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
			
			$("#btnBUdate").click(function() {
				BUdate();
			});
					
			
		});
			
		
	</script>
	<%@ include file="../include/menu.jsp"%>
	<div id="table_">
		<div id="wrapper2">
			<h4>구매목록</h4>
			<input type="button" id="btnBuy" value="더보기 및 편집">
			<form name="userForm">
				<table id="keywords2" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th><span>주문코드</span></th>
							<th><span>상품코드</span></th>
							<th><span>유저아이디</span></th>
							<th><span>상품명</span></th>
							<th><span>상품카테고리</span></th>
							<th><span>상품가격</span></th>
							<th><span>진행내역</span></th>
						
						</tr>
					</thead>
					<c:forEach var="row" items="${buylist}">
						<tr>
							<td align="center">${row.bill_order}</td>
							<td align="center">${row.b_code}</td>
							<td align="center">${row.buy_id}</td>
							<td align="center">${row.b_name}</td>
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
							<%-- <td align="center"><a
								href="/admin/admin_deal_buydetail/${row.b_code}" style="color: blue;">[편집]</a></td> --%>
								
						</tr>
					</c:forEach>
				</table>
			</form>
			<br> <br>

			<h4>판매목록</h4>
			<input type="button" id="btnSell" value="더보기 및 편집">
			<form name="userForm1">
				<table id="keywords2" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th><span>주문코드</span></th>
							<th><span>상품코드</span></th>
							<th><span>유저아이디</span></th>
							<th><span>상품명</span></th>
							<th><span>상품카테고리</span></th>
							<th><span>상품가격</span></th>
							<th><span>배송</span></th>
					
						</tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${selllist}">
							<tr>
								<td align="center">${row.bill_order}</td>
								<td align="center">${row.s_code}</td>
								<td align="center">${row.sell_id}</td>
								<td align="center">${row.s_name}</td>
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
			</form>
		</div>
	</div>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<script src="${path}/resources/js/table.js?ver=2"></script>
	<link rel="stylesheet" href="${path}/resources/css/table.css?ver=2" />
</body>
</html>