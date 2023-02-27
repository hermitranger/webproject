<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 전용 :: 거래 상세내역</title>
</head>
<body>
	<%@ include file="../include/menu.jsp"%>
	<h3>구매정보</h3>
	<form name="form1" method="post">
		<table border="1" width="700px">
			<tr>
				<td>주문번호</td>
				<td>${dto.bill_order}</td>
			</tr>
			<tr>
				<td>상품코드</td>
				<td>${dto.b_code}</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td>${dto.b_name}</td>
			</tr>
			<tr>
				<td>상품카테고리</td>
				<td>${dto.b_cate}</td>
			</tr>
			<tr>
				<td>등록일자</td>
				<td><fmt:formatDate pattern="yyyy년 MM월 dd일"
						value="${dto.bill_date}" /></td>
			</tr>
			<tr>
				<td>상품가격</td>
				<td><fmt:formatNumber pattern="#,###원"
						value="${dto.b_price}" /></td>
			</tr>
			<c:if test="${dto.b_check eq 3}">
				<tr>
					<td>상품검수</td>
					<td>상</td>
				</tr>
			</c:if>
			<c:if test="${dto.b_check eq 2}">
				<tr>
					<td>상품검수</td>
					<td>중</td>
				</tr>
			</c:if>
			<c:if test="${dto.b_check eq 1}">
				<tr>
					<td>상품검수</td>
					<td>하</td>
				</tr>
			</c:if>
			<c:if test="${dto.b_check eq 0}">
				<tr>
					<td>상품검수</td>
					<td>미검수</td>
				</tr>
			</c:if>
			<tr>
				<td>우편번호</td>
				<td>${dto.buy_post}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>${dto.buy_address}</td>
			</tr>
			<tr>
				<td colspan="9"><input type="hidden" name="b_code" value="${dto.b_code}"> <a
					href="/user/user_deal_buylist.do">구매내역</a></td>
			</tr>
		</table>
	</form>
</body>
</html>